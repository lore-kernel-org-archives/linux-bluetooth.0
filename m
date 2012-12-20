Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFOXTden8JeVHe+SXKt7GeG+QXHP01Nku2ubQ_m88LxJ1ATUmg@mail.gmail.com>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
	<20121220080447.GA561@x220>
	<CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
	<20121220091943.GA5862@x220>
	<CAFOXTdf9qrtXD0GPDBFLhLX66QGQCgF_VzyS8WWz5xTAH8+0zQ@mail.gmail.com>
	<20121220093742.GA6548@x220>
	<CAFOXTden8JeVHe+SXKt7GeG+QXHP01Nku2ubQ_m88LxJ1ATUmg@mail.gmail.com>
Date: Thu, 20 Dec 2012 12:06:39 +0100
Message-ID: <CAFOXTddu5qU3iBn4VMKE0_YxHDWqqEkVBiaR8jx7LAO4RKg-LQ@mail.gmail.com>
Subject: Re: Authentication Rejected when pairing stereo headset
From: Andrey Voropaev <voropaev.andrey@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 20, 2012 at 11:22 AM, Andrey Voropaev
<voropaev.andrey@gmail.com> wrote:
> But seems like Alsa still does not see it. I've added
>
>  pcm.bluetooth {
>   type bluetooth
>   device 00:1A:7D:25:2C:A4
>   profile "auto"
>  }
>
>
> to /etc/asound.conf, restarted alsasound, but bluetooth does not show
> up among available outputs. Well, I'm almost there. The Skype has
> "bluetooth" in the list of devices and it works. Just mplayer does not
> want to work with option
>
>  -ao alsa:device=bluetooth

Sorry. I've found the solution.
https://wiki.archlinux.org/index.php/Bluetooth gives different
configuration for Alsa

pcm.btheadset {
   type plug
   slave {
       pcm {
           type bluetooth
           device XX:XX:XX:XX:XX:XX
           profile "auto"
       }
   }
   hint {
       show on
       description "BT Headset"
   }
}
ctl.btheadset {
  type bluetooth
}

With this configuration the headset becomes visible in aplay -L.

So, the issue is resolved. Thank you for help!

Andrei
