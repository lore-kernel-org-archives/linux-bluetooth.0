Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534649;
	b=G5rGzMeh0RgmEuOMBAlzng3NLMa9mQ6vmb4qeU/1ikdmi6fK0DJlqqfNimn/Jtc7mY9k
	 5kykwbwqtai7+Ch8SJa0ABjpoSEi//E1/0Shm2JlO4HWX/zLbXSJ6CUoUHr0tyypDlkb5
	 SpXArxfrz7UbiwuGntIfy2l8EwGTa0k2ZFh8tNbb5V0w4UUkkWxSdVYUJ0XwIXriB99D5
	 MgnVRlKgl2UrnnpU6W1BrXO0H0Fmm0GRbjtgTaYFvFO9UcR3mSmrimu4d3X3tGCMflzOe
	 KxRH1jRpZl7xUvPspAbc5bM5uCIKsGRMfrouk3iR1QsrII3qkLcJtENEO3uVPUh8K8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+vemHTFllke4mRHjKFMkhveBuZAKrkf8PQBjoS+U/I0=;
	b=ROxZb14v91sFZnKAlRMODbHQga/AMaQGbk8UEHqORs5XsrO2BSY8xGxbgwJz2cb+n0EL
	 1rq9vUChvLVDTRyNRe8UyLeC2hipBimh8/NDSH1/kGCWjastK4hauLSHDBbS0eiYkdMt7
	 fncLDNJddl9jeOTcL3Svk/aJvwh759PuLxTieOxu+13To8Y9ExVwiYtq9fZ+cWXt/UmW3
	 dUFOaoGogfLV/TCTM5yKcnfb33Cjwx7eKWp3uF7KHUEKFYrlBP9ZY8TjBR6jFZKOFHm/J
	 09QkaUFNH8xZHmFvtEfhTlom+W6Ml539+YmorJkSlzkvUt32/xtF6HHRYuhrzOM545g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcGidxiZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BE606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IcGidxiZ
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67db23d8892so5083000d50.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:37:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795534648; cv=none;
        d=google.com; s=arc-20260327;
        b=UUEs5diSX1hJi/Iioo7Z1K1c2D9NEZRwyjIxt8DUSGhbYCI4jwpo+5yBbaNdSKhOMD
         uRdXeAzHVVgjmaKGJR+Ve+tkCTn2+zl/mTmXMaSlB6FnH1L/xO6l9x88WJCoIMRMIxf7
         +32iwRWgLI8C4ylE/tK4FOAqOaiLcal4Q1MHSOnao6Fmit1FxgRqLoT5i5NsVDb0zXJ+
         pOA/qQ3SwKL2O8j6sdMDZCcbin56WfQSOeVqEkCmh6xfOrV34y5XDBEfpnv8nOeYtpaw
         74uqxso7Ieeso6M5oc4EW4ABogmKhfHuwXhTUIoxdPE7BpEpYCF35RYuXAx09/igK5CG
         dbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+vemHTFllke4mRHjKFMkhveBuZAKrkf8PQBjoS+U/I0=;
        fh=6Ejz2qDC1kzAz/SGTrdN+HkwL3203PQPsV+Bv5fThMU=;
        b=dGY5fRutS4bpTZQ1msmj0upfWfpksBZvHD+D4FBwmLIZfaF8G2bvT0G1Qa25wwxpSp
         ObuEx0LnVT2DiZq+GqlJH/CBwwdBOGedGUY0YA2j2l2/uc2wCko342WP/NYqVAGuT/We
         L461Hrc1ww7leYK2wThFsD/2ogn5hvitvHWZz7hx4nocULBOP42AatyCe5BNyMxQVfvr
         0tnrLNacOwAkmRW0WptVzIqb8nDSLtjdDfN4rC4nQIHU/jcApIOa/QAtxCV9w/6q1PB1
         5rO0JiLUZHn1TPw/1ERzBIs4Y0QUYYqzH78YWovr48R5c1cbM8ohF1AI5wOqqU52x0Iw
         f1BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534648; x=1796139448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+vemHTFllke4mRHjKFMkhveBuZAKrkf8PQBjoS+U/I0=;
        b=IcGidxiZl/mNFvtW1ggMs9Bz0d+NANdIb/o751/Du1QO8oOf1AlXAan1eFmpHTFfRg
         9Ro1IvkjBU5bjnYTb/HWgwyaCUmfvGCJniXzWP1Cbk0ZfurYYJ8Lc3pBbcUqD8+bt/4P
         ESjuG3IYqGphSZ/0ihw+XTfbHRl8pzfj2VatLycrR4wrqWKpzBu065HZgaMrgMmNJspw
         RMveyxHFi0U93idASdj9bv1bsx4SFmie6jot/L+HWDr/h6joOewvZ5psNfH3kqL0P1Bv
         VkWm5e5bCpCy/Fq2PJ5yzB0xx6t3QgpFxjtFYbE51n00XkJKSHQODXSf3+JjTRLhZKTy
         sZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534648; x=1796139448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+vemHTFllke4mRHjKFMkhveBuZAKrkf8PQBjoS+U/I0=;
        b=PAKby3kz9UeDl+/rF4XqLfzrvLBVLlLtCaq/PuTYZhSOSrkKZGyyyaVdgS/V+J+B8N
         fQT12YnFW89gRebHTDXLP4Dj3o17TXM3+utz4AQVBb/CDEueVb96xyRdYyL9xfghdugw
         JJEWsdFBLh/lvB/VQ7ZSaU9vp8Jh+AgwuGEvuLyAYvR3J86lxjiomqmLJVb/L0jQuX03
         lHeVfbT8Fp5Af2C/HnBrtpnhFq+cusu5KoekDohtzhf+8t4j8siBRJyEfOmArWWCb6kE
         uw9y0uRUZKTHNVFkdBJf4PvKA6LM9WOFqFWqFBpvnm3QglHR+JkZ4/AfZ658U9N2Nz65
         +cAQ==
