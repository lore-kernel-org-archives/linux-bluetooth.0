Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5518E023
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159282; cv=none; b=LGmUq8hD0iivsn+mFFgiCzla5iDx+d64nhR+JcFzZ/YohVIVaA32bPu8cEbdr/0epBApylq8brN96YJph3SGvo5LN0S2SMtGK7D0x+buIzbczlbW/fQgnoj3/Np+g7rlJP5CfRTxiMS5CUfRUqXqkTKnQwzHPyHuFqHIR+T8GkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159282; c=relaxed/simple;
	bh=plJ6Jyc6U0JgtXw3iPSNFcY9K/PBv1CUUdalr4hw0+g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Yh49hkpg/RwUty8KSNTdnmY4x3WGTRbjs4z6au5JV/4yb8vIm9WHL8VZc8XHgMDrCtWHzkGPLkeD/GRv10XRVHAsCtv2AWKiSqNrumvaoyKtVkitcFJ/pAAdSZ/qiMGr2CtPQXs7sjwgUlkYJSKiqZabkJXdYilPNTrrOkYP7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hohnNEJ9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hohnNEJ9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d436c95fso336979485a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724159280; x=1724764080; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=plJ6Jyc6U0JgtXw3iPSNFcY9K/PBv1CUUdalr4hw0+g=;
        b=hohnNEJ9D8+RJKoJ7vmyQHJdvSoTk7Ci9ebaL+wOic+C26DumBDmV9WQZiEJ56GVfB
         tG+o62pfgsfTD4fmJpEw1oJogB/BRdKkBcjCumDafspqMFTASGu6oGbf1oohyCH2XCt4
         jkPC+FJpANyNKtAh9oLZPGlvSAX8lK0rjY9Ir6uNxFiAiDY/KRiwzCxKtI4D3fSC9HSh
         GgjMItmNSUKfSPnqfm0fr1ScQCMKT9NhE/2tnD2Qvr0/p7VHdBxsUnGnhMQBkGCUq9we
         Vh9UFxIC/cSOuTcX4wtQRomP9yIFLbYFIXW02ZnADaY1Al5GBQysiL8xuz1rnzkvVcbb
         IxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724159280; x=1724764080;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plJ6Jyc6U0JgtXw3iPSNFcY9K/PBv1CUUdalr4hw0+g=;
        b=UC8WF8ZW7/6AyIVK3trDdsbzxE3O95wj5oF3ChP3Yl1yEop1oD9DWhDL3/XNUf8M4V
         VvqnxZtxHQdObCXJrlP5ysGMfxrKAWkoi0RPYzHzqNdlhI/sJzQG/3p5zlw3ApNjBYb5
         U7RqEZdAeS8SaHMvC5LG+gLcbWPqM4OOLB7Vzpj6KicHGg6wp7OARIX9mxCiiNuJ1+Oo
         /8cVOy1QP4H/dVhpHASKxWZ1zwu3HaCNOehRIbReNXb2v75w7deXYxTGc1tyHpTrHd49
         K8Tl5kQX4MwTp4ILr4RaYogh4VnGR5Am4Q6w6EzD+iYlUtoJNscG8qH8GNgRIWAHaXBH
         5nsQ==
X-Gm-Message-State: AOJu0YwjV4AGO+qGstzJQmcWk8aDp5fOZ2+rlrOdL8V6Q8LIA+DZSYuY
	w7YEBDytTHJWV/NhGrGJj4UFDea6Z4igg4BC3Iplbn5xfai4BU3l9/lL1A==
X-Google-Smtp-Source: AGHT+IEhwbzuBtvIPNnkL+GyPk7X6XcC/5tj+vmzY9/NYiXgp6b9TFJ17USY1sba43isPMSV0hu31Q==
X-Received: by 2002:a05:6214:4906:b0:6b5:e3ee:f7f6 with SMTP id 6a1803df08f44-6bf7cdd895cmr214276976d6.23.1724159279445;
        Tue, 20 Aug 2024 06:07:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd886asm51532096d6.24.2024.08.20.06.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:07:59 -0700 (PDT)
Message-ID: <66c4952f.050a0220.cdf27.49ac@mx.google.com>
Date: Tue, 20 Aug 2024 06:07:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3409623707274417495=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client: Add bluetoothctl-assistant.1 man page
In-Reply-To: <20240820113153.25708-2-iulia.tanasescu@nxp.com>
References: <20240820113153.25708-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3409623707274417495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgxMzE0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC4zOCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMwIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI1LjExIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3NzcuMzAgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuNjUgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTYy
LjI5IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1NS43
MSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNjIuMjgg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIzLjk1IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE1NDUuNzUgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQRU5ESU5HICAgMTA5OS45NyBzZWNv
bmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hl
Y2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoq
KiBbTWFrZWZpbGU6MTE3NjY6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBb
TWFrZWZpbGU6MTE4NzQ6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MTIzMDM6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDU6IGNo
ZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlz
dGNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFj
a2FnZSBjdXBzIHdhcyBub3QgZm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBl
cmhhcHMgeW91IHNob3VsZCBhZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0
byB0aGUgUEtHX0NPTkZJR19QQVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1
cHMnIGZvdW5kCm1ha2VbNF06ICoqKiBbTWFrZWZpbGU6MTE3NjY6IHRlc3Qtc3VpdGUubG9nXSBF
cnJvciAxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE4NzQ6IGNoZWNrLVRFU1RTXSBFcnJvciAy
Cm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6MTIzMDU6IGNoZWNrXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6
MTIyMjY6IGRpc3RjaGVja10gRXJyb3IgMQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogQ2hlY2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sgd2l0
aCBWYWxncmluZApPdXRwdXQ6Cgp0b29scy9tZ210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJht
YWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEyNzI1OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNr
aW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50
c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjcyNSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCiAgICAgIHwgICAgIF5+fn4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc2NjogdGVz
dC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg3NDogY2hlY2st
VEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMwMzogY2hlY2stYW1dIEVy
cm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMwNTogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFNjYW5CdWlsZCAtIFBFTkRJTkcKRGVzYzogUnVu
IFNjYW4gQnVpbGQKT3V0cHV0OgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============3409623707274417495==--
