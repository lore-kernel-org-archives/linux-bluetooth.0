Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1B205A79
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233668; cv=none; b=IjHsO17vxpIPlJYV3erqvQGsZXNlena9WOOFe3TVWeK3l5szgDP1d80t7cpBI7cdYt1jOd91S3kO5kNv0OEDqARjMVrJTmAb2dFEI1ItJE/MAr+z7yP/qBQvehIHNFVBtJ8Y2vrr78OLT+DdKWNnnEweriKoHTVt3OlEMjme8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233668; c=relaxed/simple;
	bh=Np4JXK5sIZ0fDWgLysIjTU/X54PprhKiKocoD9oVHsY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VMomqlLRrp91z5yzPT1lRS4Yhm0ImQjaCJ5YZ/rOhrLTnEb+miWWCaBvNwny7k+7l2pVamREy/WT576qv4Pt2HWdtfNixkmwgWGjqzXMBb/NGaE0NVGaRnleaLQPlmu+owWRKpkkLDEmScOnqDAKZPqFZUDEl3gjY2WfJYrd8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQV28WNX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQV28WNX"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf775d1bdfso33250896d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724233665; x=1724838465; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Np4JXK5sIZ0fDWgLysIjTU/X54PprhKiKocoD9oVHsY=;
        b=EQV28WNX8XpRb94wU0gbqsdo7BErw6qYtcEK5pg9JVopYHsQ2Df7zOC+Dl6yA9hfom
         1tT2VH8+lYE8OR39zp5yuOcXlyYmjI21p33GQarhQQRu/a7ztVWKm9sdISvHlXo6RbN/
         ePWpP47Kv/sHubdCRpR2AeyQC//5qjrM01IQDV2biJmKps9QbyTJgJ+zhEmZd05KW/3F
         7Gjxwbz71W4kJc3ZJoR+RWhHKvzGSRF1NBGrSILJRtwctqi563BSMBZMCZpB9H+J9M2L
         2NV4obrdNh941tVOCvk4raNUy6AONoqh2RnKG6EEecgksFfy0aKZkLG1jFrAAe4SpDTY
         brkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233665; x=1724838465;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Np4JXK5sIZ0fDWgLysIjTU/X54PprhKiKocoD9oVHsY=;
        b=UMat+ciohxJFWz0IpyhSQ4AqtzB8WGox+NZCws813RaQIA/SR8zl84S4W53UA+SrSh
         Mr+iVB0j/MGctAhUjBgXOWlgItJy52X0dUS5w55ZNgo86zHLZE7UGwsBYsjNLEHZhmDu
         BIV/h3NtGbhYbmPwnkzj779/nFvEayp0poSh3/oWZy1Y96CO2MBmvCjQM2VEX62F33kD
         IdsXkHvgbbgkBcRU+6/7zT1OnUXVuOhvGGtHAdFiXeQdPPHN5pGbqYR7ELDVZazt0nJX
         xv+Ws7PUPHceZp4ZsKjconiBAA4ntx/qnV1uvY+vKeBtw2HIx6cskxQkZA0uRJNxrEMe
         Q7NQ==
X-Gm-Message-State: AOJu0YxVSi2ZNroiUFXBfz3HBqtVWHzShJ70JIdJ3Y07aN94xnFWu9Re
	SJvh1GizPKzokDx2DUC5eHgx4rPKaTeuN6AHmzf+8+sH3osjgtwCDeYX/Q==
X-Google-Smtp-Source: AGHT+IEj9nKiw+g6OW3Ni64callfOxHWrcGtKx2v16imZ3iKBnN/Llta8Ua8HdCuKNKXXt2lJM/RxQ==
X-Received: by 2002:a05:6214:578a:b0:6bb:bc83:660b with SMTP id 6a1803df08f44-6c155d889f0mr21424236d6.20.1724233665163;
        Wed, 21 Aug 2024 02:47:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe26c71sm59162126d6.61.2024.08.21.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:47:44 -0700 (PDT)
Message-ID: <66c5b7c0.050a0220.c109d.8821@mx.google.com>
Date: Wed, 21 Aug 2024 02:47:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0982158715395868526=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] a2dp: Fix connection error message
In-Reply-To: <20240821075714.357691-1-frederic.danis@collabora.com>
References: <20240821075714.357691-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0982158715395868526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgxNjQ3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC40NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMzIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI1Ljk2IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3MDcuMzQgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTIuODkgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTYy
LjIwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1NS43
MCBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNjAuNTMg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIyLjk0IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE0NjkuMTcgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTA2MC43MiBzZWNv
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
IyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFNjYW5CdWlsZCAtIFdBUk5JTkcKRGVzYzogUnVu
IFNjYW4gQnVpbGQKT3V0cHV0Ogpwcm9maWxlcy9hdWRpby9hMmRwLmM6MzcxOjg6IHdhcm5pbmc6
IFVzZSBvZiBtZW1vcnkgYWZ0ZXIgaXQgaXMgZnJlZWQKICAgICAgICAgICAgICAgIGlmICghY2It
PnJlc3VtZV9jYikKICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fgoxIHdhcm5pbmcg
Z2VuZXJhdGVkLgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============0982158715395868526==--
