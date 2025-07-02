Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E70AD51
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425976; cv=none; b=kLnhVG0bpdBQbubi8fbdDQ92WO6dE/JbXTVgcuxcrl7zIcfnIBAWGES5a8mUeILYN1R9dfi5cNPfPJJqhnozoPpT17zx2FFL2lFvfxA/bx8BsZxvw9tekgh4PASfZvbUcjtdSq1z9+MnasHNzBpjJB2BlINOh3VN2jvnWmn88o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425976; c=relaxed/simple;
	bh=nVhlUla+BBzxK03WxFoBxJOD/33pvM+S7i+qJIjrvKw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XXu7FRNUzMkoTZRceRMgSqLRE3XIxt6IbrVaP3pzZzol+VG71+3zF0l3GogLrA0OxsDRfBuZW2kAifDeUR/n/EcYJmvxPWrvLiFPxUkfzTFlJvu1P+4Ui4+B5sWVPEnHvRXx2sGz635Ifpa72hw/XtXihf//lgwgRLHB4rt5iMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIXFkOAt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIXFkOAt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d219896edeso678524185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751425972; x=1752030772; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nVhlUla+BBzxK03WxFoBxJOD/33pvM+S7i+qJIjrvKw=;
        b=MIXFkOAtZ2+meAQgEIh5/CF6MFzMDFHw4Kg6WRcWvESkbUHFbGhqr+zUFOxDpc7NuL
         Evq1EySGoFsqK9Sz4CosXvRYt33qwX34d3VzFGqcbEE7KktiUjrYHSqed4h4TDbVdM1S
         BnTg3O9uA2O0PRu51KbPy8RzhnOkVUJZI/TK8ipFmTuSaExmd+cglU4WmKHaOroKvhV0
         e7aWvddzPDcSkHyUjy93TlRNjAKyI+wxdaRyReDlBPy4W7eI/8ZT15bPxptjHr8tqyj+
         yjFOpU3+bZIHvje/a7YNduL32T5b9JuMU6+HOGEk13LRRhVu2un5dpQEaJ91yVLbxnbK
         mErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751425972; x=1752030772;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVhlUla+BBzxK03WxFoBxJOD/33pvM+S7i+qJIjrvKw=;
        b=hPTjMderytyv34939LJkYXEBn3i228AqkgUC8FSINI3kZqDwQvoS6IVsYPVyWwT5Rq
         o1sUqaiMXWy9ottmB+Mk5e4F6rknAdH9uIpmGBTFssU8HlTnrd1liGqiVm+/KTlu+jBQ
         xsRhrwBeXQaDTM8+kODR62Q+vcJ0KGxitozLMBG7NqiJDHmAiTGnzaTO8jWlDUMRp2/f
         ki6h1m65yob2L8IzedYxVmPKI/4wO43UJXRqVBH1g+NWicZ02ivqr0n9d1+l6tiwgB7L
         j8+b2/qXjxlEnBFMr6VG75BDL/FRKlNwqixuSe4WRR5WoG3U10X0PbS6aUsK/kmKNpwt
         fdXQ==
X-Gm-Message-State: AOJu0YzQEvnedZQIgCvN/gCCLK4xT7WhXm/lAdEvi6qamSo9ewc5lfjq
	l8+PJ1AVgVxMZ74rBnMxaQyPs0ytCpLImPt7i6xKPF12XyigoKUOBZMCQOSOXw==
X-Gm-Gg: ASbGnctOp2nP9OnO1JzSvUM/n6k4h0QhD93UVQyoCPt/pxBb9t9kgy3ZBQO0JOkTePN
	6oW4vy0tG+FGsdo+9bZ+9qAyWQPOsdUJCRmRYgosSLOOxCTNVJr08Xy2frWwfcf4gQQRntcWXJQ
	UMkrYxZgfKyZIJY4N6EESe4Thp8hVM0twF0wHo0LlJ92LoFn0BaxcXG/k42ymCkYTEUKhZyh1cZ
	IoWMq597VI9co3y+lJuGnaLnylaAZ49IrF/6D9oHRAlakw73oU4PgNMpwWPZr4btVZl7n2O8VYL
	ayr5rWjmFqIrqXY7I7FvoerPts/7c7Qr62x5g8nLvvqxgzguDtczonInV/cu4McEWO2y64QaK60
	ovug=
