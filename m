Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 4/5] android/bluetooth: Add support for caching remote device info
Date: Tue, 14 Jan 2014 18:55:31 +0100
Message-ID: <1877346.eJJvW3yP1x@athlon>
In-Reply-To: <CABBYNZJRVE50AVx0Tm+y_MMuO94U4wEARetXyhRf8UckJCwJcw@mail.gmail.com>
References: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com> <1389697905-18532-5-git-send-email-szymon.janc@tieto.com> <CABBYNZJRVE50AVx0Tm+y_MMuO94U4wEARetXyhRf8UckJCwJcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tuesday 14 January 2014 17:49:54 Luiz Augusto von Dentz wrote:
> Hi Szymon,
> 
> On Tue, Jan 14, 2014 at 1:11 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> > Cache is limited to DEVICES_CACHE_MAX. Devices are sorted with
> > timestamp so if cache is full olderst device is removed.
> > ---
> > 
> >  android/bluetooth.c | 69
> >  ++++++++++++++++++++++++++++++++++++++++++----------- 1 file changed, 55
> >  insertions(+), 14 deletions(-)
> > 
> > diff --git a/android/bluetooth.c b/android/bluetooth.c
> > index 8c91d87..df442a3 100644
> > --- a/android/bluetooth.c
> > +++ b/android/bluetooth.c
> > @@ -70,6 +70,8 @@
> > 
> >  /* Default discoverable timeout 120sec as in Android */
> >  #define DEFAULT_DISCOVERABLE_TIMEOUT 120
> > 
> > +#define DEVICES_CACHE_MAX 100
> 
> Is this being limited because Android UI cannot handle more than that?
> Or perhaps because our IPC/MTU cannot carry more than that? If the
> latter I believe we can actually calculate the maximun e.g. MTU / pdu
> size.

This is not related to Android UI nor MTU. This is just to limit max resources 
usage. Value is totally arbitrary. If device is not in cache some HAL 
functions might fail (notably set/get device property).

-- 
Szymon K. Janc
szymon.janc@gmail.com
