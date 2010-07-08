Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343068C875F6F@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B997343068C875F67@VSHINMSMBX01.vshodc.lntinfotech.com>
	<AANLkTikuMXwdV8gZegBN_fzY0NzVZcL6GZ7tcM61mWcl@mail.gmail.com>
	<70376CA23424B34D86F1C7DE6B997343068C875F6F@VSHINMSMBX01.vshodc.lntinfotech.com>
Date: Thu, 8 Jul 2010 17:05:50 +0300
Message-ID: <AANLkTikyO_fjWbef9hIG2MFTWRaU__hbJ_euOTZghVHA@mail.gmail.com>
Subject: Re: bluetooth data rate vs VDP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Viral Mehta <Viral.Mehta@lntinfotech.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 8, 2010 at 2:49 PM, Viral Mehta <Viral.Mehta@lntinfotech.com> wrote:
> I want to send RAW video data. For e.g., read from /dev/fb0 and stream it...
> Is it possible at the first hand? (I guess, in theory, yes)

Yes, it is possible, but it probably will require a lot more bandwidth
than something encoded.

> I also had a question whether encoding/decoding is done by VDP profile
> or I have to write some application on top of VDP profile. ??

The profile doesn't do anything, it only defines, but yes you most
likely will be reading rtp data from bluetooth socket and then you
have do decode it yourself.

-- 
Luiz Augusto von Dentz
Computer Engineer
