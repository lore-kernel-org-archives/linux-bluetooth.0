Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793982638;
	b=wlq0sIBHLIbW53xubh9HhNyR4Uxi6PW9lhsWnLlMwwesxcawx/0XnDrc6mtaRpGHsKCF
	 Yyz+50V1OqP+xIl/h+uj1fJ+ox7PHH+CRQTwnPayXnsZ1mejmdawAphtRwcj+OgNq2Mho
	 ByBfo52Z1JosP7m9+INCjRc0UgRNWHhPhaXx0VDOno1T7NclyY/T9DyVdpbzPsxF7mFet
	 5i4/FFIw2Bwi5qEAGkd2G7SPiPCFccD4PObJ5/GQXLWiv9z8uNOgAHwU1Ju9HZmTWIZaD
	 vWkPHUxCVtlMYqy+RIXWHk2ke74PrfdmkwFbXMrkuSxBoVFNDrIIQ/MvpdfTzaWsaww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ojnGgmq6HDIBAqEgDzC1pN7ceQb0aYTeLWeq3TU20ZI=;
	b=fHTbZJ+NDGi31j5zrdTPmtIpYoQohr79kpZsRIt4Shmoes3uVac17ZEk+pzQNgltVYue
	 pUDcHNIjLuio1APsXt4pVpUfZTCE/tCYj3G4dvIlfMq7nmFb0D+dqOOyHk55x8JlYQLBa
	 jUT+P1IvT20rI7X2DcVei4rK38ZYUTGzgtjnxMg6ayoULLTjLIVn/sDpqUnvv1WMLWmgS
	 ztB6Av3sbzjCZLaqxu0PnHXBvvYX0NS661S7raQ2aNNWwgB7B7Xkfys1kBl3LgAKi8+fU
	 Ode/Vlrd+CT115knn0MNDfB/ClIzX5ECZvQdkvz8sJY50lAFGxCdEuKqH5cRYtSyMrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5sJb6uT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3416606A329
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 16:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3416606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5sJb6uT
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b31fc13124so6179797b3.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 08:30:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793982637; cv=none;
        d=google.com; s=arc-20260327;
        b=nrqxMQc2RRtIvwDOBgu0AAUqdREdC6E6xsjE/gCaVMxKGvTyZjMTuDrZRPqBenWrOO
         BYr5JNEbVOTxF44EOnEDrdBmvBLiGa+ZG24NLVVjP8gKB74kK2v6p6EYdherKB3ZJrDK
         QMacDtBRnEvvgpJuBfASkWWE1+Ys+yR8w4UyLh6Si3S1NhovC84z4uz90XYkFmlbiOEC
         CzKal5qD0bxR8T9ZuT7dWM6g82WWJEoJzLICTW7OeewFsQ2YjtMX/NphM4miUX0HFLsD
         M+x1mcAklStVVuB4h9ucO0RccmimOFEh3XpybL5cdUxhC4lCG+xVZZ/uarz7dOiRVUwN
         GL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojnGgmq6HDIBAqEgDzC1pN7ceQb0aYTeLWeq3TU20ZI=;
        fh=LUWgbrUuhMtahyXO6QT454ErJE9yEFx36d0SI3GxXhQ=;
        b=r0OtncC9QXk/TcPbFdxTDO6T7QrIsoDy/oOpFRGxQ9o80T8MGrl8d98URuuwRn5o2m
         KzkKwthWjGejt4Rq6CCkur0/6BP11oYv9F5tc2kyZ7P54kCqoKjB5Yhag5+YORMjABzs
         B1YdwEeP+zM4OEHgzs2GDy2P68BHheFx/tbr8fa6EjQanFhCffGn9TNtyWOxVwNZCh0E
         WV0VU6P97sgeUo24gb2DDN3LVlZTpp+ko7x4/F/YjByGd2TbZXJqUzU+tisvdja6IIEj
         7a8NN/ZGkPNzNtHMYjrPMLzkhZfbsRDk1wSE7uuP+Oua6/WMbxUak1sLO9HJW4k1zuC1
         yovA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793982637; x=1794587437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ojnGgmq6HDIBAqEgDzC1pN7ceQb0aYTeLWeq3TU20ZI=;
        b=V5sJb6uTDb7wz9p9+VzKV5xTPyrgZCAsalpOAOllUCeRZiB1hbNdXiQKimY9Ef5crU
         TVXEJjFSOxCuSsLqA0hlWtDCUYSLkk1eMcNk+qpxaD/THZr1ShJK3m4Ufm60gcy9btsO
         ZIZ2cm3l2uVgETbFGYQlqCC2Ee7aZFWaI+dcg6kE2+p0+EsOn8sjRZaAUT4cIRcXrLXl
         vWE09CzU5Q3dg1Xr8LbNNySg0ues4lVJxoh/9JWNJJlifDpD/WW7SRwnEWoCCEsOonkZ
         fr2vpigGCo2MkWRmMDNwGcpFp4jnpY3ONlO+N2/N/XwUxIvJtUhvreXYpc0/0hjHBWTn
         DNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793982637; x=1794587437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ojnGgmq6HDIBAqEgDzC1pN7ceQb0aYTeLWeq3TU20ZI=;
        b=MAS09Eax+996if/jEeg0lMZmOgcFK1UxK83zuOR1GC+DiGxYclPUED+6t1wh34eurJ
         Jd44+vZI94wsAlTZkEBfq+cLDLUVmN4VCdt4R7O/RIHzE+FdumYv/rMin9K070abCKGF
         ouOMIwMysC7PuVgqPqIVE5008J//RjdrCFA9pSgFdVnwjx7waQ+mGIXMy3nSaEAff07K
         EcWfdUtVsIaB26YSAMN52aisrSFSqQQO56LenKPLfYykIZIuc32XY4pOsqOWYCnrNSPa
         WwDkefDHB6E60I46lpJzXJVJlU0ngxCUIGa7Tamo7VLoaV4NDpTKKJfIBT86x3a6cCku
         UdjQ==
