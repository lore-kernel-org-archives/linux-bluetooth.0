Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893073;
	b=FgmCgeq19AhEl7zMgyA8Y4pddGbo56ql8NKegkHQiEGwqC6pJNUF7YrrCVTiUb2s03jn
	 K7ZRO6/QzdfJAsbbcQiGVmKE5wW9hnKLkibaPba/dKk1JR7X03HdVEx5KU2C5x2ohcsEV
	 /JsrxwuBSs+wFJswO568swjmPXNGJrLqReVZ7elgcsfLLDR+DTCulIQt8KwEI8lNRvZ8E
	 KquUJkgKFVZ3dyePLi10Q8v/Y6Ua1+Lbpgc8QiQv+2LckqSVDFknT8S+HU32TWjl10eQz
	 mZEk7Lzt6J85TaqXEoxAEJDEGjVFj9bRBBqntuD39CfwmX7j23iQU0QNT+IXvjQU2Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XCijhCh94dxLVazrtUxPbG8M0U9R5C0DurD7VvFeAFQ=;
	b=0r5l47VDtvLtFKKpNYlCcpIj3PRO7cBCLnaCnRyAW/LdIuuHAWJVG/NdC3vtk5ZwlLIG
	 u1ylLvf00HO4f9yUB3CA/gWNPzVau1+YsVOgprxd6MBcPEKbj3b6DPUdTdyDKGipmwWf5
	 bId5SwO3DongQIEvEgZWqU8tmU0Fr6RrFCEgVW8Nm7+o1sRCqw88PT1KGLCNm6f5ddC2R
	 3i1hH8P9e1tZ670Jh9W+vB7u8zoaTJwqB/xsE3KHRoDSsoie2AyqhJdGy4NDIfJAiiejl
	 iVHZozFrs0iVPdCFUwS6HTzChO98Xw/DzeahAblKCcHFz2QWcJinT9OeQxTKj7t9I9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iLa3hi/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E57606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 15:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E57606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iLa3hi/d
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b306bbff8eso16650207b3.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 07:37:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793893072; cv=none;
        d=google.com; s=arc-20260327;
        b=lCxpnosAvtnlTDgrTJ7TQthm8xoKTfSy+B+0O2xpBn6ZjwTpzsIh9sqAAIOI+Ns2/T
         pNeyP97x+m+mE6/XW/PijEv3QyZtKojxNhJlYxZBTbhKfbWK7zsXk9Fo2YQPvww/ASrC
         jMo54Ho07HCPDM+N3esAHKKCbW1So5UHpPhFyyLfpBsZrtRdkDX5E8K2bIdGXW4WCtM2
         SRTN+vyZ8vBFNu3DNbd74eD/JWJDgY5EhOkdeSBhXqvFiz4rbWMjtFrdrkSEWHtfVxz9
         n9e5iGTL9CmWJKEWsSUCp93+Qc/Z6jYZRl4pJJG3Uoqlkw5VRyjTdr2+PojSmYLNhCsV
         UsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XCijhCh94dxLVazrtUxPbG8M0U9R5C0DurD7VvFeAFQ=;
        fh=fKgaVqPOrfVyQ+h59AjduQLbwGVVkXzkIoThil+1UiI=;
        b=NbBn7Ub/RZlWv1AEYEE734dPmZaUtnMOIUOFacjJvu5IXiCLNW5GTnkpDF55G8tXFT
         wd6j09LWYGL24i9W0dBA9J7iD9Q9pyeMs9pDkxUEyRCI58THfbiar5qSdRzjRgshBjxK
         9qjSGIZDOfnSjGFi3nAoD0g7RqW6G9ea+yjunldXghNzlRRTUgmbvKLfIEXKC479egdl
         QfJEOwyODZHEksiHLx1AqkMQLKKedC/k1fai1jXanWKbj9yTlGrQ6tan2UqwEFkG25T/
         WTPQ0IYqY8lm71xrJKPR7p0Dfk6ycILiwkJWW/nPC3IoP+zwyYGHsQjRjhZYsBX1nIUb
         4Pog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793893072; x=1794497872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XCijhCh94dxLVazrtUxPbG8M0U9R5C0DurD7VvFeAFQ=;
        b=iLa3hi/deUrKU3rqwmrQfa2V/0/IvDPmbK9Cr8WKghWEE9ENLnZury++8s/qPrTrwP
         kR8k5uvlniMHyPUYbMZqsZg5suWjAnhZQbGKDwRuFG7+q8A1gYA2E7tHTz7MDN5rRSj8
         I3nZDJSAeesnMXBtwAd9GvuWJfnZ8GbCzMvWtorjlDMFVLujH76rBAYE+vDh/+9vnpIW
         uP+RrqUAVlCJoOIattGSN3WBl6TIxnD4GdBGPfVW2/ICvNbRKF4EGNxPwCMAT4InWcVX
         tnbGOh33LiRv5IvXP2zSDD9ymRyrTnpuv6aS4zs9Z3JNt32V+wZsrT9m1eiuZSSj0cim
         CJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893072; x=1794497872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCijhCh94dxLVazrtUxPbG8M0U9R5C0DurD7VvFeAFQ=;
        b=saj0xLzqKiQ+s9XXwZw28vnH26inHh9zCOa7MCuwJqYM5+cIpDw5+/Wk8higdWEXSe
         T+lILDK3+DVCt7Xfw+sMOXSkmIR0qHzWsPKOoZrF1RtEPIutCXmzOvW4xlFlujRd5zna
         LkgaSzRGikMM5A6YnY1vDnohqoFrA7m3Wpofxk5PbSJDfMbkK9zQePpZl5QJlL7Fu+4g
         GXXFXFSoyNiVrq9LIupvIfAqczV5aDY1VUQVafFlRGf5iEvnQ9jUflXnNS3DdIMkCJhE
         ga/Mv1bXZ9yJpcx5T7E9UbXqm5UXGwD6y2NcpqMJ39L/P5v4hSHwTPnS17Rsr4gNH72c
         8XnA==
