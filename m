Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343068C875F67@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343068C875F67@VSHINMSMBX01.vshodc.lntinfotech.com>
Date: Thu, 8 Jul 2010 14:29:14 +0300
Message-ID: <AANLkTikuMXwdV8gZegBN_fzY0NzVZcL6GZ7tcM61mWcl@mail.gmail.com>
Subject: Re: bluetooth data rate vs VDP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 8, 2010 at 9:04 AM, Viral Mehta <Viral.Mehta@lntinfotech.com> wrote:
> Hi,
> I am new to bluetooth and sorry if posting at a wrong place.
>
> I have a very basic question,
> As I read through documents, Bluetooth 2 can support max data rate of 2Mbps or upto 3Mbps.

If you mean EDR, yes it is up to 3Mbps, but with Bluetooth 3.0 you can
much higher data rate.

> Then how can a profile like "Video Distribution Profile" work at such a low speed. If I am not wrong VDP is used for streaming of Video, how can Video streaming be achieved at such a lower data rate ?

For low/webcam quality is more than enough I guess, if you think about
it is not that different from using a phone such as N900/iphone and do
a video call over 3G , so I don't see any problem in doing it over
bluetooth, just use the same codec and you will going to get about the
same thing. Also the think with vdp is that if the device supports the
same codec as used in the video call you can pretty much sent it as it
is, no additional encoding/decoding.

> Is there something like data rate can be increased with VDP like profile ?

Yes, bluetooth 3.0.

-- 
Luiz Augusto von Dentz
Computer Engineer