X-Gm-Message-State: APuU4Z8DcNfb52i42yudZ9EYGtI1zCWQHJvWidCB1DugK8eUUxJpz4hV
	MwB1nq14wMT0ksIBBHV3/lK6dfLPScVjKUd7wRFPNW+G3+HJ6dhWIEmgpwdVm/m+fTZWuuroeab
	tm2FRzXCN3fY8hTLPpZLxsJBI9gg+eKasCXH/
X-Gm-Gg: AZFdTZdc0j1bbFQwkvY7FqVPcLfF30+/5WkS8krRJAlNMn+xIb20mBVs2iLBVnnPHwN
	8fI3XWXWC/np3UJyrkqg0YYELxoKdyS9J0ZyZUFDRlHChoJc7Mjswd+xu9SQHAKJCPanLQVas1G
	2tgMub8oKvjUrimhmjuIaxHOg4fWqEYS+LxbV2gATlGv8nb992x5yjLfMPBgEwz5QjMDT27xfwy
	1FFwLq92NgYx1SfqtV/w8f/FyTNOOC1/UNG5Mcgql7/gIosvl2c/QXl76tGWCxnGBQUyRsmSZOW
	2Fg/KUklGtvujrzlKqbIKpFgHnpAs/kdodWa+JyEDGdY1XFWXOnWXyWS/x1+iQZ52u3tQ/FqMw7
	dA4MGxKBU6I5NhSWZuucBTAiYxu8TLsWFRFokN4CV1JI9Iq9vWdcdpIDuYAudmCoMEhp+hD2S73
	BfnJhb7F1jPDmBlRZ7Y85pVK8SWIZ7eI7m1MmEcdPOwP4pWPzzHEKwDbDw
X-Received: by 2002:a05:690e:80a:10b0:67d:99fc:2e48 with SMTP id
 956f58d0204a3-67df441fbccmr4804347d50.47.1795534647574; Tue, 24 Nov 2026
 07:37:27 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124100035.245953-2-frederic.danis@collabora.com> <6b05756c.018c0331.11d296.c08e@mx.google.com>
In-Reply-To: <6b05756c.018c0331.11d296.c08e@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Nov 2026 10:37:16 -0500
X-Gm-Features: Aa3M54pQtscHfhodgxqg2tbL-Ippvl08nQWlwSy_R05Db-Kell3PxlDfgnULr1w
Message-ID: <CABBYNZJRrv81NNbbD9cJ9Q2r+FGMxmxjWiVPzde+1YuCMga4aQ@mail.gmail.com>
Subject: Re: client/btpclient: Security Level reporting
To: linux-bluetooth@vger.kernel.org
Cc: frederic.danis@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Tue, Nov 24, 2026 at 6:31=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1220644/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.99 seconds
> GitLint                       PASS      0.69 seconds
> BuildEll                      PASS      15.91 seconds
> BluezMake                     PASS      229.50 seconds
> MakeCheck                     PASS      13.53 seconds
> MakeDistcheck                 PASS      117.21 seconds
> CheckValgrind                 PASS      280.36 seconds
> CheckSmatch                   PASS      234.25 seconds
> bluezmakeextell               PASS      75.46 seconds
> TestFunctional                PASS      1003.52 seconds
> IncrementalBuild              PASS      235.64 seconds
> ScanBuild                     PASS      844.91 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2896

Copilot flagged a problem:

https://github.com/bluez/bluez/pull/2896#pullrequestreview-6038693469

--=20
Luiz Augusto von Dentz
