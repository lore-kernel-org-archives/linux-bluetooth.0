Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620D379ECD
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921414; cv=none; b=OAJV8vqyG0f2cIQIbMfuToO3fgXwxnDEWGkV3PrOx/EYNEqqCfeRPEx3DcPSy//mBEujejc/BpBC3ASfMJYZfu2GdaNmq7nb/dKttnP19NxUslmZ8fod0DZdxO5vMDDHI4qAJhZUatz3kSmUKujP2Rer9r76ySel4Y/tnu4/wSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921414; c=relaxed/simple;
	bh=l6LAqlk0FMt2Zah0n/3qtLjw6SDR+kj2ed6TvHq3Vx8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gjB5jTElNGSaPnulKT+AK5pytuUQ4sxTUHlMDK5pO7+8s/ibacu1MSDdtMy4QGtjhjlNORl7qhgVyR8FjtM8POvKXetnG8KzIIj2oLXfUPDp+Caa4DWMKR36a8SGhoCWlK8vlr9W1wr8CzGJxyNbkp7QENOR7jJY+QMGjHzUKMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmpU3s3i; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmpU3s3i"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4863a7dac63so2128163b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780921412; x=1781526212; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l6LAqlk0FMt2Zah0n/3qtLjw6SDR+kj2ed6TvHq3Vx8=;
        b=gmpU3s3iV0V+tMF/7WLlOd5RTohTyR5AEQWfeQmmvYDGuBqRjScYa6iJFY4LMrF8hH
         KFtLmDCBLMFOTmC3wM70GwfLmOf115/lLtr6Xu3UNSqSu2UAjUWyXhWF3SsMSXZ+TD+F
         QJDw1JLk3Y9B6V75l6gBHUrZ4Fdu2CRKFXlBNXI4rKqyx6ynvl2yDfKf+D2HjWWVrLxA
         FYKt0NhrEp7c7s++Ti4JLx/W4SAY2bU/aq0ltr4JQmLPXV0ced8Yl+6y8o/n41R3OU4j
         DNc4lbhlQ2neM2lS9yZW19CRXKrThrzDqH57HZwZ8InT0SSJnAiRLnPgrpiDkabG3gBg
         5y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780921412; x=1781526212;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6LAqlk0FMt2Zah0n/3qtLjw6SDR+kj2ed6TvHq3Vx8=;
        b=e6cPHiuiMuyp/382NfTuMDd3HPJuFGC3WgOuUel2x9Vv7PBZ4oraPhfDzhTWeG5KzO
         XNYklogyEkk7EBjJ93SmLyzEZVX45XpTCG4WmmEiHB2xYdkjTos9djLfjEvbsmMp4H01
         5hjG6cUXoybsP9SppDkEFj2NKSXzm/m+KcvjNolq7Wtb/Mnbtbjnt22B3Sj07MpjMiDP
         fPlgy/hEdOAtfqa+BsMSoZ4rxBNmOOsU0vtH770wYzxMoGJ59neBVZ76sBDMfriNDxt6
         zzZNUZgTim/sdE2rKpcUBA1F3joufNwRfoTQbq/8zmRM3cPW2/csJkl1Kl87Juo11Q57
         y4vQ==
X-Gm-Message-State: AOJu0YymGPLoss08lohBA8mryCTUGGUgZz9O6zmwvgaygJYDlMDEUFp5
	p06E86MBF1l3esXcwe1ny2mQyHMtShK+F93jE9hdB11qC5upWmpnWS5SC0MI0A==
X-Gm-Gg: Acq92OEjed7RBmDTvP0oBmKvSexyuEDyA4Sq9x2WCz1+ZNSrOsUGTQAeeHOZUmglX9f
	gVlmHyk8GSwrmNWlWhrVe+7WI6BV+/j0ugcpWvg2Nj7dfvR87f6JHWy7pvH77TOOyPav5ZksWlk
	OxKeh3YYH9dQ/2b/r0+fOUt/hUi8j1BpthgzRi5yBHAJXFppnrHc8+3naPLA3wyP8/BHlq/9qBx
	Mow70rgQYMYVpRD4A3OfIpNJcxzWZoGba8Or9x4vGRrpkdZsbzBEqF3QSvtYbPrO/G79uDXKSL8
	ETdfw6zLpq2Blw0TZSMeE/68l+oIMosl5sqwI5sqnCrl4Zb1Wl5n7nWROB0rWNEO5gUSD0D5uZf
	BrCly9pWbuy1IhTQTi2QozslZ3KEUc6aiVuAlRexrYJNBk3u9ENnAD/9Ry83qpU2tWwBH9gE72o
	Y7g3iLgPly0V02qIqf0zzXLFDqrAi4BS+XsZpmhViI
X-Received: by 2002:a05:6808:3208:b0:486:523e:d259 with SMTP id 5614622812f47-4868d89913fmr9376445b6e.0.1780921411508;
        Mon, 08 Jun 2026 05:23:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.182.166])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm15303443fac.8.2026.06.08.05.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:23:30 -0700 (PDT)
