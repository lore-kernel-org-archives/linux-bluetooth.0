Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75274C2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 16:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3C42072A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDGQ3a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:29:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34262 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDGQ3a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 12:29:30 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id DCFCCCECD8;
        Tue,  7 Apr 2020 18:39:02 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [bug report] Bluetooth: btusb: handle mSBC audio over USB
 Endpoints
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200407123215.GA101015@mwanda>
Date:   Tue, 7 Apr 2020 18:29:27 +0200
Cc:     Sathish Narsimman <sathish.narasimman@intel.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <00145007-5EFD-4C0E-9662-6CF1CAE217FB@holtmann.org>
References: <20200407123215.GA101015@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> This is a semi-automatic email about new static checker warnings.
> 
> The patch baac6276c0a9: "Bluetooth: btusb: handle mSBC audio over USB
> Endpoints" from Apr 3, 2020, leads to the following Smatch complaint:
> 
>    drivers/bluetooth/btusb.c:1665 btusb_work()
>    error: we previously assumed 'data->isoc' could be null (see line 1642)
> 
> drivers/bluetooth/btusb.c
>  1641			if (!test_bit(BTUSB_DID_ISO_RESUME, &data->flags)) {
>  1642				err = usb_autopm_get_interface(data->isoc ? data->isoc : data->intf);
>                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This code assumes that "data->isoc" can be NULL.
> 
>  1643				if (err < 0) {
>  1644					clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
>  1645					usb_kill_anchored_urbs(&data->isoc_anchor);
>  1646					return;
>  1647				}
>  1648	
>  1649				set_bit(BTUSB_DID_ISO_RESUME, &data->flags);
>  1650			}
>  1651	
>  1652			if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
>  1653				if (hdev->voice_setting & 0x0020) {
>  1654					static const int alts[3] = { 2, 4, 5 };
>  1655	
>  1656					new_alts = alts[data->sco_num - 1];
>  1657				} else {
>  1658					new_alts = data->sco_num;
>  1659				}
>  1660			} else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
>  1661	
>  1662				data->usb_alt6_packet_flow = true;
>  1663	
>  1664				/* Check if Alt 6 is supported for Transparent audio */
>  1665				if (btusb_find_altsetting(data, 6))
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
> The new btusb_find_altsetting() dereferences it without checking.
> 
>  1666					new_alts = 6;
>  1667				else

while it is unlikely that data->isoc is NULL, this can actually happen in some weird cases where the USB device doesn’t provide ISOC endpoints, but still has SCO transport support. So yes, we should be adding a NULL check in btusb_find_altsetting.

Regards

Marcel

