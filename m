Return-Path: <cyrus@holtmann.org>
Date: Thu, 21 Jul 2011 12:09:45 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Allow ACL packets over USB in HCI_RAW mode
Message-ID: <20110721150945.GA3387@joana>
References: <1310647712.3208.3.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310647712.3208.3.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Hurley <peter@hurleysoftware.com> [2011-07-14 08:48:32 -0400]:

> Removed tests which prevent transmission of ACL packets
> when the device is in HCI_RAW mode. These tests verified that
> there are ACL or LE links currently tracked by the HCI
> connection manager. However, a HCI_RAW mode device does not
> use the connection manager. In these circumstances, the connection
> counts will be zero, and thus, transmitted ACL packets dropped.
> 
> The acl_num test is actually a vestige of a previous bulk URB
> scheme that is no longer used by this driver (bulk URBs were not
> started until at least one ACL connection was created). This was
> incompatible with some endpoint implementations and was dropped -
> see commit 43c2e57f94.
> 
> The utility of these tests is marginal - currently, the hci tx
> scheduler cannot send an ACL or LE packet for an untracked connection
> (except if the device is in HCI_RAW mode).
> 
> Lastly, no other transport layer driver enforces these same tests.
> ---
>  drivers/bluetooth/btusb.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
