Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792591255;
	b=ma/FlFHd//7SF3Jes1zD3su6qxSXkz1eIsE9eFmk/ItPSfaIIfeXdpf1I+tdqYnGuVKa
	 W8pFGDcMt/frgGXk5u25CbFHyYFfNIIpga2wRpfGjQ10uEiS6Qyu49WMwqP0HEtJxm8vz
	 cfxZ6jYYTZhfHEs1pU4Ws0si7dwdQqouWHcE0msZOKb11pmoWgYLazO5YPYIYSpulOBGX
	 ZHk6HsYnvbel4UyaImRhL6r5b6PuEaObnwwYFvyZkRFHPq5yybDjbXyopn7MkzlNfv6ko
	 92Qi+xIxm9B1EPetXorT347DQFt1N8IjWRB4Q9QaqJ7V8OHsfDm/XLGMnER2a9mOd2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FdVCBZfpYOZXVIwiE/Xpz5oZYVnx0Z/FsH1U5IHm83c=;
	b=LcgJ9RKba08TO+2VOoFT8/5X71JvXDWoQaxENr8zcS9SFlTZ5cw/gCSoCI3gNPK6MHrJ
	 aB3HJSymdnr106cCERc9W8Tj1JpvKtFeq+KVAPe29CoaIgqiNBk75Ubbea5PeVFr9GyEx
	 Q0vs1/xzmtO7xEMmfm9qubWzaE9UCMF2BEc6izufCD1lGoAk6c07qQ8N6vR00a2R8S8RZ
	 Bvg+2Hm35NNZ6V65tHr4I4la092f2Q5yZLuQKmNoxVHAKxXhcdUCZ6GwdmTSqhGyEUC4J
	 Cux6MTn0HDHE4pdLpdfl++KCVTl1gFLmZLFemPGJLZ66kaSqnN3n5qiiSM6CxGOYMsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="hc7NQx/x";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54933606A319
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 14:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54933606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hc7NQx/x
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0db268bd8so4755387b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 07:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792591254; cv=none;
        d=google.com; s=arc-20260327;
        b=P7Z0ZNKhqUq+leVWWxqVk2FdRcxgnE1Vjbk1W12CnKO5wYnSBI0sIiHYNILiKnDHHS
         GDhivpMY6R1pkTaWO4/HhGzlAjU1l2G+bAGiL/2HNZ0+G5vfFanf2DyO/HsyrDhcMFwg
         Q1N3v3aWcbJW7K8LU0bwIVv7IJ7M9WDjYG/iNca4UwbUebP6u/7LKUMLFsLE6Be1YJr8
         yBAX+ulXOu7ykFjFvl8pAI3f/JctaLiOO8HmOubldIeZsF7FoRv8Rbs7sPveTcvwPv3X
         L2b8Q90G3zlkHT+RGvI+6AgJjyhXQlexEz57Wq1AnYAPbY30TgVWD5TzyZpWNTQAjFqh
         uQhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdVCBZfpYOZXVIwiE/Xpz5oZYVnx0Z/FsH1U5IHm83c=;
        fh=bsiDxbmAEmIqk4zDx25mjQYDczyDjME8oMNJO8NNA5g=;
        b=CTBv5l2irYZgL2v+7aQO+CIu7JuQsUtA965oDlK6TU/zm0mA3NBb8QzCcnW3ResCVm
         moK8Jv8yJLPOoebnyv/YXjmR65XEvjZD31Q2SiaM0EnUBVo9Gtc0S0Q6l4azQwPaiHOW
         1qnKcbLSLVgJAABZ7Vt0/TWISGPA8dtKYrMmHM6K6ZAQsKU1Rk/xPEqAT/OmI7E1Z4dm
         cbxTndEjJHwD7nm/uqXOOAlwcD0Y0Noof4/Jx9kfk9DLuGcD0hqUixe+eGBapFeAjmrD
         8SFBWAspmqUk7lEg/TDxrCijeIcQow07JxJARfl0LxGlTDRhWimTL8wsxLJIC1hvdj0a
         YuTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792591254; x=1793196054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FdVCBZfpYOZXVIwiE/Xpz5oZYVnx0Z/FsH1U5IHm83c=;
        b=hc7NQx/xjAJG+jPo3n0dS7BH8KqSaoMxTMze7IR1gQCwLB0OvewHjps3egEsKbugVX
         IWutPsxgYWJbfivTNI37Dx4dJsHBwuBjhlSJnn9roGQtPyzSWTi7QSo3sDyHGixUjBhL
         vlvD+XEVs7r05Zm7WJ7iu1Z9qLualBs5STbupuZeIOJuZr3FUweQztNUhtC2wOD3bmnV
         42bKomRRRyWKKGRsr6aGbh886xRyHzhZJzJ8GXzSo7gDePWjOA/PBMB9wjQXl9KUh0oA
         koTubI4nGDqXZ7tDEBnOQFOVlHWvj/wPWryHmvJBFDyzXiVzory4HaU5NZG3OVwfzLoh
         jMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792591254; x=1793196054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdVCBZfpYOZXVIwiE/Xpz5oZYVnx0Z/FsH1U5IHm83c=;
        b=ZVcP4jrE8BnGFQJSvsupnVv81rGtkjMFtR30B6ZmKkZZirAgIXH8mz1HyHcZ80iN3C
         ovfz8HrHAB+gOcIZp5OSWmOtvkk2sh7Ig+UV9LvVBqTCaHaJXk65d7p6WYq1BxRrFkTb
         ki5vdvK5ObOfypgDNYGtD0vMfmZEhRZR9QcsV+fJaJoiFuYwP5/0AIV4cgJNI0COIuiR
         gCiLUHGKh+rHzpbasa3K+/DgN5cq/OXz5IbtYzaa0ZY7xauI5R4n1weiPxln8rs1EpSM
         qmIkr+NU1P2axHl9A+OEtExIHNHSdw9kl5YgNpDXpSAmQA3g7q9FBhWPD69SHedXaIJ2
         l9qw==
