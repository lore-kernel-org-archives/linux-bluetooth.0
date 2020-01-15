Return-Path: <SRS0=uqsz=3E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57420C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DA02084D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jan 2020 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgAOVSJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:18:09 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:44353 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAOVSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jan 2020 16:18:09 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D1C62CECF2;
        Wed, 15 Jan 2020 22:27:25 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v5 02/11] Bluetooth: Add initial implementation of CIS
 connections
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200115210221.13096-3-luiz.dentz@gmail.com>
Date:   Wed, 15 Jan 2020 22:18:07 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3FDBB982-CE2E-431D-8FA1-61C2DA19E153@holtmann.org>
References: <20200115210221.13096-1-luiz.dentz@gmail.com>
 <20200115210221.13096-3-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This adds the initial implementation of CIS connections along with a new
> socket type BTPROTO_ISO to make use of it.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/bluetooth.h |   35 +
> include/net/bluetooth/hci_core.h  |   68 +-
> include/net/bluetooth/hci_sock.h  |    2 +
> include/net/bluetooth/iso.h       |   36 +
> net/bluetooth/Kconfig             |    1 +
> net/bluetooth/Makefile            |    1 +
> net/bluetooth/af_bluetooth.c      |   12 +-
> net/bluetooth/hci_conn.c          |  169 ++++
> net/bluetooth/hci_core.c          |  243 ++++-
> net/bluetooth/hci_event.c         |  230 +++++
> net/bluetooth/iso.c               | 1393 +++++++++++++++++++++++++++++
> 11 files changed, 2138 insertions(+), 52 deletions(-)
> create mode 100644 include/net/bluetooth/iso.h
> create mode 100644 net/bluetooth/iso.c
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index e42bb8e03c09..af969f250b7d 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -53,6 +53,8 @@
> #define BTPROTO_CMTP	5
> #define BTPROTO_HIDP	6
> #define BTPROTO_AVDTP	7
> +#define BTPROTO_ISO	8
> +#define BTPROTO_LAST	BTPROTO_ISO

I prefer to add this patch in a second phase since it is actually userspace API and I want to think this through more carefully. We might need to split this out in the ISO packet processing and ISO sockets.

Regards

Marcel

