Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1509104058.19297.5.camel@hadess.net>
Subject: Re: [PATCH v2 01/11] adapter: Add
 btd_request_authorization_cable_configured()
From: Bastien Nocera <hadess@hadess.net>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 27 Oct 2017 13:34:18 +0200
In-Reply-To: <2420304.WZtTGuyavg@ix>
References: <20171018015815.10045-1-hadess@hadess.net>
         <2420304.WZtTGuyavg@ix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-10-27 at 10:00 +0200, Szymon Janc wrote:
> Hi Bastien,
> 
> <snip>
> 
> Patches 1-8 are now applied, thanks.

For those following along on the mailing-list, I asked Szymon not to
commit the Wireless Keypad patches as they don't use pairing at all,
making it insecure.

It's possible to pair the PS3 Wireless keypad properly, like a normal
keyboard, by turning it on with the blue button (left trigger) pressed.
I'll see whether we can support cable pairing with actual pairing, in a
way that makes it easier for the user.

Cheers