X-Forwarded-Encrypted: i=1; AKwUvByziVbax28v9894CvXl+uKmhr/aERyLAj2P9sKbhyjQlQcGx305LVX1katXOxMsGsgj2QT3ipOjrwqEki99xzQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIKMMVAymt2JByU77NICahBuBNlaDtfWcS59TH+6+GzGKwD0DH
	1bAYutNgZeNm+pqDcGSgt2enWqUKcHgyKfXyhR96Tgljw92+2TSzJSRbXNW7rCjT5qJEOB4am7N
	n+Gf76QgEULItEJaLcFgTfxXeBfmgHri+/C5h
X-Gm-Gg: AYBFou3BZhXCR7urf0mdmM1yjX2ZYoWASh+OZPf1sxgB+zjEHVB4TDV2ChHB2cKtro0
	xMKbwCKmy/TgTDjsi60M3En4/41iu1xIZk/hXRfKj2/6JlG2YN9EdEgiYkVprpU74pL97US/+oL
	YTovcxetSvyMPZV7VM4PLnWfQnReDqeyKJZWcmzPn5jSKnFso/nRu10jRdgDNtjq3YsTqN/qiaa
	lijKpaQ8lCrAWSvIJL3lJ6CZZmX7RE0gzLrkDmCgOdqYHNCtbKF/dXMKf7h9qAjQ4mitJmo+uGL
	R2SFlluA4YoK+taAmFVoH37WINF+P2IisJDTBTtLpVUz7oe76abr1U4oQZn1uCvMhSbuJF+caVB
	kVs7qkJWPA34iomPsALnx48DyWt4mTeOji3RHTV2gifFbRi0HXmzjUeOkx48idaz5IZgvIo+FRr
	gnEcJWAwB0aPeKh4zceR3VVWQ=