X-Google-Smtp-Source: AGHT+IHOAorrGOk84+6YnoBpwvKlC1liZ9wNeaDsMFUpT5t+18+pBXzBiTcEGNPTNcNSzfibp5SNaQ==
X-Received: by 2002:a05:620a:4091:b0:7c5:49b7:237c with SMTP id af79cd13be357-7d5c471770cmr164660385a.27.1751425972179;
        Tue, 01 Jul 2025 20:12:52 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.130.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443231da6sm875094785a.101.2025.07.01.20.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:12:51 -0700 (PDT)
Message-ID: <6864a3b3.050a0220.64ede.d50a@mx.google.com>
Date: Tue, 01 Jul 2025 20:12:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5639315565723797247=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_core: lookup pa sync need check BIG sync state
In-Reply-To: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
References: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5639315565723797247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTc3OTcwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4yNyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjIzIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTIgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjQuNzUgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMjcu
MDAgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzAuNTkg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjQuNjMgc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBGQUlMICAgICAgMTAyLjIyIHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgRkFJTCAgICAgIDAuNDUgc2Vjb25kcwpU
ZXN0UnVubmVyX2lzby10ZXN0ZXIgICAgICAgICBGQUlMICAgICAgMC4xMiBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIEZBSUwgICAgICAwLjEyIHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgRkFJTCAgICAgIDAuMTIgc2Vjb25kcwpUZXN0UnVubmVyX3Jm
Y29tbS10ZXN0ZXIgICAgICBGQUlMICAgICAgMC4xMiBzZWNvbmRzClRlc3RSdW5uZXJfc2NvLXRl
c3RlciAgICAgICAgIEZBSUwgICAgICAwLjEyIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10ZXN0
ZXIgICAgICAgRkFJTCAgICAgIDAuMTIgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVyICAg
ICAgICBGQUlMICAgICAgMC40NCBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAgICAg
IEZBSUwgICAgICAwLjEyIHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAgRkFJ
TCAgICAgIDAuMTIgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5H
ICAgMC43MSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja1BhdGNoIC0gUEVORElORwpEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQK
T3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQ
RU5ESU5HCkRlc2M6IFJ1biBnaXRsaW50Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyU2V0dXAgLSBGQUlMCkRlc2M6IFNldHVwIGtlcm5lbCBh
bmQgYmx1ZXogZm9yIHRlc3QtcnVubmVyCk91dHB1dDoKQmx1ZXo6IApzcmMvZGV2aWNlLmM6IElu
IGZ1bmN0aW9uIOKAmGNvbm5lY3RfcHJvZmlsZXPigJk6CnNyYy9kZXZpY2UuYzoyNjg5OjY6IGVy
cm9yOiDigJhFUlJfQlJFRFJfQ09OTl9QUk9GSUxFX1VOQVZBSUxBQkxF4oCZIHVuZGVjbGFyZWQg
KGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogMjY4OSB8ICAgICAgRVJSX0JSRURSX0NPTk5f
UFJPRklMRV9VTkFWQUlMQUJMRSk7CiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+CnNyYy9kZXZpY2UuYzoyNjg5OjY6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBp
ZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBl
YXJzIGluCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTExNjI6IHNyYy9ibHVldG9vdGhkLWRldmlj
ZS5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6NDY5MDogYWxsXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX2wyY2FwLXRlc3RlciAtIEZBSUwKRGVzYzog
UnVuIGwyY2FwLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5k
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX2lzby10ZXN0
ZXIgLSBGQUlMCkRlc2M6IFJ1biBpc28tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpO
byB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBibmVwLXRlc3RlciB3aXRoIHRlc3Qt
cnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBUZXN0UnVubmVyX21nbXQtdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gbWdtdC10
ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6Ck5vIHRlc3RlciBmb3VuZAojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9yZmNvbW0tdGVzdGVyIC0gRkFJ
TApEZXNjOiBSdW4gcmZjb21tLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKTm8gdGVz
dGVyIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVy
X3Njby10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBzY28tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIK
T3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IFRlc3RSdW5uZXJfaW9jdGwtdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gaW9jdGwtdGVzdGVy
IHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfbWVzaC10ZXN0ZXIgLSBGQUlMCkRlc2M6
IFJ1biBtZXNoLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5k
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX3NtcC10ZXN0
ZXIgLSBGQUlMCkRlc2M6IFJ1biBzbXAtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpO
byB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RS
dW5uZXJfdXNlcmNoYW4tdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gdXNlcmNoYW4tdGVzdGVyIHdp
dGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IEluY3JlbWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6IEluY3Jl
bWVudGFsIGJ1aWxkIHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CgoKCi0t
LQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============5639315565723797247==--
