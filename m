Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847FC74A42
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 07:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A676A21537
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 07:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="zmh7USZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfGKHKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:10:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39989 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfGKHKN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 03:10:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so4538971wmj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2019 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gFc7Bze9R0QF9bgPAHS1WTmz8a7Wdn2oJo6jt9Y2QYM=;
        b=zmh7USZpmKGIDF6e1D3JU86k+QzCUckXnrEGwQ8kuTnESJLFpA/PPG4QR7gRGYWQKi
         Uio1XDfyaV1znMo4BKvsSFEMusFpQTSQGuxpzlrY2uX+maJYJx42IZohOE6jUDLgmbjF
         NlHwxLSTZG9WHbw2ML11WutXXqWi/IC11QKp9SOi0KNNkK5Lxg9qhosRxL0HfXzHSIxI
         Y4egM2kinf48JMV1D53WHwOziQJkG9UGIrhApIaHScldYygUMnUv5aWEKx+wuTYZer/C
         pJ+1JDaBaRcM8JCtl0xMaXLrdSLq3Bkv62ROCZAZR/3LKoO+qSNi+WQDEQJ78aXjOuek
         TRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gFc7Bze9R0QF9bgPAHS1WTmz8a7Wdn2oJo6jt9Y2QYM=;
        b=PcCwJ4Y0yNri16OdPOMBxObYpYBi80RDYl7C0vhJrhicKa5hAyUOqpLiD7uzCljJZh
         Lc4gx6Dtpyu+ahmmAuOlWZ6zsWmQc6+97Z2rz1w8SDaxXsU+AWjoco7b2t6yzD6P1dBf
         7ztpYXhHs7GYJXBI67XS/EQP6AUFoT9lvd51M4/DdQihU0NIHEsmq3qwGQEJ2xywhNzs
         Gg1jPjJRkCYHGPwKo4rLiP3EdTSqTaTuIjxcUvrF5erIvvNPWZ9hFaFhN+bi6GC7TDaJ
         yIZKwImkSNl/dMWIfNGxF2kGanUVgPVVTylVd4SzcHSq+5b9d6vf50jq4RqhdkZ7p1ox
         oexA==
X-Gm-Message-State: APjAAAVL3E5TxdpYDR495sIMrqYAqwvywCcS5YSzF8m3Nr8OtnFbeXDh
        wWo8V+FI2Kcygt7Dw+DO9f5rmn+djU4=
X-Google-Smtp-Source: APXvYqzchvJGXefIxPuNoOd4wTN3btKGMFD4WP/mMEbTgjvVxOIlpeXTxcuCBGQhNSUDctq5a6+q6g==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr2197247wmj.64.1562829010449;
        Thu, 11 Jul 2019 00:10:10 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id n14sm6911418wra.75.2019.07.11.00.10.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 00:10:09 -0700 (PDT)
Date:   Thu, 11 Jul 2019 09:10:07 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ 2/8] mesh: Fix support for Provisioner Initiator
Message-ID: <20190711071006.gyosotypqqdaql6b@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190710230757.8425-1-brian.gix@intel.com>
 <20190710230757.8425-3-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190710230757.8425-3-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 07/10, Brian Gix wrote:
