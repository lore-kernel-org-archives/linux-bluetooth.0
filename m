Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDBC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02B9218A2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 23:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeLRXJV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:09:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56959 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeLRXJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 18:09:21 -0500
Received: from marcel-macpro.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id E1179CEE81;
        Wed, 19 Dec 2018 00:16:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BlueZ v4 09/30] mesh: Acceptor side provisioning
 implimentation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181218223139.8041-10-brian.gix@intel.com>
Date:   Wed, 19 Dec 2018 00:09:19 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        inga.stotland@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <1A6BD1B4-7CCB-466E-9390-B36C690CB70C@holtmann.org>
References: <20181218223139.8041-1-brian.gix@intel.com>
 <20181218223139.8041-10-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> ---
> mesh/prov-acceptor.c | 711 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 711 insertions(+)
> create mode 100644 mesh/prov-acceptor.c
> 
> diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
> new file mode 100644
> index 000000000..ac42e1e2c
> --- /dev/null
> +++ b/mesh/prov-acceptor.c
> @@ -0,0 +1,711 @@
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
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <sys/select.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <termios.h>
> +
> +#include <ctype.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <getopt.h>
> +#include <time.h>
> +#include <ell/ell.h>
> +
> +#include "mesh/mesh-defs.h"
> +#include "src/shared/ecc.h"
> +
> +#include "mesh/util.h"
> +#include "mesh/net_keys.h"
> +#include "mesh/crypto.h"
> +#include "mesh/net.h"
> +#include "mesh/error.h"
> +#include "mesh/prov.h"
> +#include "mesh/provision.h"
> +#include "mesh/pb-adv.h"
> +#include "mesh/mesh.h"
> +#include "mesh/agent.h"
> +
> +/* Quick size sanity check */
> +static const uint16_t expected_pdu_size[] = {
> +	2,	/* PROV_INVITE */
> +	12,	/* PROV_CAPS */
> +	6,	/* PROV_START */
> +	65,	/* PROV_PUB_KEY */
> +	1,	/* PROV_INP_CMPLT */
> +	17,	/* PROV_CONFIRM */
> +	17,	/* PROV_RANDOM */
> +	34,	/* PROV_DATA */
> +	1,	/* PROV_COMPLETE */
> +	2,	/* PROV_FAILED */
> +};
> +
> +#define BEACON_TYPE_UNPROVISIONED		0x00
> +
> +static const uint8_t pkt_filter = MESH_AD_TYPE_PROVISION;
> +static const uint8_t bec_filter[] = {MESH_AD_TYPE_BEACON,
> +						BEACON_TYPE_UNPROVISIONED};
> +
> +enum acp_state {
> +	ACP_PROV_IDLE = 0,
> +	ACP_PROV_CAPS_SENT,
> +	ACP_PROV_CAPS_ACKED,
> +	ACP_PROV_KEY_SENT,
> +	ACP_PROV_KEY_ACKED,
> +	ACP_PROV_INP_CMPLT_SENT,
> +	ACP_PROV_INP_CMPLT_ACKED,
> +	ACP_PROV_CONF_SENT,
> +	ACP_PROV_CONF_ACKED,
> +	ACP_PROV_RAND_SENT,
> +	ACP_PROV_RAND_ACKED,
> +	ACP_PROV_CMPLT_SENT,
> +	ACP_PROV_FAIL_SENT,
> +};
> +
> +#define MAT_REMOTE_PUBLIC	0x01
> +#define MAT_LOCAL_PRIVATE	0x02
> +#define MAT_RAND_AUTH		0x04
> +#define MAT_SECRET	(MAT_REMOTE_PUBLIC | MAT_LOCAL_PRIVATE)
> +
> +struct mesh_prov_acceptor {
> +	mesh_prov_acceptor_complete_func_t cmplt;
> +	prov_trans_tx_t trans_tx;
> +	void *agent;
> +	void *caller_data;
> +	void *trans_data;
> +	struct l_timeout *timeout;
> +	uint32_t to_secs;
> +	enum acp_state	state;
> +	uint8_t transport;
> +	uint8_t material;
> +	uint8_t expected;
> +	int8_t previous;
> +	struct conf_input conf_inputs;
> +	uint8_t calc_key[16];
> +	uint8_t salt[16];
> +	uint8_t confirm[16];
> +	uint8_t s_key[16];
> +	uint8_t s_nonce[13];
> +	uint8_t private_key[32];
> +	uint8_t secret[32];
> +	uint8_t rand_auth_workspace[48];
> +};
> +
> +static struct mesh_prov_acceptor *prov = NULL;
> +
> +static void acceptor_free(void)
> +{
> +
> +	if (prov)
> +		l_timeout_remove(prov->timeout);
> +
> +	mesh_send_cancel(bec_filter, sizeof(bec_filter));
> +	mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
> +
> +	if (prov->trans_tx) {
> +		if (prov->transport == PB_ADV)
> +			pb_adv_unreg(prov->trans_data);
> +#if defined(GATT_ENABLED)
> +		/* TODO: Cleanup GATT bearer if exists */
> +		else if (prov->transport == PB_GATT)
> +			pb_gatt_unreg(prov->trans_data);
> +#endif

this is a simple no. Please stop hacking the code like yes. And yes, adding ifdef is hacking it. Either you abstract different bearer cleanly or they will be all always available. I am not doing two test runs to check your idea of build options.

Regards

Marcel

