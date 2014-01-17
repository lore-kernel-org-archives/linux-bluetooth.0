Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Jan 2014 16:07:05 +0100
From: Natanael Copa <ncopa@alpinelinux.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/3] unit: prevent use of glibc's error(3)
Message-ID: <20140117160705.67b3c508@ncopa-desktop.alpinelinux.org>
In-Reply-To: <CABBYNZ+LYk1c0YUU0==JyKxJ_SbX6nNbcpwRCd==HUV1CKx+Ow@mail.gmail.com>
References: <1389960506-10273-1-git-send-email-ncopa@alpinelinux.org>
	<1389960506-10273-3-git-send-email-ncopa@alpinelinux.org>
	<CABBYNZ+LYk1c0YUU0==JyKxJ_SbX6nNbcpwRCd==HUV1CKx+Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 17 Jan 2014 16:37:15 +0200
Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:

> Hi Natanael,
> 
> On Fri, Jan 17, 2014 at 2:08 PM, Natanael Copa <natanael.copa@gmail.com> wrote:
> > When building the test-sdp we don't want src/sdpd-request.c end up
> > using the incompatible GNU libc's error(3).
> >
> > This also fixes building on musl libc which misses the error(3) GNU
> > extension.
> > ---
> >  unit/test-sdp.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/unit/test-sdp.c b/unit/test-sdp.c
> > index 6d699e2..eeed0cb 100644
> > --- a/unit/test-sdp.c
> > +++ b/unit/test-sdp.c
> > @@ -134,6 +134,12 @@ void btd_debug(const char *format, ...)
> >  {
> >  }
> >
> > +void error(const char *format, ...);
> > +
> > +void error(const char *format, ...)
> > +{
> > +}
> > +
> >  static void context_quit(struct context *context)
> >  {
> >         g_main_loop_quit(context->main_loop);
> > --
> > 1.8.5.3
> 
> We could perhaps do the same thing we did in test-avdtp.c, build with
> log support and add the following check:
> 
> if (g_test_verbose())
> __btd_log_init("*", 0);
> 
> 

sounds good to me.

-nc
