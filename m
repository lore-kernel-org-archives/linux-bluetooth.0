Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85195C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FAAD217D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLRXFK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:05:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54304 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeLRXFK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:05:10 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id B76CBCEE81;
        Wed, 19 Dec 2018 00:12:48 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v4 04/30] mesh: Internal errors
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181218223139.8041-5-brian.gix@intel.com>
Date:   Wed, 19 Dec 2018 00:05:09 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 7bit
Message-Id: <087F26C1-6E63-47BE-9F9B-2F40B91A45D9@holtmann.org>
References: <20181218223139.8041-1-brian.gix@intel.com>
 <20181218223139.8041-5-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> mesh/error.h | 35 +++++++++++++++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
> create mode 100644 mesh/error.h
> 
> diff --git a/mesh/error.h b/mesh/error.h
> new file mode 100644
> index 000000000..e7bac445b
> --- /dev/null
> +++ b/mesh/error.h
> @@ -0,0 +1,35 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2018  Intel Corporation. All rights reserved.
> + *
> + *
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
> + *
> + *  This library is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *
> + */
> +
> +/*
> + * Important: Changes in this table must be reflected in the
> + * the entries of error_table[] in dbus.c
> + */
> +typedef enum {
> +	MESH_ERROR_NONE,
> +	MESH_ERROR_FAILED,
> +	MESH_ERROR_NOT_AUTHORIZED,
> +	MESH_ERROR_NOT_FOUND,
> +	MESH_ERROR_INVALID_ARGS,
> +	MESH_ERROR_BUSY,
> +	MESH_ERROR_ALREADY_EXISTS,
> +	MESH_ERROR_DOES_NOT_EXIST,
> +	MESH_ERROR_CANCELED,
> +} mesh_error_t;

we are not doing typedef unless really needed. I do not see the need here.

Regards

Marcel