> ---
>  mesh/pb-adv.c | 54 ++++++++++++++++++++++++++++++++++++------------------
>  mesh/pb-adv.h |  3 ++-
>  2 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
> index 8762afd7c..346293bd0 100644
> --- a/mesh/pb-adv.c
> +++ b/mesh/pb-adv.c
> @@ -65,6 +65,8 @@ struct pb_adv_session {
>  
>  static struct pb_adv_session *pb_session = NULL;
>  
> +static const uint8_t filter[1] = { MESH_AD_TYPE_PROVISION };
> +
>  static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
>  							uint16_t size)
>  {
> @@ -77,7 +79,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
>  	if (!size)
>  		return;
>  
> -	mesh_send_cancel(buf, 1);
> +	mesh_send_cancel(filter, sizeof(filter));
>  
>  	l_put_be32(session->conn_id, buf + 1);
>  	buf[1 + 4] = ++session->local_msg_num;
> @@ -103,7 +105,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
>  	l_debug("max_seg: %2.2x", max_seg);
>  	l_debug("size: %2.2x, CRC: %2.2x", size, buf[9]);
>  	/* print_packet("PB-TX", buf + 1, init_size + 9); */
> -	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 50, buf, init_size + 10);
> +	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200, buf, init_size + 10);
>  
>  	consumed = init_size;
>  
> @@ -120,7 +122,7 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
>  
>  		/* print_packet("PB-TX", buf + 1, seg_size + 6); */
>  
> -		mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 50,
> +		mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 200,
>  							buf, seg_size + 7);
>  
>  		consumed += seg_size;
> @@ -130,7 +132,6 @@ static void send_adv_segs(struct pb_adv_session *session, const uint8_t *data,
>  static void tx_timeout(struct l_timeout *timeout, void *user_data)
>  {
>  	struct pb_adv_session *session = user_data;
> -	uint8_t cancel[] = { MESH_AD_TYPE_PROVISION };
>  	mesh_prov_close_func_t cb;
>  
>  	if (!session || pb_session != session)
> @@ -139,7 +140,7 @@ static void tx_timeout(struct l_timeout *timeout, void *user_data)
>  	l_timeout_remove(session->tx_timeout);
>  	session->tx_timeout = NULL;
>  
> -	mesh_send_cancel(cancel, sizeof(cancel));
> +	mesh_send_cancel(filter, sizeof(filter));
>  
>  	l_info("TX timeout");
>  	cb = pb_session->close_cb;
> @@ -162,17 +163,29 @@ static void pb_adv_tx(void *user_data, uint8_t *data, uint16_t len)
>  	send_adv_segs(session, data, len);
>  }
>  
> +static void send_open_req(struct pb_adv_session *session)
> +{
> +	uint8_t open_req[23] = { MESH_AD_TYPE_PROVISION };
> +
> +	l_put_be32(session->conn_id, open_req + 1);
> +	open_req[1 + 4] = 0;
> +	open_req[1 + 4 + 1] = PB_ADV_OPEN_REQ;
> +	memcpy(open_req + 7, session->uuid, 16);
> +
> +	mesh_send_cancel(filter, sizeof(filter));
> +	mesh_send_pkt(MESH_IO_TX_COUNT_UNLIMITED, 500, open_req,
> +						sizeof(open_req));
> +}
> +
>  static void send_open_cfm(struct pb_adv_session *session)
>  {
>  	uint8_t open_cfm[7] = { MESH_AD_TYPE_PROVISION };
>  
>  	l_put_be32(session->conn_id, open_cfm + 1);
>  	open_cfm[1 + 4] = 0;
> -	open_cfm[1 + 4 + 1] = 0x07; /* OPEN_CFM */
> -
> -	/* print_packet("PB-TX", open_cfm + 1, sizeof(open_cfm) - 1); */
> +	open_cfm[1 + 4 + 1] = PB_ADV_OPEN_CFM; /* OPEN_CFM */
>  
> -	mesh_send_cancel(open_cfm, 1);
> +	mesh_send_cancel(filter, sizeof(filter));
>  	mesh_send_pkt(5, 100, open_cfm, sizeof(open_cfm));
>  }
>  
> @@ -182,9 +195,8 @@ static void send_ack(struct pb_adv_session *session, uint8_t msg_num)
>  
>  	l_put_be32(session->conn_id, ack + 1);
>  	ack[1 + 4] = msg_num;
> -	ack[1 + 4 + 1] = 0x01; /* ACK */
> +	ack[1 + 4 + 1] = PB_ADV_ACK;
>  
> -	/* print_packet("ADV-ACK", ack + 1, sizeof(ack) - 1); */
>  	mesh_send_pkt(1, 100, ack, sizeof(ack));
>  }
>  
> @@ -192,16 +204,16 @@ static void send_close_ind(struct pb_adv_session *session, uint8_t reason)
>  {
>  	uint8_t close_ind[8] = { MESH_AD_TYPE_PROVISION };
>  
> -	if (!pb_session || pb_session->user_data != session)
> +	if (!pb_session || pb_session != session)
>  		return;
>  
>  	l_put_be32(session->conn_id, close_ind + 1);
>  	close_ind[5] = 0;
> -	close_ind[6] = PB_ADV_CLOSE;		/* CLOSE_IND */
> +	close_ind[6] = PB_ADV_CLOSE;
>  	close_ind[7] = reason;
>  
> -	mesh_send_cancel(close_ind, 1);
> -	mesh_send_pkt(5, 100, close_ind, sizeof(close_ind));
> +	mesh_send_cancel(filter, sizeof(filter));
> +	mesh_send_pkt(10, 100, close_ind, sizeof(close_ind));
>  }
>  
>  static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
> @@ -311,7 +323,7 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
>  		if (session->local_acked > msg_num)
>  			return;
>  
> -		l_debug("Got ACK %d", msg_num);
> +		mesh_send_cancel(filter, sizeof(filter));
>  		session->local_acked = msg_num;
>  		session->ack_cb(session->user_data, msg_num);
>  		break;
> @@ -395,7 +407,8 @@ static void pb_adv_packet(void *user_data, const uint8_t *pkt, uint16_t len)
>  	}
>  }
>  
> -bool pb_adv_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
> +bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
> +		mesh_prov_close_func_t close_cb,
>  		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
>  		uint8_t uuid[16], void *user_data)
>  {
> @@ -408,11 +421,16 @@ bool pb_adv_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
>  	pb_session->rx_cb = rx_cb;
>  	pb_session->ack_cb = ack_cb;
>  	pb_session->user_data = user_data;
> +	pb_session->initiator = initiator;
>  	memcpy(pb_session->uuid, uuid, 16);
>  
> -	/* TODO: register PB AD type and Start Beaconing ? */
>  	mesh_reg_prov_rx(pb_adv_packet, pb_session);
>  
> +	if (initiator) {
> +		l_getrandom(&pb_session->conn_id, sizeof(pb_session->conn_id));
> +		send_open_req(pb_session);
> +	}

I would suggest renaming 'conn_id' to 'link_id' to be more aligned with the
spec. The same remark applies to 'msg_num' - it's called 'transaction
number' in the standard.

> +
>  	return true;
>  }
>  
> diff --git a/mesh/pb-adv.h b/mesh/pb-adv.h
> index a5870d5a2..80d53d234 100644
> --- a/mesh/pb-adv.h
> +++ b/mesh/pb-adv.h
> @@ -17,7 +17,8 @@
>   *
>   */
>  
> -bool pb_adv_reg(mesh_prov_open_func_t open_cb, mesh_prov_close_func_t close_cb,
> +bool pb_adv_reg(bool initiator, mesh_prov_open_func_t open_cb,
> +		mesh_prov_close_func_t close_cb,
>  		mesh_prov_receive_func_t rx_cb, mesh_prov_ack_func_t ack_cb,
>  		uint8_t uuid[16], void *user_data);
>  void pb_adv_unreg(void *user_data);

This change requires updating the callers to add the 'initiator'
argument. I think this should be:

prov-initiator.c, initiator_start():

	/* Always register for PB-ADV */
	result = pb_adv_reg(true, int_prov_open, int_prov_close, int_prov_rx,
						int_prov_ack, uuid, prov);

prov-acceptor.c, acceptor_start():

	/* Always register for PB-ADV */
	result = pb_adv_reg(false, acp_prov_open, acp_prov_close, acp_prov_rx,
						acp_prov_ack, uuid, prov);


-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
