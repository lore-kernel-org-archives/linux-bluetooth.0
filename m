Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Feb 2011 09:46:22 -0800
From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
To: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
CC: David Woodhouse <dwmw2@infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Subject: Re: [PATCH] linux-firmware: Remove ath3k-2.fw
Message-ID: <20110203174622.GA1226@tux>
References: <1296207208-4465-1-git-send-email-sbalashanmugam@atheros.com>
 <1296719005.12863.28.camel@macbook.infradead.org>
 <4D4A60E1.3080000@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4D4A60E1.3080000@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 03, 2011 at 12:01:37AM -0800, Shanmugamkamatchi Balashanmugam wrote:
> On 2/3/2011 1:13 PM, David Woodhouse wrote:
> > On Fri, 2011-01-28 at 15:03 +0530, Bala Shanmugam wrote:
> >> ath3k-2.fw is obsolete and not use by Atheros chipsets
> >> anymore.
> > Are you telling me that there is no extant hardware, and no old kernels,
> > which would use this? It was added to the linux-firmware tree and
> > *never* used?
> >
> Yes David, no older kernel uses this firmware.
> We thought to have new firmware file for newer versions but
> our driver patch was not accepted and we decided to
> have single firmware for this chipset [ath3k-1.fw].
> 

To be clear, the patch for upstream to use that firmware was submitted IIRC but
never merged upstream... you merged the firmware first. By the time it came
time to push it again, I had asked WTF was in it, and asked for the patch to
get merged, but it was made clear by our team the APIs never changed so Marcel
suggested we just replace the firmware in linux-firmware instead of adding a
new firmware and patching the driver.

Apologies for any trouble.

  Luis
