Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546F3FA5E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902650; cv=pass; b=LNWFRYf3MEBOzSFfuq6Nf6RTNmpXJ41odkKXGOdLfSs4KRLs7wXjrd1HwA6Sj6KX3bELD2PIebBaJBAW3LRox3Y+t7RidCMEv7TmcDke4ZePDKXeseIec6hcsXLc4mBwHykKBJqJrBNbcv5bJX6go8/MvES2isrpWxjUxyn7wbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902650; c=relaxed/simple;
	bh=MA6sP6dXRxWesg/4OAgbGsLj9XIL/e42mlrA2trIl3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNWVNGbFf2OfqYb9DxvYjmEjCOltJpYB1j0sXbrkTZ3k49dkOa593KFifG0nHAuyetZKum1j/ESwxUlKr+hcpb+dCO1bwD5olQeY5hZPY7ZzgVqSk4v989AbbTftJCgetVH26bE/Om5MGkRJ6gLFwqoKE1/c5mkHxv1ZRY9o2Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oioxcsSV; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oioxcsSV"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679334baa1fso2397607d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791902648; cv=none;
        d=google.com; s=arc-20260327;
        b=kyrW7anBgWQ7nn081gsExo5ZvKImGly7xa+JAlFmz9Lt2w0+xxoLjeNd3ydHB5ZKlN
         i6+R4reZgOYQvlehTybL55ObxSvyq8fUyg9QmXwAOXFxHlwTRhbRWTyB3mUI5JtKotVO
         GH9kY6aq2HYrCiZLQnu8PU2hZsIq7luQwawmghDIJFNzva8x/9YqPLyl9cSM2zSRtIGC
         ZCaY65gzq9UtuGRLOrwDkDuN64Jr0t+eyeDku7oApbJAj9xzBiLE62qUzxtUmevV6mdI
         iGWJLje8x/sLj2GBY4v1IJyh9h0iLhPCN28xn+h9uksZPCh9X2HsYe+c76g9XPajbSlP
         tx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=atduYo+ztkM6ugcnct8YLiRvmZz5QJJQ9yuNM0yfFDk=;
        fh=bAf3uaujpCfZ+gfuJE9eD1gL5QYFdHZrAlQVfG7eWXo=;
        b=VBT+1UwCWBcFIjXVvIL5JCbzKDQU63Y73keQsmwzieU1Lt4DLaSGA+ELhi0SBtjqXb
         I3J14MaHODUlVfxPDYsj72DfnvY9gXcOd+nMut3O6+i2EGNEnl2zdB2X1ys6xoeLR4AS
         9cAYEj3/QXiohaU5VAav5+C1ybh92r1P2h93bQMaNl4VQ+iCoa50Xh4I/lce8VldGRoe
         QkoLKlhi2JGI5Y+AOcN0Bk9IaqoIo3Qq+7KhXblRU3UdyPsoDe4FLu5sMy551gfu/ktz
         y1lOvFu6/Qy6dM1B/T7Zexo+m1ux6932FKnaE4cSdkMAUjHUJGI4ijx4jK3UiTp8lKcX
         muuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791902648; x=1792507448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=atduYo+ztkM6ugcnct8YLiRvmZz5QJJQ9yuNM0yfFDk=;
        b=oioxcsSV1jX4G6SkVvKEn08Rh1wVAG78rQv3RdEpdS/4e/XZvcfL4jqTBNT3z7CTTS
         IjuwObMFQ0RlBIU+3NKn3H0p06yspFjapBEF2Bbw+fAaU8RIeos46SAQ1sFQdRJToo8x
         i7RdOu3/ucEwQGkeDHbQpv2P812EfBULHcf/XkJJVvKobqAIqp+zPK8/2YFzRc97im5h
         RUNOluwU/R8DSon4caf6kUZzlhymwHcru40ZzEcTWOfnBNcBmLRCUM+Kq/2lHBRSX+KJ
         NzJvIMb4kSzdAHy/+DxLYPcOEY67xXJSNhhuahAwJntQtvj0PeixUiGAJTDfdHJZH5/A
         oQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791902648; x=1792507448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atduYo+ztkM6ugcnct8YLiRvmZz5QJJQ9yuNM0yfFDk=;
        b=R3qLD8M7Q66wBZE9h5apIYEwkNIco063PVR6wa+m9VJ488FeKJXJ88ungXxvsbndfN
         N0zyT7m79U+iyXoYl4ayGBZpimPo5TkALNHYbXTBRPKVMYi3pPtH/bf1YzGuIXemj2oA
         SuiTef/IuR5ZWx0iE29BOG0tyrIrqFioVGklhMnToPPkAEi5diGL0EK/WCDuHOp+TOsR
         AyxWp+h3rah/Gk4vsHy5ggIh/k1TM7sL//DiVXx8+sUmizgS7gFjs76yasyHF2GYFGaN
         DyLyDQPWw9YfCe+01Bo6z7HUYrTlylMFkBVlQw4nsxtwl+OtyAG77W98aiJtjSeBuzmx
         TjhQ==
