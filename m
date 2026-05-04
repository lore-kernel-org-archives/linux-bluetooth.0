Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F43DC4A9
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901660; cv=pass; b=n5bFuNp6TyMdIE6jcO9vJ64SOX3rw7q+/5EeOPOatyDXLss38uphkU/TcQogxzQKCbpMdAnXH9CL29lqJ+3lTOfKigKYJSsXiQ77N4TT2V9rSy73sMumuUI7ml146KRRjeI1FkRNQa5Raebhx/gVx1OBGSHDSba/AR0XHFw5fw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901660; c=relaxed/simple;
	bh=/Mg3lW4DLZnVj56QhpLU5C5/3bjRhr9Lt7DkvVBwxwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtS3bGLHVw7ZyYyudR0MSj993uiMQxEtX0PFs8Es9L8tniDicnIhAkUWbDgS888EY32J+Uxoq+ji2l1sktvM4roR2uV22IBOL2M4i+iBvlnqIFUrKG/U5cp4G3EUsY1rJXskCn5B7AESuDiG5oROdP1XMbNT6kFiscfLDUiwIDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRcAMT+U; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRcAMT+U"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bc83e74aso3487492d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 06:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777901657; cv=none;
        d=google.com; s=arc-20240605;
        b=izbvwC7VPWXzLAvELXHQ4ZalmXuprayd/DDcO+8HCYx1hByH1FPKi404zxYbe372KO
         AHVER5nAqz/hyigjh7JFsQUYe5jQ+iOnjgiDgys/adBZwaS9NCTKvwbrGANv+hdrduDU
         w8jSe9A+YWO7hp3otHJDMO/yInciA0ghk0Cl1bqX5Z+Ym3FdINLW9YQJXIG3QRtVcZq8
         y8pRHPpcgp/A5G5yatY4vtWA+mhtxF1vkF55qglglLXrmNptngIPYYOboNx5d6pm/fm+
         LATqZUKPOoo/AEabYeAMGTrl7CFgJtP4pdxpcq2AfVpfBC9ZWRC8JU1R1nzl6miHxIJW
         n8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3QVMt4xHvvbd+Zrm92w1gunTlgC2M+8QZXdbIx9gWI=;
        fh=o8NNz34DwVSw7MPJlEb3OWegD1ei3PfHO8o7tqRMUfs=;
        b=K7S9vBXe9jbKgA+7pRXKCb8Jth4oK7VP/lwY+0hLEl7KI5zCPx2V92bAmrOVR1NkIY
         obr+sUsgdVpoeUFaUtGwYATMDLcchhdO44T4dR8Q4ItoEDglwH/0HZZ8DzRb1aE5MhLB
         D4IQOLhnEPD5TsLn/NH873uMEXH/CPCDWkWGzEvVTruXsIaQpUXPul5PoKFqZxCPa8TY
         DbSIQjts+iOcG6c+LFp0jUx+JPE0THDFrJWnztcp78hpln4k4KvWjrj987Z5/lchE4nr
         gC9PBo3NbJlgh1V3nsafDwi7g72rIpABkAmanDs8UEBp+bwdYhwncZp9wx4b1kmBBWVc
         +qpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777901657; x=1778506457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3QVMt4xHvvbd+Zrm92w1gunTlgC2M+8QZXdbIx9gWI=;
        b=NRcAMT+UwUwrLAc0Sr/NwZ3pIBUKX2K89ClwuAtP91jZfIKSMuMRNEeDIzrdizQOA2
         3ER6RSAUAnqCfM3mWx8cugOFWeGyGwkdXYhXN/O2iashbriVALlE4h5Pu0c6xpF0fj9T
         mzMpvrqT+KvSvCfKChKRMbUWozTI1R1WRPaXfry301ezaxwUrwhsNB5zO+K9WYqs0WK0
         tLbyfz4ictvn2rqFZEoEvxQgHTeD/o72LY1HrsCZZE9NhZWQ11aCdLAwOCRnUaVAyenj
         svLB+dPeVUBCBaNrMPdDhA1ut/TfRRIALXr+8uFuX1sZuVAiaBhS3fAfj/168Kjl1EvN
         silg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777901657; x=1778506457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3QVMt4xHvvbd+Zrm92w1gunTlgC2M+8QZXdbIx9gWI=;
        b=AP1FMrRCZ/EfkT5hgpIUdR1HDSL4O07dxBA2ziunV2gson+DG6/huLyK5pIo1G1R8W
         vxM55DDDLYjyUnsTCJ0xNIQjiTvvS0yg9nmnZibsIVeFpZptBXTMpx3ChaBOqDaIEIYH
         aITjL42rDjxFwLL56n7Wc2W5GGgtBS1qo57paBgAZLs3TTG9Ue1PEXD+SqQX3alAp8ao
         XunuHEatQMy0EnQx9o257x60/3XL2Pxhw2EC+xDv/qqbtLOyb+t5ZOa2eNMoN+O2hfgC
         z6WIn2phsl7ZOl6hIDcTXzuhTMCLazzqb7aGeeta1YpBUuk7tvdCmEXud9L9FRh3RjJE
         IsCg==
