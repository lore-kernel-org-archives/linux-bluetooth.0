Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3642E88B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991564; cv=none; b=UMtGNnpkjubKjK5xKJAMvKPmA6Q15IECiIYKXD8CAA91QFYCNWDv4DfwmSeSdsqGAHqZnSqqZa9+E3Hb3Bfgk0CtwCkaGnX4p3ZVY1gYUDxL7MQk+7iUJ0hpPk+Yr8Y8QSL4T/rHNvm25mOZBnSBVebk53qmmZLIddDtwonvhoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991564; c=relaxed/simple;
	bh=kAgWGjWWM29rJqvBRFC2OOPU1ZzXPOTCxlnuEoxYcrg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C3UIHPAXQ0WgBIT1chMBrFvCXlIuyePxsqWTPVfo4lN4i5vIzAAlVjyEWySQA/bAobGV8Yq3rPlSBC9y/1s0AfRz1Rq8Q5/8hNRAxPrBuCK1OW+QR/y4zOOq0nZ3Wqk9eJ19siKxsSuSFvAHdG3PXdd2U+Kjc/NcTNjGN0MlNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrZFZWHO; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrZFZWHO"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e62a1cbf82so361859785a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754991561; x=1755596361; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kAgWGjWWM29rJqvBRFC2OOPU1ZzXPOTCxlnuEoxYcrg=;
        b=GrZFZWHOqqSGT3q0UAke4J9QD4DUNxEePv6A0M3cXmBE/wD2lCXpyZnc83ArrJRcap
         a63eXS2g9a9UG6vZ67qst7I7mMkSs004ZWtR563DP+aEuo070wpCPgoGTiTd9fjEaeZk
         rXM6ZYyDSDgHO7opi5yQCRT6Be9ngM3JxWyyIpSMVf1AYS9YP6K5ZV1+nZDse2XenbFx
         oYaN30a1oOsee8tpJ6WnkHSNPZ4320d971br4e3mjP6Ub5r+VxZYMYmB1Iw04s+yVWcV
         AMEKFK8PZGYZqN8iO+Z+iieyNdqjDfgFYciIFfuOV7NkdGMYCs53Gavn26fuxvytyEnk
         eaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754991561; x=1755596361;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAgWGjWWM29rJqvBRFC2OOPU1ZzXPOTCxlnuEoxYcrg=;
        b=P7cSGi/H6xsET59ZsaKEN1nbzFecYpFbeOmYy1ib0/i7d+2rVtiO66uPjBACoxnpQ0
         RLxGGENno/zTqBliQ+9Eovf96EmK+WvI5oAco4cjq6K6jU0ckvI/473WfyTLnHnn6ZvQ
         rVSNVGLII9dLjZ/Tf1FgJAEX+0C2J0HFNTOMeo3kEGlNqBSEmupdAIv9msLntl/idXwe
         jpcOr+eh5TRePMDAbk7w51FtIAOX/FZrtZAooW9RRpCy72YufdRqRLLz0aCUfSgsjzla
         ehKyU5kzp/NbFvNrMtR5dBICBXykySexuFjNG7QMI4Q/WAg2aQZO+iwae+p1dFeXI5rT
         Z9Wg==
X-Gm-Message-State: AOJu0YxRFdC+1X28/w0LO7KZpH8SCd/h3yNzc6CtFArIIMT9pfGMV0cF
	94wtZOiEWhGl9tPtRTiViaVEljQW/aCoVgMO7yH+uiK7oaST1MeZujOkJImFg2Un
X-Gm-Gg: ASbGncsP2IGHRUFMMmGlb8RhYJ5zjgZR9GsOSvrRw6VwZROG2sJcgGGHuwouxcz+vx5
	XPLK8oYOyZGJmhoCwasBET8n4kmTl0X33mDpqAkRz5hR3Dx7kD6RlCEhLLdCWhRKAWLpjPrIq1u
	26A4hSfUPvYvIAPFXOv2mFKI0e/I6+/jc6Dl7odDVMIydvbArUj9xtFaxdJ4LObD3S7SSBmwrTj
	IvWkLGNlurLUzXXRuZzqKFPvX2fW7Yi1J/I5EBck1fM3AGWEvjUgSYOLDLRew3r88uiek8kkG2y
	NyZpkIzfiiYZgSGjUc5MdkJSkPYoEvosQd6/RmpZOhHE1Z+V9guia2euxwcB25gguIN3N3VG17q
	blIO19igqmxRN9hE0yBp2bq0si2pELc0=