X-Gm-Message-State: AFq9FYK2D7Xw5o6NYNXvo19aNu17CsV2PwSy30wAJ0kUlcm//uuZLp7k
	4wDX3JfXcbqu05M+0+++pyfHN7nwmq6PAg7nJgHsIu8i4xCTOz1iTavfdxba+HaciWbPYyxzZh5
	OWrlU4evlj6zfh7YEnAvXlFLLLU5ksV8=
X-Gm-Gg: AYBFou3BKFMmth935b9UUeBndz1ZiEV1V64qiRtX0tXTOfJJ2nBjbedzSisoC8e77Nz
	jDHMBjMSEqAVna/IwKlISRNJvTyAP3pgY6a+5EIL6zfppsZpgrq2Ls5YyzWiygiVEPbCWAEilpY
	CV8ESQvprnWzNPe9xYQd+01nIABewKWtELRxWVCga1H4Uv2ztKwXt0FJ9fx08+d/qP7W+vS3ZPQ
	h6fdhZzvLZHlsnVVuvbhfohjR+1URuK1EywOwAILRox1mCfPizHUbK+2f0Ni23BnSRLK24am0DY
	NXadv2bRyNWScWS/PC8nck6Vpiyhxa1KUNDfjEK8kfBiS/KDRJr44eYZse3R0yezusPUQBRpnOn
	OCc9jso2QIgstHFbtlQbCfpDeMrhoRstAttHXRNV0+A==
X-Received: by 2002:a05:690e:43c5:b0:671:3036:42bf with SMTP id
 956f58d0204a3-679362d4543mr1887297d50.91.1791902647582; Tue, 13 Oct 2026
 07:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013031943.489829-1-cochcoder@proton.me>
In-Reply-To: <20261013031943.489829-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Oct 2026 10:43:54 -0400
X-Gm-Features: AclHuK_yIlUUXWCuWRRo25-uRMur7Xtx4RX0jWSulcxBiJ6GnOX20DiZb3u9uYo
Message-ID: <CABBYNZJJf3owtAwGs4OuL6+YZz+zuY_kewKFDZPQdfcF-xyFFA@mail.gmail.com>
Subject: Re: [RFC PATCH] Bluetooth: L2CAP: tolerate zero-ident LE credit indications
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Mon, Oct 12, 2026 at 11:20=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
>
> A nonconforming ASHA peer sends identifier-zero credit indications
> that are discarded, reducing usable transmit credits until audio stalls.
>
> Tolerate only exact-size credit indications for a connected LE CoC.
> Preserve the channel reference, lock and credit-overflow checks and do
> not send a response with identifier zero. Other zero-ID commands and
> BR/EDR signaling remain unchanged.
>
> Core Vol 3 Part A section 4 forbids identifier zero. This is an
> interoperability RFC requiring maintainer agreement, not a conformance
> fix or a claim of automatic stream recovery.
>
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Submission review notes (not part of the commit message):
> Core specification forbids identifier zero. This is a narrow opcode
> interoperability exception, not a conformance fix. N8 captures contain
> zero-ID credit indications. Native malformed/overflow/teardown and
> lockdep/KASAN coverage and exception policy remain review gates.
>
>  net/bluetooth/l2cap_core.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 49a998804..1a0868437 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5328,6 +5328,12 @@ static inline int l2cap_le_credits(struct l2cap_co=
nn *conn,
>
>         l2cap_chan_lock(chan);
>
> +       /* Tolerate identifier-zero credits only for a live LE CoC. */
> +       if (!cmd->ident &&
> +           (!credits || chan->state !=3D BT_CONNECTED ||
> +            chan->mode !=3D L2CAP_MODE_LE_FLOWCTL))
> +               goto unlock;
> +
>         max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
>         if (credits > max_credits) {
>                 BT_ERR("LE credits overflow");
> @@ -5923,11 +5929,21 @@ static inline void l2cap_le_sig_channel(struct l2=
cap_conn *conn,
>
>         BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd->code, len, cmd->ide=
nt);
>
> -       if (len !=3D skb->len || !cmd->ident) {
> +       if (len !=3D skb->len) {
>                 BT_DBG("corrupted command");
>                 goto drop;
>         }
>
> +       if (!cmd->ident) {
> +               if (cmd->code !=3D L2CAP_LE_CREDITS ||
> +                   len !=3D sizeof(struct l2cap_le_credits))
> +                       goto drop;
> +
> +               /* Credits have no response or identifier-matched transac=
tion. */
> +               l2cap_le_credits(conn, cmd, len, skb->data);
> +               goto drop;
> +       }
> +
>         err =3D l2cap_le_sig_cmd(conn, cmd, len, skb->data);
>         if (err) {
>                 struct l2cap_cmd_rej_unk rej;
>
> base-commit: 964430c038967fd06643e866f68115664e1a1bd1

Sashiko flagged a problem with this:

https://sashiko.dev/#/patchset/20261013031943.489829-1-cochcoder%40proton.m=
e

--=20
Luiz Augusto von Dentz