Message-ID: <6a26b442.48960be9.31d619.bb22@mx.google.com>
Date: Mon, 08 Jun 2026 05:23:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3526660525449191997=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] bap: Fix CCC value for ASE control point
In-Reply-To: <20260608112028.3686726-1-simon.mikuda@streamunlimited.com>
References: <20260608112028.3686726-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3526660525449191997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTEwNzc4MwoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgIDEuNzQgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4yNiBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAxNy44OCBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA2MjUuMTIgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MS4wNyBzZWNvbmRzCk1ha2VEaXN0Y2hlY2sgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxOTYu
Njcgc2Vjb25kcwpDaGVja1ZhbGdyaW5kICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjA3Ljcz
IHNlY29uZHMKQ2hlY2tTbWF0Y2ggICAgICAgICAgICAgICAgICAgV0FSTklORyAgIDMxMy40MiBz
ZWNvbmRzCmJsdWV6bWFrZWV4dGVsbCAgICAgICAgICAgICAgIFBBU1MgICAgICAxNjguOTYgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNTICAgICAgNjQyLjI2IHNlY29u
ZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDkzMy40OSBzZWNvbmRz
CgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hlY2sg
LSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCi4vdGVzdC1kcml2ZXI6
IGxpbmUgMTA3OiAzMTE1NyBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIk
QCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjEwMjM5OiB0ZXN0LXN1
aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEwMzQ3OiBjaGVjay1URVNU
U10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEwODE4OiBjaGVjay1hbV0gRXJyb3Ig
MgptYWtlOiAqKiogW01ha2VmaWxlOjEwODIwOiBjaGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZURpc3RjaGVjayAtIEZBSUwKRGVzYzogUnVuIEJs
dWV6IE1ha2UgRGlzdGNoZWNrCk91dHB1dDoKCi4uLy4uL3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzog
NTI5MTkgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAiID4gJGxvZ19m
aWxlIDI+JjEKbWFrZVs0XTogKioqIFtNYWtlZmlsZToxMDIzOTogdGVzdC1zdWl0ZS5sb2ddIEVy
cm9yIDEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMDM0NzogY2hlY2stVEVTVFNdIEVycm9yIDIK
bWFrZVsyXTogKioqIFtNYWtlZmlsZToxMDgxODogY2hlY2stYW1dIEVycm9yIDIKbWFrZVsxXTog
KioqIFtNYWtlZmlsZToxMDgyMDogY2hlY2tdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZTox
MDc0MTogZGlzdGNoZWNrXSBFcnJvciAxCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjayB3aXRo
IFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG1h
aW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTI5OTA6NTogbm90ZTogdmFyaWFibGUgdHJhY2tp
bmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz
4oCZLCByZXRyeWluZyB3aXRob3V0CjEyOTkwIHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKICAgICAgfCAgICAgXn5+fgouL3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzogNzE2NTIgQWJv
cnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEK
bWFrZVszXTogKioqIFtNYWtlZmlsZToxMDIzOTogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFr
ZVsyXTogKioqIFtNYWtlZmlsZToxMDM0NzogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTog
KioqIFtNYWtlZmlsZToxMDgxODogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmls
ZToxMDgyMDogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IENoZWNrU21hdGNoIC0gV0FSTklORwpEZXNjOiBSdW4gc21hdGNoIHRvb2wgd2l0aCBzb3Vy
Y2UKT3V0cHV0OgpzcmMvc2hhcmVkL2JhcC5jOjMxMjoyNTogd2FybmluZzogYXJyYXkgb2YgZmxl
eGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6IG5vdGU6IGluIGluY2x1ZGVkIGZpbGU6
Li9zcmMvc2hhcmVkL2FzY3MuaDo4ODoyNTogd2FybmluZzogYXJyYXkgb2YgZmxleGlibGUgc3Ry
dWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6MzEyOjI1OiB3YXJuaW5nOiBhcnJheSBvZiBmbGV4aWJs
ZSBzdHJ1Y3R1cmVzc3JjL3NoYXJlZC9iYXAuYzogbm90ZTogaW4gaW5jbHVkZWQgZmlsZTouL3Ny
Yy9zaGFyZWQvYXNjcy5oOjg4OjI1OiB3YXJuaW5nOiBhcnJheSBvZiBmbGV4aWJsZSBzdHJ1Y3R1
cmVzc3JjL3NoYXJlZC9iYXAuYzozMTI6MjU6IHdhcm5pbmc6IGFycmF5IG9mIGZsZXhpYmxlIHN0
cnVjdHVyZXNzcmMvc2hhcmVkL2JhcC5jOiBub3RlOiBpbiBpbmNsdWRlZCBmaWxlOi4vc3JjL3No
YXJlZC9hc2NzLmg6ODg6MjU6IHdhcm5pbmc6IGFycmF5IG9mIGZsZXhpYmxlIHN0cnVjdHVyZXMK
CgpodHRwczovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovcHVsbC8yMTkwCgotLS0KUmVnYXJkcywK
TGludXggQmx1ZXRvb3RoCgo=

--===============3526660525449191997==--