X-Google-Smtp-Source: AGHT+IH4UXSQxKeOhEmlZumoB6yEAfAp+Ykbug+9FgCD5jmStz7/nzx+rMDhTb4jmD1O0UrSO89dug==
X-Received: by 2002:a05:620a:a905:b0:7e7:40f1:8d33 with SMTP id af79cd13be357-7e82c758067mr2161886285a.41.1754991561313;
        Tue, 12 Aug 2025 02:39:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.221.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e83e5d6a1bsm546977085a.13.2025.08.12.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:39:20 -0700 (PDT)
Message-ID: <689b0bc8.050a0220.c6509.ec55@mx.google.com>
Date: Tue, 12 Aug 2025 02:39:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2214937862595383154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, valorcool@gmail.com
Subject: RE: Fix memory leak when adding GATT Characteristic
In-Reply-To: <20250812080044.131526-2-valorcool@gmail.com>
References: <20250812080044.131526-2-valorcool@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2214937862595383154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTkwNDA3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zMSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjIzIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIwLjI0IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDI1MjcuMjUgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTEuNjkgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTYx
LjM1IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDE5OS44
MiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzMDkuNDQg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTI4LjA3IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVORElORyAgIDAuNDAgc2Vjb25k
cwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgOTIwLjU0IHNlY29uZHMK
CkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2gg
LSBQRU5ESU5HCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdApPdXRwdXQ6CgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBFTkRJTkcKRGVzYzogUnVu
IGdpdGxpbnQKT3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2VDaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKLi90ZXN0
LWRyaXZlcjogbGluZSAxMDc6IDMwNTg0IEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1
bXBlZCkgIiRAIiA+ICRsb2dfZmlsZSAyPiYxCi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiAzMDYx
MyBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUg
Mj4mMQouL3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzogMzA2MjIgQWJvcnRlZCAgICAgICAgICAgICAg
ICAgKGNvcmUgZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKLi90ZXN0LWRyaXZlcjogbGlu
ZSAxMDc6IDMwNjMxIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkgIiRAIiA+
ICRsb2dfZmlsZSAyPiYxCi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiAzMDY0MCBBYm9ydGVkICAg
ICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNd
OiAqKiogW01ha2VmaWxlOjk5Mzc6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoq
KiBbTWFrZWZpbGU6MTAwNDU6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFr
ZWZpbGU6MTA0Njc6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0Njk6
IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtl
RGlzdGNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoK
UGFja2FnZSBjdXBzIHdhcyBub3QgZm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGgu
ClBlcmhhcHMgeW91IHNob3VsZCBhZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBj
Jwp0byB0aGUgUEtHX0NPTkZJR19QQVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2Ug
J2N1cHMnIGZvdW5kCi4uLy4uL3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzogNTEwNDQgQWJvcnRlZCAg
ICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKLi4vLi4v
dGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA1MTA3MSBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29y
ZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQouLi8uLi90ZXN0LWRyaXZlcjogbGluZSAx
MDc6IDUxMDgwIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkgIiRAIiA+ICRs
b2dfZmlsZSAyPiYxCi4uLy4uL3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzogNTEyNzQgQWJvcnRlZCAg
ICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKLi4vLi4v
dGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA1MTM0MiBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29y
ZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzRdOiAqKiogW01ha2VmaWxlOjk5
Mzc6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTAwNDU6
IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTA0Njc6IGNoZWNr
LWFtXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTA0Njk6IGNoZWNrXSBFcnJvciAy
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6MTAzOTA6IGRpc3RjaGVja10gRXJyb3IgMQojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVu
IEJsdWV6IE1ha2UgQ2hlY2sgd2l0aCBWYWxncmluZApPdXRwdXQ6Cgp0b29scy9tZ210LXRlc3Rl
ci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEyOTA3OjU6
IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZh
ci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjkwNyB8IGludCBt
YWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KLi90ZXN0LWRyaXZl
cjogbGluZSAxMDc6IDY5NDYzIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkg
IiRAIiA+ICRsb2dfZmlsZSAyPiYxCi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA2OTQ5OSBBYm9y
dGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQou
L3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzogNjk1MDggQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNv
cmUgZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKLi90ZXN0LWRyaXZlcjogbGluZSAxMDc6
IDY5NDkwIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkgIiRAIiA+ICRsb2df
ZmlsZSAyPiYxCi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA2OTUxNyBBYm9ydGVkICAgICAgICAg
ICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAqKiog
W01ha2VmaWxlOjk5Mzc6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFr
ZWZpbGU6MTAwNDU6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6
MTA0Njc6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0Njk6IGNoZWNr
XSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRh
bEJ1aWxkIC0gUEVORElORwpEZXNjOiBJbmNyZW1lbnRhbCBidWlsZCB3aXRoIHRoZSBwYXRjaGVz
IGluIHRoZSBzZXJpZXMKT3V0cHV0OgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============2214937862595383154==--
