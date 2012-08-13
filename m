Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5027DC19.8020505@ntlworld.com>
References: <5027DC19.8020505@ntlworld.com>
Date: Mon, 13 Aug 2012 15:23:00 +0300
Message-ID: <CABBYNZJTkSf1BFZYge9R5WX7m79=hkDfaENh201EygSdck_yyQ@mail.gmail.com>
Subject: Re: gstreamer a2dpSource plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "alistair.rodger" <alistair.rodger@ntlworld.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, Aug 12, 2012 at 7:38 PM, alistair.rodger
<alistair.rodger@ntlworld.com> wrote:
> Hello,
>
> I am looking for some help getting audio out of the bluez stack using
> gstreamer? Are we still using an alsa source or should we be using the
> MediaTransport file descriptor.
>
> I am able to generate a sink file descriptor, using the simple-endpoint
> script, but don't know which gstreamer plugin to use.
>
> I am able stream to a device using the a2dpsink.

What do you mean by which plugin to use? You are using a2dpsink
already, I don't think I got what you want.

I normally test using the following pipeline:

gst-launch -v audiotestsrc ! audio/x-raw-int,channels=2 ! audioconvert
! sbcenc ! a2dpsink
transport=/org/bluez/{PID}/hci0/dev_AA_BB_CC_DD_EE_FF/fd0

-- 
Luiz Augusto von Dentz