X-Gm-Message-State: AOJu0Yzv1I79WrrAQukR6ZGxkz6iM7OlUjtFJVVHXcT5LAnm43pgI0MK
	ed7A1IQA9mmPndjTICxV8MOULG581UGZtJ9rtRzf7TsRwygDKsvKnggZicVgmGB6OUzT9XykMLC
	rK2RGI7D8LWgTwoNnFLDxdNiJFdm/SmA/8w==
X-Gm-Gg: AeBDiet+auPQogfBX6x9eQMbY4s6MD2HAYgdWiLsnlFLaFLhmF+yluKhv9htcxKP8eC
	3p4sAKfjFXk/haD6N9tOGH3U966FrSlHDMcufeG1IBg7p+NAX2+HyU4B99Zi21VKJImjnkf8eXw
	+nXnr4S4jK81XJUyFUlPVY+vSI0e4kOM7R2mpa5T5rvuwBRobO+p5JIv4jBOUyPtBtgQvZplwOP
	IzE971Y3yoXQM9R9s4u7i51JAdwEQp/0nlQXHHqBabnA0rGU3Ie0ND8wfY2vg0mBg92wj298Upc
	RGxP4ILxBxFLghVv4dKwr2UbUjy7CjSEMOUtNkNdYamuF2c9yawMpMKJKmkalchul/vKRQulnAc
	xkEF+
X-Received: by 2002:a53:d00a:0:b0:65c:2b92:f8de with SMTP id
 956f58d0204a3-65c3da3b7c7mr8559811d50.28.1777901656540; Mon, 04 May 2026
 06:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org>
In-Reply-To: <ygH6bncNsvf-0Hco92Ae11Lw8-jOfekFO6O3bUvFK8w0DTueny_rwJIF6ffZg2G_XCB4v8h8xRIcAL2b_KwaweNcGa231ZQDHCMpzyvR5i8=@fluentlogic.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 May 2026 09:34:04 -0400
X-Gm-Features: AVHnY4KYPujXvK94M2f7HchAqiapjJFtLjCxyB1fFY7PwWOoPBKqeZ9aQFGrLFI
Message-ID: <CABBYNZLV8-8YYwDEAno4_WBNEv-hcERL_NvwMfHBnLK4ZDZ+7g@mail.gmail.com>
Subject: Re: [SECURITY] BlueZ sdp.c signed integer underflow in SDP sequence
 parsing (8.1 HIGH)
To: admin <admin@fluentlogic.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 3, 2026 at 7:25=E2=80=AFPM admin <admin@fluentlogic.org> wrote:
>
> To: linux-bluetooth@vger.kernel.org        Subject: [SECURITY] BlueZ sdp.=
c signed integer underflow in SDP sequence parsing (8.1 HIGH)
>
>   linux-bluetooth,
>
>   Reporting a residual signed integer underflow in BlueZ 5.86 HEAD that
>   was not fully addressed by commit 31e4fb1.
>
>   AFFECTED FILE: lib/bluetooth/sdp.c lines 1213, 1262, 1392
>
>   ROOT CAUSE:
>   bt_get_be32() returns uint32_t. The result is stored into an int*
>   target, sign-extending values >0x7FFFFFFF to negative. High-level
>   paths in extract_seq() and sdp_extract_pdu() have seqlen<0 guards,
>   but the residual paths introduced or left unpatched in 5.86 HEAD
>   remain unprotected. An adjacent attacker sending a crafted SDP
>   response with an oversized sequence length field triggers negative
>   seqlen, bypassing subsequent size checks and corrupting heap metadata.
>
>   ATTACK:
>   Pre-pairing, no authentication required. Auto-triggered on Bluetooth
>   device discovery. Adjacent attacker sends malformed SDP PDU during
>   scan =E2=80=94 signed underflow =E2=80=94 heap corruption =E2=80=94 pot=
ential RCE or DoS
>   in bluetoothd.
>
>   CVSS 3.1: AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H =3D 8.1 HIGH
>   CWE-191: Integer Underflow
>
>   REMEDIATION:
>   Add seqlen<0 guards at lines 1213, 1262, 1392. Store bt_get_be32()
>   result in uint32_t and validate against INT_MAX before signed cast.
>
>   Also reported to security@bluez.org.

You were supposed to report only to security@bluez.org, fixes should
only be disclosed to linux-bluetooth. Now that it is published there
is no taking it back. Anyway, do you want to send a fix as well?

>   Martin Brodeur                       Ottawa Canada
>   Independent security researcher
>


--=20
Luiz Augusto von Dentz
