Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 May 2014 11:14:10 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv4 12/12] android/audio: Add write to SCO
Message-ID: <20140509081408.GD23010@aemeltch-MOBL1>
References: <1399551937-27109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1399551937-27109-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CABBYNZ+QNsM9aQ_5gM_dYYtSp9PP0YsSE+=4yHrvJbm1HBe06A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+QNsM9aQ_5gM_dYYtSp9PP0YsSE+=4yHrvJbm1HBe06A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, May 08, 2014 at 04:51:48PM +0300, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Thu, May 8, 2014 at 3:25 PM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > For synchronization interleave read() and write().
> > ---
> >  android/hal-sco.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/android/hal-sco.c b/android/hal-sco.c
> > index 7b6608b..5ec56ce 100644
> > --- a/android/hal-sco.c
> > +++ b/android/hal-sco.c
> > @@ -41,6 +41,8 @@
> >  #define OUT_BUFFER_SIZE                        2560
> >  #define OUT_STREAM_FRAMES              2560
> >
> > +#define SOCKET_POLL_TIMEOUT_MS         500
> > +
> >  static int listen_sk = -1;
> >  static int audio_sk = -1;
> >
> > @@ -275,6 +277,74 @@ static void downmix_to_mono(struct sco_stream_out *out, const uint8_t *buffer,
> >         }
> >  }
> >
> > +static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
> > +                                                               size_t bytes)
> > +{
> > +       struct pollfd pfd;
> > +       size_t len, written = 0;
> > +       int ret;
> > +       uint16_t mtu = /* out->cfg.mtu */ 48;
> > +       uint8_t read_buf[mtu];
> > +       bool do_write = false;
> > +
> > +       pfd.fd = out->fd;
> > +       pfd.events = POLLOUT | POLLIN | POLLHUP | POLLNVAL;
> > +
> > +       while (bytes > written) {
> > +
> > +               /* poll for sending */
> > +               if (poll(&pfd, 1, SOCKET_POLL_TIMEOUT_MS) == 0) {
> > +                       DBG("timeout fd %d", out->fd);
> > +                       return false;
> > +               }
> > +
> > +               if (pfd.revents & (POLLHUP | POLLNVAL)) {
> > +                       error("error fd %d, events 0x%x", out->fd, pfd.revents);
> > +                       return false;
> > +               }
> > +
> > +               if (pfd.revents & POLLIN) {
> > +                       ret = read(out->fd, read_buf, mtu);
> > +                       if (ret < 0) {
> > +                               error("Error reading fd %d (%s)", out->fd,
> > +                                                       strerror(errno));
> > +                               return false;
> > +                       }
> > +
> > +                       do_write = true;
> 
> You probably gonna have store the read data in a buffer to be read by
> upper layer after remixed to 44.1 KHz, to safe space you can probably
> leave the remixing to be done on the read callback. Im fine to do this
> in a separate patch but we should at least add a comment about it.

I think we need to have special thread which does read-write since Android
might call read() without write().

Best regards 
Andrei Emeltchenko 