X-Gm-Message-State: APuU4Z/DYa7KGUrJHAOd0B8kIK/ICnJqF2OrBtCcKEFIRIvnG++iFSRW
	Ha8DXJk+pycguO2sQvs7CTPv6Ug7XeLk8ja1DkPcR6oe+gOllnibNqhcROlnkxju282WkQUgwct
	3HA9qYcD07NzmyHty1TmHSc0traZGEdS0lbCv
X-Gm-Gg: AYBFou0uNemeYMzey55cFc5Ejq8tC0NTnHcLt0YCntLcUvlQszgAsh8/FNXFPVupsP8
	r5wyw4nRfdf0TdyuR1gAkJ9u6Ztkz+c8GkcLy3/H7OBYLHtxIxHyuCTxSGNwhiPukU0rOI3pKeA
	NmcyHk8BVEgnZSHGr2lfhG86M2aXXl9mMDwLa2blxov26RsBmS82/Q2Mwe4La/mruAPG2F1dfST
	uJ9VQLJCMtotoVHqCE7l4z9mM0WduO9bkV7CMDW03y3RYKDjdfyFh1vqsPRtLdSjLwKWfBoHabA
	Jfq2BGIjCjwiwKMkRLS/3Ki/b144raubLBgigxlQtCroAePALAWckVSv0hucEhBv2xMTEm2UcWB
	WP1voWdLFHvzdI3NQL38X+2fF+PVdqmjDhrl337RWoH+i/ZQNxTEy8BvZJfB5dFCQ1tbyIaeqG0
	oUNZrVOm7i46y8sOKK479M6f+tfAFYefNAXqKzI4+1Hx9jls3wUrZxp14hQBnIJqAo6tIX6UXl5
	NGmDA==
X-Received: by 2002:a05:690c:c507:b0:8b0:d9ff:4f50 with SMTP id
 00721157ae682-8b341907c68mr19452117b3.16.1793982637082; Fri, 06 Nov 2026
 08:30:37 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me>
 <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me>
 <20261106045515.853897-1-cochcoder@proton.me> <20261106045515.853897-2-cochcoder@proton.me>
In-Reply-To: <20261106045515.853897-2-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Nov 2026 11:30:24 -0500
X-Gm-Features: AclHuK9r1UDQPVb1Rk83Sl1_d9d2jweh_2UwuIfFDf8P71BH8M_1lcPpFhqgd0E
Message-ID: <CABBYNZJukAMZzC_2=jwoYiCw8qEpN2tMs2VdZvT8xKWr=0LdQg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] Bluetooth: L2CAP: tolerate zero-ident LE
 credit indications
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Thu, Nov 5, 2026 at 11:56=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> w=
rote:
>
> Cochlear Nucleus N8 captures contain LE credit indications with
> identifier zero. The specification forbids zero identifiers, so the
> current parser discards these grants and leaves the channel without
> usable transmit credits.
>
> Accept nonzero grants only for connected legacy LE CoC channels. Keep
> ECRED and all other commands excluded because the observed
> interoperability issue concerns legacy LE CoC. Apply normal credit
> overflow and pending-security handling, including the shared transmit
> guard from the preceding patch.
>
> Let the credit handler validate the exact payload size after the
> signaling parser validates framing.
>
> Assisted-by: LLM
>
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Changes in v5:
> - Explain the observed Nucleus N8 behavior and legacy LE CoC restriction.
> - Use the credit handler's existing exact payload-size validation.
> - Depend on v5's shared security transmit guard.
>
> AI review:
> https://sashiko.dev/#/patchset/20261106021723.631339-1-cochcoder%40proton=
.me
>
> Credit/parser fixtures pass. ECRED remains excluded from the zero-ID exce=
ption.
> Native L2CAP and hardware behavior remain unverified. The interoperabilit=
y
> exception remains subject to maintainer policy approval.
>
> AI assistance: Codex prepared source revisions, descriptions and local te=
sts
> in response to the v4 automated review. Attribution is retained.
>
>  net/bluetooth/l2cap_core.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ae6659fab..d3b875c47 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5388,6 +5388,10 @@ static inline int l2cap_le_credits(struct l2cap_co=
nn *conn,
>              chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL))
>                 goto unlock;
>
> +       /* Tolerate identifier-zero credits only for a live LE CoC. */
> +       if (!cmd->ident && (!credits || chan->mode !=3D L2CAP_MODE_LE_FLO=
WCTL))
> +               goto unlock;
> +
>         max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
>         if (credits > max_credits) {
>                 BT_ERR("LE credits overflow");
> @@ -5997,11 +6001,20 @@ static inline void l2cap_le_sig_channel(struct l2=
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
> +               if (cmd->code !=3D L2CAP_LE_CREDITS)
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

Sashiko is flagging quite a few problems with these changes:

https://sashiko.dev/#/patchset/20261106021723.631339-1-cochcoder%40proton.m=
e

--=20
Luiz Augusto von Dentz
