Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233212BEBB
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790797; cv=none; b=r1x/xj261y/DPKL+sAW6I+PWqqk1nkChCMkebAQ8Il5JzFuUS64kEDUii2Xgz5CoV/G9AhJXR7FHkrOLLytIPI6UXlG5GwuJQnp6vC0jsJOB2rRWfnyqkdDgzVxn5yiQgCMGGnELu2lbtq+0Bc3WTmR4dRNMuxonYCN/kh0ozgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790797; c=relaxed/simple;
	bh=21RboMPrkpVCsQgZEkEI1Tul3kkgDoqBOxqTWzdArDw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U3pKbJWAjKWesP9CQs9PvOqNwCiDNfxPREG7oXOUJ9ab1toxQz1r1mbSVJ9nQfrKOKFnQHiAGyFOoV0MMA/qQwAz/+hkswubb5qKSxL6UTm1VNYrkMjn+0ScI2c+5iCoEhvAGvvaxjeKh2cKnmHq2VVLFUyZ0Pi/RFO7CDlEcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJRQaJQH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJRQaJQH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a5074ebb9aso31248385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723790795; x=1724395595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=21RboMPrkpVCsQgZEkEI1Tul3kkgDoqBOxqTWzdArDw=;
        b=SJRQaJQHjgSqA1C4ER5rQ/YlZVt47+FwygGDW1RqNIaOcYhtrIlu2n1WQETYYQ5yaW
         FAcZJWEvm4hPgBXT6K/sTN884P8AvfkxfXwrb28rqnWM1jREf2yw3sBtboLFQQI82e39
         gAxLFmdU/RmKlBs1HT70wbmb7/DbNvzdoOEChiqy7mwsXG1t5sbF8bPzsb8f1bhv2J1d
         iTUuFcKAbdTbH8pAYM3A9HvY/2t/qn2FX2OMWbq5bTLmHQPIPsi9nM5a7OoeoGh4OE8x
         JZQIYRd9grSsJXcV4F8gbLsWtHZhltA9i2IpwqkPiUK3IyjFYxKTV/Z3ktRbmwB6/5hC
         Gp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790795; x=1724395595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21RboMPrkpVCsQgZEkEI1Tul3kkgDoqBOxqTWzdArDw=;
        b=wkkRFiNdVgM6HWvFhf3MnXqRRSZcGBTfYeWyBufTZE6Y1uw4aPX4hp9SUXVeYUt78i
         CCRVITd0fDVuj7KuvwLLKZ4VbYGhMMsCNO0XC2h/V0bi5rJRYJRsamO+FGxW7mg3z5yF
         gdyCbCvtatwLKXvknfSwGcSA3CzZniuhWvoA9AJ+/uwVaB/H7vRwLKSuOcPmEh8Db6JC
         /aj/oWvfjABTopHfVwlU3rBaAtsaGlTzYpTfw+brfvqgb0R58TYu7ekiRiIxzmKCQ58p
         abFmMQOMcEJiuJb7044qqucAI0bhCTGMC2dtK7mKxn7ta9a/HvpjYGwsgsF6aT/ZzPaY
         zrqQ==
X-Gm-Message-State: AOJu0YxMHhsFcOmGIEHvaWzUzVxlztSou+wMtdis/274jpVwDkKIhvL8
	gNoyTG6xp02wYi9U9ooLAmUI2kRGSrk7VrPjcX5TqSk6waAp2SrsU5v/qQ==
X-Google-Smtp-Source: AGHT+IF8jAKQ/VDn/z56TgA6GVJ9jCX5D/tbx6VbdWKJgIC8ZECEys0gh68eStV7rPwvLFB06lhpoQ==
X-Received: by 2002:a05:620a:2a10:b0:7a2:d64:1cbc with SMTP id af79cd13be357-7a50693d5efmr244847285a.26.1723790794631;
        Thu, 15 Aug 2024 23:46:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01de0csm139407285a.1.2024.08.15.23.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:46:34 -0700 (PDT)
Message-ID: <66bef5ca.e90a0220.3822a8.6f9f@mx.google.com>
Date: Thu, 15 Aug 2024 23:46:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4818911030774837082=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] Monitor: Complete missing fields in ESco Connection
In-Reply-To: <20240816131145.Bluez.v1.1.I6eb6574a1f0abd21e735618d5e8936fd230a4fa3@changeid>
References: <20240816131145.Bluez.v1.1.I6eb6574a1f0abd21e735618d5e8936fd230a4fa3@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4818911030774837082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgwMTg1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC41NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM2IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI1LjAwIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE2MjAuODAgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBQRU5ESU5HICAg
NzQuMDMgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTYz
LjU2IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1Ni43
MiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBFTkRJTkcgICA0MDUuMzAg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIxLjQ5IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE2MDQuNzQgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTAwNy43MSBzZWNv
bmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hl
Y2sgLSBQRU5ESU5HCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNjOiBS
dW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFja2FnZSBjdXBzIHdhcyBub3QgZm91
bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBlcmhhcHMgeW91IHNob3VsZCBhZGQg
dGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0byB0aGUgUEtHX0NPTkZJR19QQVRI
IGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1cHMnIGZvdW5kCm1ha2VbNF06ICoq
KiBbTWFrZWZpbGU6MTE3NjQ6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbM106ICoqKiBb
TWFrZWZpbGU6MTE4NzI6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMl06ICoqKiBbTWFrZWZp
bGU6MTIzMDE6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzMDM6
IGNoZWNrXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIyMjQ6IGRpc3RjaGVja10gRXJy
b3IgMQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tWYWxncmluZCAt
IEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sgd2l0aCBWYWxncmluZApPdXRwdXQ6Cgp0
b29scy9tZ210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRl
c3Rlci5jOjEyNzI1OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVk
ZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91
dAoxMjcyNSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+
fn4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc2NDogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEK
bWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg3MjogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsx
XTogKioqIFtNYWtlZmlsZToxMjMwMTogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtl
ZmlsZToxMjMwMzogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IENoZWNrU21hdGNoIC0gUEVORElORwpEZXNjOiBSdW4gc21hdGNoIHRvb2wgd2l0aCBz
b3VyY2UKT3V0cHV0OgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============4818911030774837082==--
