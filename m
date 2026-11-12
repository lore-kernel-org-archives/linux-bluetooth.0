Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794511534;
	b=bIrp4VMZHJFde9CyKexS0h9fFMgDifAr6L8M84o/jwkdGAmXiqpWzNike+D0g25UMdYI
	 ljHrbNZSkXgBGZj65kNTFhLyA2f74qvzWYcPRaYS+Ie1Meuxm2cOwVzmFUqPGCP3Vx2pH
	 ZWxu7jXf5rgPrkUCJ4nPUEcsJOE9VOQW0tXTxSdTvNJN1N3yCNJIvSwRazmBTbMI848Y8
	 fxCCrhMUNoREeMLjS6WkpGhYnfE/8I9v/Fvyfgh+ajMV3R6XFbHNG0fTV9F7ctEMEpv+v
	 D/Du2eU4jXhMyVxHK8S0g+IVhCGyT4gOh/EFcatMgsC84bNuata8eg68Sxrdi4MCSMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C/FeJGt2TlKPGCAUSI45YJPznbRiDFENeI1EgvycPz8=;
	b=wAmFxsfeL/WcJcYFJh4L6/2/i8iN70hDfaYdeDk4xeqUPDVXYGWVonjTdFE1JZ6q4A5s
	 j2GG8qHwEaAxhTPFltcx55CQtMQ/vXR+LrzIoSyh9oXlaGm/tyyLox9WZFK88CQNvzwIh
	 Vn58v2Fc9ztOyxN5RzFcDFKIJ6DyHeNd0NrVBhmxBvDQzzh1S4Mm5i9CwSlqex/v/Wd3O
	 yv/+zIA5krMVMLfBhmaoWQV9LedBiAVBkfLfyubxCw+6Odw1Dt15TyPDtk3qemIuvefLc
	 Lse61qtSW2gPVhvPY+def9E3lWIKcN9JkPqora98yPJc6T+Pv1noFzss4eQZgUHDXyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g3kfUNos;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F47606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F47606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g3kfUNos
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-677d35fd1d2so159918d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 11:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794511533; cv=none;
        d=google.com; s=arc-20260327;
        b=UpeuDXAYFbotlxG9NWqXwMWu96L8s6+CWXh5ghSHk32DsH+XK5oEdTPmxt7c3itGJ8
         ZmilWhELpDLbHDVO38kI5tI01pkLEqtFEb6muqNqplhQ9LbHxUGZGvHTMKGp9BhlH2hh
         8cYdJNDZ4RbJXMVu12cF4/v64GY90n93iLYjMMzc4cOpzT3wMIg/wT2H0VN97oZUBwpH
         igZMbwH6g5F7ooVK3pwCK8GjjUaDZJfDeZ/hgzjKu/NWfet6ciyADMLx7U9IParJY2WS
         jOBsnaiWW80pepj1Ik/2PRH40OrH8nbBUKUCW1yfwKFxNyq3klM9Atfcxp7zfQrBDKD5
         8zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C/FeJGt2TlKPGCAUSI45YJPznbRiDFENeI1EgvycPz8=;
        fh=hQofMkVg8dvTaeeAnN9dJ1/iP9uvRW+YqVFLauQwMmM=;
        b=Cuwe8JMklvU2KAL+sCSxM7p78S+DwnqCrtdSICmCqP3oNMwlKqRJDdhI8SgEUtat8G
         w35PGsdEhBkEQ6F2fFwnXKAgkkcr2Hcc5LNlWIHVlP7AuZDssZitC88vRJ/zPzkvqWf3
         rFW+qU/9y6elYzMnXJHM8ZVvspXYXCEZzLCBwo9gyRl/QHMMQxAEFfiyviJGZ0gmmpin
         NGddxS6xXGa49OiK67JcGocidayV6Lj+bc8dTy3Dvw8p5PjHzZ39QxtS7IrmzRSCAM+U
         irmALRSYfpihx06+TdN7ZmfO17YurNhT+LMeqCZ63okVyI2vsbZfoPeSTuTGtN2Vt2iD
         XSpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511533; x=1795116333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C/FeJGt2TlKPGCAUSI45YJPznbRiDFENeI1EgvycPz8=;
        b=g3kfUNosoHrwzweyUXdxMHxUyajmy1RzkQUXQGrtHImU+etpUgEvLu1U1HsQVhi3lz
         QzC3aJF59asm6Sz4JSZ1bz1asozjR3uXVqSLFPZNuIANTQAeH13dvJxQb/DsYM6F3NtV
         cy+q2Pha6VlPLqrF2T62AztnO0lDD4nhSmGb/7x3T3HqFyq/7masUE/dtsbIjOU5HkwM
         LIFXdYZcaCwB6ud0WjccA3nKSaUNgxELWSc6SWNv4FC4DQ/Bh3ujvHPv4Fs82xPKohnk
         EufKTmFA4ynNbWvuknZZliHa58fYs498/XopuEX8KZYxYT32uSjOfFTKuSh60HsXwiMU
         wq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511533; x=1795116333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/FeJGt2TlKPGCAUSI45YJPznbRiDFENeI1EgvycPz8=;
        b=OmfGPBvNmEIamGhc5Q/5c/f5EMy7I4saPaZNly14bwPQ1RwsgbULhOqnbAGHL2ex5O
         JZM0RsiTdijHWJ3QLtL10ix2tPW1Xe1yNxh7vhGq+mWnic5Au0jih7x+S3sNClCOgnXx
         /vlr5tmc5jOmo9WFkM0RsXoBTdBzGfaLCwaI+nMQqj0dSw4xmZlTFeSL82vb6NwuXjdN
         dfFrKHBrOxP04XFa50gHztLqVGw+mD8wDK8DqEtIGsKMBm0aGdJNA0Pkxm/jZMJnPney
         QBZiQRFPnWVHSsLgpbH8G9YQGrYBsnTsvTQJ+UHrOa98rph7Wd88U1fbHWbw2aMelKLe
         ZMFA==