X-Received: by 2002:a05:690c:102:b0:8b0:5847:8829 with SMTP id
 00721157ae682-8b1340b4359mr10303147b3.56.1792591253005; Wed, 21 Oct 2026
 07:00:53 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021093522.3536051-1-jlee@suse.com>
In-Reply-To: <20261021093522.3536051-1-jlee@suse.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Oct 2026 10:00:41 -0400
X-Gm-Features: AclHuK_pJcfVEZxvIrbjkfK0WdK1MAInOAt5cac-VrQ-ZEp57W-cMFA67ddroTs
Message-ID: <CABBYNZ+7ro4EHt8DXL-Oo_tgN1bn5av_KkGtaXXU7YqoQ0vDxQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: SMP: Fail if the X coordinate of remote and
 local public keys are identical
To: Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Chun-Yi Lee <jlee@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chun-Yi,

On Wed, Oct 21, 2026 at 5:35=E2=80=AFAM Chun-Yi Lee <joeyli.kernel@gmail.co=
m> wrote:
>
> The 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys
> are identical") patch be introduced since v5.13. Looks this patch can
> handle the CVE-2021-37577 issue. However, it only checks if the full
> 64-byte public key (X and Y coordinates) is identical, which is
> insufficient.
>
> In CVE-2021-37577:
> Bluetooth LE and BR/EDR Secure Connections pairing and Secure Simple
> Pairing using the Passkey entry protocol in Bluetooth Core
> Specifications 2.1 through 5.3 may permit an unauthenticated
> man-in-the-middle attacker to identify the Passkey used during pairing
> by reflection of a crafted public key with the same X coordinate as the
> offered public key and by reflection of the authentication evidence of
> the initiating device, potentially permitting this attacker to complete
> authenticated pairing with the responding device using the correct
> Passkey for the pairing session. This is a related issue to
> CVE-2020-26558.
>
> And base on spec, the remote and local public key should not have
> the same X coordinate:
>
> Bluetooth Core Specification Version: v5.4
> (7.1 PHASE 1: PUBLIC KEY EXCHANGE)
> "If the two public keys have the same X coordinate and neither is the
> debug key (see [Vol 4] Part E, Section 7.6.4), each device should fail
> the pairing process."
>
> Bluetooth Core Specification Version: v6.0
> (7.1 Phase 1: Public key exchange)
> "If the two public keys have the same X coordinate and neither is the
> debug key (see [Vol 4] Part E, Section 7.6.4), each device shall fail
> the pairing process."
>
> Update the check in smp_cmd_public_key() to only compare the 32-byte X
> coordinate of the public keys, making the validation strictly compliant
> with the specification and effectively mitigating CVE-2021-37577.
>
> Fixes: 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public key=
s are identical")
> Link: https://nvd.nist.gov/vuln/detail/cve-2021-37577
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> ---
>  net/bluetooth/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 2df303f6a38f..80128b31e631 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2734,7 +2734,7 @@ static int smp_cmd_public_key(struct l2cap_conn *co=
nn, struct sk_buff *skb)
>          * not in use.
>          */
>         if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
> -           !crypto_memneq(key, smp->local_pk, 64)) {
> +           !crypto_memneq(key, smp->local_pk, 32)) {
>                 bt_dev_err(hdev, "Remote and local public keys are identi=
cal");
>                 return SMP_DHKEY_CHECK_FAILED;
>         }
> --
> 2.51.0

Sashiko is flagging a problem:

https://sashiko.dev/#/patchset/20261021093522.3536051-1-jlee%40suse.com

That said I do wonder if the check is only truly valid as an
initiator, since as a responder, this could be checked before
responding in the unlikely event that the X coordinate happens to be
the exact same as the initiator's (if that is even possible).


--=20
Luiz Augusto von Dentz
