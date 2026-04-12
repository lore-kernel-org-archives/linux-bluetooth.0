Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0152D97BB;
	Sun, 12 Apr 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775979516; cv=none; b=R4cLPhqFWqEEKtvQc2+egQnRz/H/HTBOQe2AJ1tvjGzCFu0ST8RrB5IT8JjMnfqAhazGBHpq3ruSOT03mpL02DGOAsfePShaRB0X619233ys44qtljCxtXYMp9aQZ6oV9wZuqwxDLySoknikSyGS7XJmtvHDMjXvUhwrK2Gm5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775979516; c=relaxed/simple;
	bh=klXkvAco3dCEhyPEk2nAJN7GzJnM1we71W3KS1Fsd1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gosr/dhfSEOwyW+3z0VMNaj7A6svRAeDfzlfgqmtPs5/B0QRFadduxqY89tRqAZfdj1Iqt1JEta7WI71J2/lzPJn0VeIP8+afDJEN2BesxnwS3K4ZniCZ2cdNQdG/d9oTJc1vlKcObiPsXewh1hVKvUjclDobXrMkHPJEG6ILN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc559e8.dip0.t-ipconnect.de [93.197.89.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E0A164C2C37F03;
	Sun, 12 Apr 2026 09:37:59 +0200 (CEST)
Message-ID: <e009a1a1-17df-4845-b72a-ca6442754472@molgen.mpg.de>
Date: Sun, 12 Apr 2026 09:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: RFCOMM: validate skb length in MCC handlers
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, kees@kernel.org, kuba@kernel.org,
 me@brighamcampbell.com, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260412045457.53100-1-suunj1331@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260412045457.53100-1-suunj1331@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear SeungJu,


Thank you for the patch.

Am 12.04.26 um 06:54 schrieb SeungJu Cheon:
> rfcomm_recv_pn(), rfcomm_recv_rpn(), rfcomm_recv_rls(), and
> rfcomm_recv_msc() cast skb->data to their respective structs
> without first checking skb->len. A remote device can send a
> short MCC frame, causing out-of-bounds reads from the skb buffer.

Nice catch. Do you have a reproducer to create such a short MCC frame?

> For rfcomm_recv_pn(), the uninitialized pn->mtu value is stored
> in d->mtu via rfcomm_apply_pn(), then echoed back to the remote
> device in the PN response, leaking kernel heap data.
> 
> This results in use of uninitialized memory, as reported by KMSAN.
> 
> Add explicit skb->len checks against the expected structure size
> at the start of each handler before accessing the payload.
> 
> =====================================================
> BUG: KMSAN: uninit-value in rfcomm_run+0x7eae/0xee90
>   rfcomm_run+0x7eae/0xee90
>   kthread+0x53f/0x600
>   ret_from_fork+0x20f/0x910
>   ret_from_fork_asm+0x1a/0x30
> 
> Uninit was created at:
>   kmem_cache_alloc_node_noprof+0x3cd/0x12d0
>   __alloc_skb+0x855/0x1190
>   vhci_write+0x125/0x960
>   vfs_write+0xbe1/0x15c0
>   ksys_write+0x1d9/0x470
>   __x64_sys_write+0x97/0xf0
>   x64_sys_call+0x2ff0/0x3ea0
>   do_syscall_64+0x134/0xf80
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 0 UID: 0 PID: 3374 Comm: krfcommd Tainted: G        W           7.0.0-rc7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Kernel panic - not syncing: kmsan.panic set ...
> =====================================================
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>   net/bluetooth/rfcomm/core.c | 40 +++++++++++++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 611a9a94151e..daeba71a1514 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1431,9 +1431,15 @@ static int rfcomm_apply_pn(struct rfcomm_dlc *d, int cr, struct rfcomm_pn *pn)
>   
>   static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
>   {
> -	struct rfcomm_pn *pn = (void *) skb->data;
> +	struct rfcomm_pn *pn;
>   	struct rfcomm_dlc *d;
> -	u8 dlci = pn->dlci;
> +	u8 dlci;
> +
> +	if (skb->len < sizeof(*pn))
> +		return -EINVAL;
> +
> +	pn = (void *) skb->data;
> +	dlci = pn->dlci;

gemini/gemini-3.1-pro-preview comments [1]. No idea if it’s a valid comment:

> Before these handlers are reached, rfcomm_recv_mcc() unconditionally casts
> skb->data to struct rfcomm_mcc * and reads mcc->type and mcc->len. Does
> this leave an out-of-bounds read unpatched if a remote device sends an MCC
> frame with 0 or 1 bytes of payload?
> Additionally, if rfcomm_recv_frame() unconditionally trims the FCS with
> skb->len--; skb->tail--;, could a 0-byte payload cause skb->len to
> underflow to UINT_MAX?
> Since skb->len is unsigned, this new check (UINT_MAX < 8) would evaluate to
> false, potentially bypassing this protection entirely.
>   
>   	BT_DBG("session %p state %ld dlci %d", s, s->state, dlci);
>   
> @@ -1483,8 +1489,8 @@ static int rfcomm_recv_pn(struct rfcomm_session *s, int cr, struct sk_buff *skb)
>   
>   static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_buff *skb)
>   {
> -	struct rfcomm_rpn *rpn = (void *) skb->data;
> -	u8 dlci = __get_dlci(rpn->dlci);
> +	struct rfcomm_rpn *rpn;
> +	u8 dlci;
>   
>   	u8 bit_rate  = 0;
>   	u8 data_bits = 0;
> @@ -1495,6 +1501,12 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
>   	u8 xoff_char = 0;
>   	u16 rpn_mask = RFCOMM_RPN_PM_ALL;
>   
> +	if (skb->len < sizeof(*rpn))
> +		return -EINVAL;

gemini/gemini-3.1-pro-preview comments [1]:

> Does this unconditionally drop legitimate 1-byte Remote Port Negotiation
> (RPN) requests?
> Looking at the existing code further down in rfcomm_recv_rpn():
>     if (len == 1) {
>         /* This is a request, return default (according to ETSI TS 07.10) settings */
>         ...
> Since sizeof(struct rfcomm_rpn) is 8 bytes, enforcing this minimum length
> would reject valid 1-byte queries allowed by the ETSI TS 07.10 standard.


> +
> +	rpn = (void *) skb->data;
> +	dlci = __get_dlci(rpn->dlci);
> +
>   	BT_DBG("dlci %d cr %d len 0x%x bitr 0x%x line 0x%x flow 0x%x xonc 0x%x xoffc 0x%x pm 0x%x",
>   		dlci, cr, len, rpn->bit_rate, rpn->line_settings, rpn->flow_ctrl,
>   		rpn->xon_char, rpn->xoff_char, rpn->param_mask);
> @@ -1589,8 +1601,14 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
>   
>   static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb)
>   {
> -	struct rfcomm_rls *rls = (void *) skb->data;
> -	u8 dlci = __get_dlci(rls->dlci);
> +	struct rfcomm_rls *rls;
> +	u8 dlci;
> +
> +	if (skb->len < sizeof(*rls))
> +		return -EINVAL;
> +
> +	rls = (void *) skb->data;
> +	dlci = __get_dlci(rls->dlci);
>   
>   	BT_DBG("dlci %d cr %d status 0x%x", dlci, cr, rls->status);
>   
> @@ -1608,9 +1626,15 @@ static int rfcomm_recv_rls(struct rfcomm_session *s, int cr, struct sk_buff *skb
>   
>   static int rfcomm_recv_msc(struct rfcomm_session *s, int cr, struct sk_buff *skb)
>   {
> -	struct rfcomm_msc *msc = (void *) skb->data;
> +	struct rfcomm_msc *msc;
>   	struct rfcomm_dlc *d;
> -	u8 dlci = __get_dlci(msc->dlci);
> +	u8 dlci;
> +
> +	if (skb->len < sizeof(*msc))
> +		return -EINVAL;
> +
> +	msc = (void *) skb->data;
> +	dlci = __get_dlci(msc->dlci);
>   
>   	BT_DBG("dlci %d cr %d v24 0x%x", dlci, cr, msc->v24_sig);
>   


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260412045457.53100-1-suunj1331%40gmail.com