X-Gm-Message-State: APuU4Z8AZA4Cq+OGoWZuVCx78SCGp0Aewe8ChKEDuZj4PQlTbQwVOVJ/
	wETX97EPhnNb7z5ov3jpoUZcnnzY6LP93EfvazPLI2tXhZ79CCVK3J4mQIHHCWcql1VW1Fhjzxh
	Vy/KaXGWBRHvi9QQHmaeCODRRGGlaLg19hY8z
X-Gm-Gg: AYBFou2gAdICLOcDog/3tUKt0+VEQRkd2/82nl1PxKygU6wUhMl75jCF0Ui+LDUIrs9
	j8PKjc27FKcuKxcl6ndWj7KKQuToPJb/UbXnYVc719NM3FPxpcX2+hfFht/Ff8PiQMNSL2Bn0ee
	KwOn+3qDQS+DQp08h+pVODLYqxYEZtsWtdkLyyvW3iEUP3zejijQDA5mPZwg1BYd2mJu0n46Nsy
	AaXFgYa9PV1ipYC+J66A2hBOZsPxWDGXh2B6Zl2c8/XdXubLYI1pv74hroDMFa4ww3jNVAxqy6I
	T9xAGkA9/FF2uxLEXsW80l3e7oJrLs5J0M5iqmuSwHUb7Fs6JaoRyhv2pEqxjC4NxYodR3TXNhq
	EC3yanovsTE056hIfXthtqqkODadL7pRVn8hGxGfkQPjCntLX6y5wR8U3jN0D7WaKBqwToHYuO0
	JEt35RuWNcnZIQ12dzKxotF23RcYJzxI7nAIvEiQXqxEswm6QQ3VNTYNWp
X-Received: by 2002:a05:690c:f87:b0:8b3:2d9f:e602 with SMTP id
 00721157ae682-8b32d9fe9bamr8614587b3.66.1793893071856; Thu, 05 Nov 2026
 07:37:51 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com> <6aeb639e.87c3a088.228e9e.5ddb@mx.google.com>
In-Reply-To: <6aeb639e.87c3a088.228e9e.5ddb@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 5 Nov 2026 10:37:39 -0500
X-Gm-Features: AclHuK_o3ecIO2xpbS0CX6WZyc2fRQsU0jhGNq6dSfnCq2qywblDydr1AWrUK3Y
Message-ID: <CABBYNZ+6c45s-+_X7s8qE9DXihX5O7xYFTJnJmvnKT-sy96Ksg@mail.gmail.com>
Subject: Re: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
To: linux-bluetooth@vger.kernel.org
Cc: jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinwang,

On Wed, Nov 4, 2026 at 12:14=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1201470/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      8.55 seconds
> GitLint                       PASS      4.70 seconds
> BuildEll                      PASS      23.33 seconds
> BluezMake                     PASS      197.66 seconds
> MakeCheck                     PASS      13.22 seconds
> MakeDistcheck                 PASS      105.32 seconds
> CheckValgrind                 PASS      164.16 seconds
> CheckSmatch                   PASS      173.53 seconds
> bluezmakeextell               PASS      69.20 seconds
> TestFunctional                PASS      885.71 seconds
> IncrementalBuild              PASS      250.73 seconds
> ScanBuild                     PASS      687.43 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2760
>
> ---
> Regards,
> Linux Bluetooth

Copilot flagged a couple of problems:
https://github.com/bluez/bluez/pull/2760#pullrequestreview-5775992507


--=20
Luiz Augusto von Dentz
