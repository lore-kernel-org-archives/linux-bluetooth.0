Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B43C43444
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EB1218AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeLRXuE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:50:04 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:45046 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbeLRXuE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:50:04 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id CBA0ECEE94;
        Wed, 19 Dec 2018 00:57:41 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_h5: Turn off RTL8723BS on suspend,
 reprobe on resume
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181030131723.4589-2-hdegoede@redhat.com>
Date:   Wed, 19 Dec 2018 00:50:02 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E93E0E7B-E0FF-4734-97D5-74F0B5EF41E6@holtmann.org>
References: <20181030131723.4589-1-hdegoede@redhat.com>
 <20181030131723.4589-2-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Hans,

> On many devices the RTL8723BS device gets reset during suspend/resume,
> causing it to lose its firmware and all state.
> 
> Testing has shown it drops back to communicating at 115200 bps and sends
> sync-request packages, indicating it has been fully reset.
> 
> This commit fixes this by queueing a reprobe on resume.
> 
> This mirrors how USB RTL BT devices, which have the same problem, are
> handled in the btusb driver, there we set the USB_QUIRK_RESET_RESUME for
> all RTL devices, which also causes a reprobe on resume. The only difference
> is that here we need to do the reprobe ourselves.
> 
> Since we are doing a full reprobe on resume now, we can also turn off the
> device on suspend to save power while suspended.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Fix some spelling errors in the commit message and in a comment
> ---
> drivers/bluetooth/hci_h5.c | 52 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

