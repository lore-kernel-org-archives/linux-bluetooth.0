Return-Path: <cyrus@holtmann.org>
From: Viral Mehta <Viral.Mehta@lntinfotech.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 8 Jul 2010 17:19:40 +0530
Subject: RE: bluetooth data rate vs VDP
Message-ID: <70376CA23424B34D86F1C7DE6B997343068C875F6F@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343068C875F67@VSHINMSMBX01.vshodc.lntinfotech.com>,<AANLkTikuMXwdV8gZegBN_fzY0NzVZcL6GZ7tcM61mWcl@mail.gmail.com>
In-Reply-To: <AANLkTikuMXwdV8gZegBN_fzY0NzVZcL6GZ7tcM61mWcl@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Thanks for the reply
>From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]
>On Thu, Jul 8, 2010 at 9:04 AM, Viral Mehta <Viral.Mehta@lntinfotech.com> wrote:

>> Then how can a profile like "Video Distribution Profile" work at such a low speed. If I am not wrong VDP is used for streaming of Video, how can >Video streaming be achieved at such a lower data rate ?

>For low/webcam quality is more than enough I guess, if you think about
>it is not that different from using a phone such as N900/iphone and do
>a video call over 3G , so I don't see any problem in doing it over
>bluetooth, just use the same codec and you will going to get about the
>same thing. Also the think with vdp is that if the device supports the
>same codec as used in the video call you can pretty much sent it as it
>is, no additional encoding/decoding.

I want to send RAW video data. For e.g., read from /dev/fb0 and stream it...
Is it possible at the first hand? (I guess, in theory, yes)
I also had a question whether encoding/decoding is done by VDP profile
or I have to write some application on top of VDP profile. ??

>> Is there something like data rate can be increased with VDP like profile ?

>Yes, bluetooth 3.0.

--
Luiz Augusto von Dentz
Computer Engineer

______________________________________________________________________

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
