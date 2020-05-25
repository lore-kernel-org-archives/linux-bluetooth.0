Return-Path: <SRS0=GU2S=7H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98092C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 19:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FB82068D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 May 2020 19:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbgEYTiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 May 2020 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390218AbgEYTiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 May 2020 15:38:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64EC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2020 12:38:02 -0700 (PDT)
Received: from TesterBox (unknown [IPv6:2607:f2c0:f00e:4a00:781f:9cd6:122d:6995])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tester)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E1E4C2A051E;
        Mon, 25 May 2020 20:38:00 +0100 (BST)
Message-ID: <5378e0c1e4b8710bb54442b8ae1972fbf17c7321.camel@collabora.com>
Subject: Re: [PATCH] Bluetooth: Avoid calling device_add() on duplicated HCI
 conn event
From:   Olivier =?ISO-8859-1?Q?Cr=EAte?= <olivier.crete@collabora.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Date:   Mon, 25 May 2020 15:37:58 -0400
In-Reply-To: <0858E407-99A0-4EF7-B890-B367B206F4AD@holtmann.org>
References: <20200506025358.361519-1-olivier.crete@collabora.com>
         <0858E407-99A0-4EF7-B890-B367B206F4AD@holtmann.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, 2020-05-06 at 10:47 +0200, Marcel Holtmann wrote:
> Hi Olivier,
> 
> > The BCM20702A1 device in the ThinkPad x230 seems to send the HCI
> > Connection Complete event twice for the same connection, for which the
> > stack seems to recover, except for the core device_add() function
> > which is not meant to be called twice for the same device. So let's
> > just avoid calling it in that case.
> > 
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204633
> > Signed-off-by: Olivier Crête <olivier.crete@collabora.com>
> > Cc: stable@vger.kernel.org
> 
> please include the btmon output showing this issue.

The issue is quite intermittent, and it seems to happen more right
after I update the rest of the distro (from Fedora 29 to 30.. and just
recently from 31 to 32).. And I have no logical explanation. And right
now, I can't reproduce it anymore.

> And there is no firmware update available for the Bluetooth controller in the ThinkPad. Most Broadcom devices require an actual firmware load to fix bugs. Does your device load firmware?

I have a firmware file extracted from the Windows driver, without it,
the Bluetooth connection is even more unstable.

It comes from
https://github.com/winterheart/broadcom-bt-firmware/blob/master/brcm/BCM20702A1-0a5c-21e6.hcd

Olivier

> 
> > ---
> > include/net/bluetooth/hci_core.h | 3 +++
> > net/bluetooth/hci_conn.c         | 1 +
> > net/bluetooth/hci_event.c        | 8 ++++++--
> > 3 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index d4e28773d378..b74669397dbb 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -500,6 +500,9 @@ struct hci_dev {
> > 
> > #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
> > 
> > +/* Valid HCI handles are in the 0x0000-0x0EFF range per spec */
> > +#define HCI_INVALID_HANDLE 0xFFFF
> > +
> > struct hci_conn {
> > 	struct list_head list;
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index e245bc155cc2..edf12a3f46aa 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -532,6 +532,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
> > 	conn->rssi = HCI_RSSI_INVALID;
> > 	conn->tx_power = HCI_TX_POWER_INVALID;
> > 	conn->max_tx_power = HCI_TX_POWER_INVALID;
> > +	conn->handle = HCI_INVALID_HANDLE;
> > 
> > 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
> > 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 0a591be8b0ae..e498f70fcda9 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2553,6 +2553,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > 	}
> > 
> > 	if (!ev->status) {
> > +		int first_connection = (conn->handle == HCI_INVALID_HANDLE);
> > +
> 
> We have the type bool available for these kind of things. 
> 
> > 		conn->handle = __le16_to_cpu(ev->handle);
> > 
> > 		if (conn->type == ACL_LINK) {
> > @@ -2567,8 +2569,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > 		} else
> > 			conn->state = BT_CONNECTED;
> > 
> > -		hci_debugfs_create_conn(conn);
> > -		hci_conn_add_sysfs(conn);
> > +		if (first_connection) {
> > +			hci_debugfs_create_conn(conn);
> > +			hci_conn_add_sysfs(conn);
> > +		}
> > 
> > 		if (test_bit(HCI_AUTH, &hdev->flags))
> > 			set_bit(HCI_CONN_AUTH, &conn->flags);
> 
> Regards
> 
> Marcel
> 
-- 
Olivier Crête
olivier.crete@collabora.com

