Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Support for Atheros AR300x serial Bluetooth
 Chip
From: suraj <suraj@atheros.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
In-Reply-To: <20100715195214.GA5734@vigoh>
References: <1279191250-5923-1-git-send-email-suraj@atheros.com>
	 <20100715195214.GA5734@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 09:46:16 +0530
Message-ID: <1279253776.6827.3.camel@atheros013-desktop>
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, 2010-07-16 at 01:22 +0530, Gustavo F. Padovan wrote:
> Hi Suraj,
> 
> * Suraj Sumangala <suraj@atheros.com> [2010-07-15 16:24:10 +0530]:
> 
> > Implements Atheros AR300x Serial HCI protocol.
> > This protocol extends H4 serial protocol to implement enhanced power management
> > features supported by Atheros AR300x serial Bluetooth chipsets.
> > 
> > Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> > ---
> 
> Patch looks fine, nevertheless I'm unable to test it since I don't have
> such hardware.
> 

I have tested the driver along with the hardware using good number of
profiles successfully.

So, I am pretty confident on it. But, how do we go about it in these
kind of scenarios?

Regards
Suraj



