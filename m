Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39887C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 08:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245132145D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 08:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE1I0k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 04:26:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40686 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgE1I0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 04:26:40 -0400
Received: from marcel-macpro.fritz.box (p4fefc5a7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id A4DFECECB0;
        Thu, 28 May 2020 10:36:25 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] sco:Add support for BT_PKT_STATUS CMSG data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200525184343.8532-1-alainm@chromium.org>
Date:   Thu, 28 May 2020 10:26:38 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <31E0FE7F-34A6-4819-AE06-C9F0B49D7C11@holtmann.org>
References: <20200525184343.8532-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds support for reporting the BT_PKT_STATUS to the socket
> CMSG data to allow the implementation of a packet loss correction on
> erronous data received on the SCO socket.
> 
> The patch was partially developed by Marcel Holtmann and validated by
> Hsin-yu Chao
> 
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> include/net/bluetooth/bluetooth.h |  8 ++++++++
> include/net/bluetooth/sco.h       |  3 +++
> net/bluetooth/af_bluetooth.c      |  3 +++
> net/bluetooth/hci_core.c          |  1 +
> net/bluetooth/sco.c               | 28 ++++++++++++++++++++++++++++
> 5 files changed, 43 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 3fa7b1e3c5d9..85e6c5754448 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -147,6 +147,8 @@ struct bt_voice {
> #define BT_MODE_LE_FLOWCTL	0x03
> #define BT_MODE_EXT_FLOWCTL	0x04
> 
> +#define BT_PKT_STATUS          16
> +

we need to agree on if this is an int or u8 value. Otherwise this looks good.

Regards

Marcel

