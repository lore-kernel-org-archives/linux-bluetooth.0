Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C288EC43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 07:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E720714
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 07:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="YuyuhRF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgDAHvY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:51:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33931 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHvY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 03:51:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id e7so19630301lfq.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=404v5IEOHpJiL6R3YV0ECvl8o0TmXxk3g8erqaXZDrk=;
        b=YuyuhRF13R+6QAMXaYsmauNmm/NWr3dWacKzuC6kFqD/CN27V/+n3Ua+8gqQw1HxBQ
         uQwFih5H1dfqmMnTBTv7vOftotGb+uWE/XCjuuwfJR3Lxf9a4UUuYv679KJrigf5pwUb
         Oz6virM+x+EMP4NQxJBtCQCm3sV/PocnjRwuWCqfouF49VFQ47S7+voxEL9W1LqkJRcA
         26VsCwm8s9y+j8bm/1KspuhQWFcHpyR9nDpWhpLyu07PWyd3eC+ub+vUbhBKoYPL+6Uv
         m26WX2uq0moIFLa3ioTD7VA40y40Ecp1UPEUqYVYdj3iQK1MKOOBX4u+ptWjc8DcSmYl
         AP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=404v5IEOHpJiL6R3YV0ECvl8o0TmXxk3g8erqaXZDrk=;
        b=Qv8pyGzTCLBWItz6F8GHmWvP+IFhDLK6vDJlzs3UZbTErBaE4gMC+IT6HMxLGaV7LN
         jIfSVfTKGSKX8E+htd/I5Wwbn9yOc96BzujfKYTpFkCCpz8nSUJyvmLeHnsVedEAwmUo
         Rrk1H6VSVdxf0gSSgD8xBU+0ULTp4mAJHdgIYwZESq8Zn/SW/GAG7k19nsxXEfGqWKti
         9/BGWoK9Xs5N3nA57+zlkPoa1dwdN+3n+XKxOKzAKhqsBL+L9APP+aI2GUuDHizDUg/B
         5YPLSk08uoI+rh/kncWDc6BR8l9mMqFf7Nsw717IChRp8+YNFO+RJLSfuRKs+vdXcgSh
         eHNQ==
X-Gm-Message-State: AGi0PuYq6fcA/J4ESAkFpZZO6a05O4J1vFj/wNuFqyZfpCC4VDTnsbl6
        +2lPbTZZwOp93o4gB2mhyLuFdg==
X-Google-Smtp-Source: APiQypI9Rh2fFZjPOrbXTX2kw7Pu0IZFQCCwxE++lHsOHxjjhPrJpYPfk4YUL5Cp6N09rKTV7BqY9w==
X-Received: by 2002:ac2:4113:: with SMTP id b19mr4293390lfi.70.1585727480102;
        Wed, 01 Apr 2020 00:51:20 -0700 (PDT)
Received: from [192.168.65.55] (174.60.citypartner.pl. [195.210.60.174])
        by smtp.gmail.com with ESMTPSA id r10sm659675ljk.13.2020.04.01.00.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 00:51:19 -0700 (PDT)
Subject: Re: [PATCH BlueZ v3] mesh: Add net key index to sar structure
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, michal.lowas-rzechonek@silvair.com
References: <20200331174606.18539-1-brian.gix@intel.com>
From:   =?UTF-8?Q?Przemys=c5=82aw_Fierek?= <przemyslaw.fierek@silvair.com>
Message-ID: <563cc1aa-c9c4-ee22-1dd9-e7dd1f7d2f63@silvair.com>
Date:   Wed, 1 Apr 2020 09:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331174606.18539-1-brian.gix@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,


Patch v3 looks good. Please apply it.


Best Regards,

Przemek Fierek

