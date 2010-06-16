Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Jun 2010 13:25:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [PATCH] Don't handle Changed Combination Link Key for a
 temporary keys.
Message-ID: <20100616102558.GA6512@jh-x301>
References: <99B09243E1A5DA4898CDD8B70011144809696FDFB0@EXMB04.eu.tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99B09243E1A5DA4898CDD8B70011144809696FDFB0@EXMB04.eu.tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 16, 2010, Waldemar.Rymarkiewicz@tieto.com wrote:
> Patch on behalf of ST-Ericsson SA
> 
> This patch prevents from storing Changed Combination Link Key type
> for temporary keys.  Getting Changed Combination Link Key remote
> auth requirements are already set to 0xff (bonding has finished)
> and that lets the system to store the key type of Changed
> Combination (0x06). For temporary keys we don't have to care about
> Change Link Key event.
> ---
>  src/dbus-hci.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

Thanks for the patch. It has been pushed upstream. In the future please
fix your git author name since it was set to your email address (I fixed
it manually this time).

Just to get this clear, this takes care of the situation where we had a
link key with a "No Bonding" requirement and get a renewed key for the
connection in which case we should still honor the no bonding
requirement by not storing the renewed key, right? That's the only other
type of "temporary" link key that I can think of in addition to debug
keys (which we already take care of).

Johan