X-Gm-Message-State: APuU4Z9xs2WKe43VJS2ZFAwJ1K2rt35DH4fhYgv3wJT9xITnzk7eTHas
	Wtr4SLQjKfcafh268LsAz35Riq79SSIuNyvUDmdDxhLxch5u+xfxb//6Bi33p8GrDEP6v7Z2qP5
	QmbSJskBRhfuv3A9do+YjcPaMFaAhXDK0eQd0
X-Gm-Gg: AYBFou2OxxlAwtmJQUEDxlJB55hkB7Sz/L0sXfAgdHrHOaDr2ufazcMhXet88JR2yxE
	aOLA1aqN2og42NTXn/SMjlovm7hTNJxjK1A23xeClH2rS7tH1LSBPNS3qEtQxf9meCeo2Fp2M5h
	4k8K/KYkz5TcICLKt6EJyB3XfA7GF7xSFAmHu1jwCWciDa8LxPVfOtWx3Pdg37TSH0IN38Aqn6s
	9dDhAkQ1QkTuklTNfhDnZCLvsdrqd+PdbgUWtozOrlqF1VtY8I8H+9CEa9Yg/l2L6zVemWbnUo0
	ODPHlU7OXHppBWwHAF6qnPXUkZlhymz7N4z6lWufeU+spr48mMqmWh9mU07bHClrMgNChncueR5
	0J6sBOt03c/ulJ7Vd7Nb2HM0dxk44HO0qYZwCtVbufggwEWftvlJ3CoNhK/j/IXzlI4MF3NsVXb
	PDJ4Tx5S/I77tqj/1oknjIEM9ukBBgnN1EKz4QJXChg6ZunLP62nsM4dfHaw==
X-Received: by 2002:a05:690e:801:10b0:67c:1fba:b44e with SMTP id
 956f58d0204a3-67d895e51a4mr150146d50.30.1794511532951; Thu, 12 Nov 2026
 11:25:32 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <VE1PR08MB5247BE2C05F27B1A2675FA25D5712@VE1PR08MB5247.eurprd08.prod.outlook.com>
 <6af5086b.afff5b00.2aa0c8.9b05@mx.google.com>
In-Reply-To: <6af5086b.afff5b00.2aa0c8.9b05@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 14:25:22 -0500
X-Gm-Features: AclHuK9WYNiQfajh46SAxXrbg2SSPQhScSOaFTo0KIPMSgjo2-VVuJ-T16j0_xo
Message-ID: <CABBYNZL=1cTSCt_3Nn4HoV62Tqq29Mxi2F73CGG+3hHpdEE-Pw@mail.gmail.com>
Subject: Re: Bluetooth: btusb: Wait for setup to finish before system sleep
To: linux-bluetooth@vger.kernel.org
Cc: info@jwillmer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Wed, Nov 11, 2026 at 7:33=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1208822/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.58 seconds
> VerifyFixes                   PASS      0.09 seconds
> VerifySignedoff               PASS      0.84 seconds
> GitLint                       FAIL      0.25 seconds
> SubjectPrefix                 PASS      0.09 seconds
> BuildKernel                   PASS      24.38 seconds
> CheckAllWarning               PASS      27.69 seconds
> CheckSparse                   PASS      29.20 seconds
> BuildKernel32                 PASS      24.21 seconds
> CheckKernelLLVM               PASS      25.17 seconds
> TestRunnerSetup               PASS      566.29 seconds
> IncrementalBuild              PASS      23.29 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> Bluetooth: btusb: Wait for setup to finish before system sleep
>
> 41: B2 Line has trailing whitespace: "    "
> 45: B2 Line has trailing whitespace: "    "
> 49: B2 Line has trailing whitespace: "    "
> 55: B2 Line has trailing whitespace: "    "
> 59: B2 Line has trailing whitespace: "    "
> 63: B2 Line has trailing whitespace: "    "
>
>
> https://github.com/bluez/bluetooth-next/pull/1117
>
> ---
> Regards,
> Linux Bluetooth

Sashiko flagged some problems with these changes:

https://sashiko.dev/#/patchset/VE1PR08MB5247BE2C05F27B1A2675FA25D5712%40VE1=
PR08MB5247.eurprd08.prod.outlook.com

--=20
Luiz Augusto von Dentz
