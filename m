Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01114A23
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765425698; cv=none; b=UaB/WTRR2L8jB4U/61XmL4K4sf9IVegZfH9n2ai0+PTpItaXVL40bfaYQ6tuPIrIEI1LXjE8pOYHW4ADnbQto6bD8Sdu8oRXTR+uTCuAv4eq1DRHpG4aMRHrHY0bzuflFtXz3mkTUMqUnSUoX/nbeeKkRAsSA7KzrujAoNz45oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765425698; c=relaxed/simple;
	bh=VUg9L3FE1wXH1aUtrBVfd4Trjtz66avbC/ICLd+VJ/E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ILfB1imny19CYMMewy7iAMiVd6ZQ9LigxTze4za5Iu18KNDG8ZtRznklYJqBu/k3EXz8ohA3I500mUAjIcfWQ1DEmdSXmL5mG9zZWFMgRJcg7z2lpyG710mZ+aHHP2qoSxmv8m8FfHwCN08CEpaPTJUtKkxyiTYYq2ikkDGWHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD+/2x0t; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD+/2x0t"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so651533a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 20:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765425696; x=1766030496; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VUg9L3FE1wXH1aUtrBVfd4Trjtz66avbC/ICLd+VJ/E=;
        b=kD+/2x0tqXO32YRiuDJxTBomTQtyHLRqEJDsSNXwjw3cLSApP9NpH+ihVaoKltAI65
         O+K1jpd3bh/17G8OcFPa60oD+YTVMS4nU6lxlu8952QoWFssEUN3mkWsWa2SlIYhY9eO
         d9dt7o7cFmVpQhLD+8xc+TEz7dClB+9qwT4bDiCYT7XSgELwHEUZ9MqEwMjuR9Qr2fWF
         des9UNrNMTiIKCkx64eo7giyFSFoChrHH1SbykURdznz6ZG4iUOiIoPjbegCmkiTrikW
         2KW26oOkThGxKyOyuZW/pKn1X/qvhSGsXFmUQnbqyv9W9FYM1M0mxCvNXpeVlM/k06Jl
         xLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765425696; x=1766030496;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUg9L3FE1wXH1aUtrBVfd4Trjtz66avbC/ICLd+VJ/E=;
        b=OwHo05Ch0xyV7dhoUshbLuwd6B2nS29YY8YEbAZwQ1LY58121jGtM3tM6fJCivOpJ5
         QocAk5y14IsoycSGp19cyLSxp9qH44ujR6IFMn7/zfQnnio7UFfsO0I95We6DNgWkl+6
         Ifm2YL1F4UAwW4LfEmmMLplCJY1Iy+RulJnspWZqyXBsi6GbcvIFFhlth5FcsO7GjhB9
         MwH3mlBhBWfgZF4XiHH1lNbiuGCA3Z6fyC6Gn+sSQxpuZ5zZ/Ie366juDQqXYdTyExS+
         +2uEyhb4mmAfYxWuGjDmPtmoFSB0+w/2h4a3a/OIcXgHPk8RPmR80Ra5JBunrP+uXrYR
         Ajvw==
X-Gm-Message-State: AOJu0Yy5ce55DqIayJDBI+WfaNoiokMBmlpHo7vSRU0aDiMQ11wz+JM/
	E6x7PyX1F34yCEDkAMEe1RgnzNeyBcGXi28RzW0BzBvocc2i9UBc5GSzuxY7tg==
X-Gm-Gg: AY/fxX48605yupemSlXB4qLFz9is9NHV1vhkB9zdAZCj/A2et929EuRx3/fFWjO8WOg
	0txRltQTrPEOea8eSMhiooGEJI2YNBbnLJt/pDa3BbNTnvfr4S9jJoCutHIhK6Srtx3dPZ+9ecF
	/BNTV2C+jhh4fzcornOEzl/MeYouT18e8nmsWwS/RzjTdejJtg8aPzHVHFuK3hjMJ8ZdPa6zUCN
	qhglr+S8EDaJK72vUfWqjaatg+SbXRAXhL8+K300X2iIu9zCqSlSOXHU4nwTYC7LR4Jv4NV7i1P
	GV/VHt2PQRFBExQBqMW7BYochcQMJ9/9kXqZ54cut8n+4OLa51cDXonvDyuqqfi7sENggkDHnO0
	MDVtZkVD2536+fMD5GucaWcDO2BTXXzkqmPUXCNZr71Ly1mU+3YsAo8K2uq2g61eWNrtfC/j0jw
	QRaLoIrXDQklvghwxEb08=
