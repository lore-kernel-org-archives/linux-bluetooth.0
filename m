Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Allow ACL packets over USB in HCI_RAW mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Sun, 17 Jul 2011 13:02:13 +0200
In-Reply-To: <1310647712.3208.3.camel@THOR>
References: <1310647712.3208.3.camel@THOR>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310900534.21109.116.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

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

for kernel patches, we do require the Signed-off-by line.

Gustavo, I am fine with this btw. So Acked-by.

Regards

Marcel


