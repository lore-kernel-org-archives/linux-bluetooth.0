Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 09:43:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 01/13] Bluetooth: Fix start_discovery for LE-only
 controllers
Message-ID: <20130430064304.GA29654@x220>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
 <1367300704-703-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367300704-703-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Apr 30, 2013, Andre Guedes wrote:
> LE-only controllers don't have local extended features (see commit
> c73eee9172bf061202c75ad4d16506a7efd04d1c). Thus, lmp_host_le_capable
> helper is not applicable and we should use test_bit(HCI_LE_ENABLED)
> to check if the host supports LE. Otherwise, start_discovery will
> always fail for LE-only controllers.
> 
> This misbehavior can be easily checked by running mgmt-tester tool
> (test "Start Discovery - Success 2" will fail).
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I already sent a patch for this last Wednesday:

  Bluetooth: Fix checks for LE support on LE-only controllers

So this patch can be ignored.

Johan