X-Google-Smtp-Source: AGHT+IHM/O/upz2A7IDUxCVqMkORj9kQdw95xxGQeNALOG5wvpvrRiryY8BgkGeqx6fEzdNmVR8dAQ==
X-Received: by 2002:a05:7022:239c:b0:11b:d4a8:d24d with SMTP id a92af1059eb24-11f2967dbd8mr3778608c88.12.1765425695712;
        Wed, 10 Dec 2025 20:01:35 -0800 (PST)
Received: from [172.17.0.2] ([172.184.213.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff624sm4313363c88.12.2025.12.10.20.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 20:01:35 -0800 (PST)
Message-ID: <693a421f.050a0220.2dace2.6287@mx.google.com>
Date: Wed, 10 Dec 2025 20:01:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4219495765490030628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: shared/lc3: Fix frame len in set 44_1 The frame len in set 44_1 shoule be 97.
In-Reply-To: <20251211030243.1175-1-kx960506@163.com>
References: <20251211030243.1175-1-kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4219495765490030628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTAzMjE1OQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEVORElORyAgIDAuMzUgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
RU5ESU5HICAgMC4zMSBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAyMC45MiBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA2NzEuMTIgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTAuNTQgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjE0
LjI4IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1Ni43
NiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNDkuMzQg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTgwLjk2IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVORElORyAgIDAuNDIgc2Vjb25k
cwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTAyMC4yNiBzZWNvbmRz
CgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNo
IC0gUEVORElORwpEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQRU5ESU5HCkRlc2M6IFJ1
biBnaXRsaW50Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBN
YWtlQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCi4vdGVz
dC1kcml2ZXI6IGxpbmUgMTA3OiAzMTQxMSBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBk
dW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjEwMzE2
OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEwNDI0OiBj
aGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEwODc0OiBjaGVjay1h
bV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEwODc2OiBjaGVja10gRXJyb3IgMgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZURpc3RjaGVjayAtIEZBSUwKRGVz
YzogUnVuIEJsdWV6IE1ha2UgRGlzdGNoZWNrCk91dHB1dDoKCi4uLy4uL3Rlc3QtZHJpdmVyOiBs
aW5lIDEwNzogNTI5ODAgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAi
ID4gJGxvZ19maWxlIDI+JjEKbWFrZVs0XTogKioqIFtNYWtlZmlsZToxMDMxNjogdGVzdC1zdWl0
ZS5sb2ddIEVycm9yIDEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMDQyNDogY2hlY2stVEVTVFNd
IEVycm9yIDIKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMDg3NDogY2hlY2stYW1dIEVycm9yIDIK
bWFrZVsxXTogKioqIFtNYWtlZmlsZToxMDg3NjogY2hlY2tdIEVycm9yIDIKbWFrZTogKioqIFtN
YWtlZmlsZToxMDc5NzogZGlzdGNoZWNrXSBFcnJvciAxCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBD
aGVjayB3aXRoIFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVyLmM6IEluIGZ1bmN0
aW9uIOKAmG1haW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTI5ODQ6NTogbm90ZTogdmFyaWFi
bGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFz
c2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CjEyOTg0IHwgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgouL3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzog
NzE5NjQgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAiID4gJGxvZ19m
aWxlIDI+JjEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMDMxNjogdGVzdC1zdWl0ZS5sb2ddIEVy
cm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMDQyNDogY2hlY2stVEVTVFNdIEVycm9yIDIK
bWFrZVsxXTogKioqIFtNYWtlZmlsZToxMDg3NDogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioq
IFtNYWtlZmlsZToxMDg3NjogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjClRlc3Q6IEluY3JlbWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6IEluY3JlbWVudGFs
IGJ1aWxkIHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CgoKCi0tLQpSZWdh
cmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4219495765490030628==--
