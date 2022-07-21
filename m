Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED6DC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 07:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiGUHnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGUHnT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jul 2022 03:43:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F3D6A9C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 00:43:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so358161wmo.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jul 2022 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BmLagP/rVwbAck5RhGzzhptysAm/s45OPGdy1QhJJI0=;
        b=IITyuFRWtRDMdMyps/xFVWU+dzPm+43MHKaGfV/neqV8wLAfM4Ywgznz6FFkhH281c
         7Jvu0iM3QGtwWTIK2bDQuWAR+FX3cDAAqO8HEKtF3uls0NRkhjA8gUTyX4b+AqqTMHOS
         caTb3JTNEWiUDUVJyqW5Y7ZUnp8DqaXPamMNp2CFvR3dEIYJHLyA/lnFNsGHfaeIVApp
         PVtG1u4sxU+Jt18kuH/VdDvmf/Y8PXQ0ZpWzanSZ8Kf9HoGK1tFwZ/P0T1GggY677cTp
         yIWScMG6vjzGhhlaaofLbsVy+iZA16hZnnduz5soiIaqDD13m5m7mKgzzg5CvGYnwB9t
         J7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BmLagP/rVwbAck5RhGzzhptysAm/s45OPGdy1QhJJI0=;
        b=2emmlUremNd0XiVQ02/VGGrw7y5Bz0Q8xsaOi+0iRImPzhuyAVp4EYwFtDYtVP89gU
         0VDomB+DKcP6DwYx6J3IqW+ybwC1qLQMn3QMBXpksEr6bb2apAcNexnAC7+wMhGLENrF
         Jj7Q2n5CpabRL7peWn7e7AHwUS3Y0gWwCjq6qheLBs2A6/kukO0n3JaiCmi/ItPqi9qY
         nn+dGyEWtMwC4Fb+8fSowJKIL+tOSY7SJJ9tePfUV4WgvrmDXwAqNMqATuRDS3qIEb02
         KDAtECMLkva4pzhN/zgqNm0WqxcZgPbenqzaONwVNlhLLSy+3l3lfxJE6QUzZ2rcuxe8
         /MHQ==
X-Gm-Message-State: AJIora+v/4D68cAFbEv4C0Xd0Cnx7Yev31qCW7YNIb5CYAUH9hmCjYwF
        T3u6+CtP2OJLJWE4suPnRmNhHkDtHVFqaA==
X-Google-Smtp-Source: AGRyM1v7HpRE6mENt5EMxroeurbLcH6hWuRr7PDX09Qs6ovzkVGRTeEMg0Or6hVXUMZdepfJtnjQiw==
X-Received: by 2002:a05:600c:4f43:b0:3a2:ee79:2dd5 with SMTP id m3-20020a05600c4f4300b003a2ee792dd5mr6898574wmq.143.1658389396181;
        Thu, 21 Jul 2022 00:43:16 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n13-20020adffe0d000000b0021e45afa7b0sm1044086wrr.109.2022.07.21.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:43:15 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:43:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free caused by
 l2cap_chan_put
Message-ID: <YtkDklSo4kYRCR2a@google.com>
References: <20220720170648.148219-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720170648.148219-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 20 Jul 2022, Luiz Augusto von Dentz wrote:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace which is caused by hci_rx_work starting up
> *after* the final channel reference has been put() during sock_close() but
> *before* the references to the channel have been destroyed, so instead
> the code now rely on kref_get_unless_zero/l2cap_chan_hold_unless_zero to
> prevent referencing a channel that is about to be destroyed.
> 
>   refcount_t: increment on 0; use-after-free.
>   BUG: KASAN: use-after-free in refcount_dec_and_test+0x20/0xd0
>   Read of size 4 at addr ffffffc114f5bf18 by task kworker/u17:14/705
> 
>   CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W
>   4.14.234-00003-g1fb6d0bd49a4-dirty #28
>   Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150
>   Google Inc. MSM sm8150 Flame DVT (DT)
>   Workqueue: hci0 hci_rx_work
>   Call trace:
>    dump_backtrace+0x0/0x378
>    show_stack+0x20/0x2c
>    dump_stack+0x124/0x148
>    print_address_description+0x80/0x2e8
>    __kasan_report+0x168/0x188
>    kasan_report+0x10/0x18
>    __asan_load4+0x84/0x8c
>    refcount_dec_and_test+0x20/0xd0
>    l2cap_chan_put+0x48/0x12c
>    l2cap_recv_frame+0x4770/0x6550
>    l2cap_recv_acldata+0x44c/0x7a4
>    hci_acldata_packet+0x100/0x188
>    hci_rx_work+0x178/0x23c
>    process_one_work+0x35c/0x95c
>    worker_thread+0x4cc/0x960
>    kthread+0x1a8/0x1c4
>    ret_from_fork+0x10/0x18
> 
> Cc: stable@kernel.org
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Signed-off-by isn't the correct tag for this since I wasn't
responsible for any of the coding, nor am I in the merge path.

Either as a v2 or when the patch is applied, please swap out for:

Reported-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Lee Jones <lee.jones@linaro.org>

> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 61 +++++++++++++++++++++++++++--------
>  2 files changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 3c4f550e5a8b..2f766e3437ce 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -847,6 +847,7 @@ enum {
>  };
>  
>  void l2cap_chan_hold(struct l2cap_chan *c);
> +struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c);
>  void l2cap_chan_put(struct l2cap_chan *c);
>  
>  static inline void l2cap_chan_lock(struct l2cap_chan *chan)
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 09ecaf556de5..77c0aac14539 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -111,7 +111,8 @@ static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn,
>  }
>  
>  /* Find channel with given SCID.
> - * Returns locked channel. */
> + * Returns a reference locked channel.
> + */
>  static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
>  						 u16 cid)
>  {
> @@ -119,15 +120,19 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn,
>  
>  	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_scid(conn, cid);
> -	if (c)
> -		l2cap_chan_lock(c);
> +	if (c) {
> +		/* Only lock if chan reference is not 0 */
> +		c = l2cap_chan_hold_unless_zero(c);
> +		if (c)
> +			l2cap_chan_lock(c);
> +	}
>  	mutex_unlock(&conn->chan_lock);
>  
>  	return c;
>  }
>  
>  /* Find channel with given DCID.
> - * Returns locked channel.
> + * Returns a reference locked channel.
>   */
>  static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
>  						 u16 cid)
> @@ -136,8 +141,12 @@ static struct l2cap_chan *l2cap_get_chan_by_dcid(struct l2cap_conn *conn,
>  
>  	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_dcid(conn, cid);
> -	if (c)
> -		l2cap_chan_lock(c);
> +	if (c) {
> +		/* Only lock if chan reference is not 0 */
> +		c = l2cap_chan_hold_unless_zero(c);
> +		if (c)
> +			l2cap_chan_lock(c);
> +	}
>  	mutex_unlock(&conn->chan_lock);
>  
>  	return c;
> @@ -162,8 +171,12 @@ static struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn,
>  
>  	mutex_lock(&conn->chan_lock);
>  	c = __l2cap_get_chan_by_ident(conn, ident);
> -	if (c)
> -		l2cap_chan_lock(c);
> +	if (c) {
> +		/* Only lock if chan reference is not 0 */
> +		c = l2cap_chan_hold_unless_zero(c);
> +		if (c)
> +			l2cap_chan_lock(c);
> +	}
>  	mutex_unlock(&conn->chan_lock);
>  
>  	return c;
> @@ -497,6 +510,16 @@ void l2cap_chan_hold(struct l2cap_chan *c)
>  	kref_get(&c->kref);
>  }
>  
> +struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c)
> +{
> +	BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
> +
> +	if (!kref_get_unless_zero(&c->kref))
> +		return NULL;
> +
> +	return c;
> +}
> +
>  void l2cap_chan_put(struct l2cap_chan *c)
>  {
>  	BT_DBG("chan %p orig refcnt %u", c, kref_read(&c->kref));
> @@ -1969,7 +1992,10 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
>  			src_match = !bacmp(&c->src, src);
>  			dst_match = !bacmp(&c->dst, dst);
>  			if (src_match && dst_match) {
> -				l2cap_chan_hold(c);
> +				c = l2cap_chan_hold_unless_zero(c);
> +				if (!c)
> +					continue;
> +
>  				read_unlock(&chan_list_lock);
>  				return c;
>  			}
> @@ -1984,7 +2010,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
>  	}
>  
>  	if (c1)
> -		l2cap_chan_hold(c1);
> +		c1 = l2cap_chan_hold_unless_zero(c1);
>  
>  	read_unlock(&chan_list_lock);
>  
> @@ -4464,6 +4490,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
>  
>  unlock:
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  	return err;
>  }
>  
> @@ -4578,6 +4605,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
>  
>  done:
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  	return err;
>  }
>  
> @@ -5305,6 +5333,7 @@ static inline int l2cap_move_channel_req(struct l2cap_conn *conn,
>  	l2cap_send_move_chan_rsp(chan, result);
>  
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  
>  	return 0;
>  }
> @@ -5397,6 +5426,7 @@ static void l2cap_move_continue(struct l2cap_conn *conn, u16 icid, u16 result)
>  	}
>  
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  }
>  
>  static void l2cap_move_fail(struct l2cap_conn *conn, u8 ident, u16 icid,
> @@ -5426,6 +5456,7 @@ static void l2cap_move_fail(struct l2cap_conn *conn, u8 ident, u16 icid,
>  	l2cap_send_move_chan_cfm(chan, L2CAP_MC_UNCONFIRMED);
>  
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  }
>  
>  static int l2cap_move_channel_rsp(struct l2cap_conn *conn,
> @@ -5489,6 +5520,7 @@ static int l2cap_move_channel_confirm(struct l2cap_conn *conn,
>  	l2cap_send_move_chan_cfm_rsp(conn, cmd->ident, icid);
>  
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  
>  	return 0;
>  }
> @@ -5524,6 +5556,7 @@ static inline int l2cap_move_channel_confirm_rsp(struct l2cap_conn *conn,
>  	}
>  
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  
>  	return 0;
>  }
> @@ -5896,12 +5929,11 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
>  	if (credits > max_credits) {
>  		BT_ERR("LE credits overflow");
>  		l2cap_send_disconn_req(chan, ECONNRESET);
> -		l2cap_chan_unlock(chan);
>  
>  		/* Return 0 so that we don't trigger an unnecessary
>  		 * command reject packet.
>  		 */
> -		return 0;
> +		goto unlock;
>  	}
>  
>  	chan->tx_credits += credits;
> @@ -5912,7 +5944,9 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
>  	if (chan->tx_credits)
>  		chan->ops->resume(chan);
>  
> +unlock:
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  
>  	return 0;
>  }
> @@ -7598,6 +7632,7 @@ static void l2cap_data_channel(struct l2cap_conn *conn, u16 cid,
>  
>  done:
>  	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
>  }
>  
>  static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
> @@ -8086,7 +8121,7 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
>  		if (src_type != c->src_type)
>  			continue;
>  
> -		l2cap_chan_hold(c);
> +		c = l2cap_chan_hold_unless_zero(c);
>  		read_unlock(&chan_list_lock);
>  		return c;
>  	}

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