On 31.03.2020 19:46, Brian Gix wrote:
> ---
>   mesh/friend.c | 16 ++++++++--------
>   mesh/net.c    | 38 +++++++++++++++++++++++---------------
>   mesh/net.h    |  7 ++++---
>   3 files changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/mesh/friend.c b/mesh/friend.c
> index 6d26de15b..d27da9592 100644
> --- a/mesh/friend.c
> +++ b/mesh/friend.c
> @@ -97,7 +97,7 @@ static void response_delay(struct l_timeout *timeout, void *user_data)
>   	n += 2;
>   	seq = mesh_net_next_seq_num(neg->net);
>   	print_packet("Tx-NET_OP_FRND_OFFER", msg, n);
> -	mesh_net_transport_send(neg->net, key_id,
> +	mesh_net_transport_send(neg->net, key_id, 0,
>   			mesh_net_get_iv_index(neg->net), 0,
>   			seq, 0, neg->lp_addr,
>   			msg, n);
> @@ -316,7 +316,7 @@ void friend_clear(struct mesh_net *net, uint16_t src, uint16_t lpn,
>   
>   	l_put_be16(lpn, msg + 1);
>   	l_put_be16(lpnCounter, msg + 3);
> -	mesh_net_transport_send(net, 0,
> +	mesh_net_transport_send(net, 0, 0,
>   			mesh_net_get_iv_index(net), DEFAULT_TTL,
>   			0, 0, src,
>   			msg, sizeof(msg));
> @@ -332,7 +332,7 @@ static void clear_retry(struct l_timeout *timeout, void *user_data)
>   
>   	l_put_be16(neg->lp_addr, msg + 1);
>   	l_put_be16(neg->lp_cnt, msg + 3);
> -	mesh_net_transport_send(neg->net, 0,
> +	mesh_net_transport_send(neg->net, 0, 0,
>   			mesh_net_get_iv_index(neg->net), DEFAULT_TTL,
>   			0, 0, neg->old_friend,
>   			msg, sizeof(msg));
> @@ -398,7 +398,7 @@ static void friend_delay_rsp(struct l_timeout *timeout, void *user_data)
>   					pkt->u.one[0].data, pkt->last_len);
>   
>   			pkt->u.one[0].sent = true;
> -			mesh_net_transport_send(net, frnd->net_key_cur,
> +			mesh_net_transport_send(net, frnd->net_key_cur, 0,
>   					pkt->iv_index, pkt->ttl,
>   					pkt->u.one[0].seq, pkt->src, pkt->dst,
>   					pkt->u.one[0].data, pkt->last_len);
> @@ -439,7 +439,7 @@ update:
>   	l_put_be32(iv_index, upd + 2);
>   	upd[6] = false; /* Queue is Empty */
>   	print_packet("Update", upd, sizeof(upd));
> -	mesh_net_transport_send(net, frnd->net_key_cur,
> +	mesh_net_transport_send(net, frnd->net_key_cur, 0,
>   			mesh_net_get_iv_index(net), 0,
>   			net_seq, 0, frnd->lp_addr,
>   			upd, sizeof(upd));
> @@ -487,7 +487,7 @@ void friend_poll(struct mesh_net *net, uint16_t src, bool seq,
>   			neg->u.negotiate.clearing = true;
>   			l_put_be16(neg->lp_addr, msg + 1);
>   			l_put_be16(neg->lp_cnt, msg + 3);
> -			mesh_net_transport_send(net, 0,
> +			mesh_net_transport_send(net, 0, 0,
>   					mesh_net_get_iv_index(net), DEFAULT_TTL,
>   					0, 0, neg->old_friend,
>   					msg, sizeof(msg));
> @@ -596,7 +596,7 @@ void friend_sub_add(struct mesh_net *net, struct mesh_friend *frnd,
>   
>   	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
>   	net_seq = mesh_net_get_seq_num(net);
> -	mesh_net_transport_send(net, frnd->net_key_cur,
> +	mesh_net_transport_send(net, frnd->net_key_cur, 0,
>   			mesh_net_get_iv_index(net), 0,
>   			net_seq, 0, frnd->lp_addr,
>   			msg, sizeof(msg));
> @@ -634,7 +634,7 @@ void friend_sub_del(struct mesh_net *net, struct mesh_friend *frnd,
>   
>   	print_packet("Tx-NET_OP_PROXY_SUB_CONFIRM", msg, sizeof(msg));
>   	net_seq = mesh_net_get_seq_num(net);
> -	mesh_net_transport_send(net, frnd->net_key_cur,
> +	mesh_net_transport_send(net, frnd->net_key_cur, 0,
>   			mesh_net_get_iv_index(net), 0,
>   			net_seq, 0, frnd->lp_addr,
>   			msg, sizeof(msg));
> diff --git a/mesh/net.c b/mesh/net.c
> index 5f49034e4..9a56d2ee8 100644
> --- a/mesh/net.c
> +++ b/mesh/net.c
> @@ -179,6 +179,7 @@ struct mesh_sar {
>   	uint32_t seqAuth;
>   	uint16_t seqZero;
>   	uint16_t app_idx;
> +	uint16_t net_idx;
>   	uint16_t src;
>   	uint16_t remote;
>   	uint16_t len;
> @@ -1566,7 +1567,7 @@ static void send_frnd_ack(struct mesh_net *net, uint16_t src, uint16_t dst,
>   		friend_ack_rxed(net, mesh_net_get_iv_index(net),
>   				mesh_net_next_seq_num(net), 0, dst, msg);
>   	} else {
> -		mesh_net_transport_send(net, 0,
> +		mesh_net_transport_send(net, 0, 0,
>   				mesh_net_get_iv_index(net), DEFAULT_TTL,
>   				0, 0, dst, msg, sizeof(msg));
>   	}
> @@ -1601,9 +1602,10 @@ static void send_net_ack(struct mesh_net *net, struct mesh_sar *sar,
>   		return;
>   	}
>   
> -	mesh_net_transport_send(net, 0,
> +	mesh_net_transport_send(net, 0, sar->net_idx,
>   				mesh_net_get_iv_index(net), DEFAULT_TTL,
> -				0, src, dst, msg, sizeof(msg));
> +				0, src, dst, msg,
> +				sizeof(msg));
>   }
>   
>   static void inseg_to(struct l_timeout *seg_timeout, void *user_data)
> @@ -2012,6 +2014,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
>   		sar_in->key_aid = key_aid;
>   		sar_in->len = len;
>   		sar_in->last_seg = 0xff;
> +		sar_in->net_idx = net_idx;
>   		sar_in->msg_timeout = l_timeout_create(MSG_TO,
>   					inmsg_to, net, NULL);
>   
> @@ -2208,7 +2211,7 @@ static bool ctl_received(struct mesh_net *net, uint16_t key_id,
>   	}
>   
>   	if (n) {
> -		mesh_net_transport_send(net, 0,
> +		mesh_net_transport_send(net, 0, 0,
>   				mesh_net_get_iv_index(net), rsp_ttl,
>   				0, dst & 0x8000 ? 0 : dst, src,
>   				msg, n);
> @@ -3031,7 +3034,6 @@ bool mesh_net_flush(struct mesh_net *net)
>   	return true;
>   }
>   
> -/* TODO: add net key index */
>   static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
>   {
>   	struct mesh_subnet *subnet;
> @@ -3041,7 +3043,6 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
>   	uint8_t packet_len;
>   	uint8_t segN = SEG_MAX(msg->segmented, msg->len);
>   	uint16_t seg_off = SEG_OFF(segO);
> -	uint32_t key_id = 0;
>   	uint32_t seq_num;
>   
>   	if (msg->segmented) {
> @@ -3082,10 +3083,13 @@ static bool send_seg(struct mesh_net *net, struct mesh_sar *msg, uint8_t segO)
>   	}
>   	print_packet("Clr-Net Tx", packet + 1, packet_len);
>   
> -	subnet = get_primary_subnet(net);
> -	key_id = subnet->net_key_tx;
> +	subnet = l_queue_find(net->subnets, match_key_index,
> +						L_UINT_TO_PTR(msg->net_idx));
> +	if (!subnet)
> +		return false;
>   
> -	if (!net_key_encrypt(key_id, msg->iv_index, packet + 1, packet_len)) {
> +	if (!net_key_encrypt(subnet->net_key_tx, msg->iv_index, packet + 1,
> +							     packet_len)) {
>   		l_error("Failed to encode packet");
>   		return false;
>   	}
> @@ -3217,6 +3221,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
>   	payload->szmic = szmic;
>   	payload->frnd_cred = frnd_cred;
>   	payload->key_aid = key_aid;
> +	payload->net_idx = net_idx;
>   	payload->iv_index = mesh_net_get_iv_index(net);
>   	payload->seqAuth = seq;
>   	payload->segmented = segmented;
> @@ -3321,11 +3326,11 @@ void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
>   	l_free(str);
>   }
>   
> -/* TODO: add net key index */
>   void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
> -				uint32_t iv_index, uint8_t ttl,
> -				uint32_t seq, uint16_t src, uint16_t dst,
> -				const uint8_t *msg, uint16_t msg_len)
> +				uint16_t net_idx, uint32_t iv_index,
> +				uint8_t ttl, uint32_t seq, uint16_t src,
> +				uint16_t dst, const uint8_t *msg,
> +				uint16_t msg_len)
>   {
>   	uint32_t use_seq = seq;
>   	uint8_t pkt_len;
> @@ -3373,7 +3378,10 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
>   	}
>   
>   	if (!key_id) {
> -		struct mesh_subnet *subnet = get_primary_subnet(net);
> +		struct mesh_subnet *subnet = l_queue_find(net->subnets,
> +				match_key_index, L_UINT_TO_PTR(net_idx));
> +		if (!subnet)
> +			return;
>   
>   		key_id = subnet->net_key_tx;
>   		use_seq = mesh_net_next_seq_num(net);
> @@ -3556,7 +3564,7 @@ void mesh_net_heartbeat_send(struct mesh_net *net)
>   	l_put_be16(hb->features, msg + n);
>   	n += 2;
>   
> -	mesh_net_transport_send(net, 0, mesh_net_get_iv_index(net),
> +	mesh_net_transport_send(net, 0, 0, mesh_net_get_iv_index(net),
>   				hb->pub_ttl, 0, 0, hb->pub_dst, msg, n);
>   }
>   
> diff --git a/mesh/net.h b/mesh/net.h
> index df4366b59..60396dbe7 100644
> --- a/mesh/net.h
> +++ b/mesh/net.h
> @@ -305,9 +305,10 @@ struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
>   
>   bool mesh_net_flush(struct mesh_net *net);
>   void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
> -				uint32_t iv_index, uint8_t ttl,
> -				uint32_t seq, uint16_t src, uint16_t dst,
> -				const uint8_t *msg, uint16_t msg_len);
> +				uint16_t net_idx, uint32_t iv_index,
> +				uint8_t ttl, uint32_t seq, uint16_t src,
> +				uint16_t dst, const uint8_t *msg,
> +				uint16_t msg_len);
>   
>   bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
>   				uint16_t dst, uint8_t key_id, uint16_t net_idx,
> -- 
