Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:03:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] android/hidhost: Simplify handle_uhid_output
Message-ID: <20131218080323.GF12649@x220.p-661hnu-f1>
References: <1387204652-14850-1-git-send-email-szymon.janc@tieto.com>
 <1387204652-14850-2-git-send-email-szymon.janc@tieto.com>
 <CABBYNZLu11494VB7WKMj-nxaXr1GfzNt_unYezPcU==e_7HweQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZLu11494VB7WKMj-nxaXr1GfzNt_unYezPcU==e_7HweQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz & Szymon,

On Mon, Dec 16, 2013, Luiz Augusto von Dentz wrote:
> On Mon, Dec 16, 2013 at 4:37 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > Make it use VLA for req buffer. This makes function simpler and also
> > fix cutting req to 255 bytes (req_len was uint8_t)
> > ---
> >  android/hidhost.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/android/hidhost.c b/android/hidhost.c
> > index 0e0391a..76322af 100644
> > --- a/android/hidhost.c
> > +++ b/android/hidhost.c
> > @@ -156,29 +156,22 @@ static void hid_device_free(struct hid_device *dev)
> >  static void handle_uhid_output(struct hid_device *dev,
> >                                                 struct uhid_output_req *output)
> >  {
> > -       int fd, i;
> > -       uint8_t *req = NULL;
> > -       uint8_t req_size = 0;
> > +       int fd;
> > +       unsigned int i;
> > +       uint8_t req[1 + (output->size / 2)];
> 
> Im not a fan of VLA and Ive seem even some static analyzer that would
> warn about its use without first checking > 0 and have a check of
> upper bond limit, so perhaps just having it set to UHID_DATA_MAX or
> dynamically allocate a buffer to match the output MTU size of the
> control channel would better imo.

I've applied the first patch in this set, but was there some conclusion
on how to proceed here?

If output->size was an uint8_t this would be a non-issue, but as it's
uint16_t I'm a bit uncomfortable with the idea of potentially having a
huge variable on the stack.

Johan
