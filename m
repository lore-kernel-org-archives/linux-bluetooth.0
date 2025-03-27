Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D4F8462
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111125; cv=none; b=jGYDAxx5/NUXba41Lw4ZROgpNe9527Whbv5X2ZOMfXy9zSgEkASizYTpUn5oH5KA4L/af/wT2ICYJidRyq/XROovF8xnPqZibySSHvlH+4rN/75XVwdmuszj6lDgYOcs+2NO40NokNkfdeIOBVDIpRip/uXJs1/iDml+InAFmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111125; c=relaxed/simple;
	bh=VykMGlDS2Kj0WaUz77sjQS9bw/YIVDlWGrTCUikttgI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o8eDCEzej8GrKo6jQYoJnkd3Xr3gMgED50yDujmD0GFWVpEvO0PT4J0StFNlgSF+TQDoRartOofXP7ouaS92px5Dq8E9t4dVhj8m97iFTbtjS22/jIGLhHbTUdn0ZaPzTA366i1UjfY6LIkSbktA4/0VN+a1tcQ6t0wK/SJlhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkZy45xn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkZy45xn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22548a28d0cso42878785ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Mar 2025 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743111123; x=1743715923; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VykMGlDS2Kj0WaUz77sjQS9bw/YIVDlWGrTCUikttgI=;
        b=WkZy45xnvUERUIg8hAbg548xxV9YPsGf+Vn/7lYQ3bGlJg+I3jpV+qq/viz12itELM
         2nHp8gwbo3SXjK61oXkbxGxzrpHsa9Sp6MNjRxxqnbMhdeb53kijZvtaZ6P1pzWPh7d9
         dUGDbKDhV1FmfjG9YZAEG0GvGuFBVQb54VAQByry7tC6WO+ZIeluMmK+M809+ytcL2dm
         8AWes1LnlD7ROwbfBb0MYTm1N6cSjQ2pqyrqwe6403/mCYbaTYb2awwBdo4lHWZemOz5
         LNmyVUEalHNqZDApbPrelYjhe3J8waXledEbFeJBIV8rKCHcCPg98Yln5DLe/B2mWrqs
         WSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743111123; x=1743715923;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VykMGlDS2Kj0WaUz77sjQS9bw/YIVDlWGrTCUikttgI=;
        b=b4g0I8UswAgyi/b0LT10KvZGVsA8P3BCSPUXQ8aB45hyWoE6yTkn4GaYCv5VIvIviy
         B8bbiNQPnI+L9vX1q1hV1qzMjHLRsws2jB48FGBLIDP2vt6h4wsG9ET/ng48Za4xyEEb
         nqV2VnYQdiDP4i4je48rXw+AEExs+f7/XqsL/wmi1cTzIfGKwKn123stjHf8sqwkt9eT
         8R4nVgHFdI1RJn03kJPrKsMR9szy39BQKO/1t6qakKDEVN42Fup+AtuILMbSLDhoDGww
         ht8lWnKISENoS5ImH8GzhqneLZVMxz+oCH3c80uoD8M2GwxSBJQ2q77h/e5hvxn2Z4MN
         jI6A==
X-Gm-Message-State: AOJu0Yw9S7DVYcFMSpf8HvrOS7XKIoUi/Cr4DStMqxy/0OU8lV5FeLmr
	O0Y3mgRbMk3TlBTa+m/JMOy6Y5fMHQpl5CwaKhRTXi2jy6fWplP5ZduCQg==
X-Gm-Gg: ASbGnctHjz1lcXLAvKT8PF8Bl11zoPwPvVPHEBfW/TV+JLG9r6mB/P8npYOZ2YjxWYC
	ODfL17ERPXhV97n9Wy+GMZyWoxUU6cF4JfAYh8ul9qy3WgXPGHYp+zlkBYGOQK9xPbMSM1+MGxK
	m92Qm2b+/ksPezcMWeuSJyXKGeHBuNnRU+1z5i4y/ASpANd+lFnHwmSV1eEZMzduojFxSe2Ao/A
	0E2+tGUVTQaPtrLngbet8c0AqQJkPUuM6PG/A+tzyRjHQdkwtHZyUCx9m/oseLkZN0KZ7uleEUY
	Q3BDTXTmgSl2V9lb0PKuHKArSIM1R/gUFttxSJlYrTpzBtl8MqMblmMa5oXfng==
X-Google-Smtp-Source: AGHT+IHLSL3xQrNBHNbb0XzuLvonNAfcab9pXkn2Ol6e4knAyy5MicXeIbxGye9rybzTSWMp33PmZQ==
X-Received: by 2002:a05:6a20:4393:b0:1ee:63d7:1d32 with SMTP id adf61e73a8af0-1fea2be0620mr9479496637.0.1743111122864;
        Thu, 27 Mar 2025 14:32:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.47.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b67e828sm378229a12.4.2025.03.27.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:32:02 -0700 (PDT)
Message-ID: <67e5c3d2.630a0220.21ca60.5a8e@mx.google.com>
Date: Thu, 27 Mar 2025 14:32:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7853686835207763510=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Add initial SCO(7) documentation
In-Reply-To: <20250327203006.2936448-1-luiz.dentz@gmail.com>
References: <20250327203006.2936448-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7853686835207763510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTQ3ODgyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4yOCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjM3IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIwLjYyIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE0ODAuMDIgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuNzkgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTM5
Ljc2IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDIxMi4x
MiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyODIuNjYg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgOTcuNjYgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5HICAgMC4zOCBzZWNvbmRz
ClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA4NTUuMzAgc2Vjb25kcwoK
RGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAt
IFBFTkRJTkcKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0Ck91dHB1dDoKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gUEVORElORwpEZXNjOiBSdW4g
Z2l0bGludApPdXRwdXQ6CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFr
ZUNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjawpPdXRwdXQ6CgouL3Rlc3Qt
ZHJpdmVyOiBsaW5lIDEwNzogMzIyOTQgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVt
cGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc4MDog
dGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg4ODogY2hl
Y2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMxNzogY2hlY2stYW1d
IEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMxOTogY2hlY2tdIEVycm9yIDIKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VEaXN0Y2hlY2sgLSBGQUlMCkRlc2M6
IFJ1biBCbHVleiBNYWtlIERpc3RjaGVjawpPdXRwdXQ6CgpQYWNrYWdlIGN1cHMgd2FzIG5vdCBm
b3VuZCBpbiB0aGUgcGtnLWNvbmZpZyBzZWFyY2ggcGF0aC4KUGVyaGFwcyB5b3Ugc2hvdWxkIGFk
ZCB0aGUgZGlyZWN0b3J5IGNvbnRhaW5pbmcgYGN1cHMucGMnCnRvIHRoZSBQS0dfQ09ORklHX1BB
VEggZW52aXJvbm1lbnQgdmFyaWFibGUKTm8gcGFja2FnZSAnY3VwcycgZm91bmQKLi4vLi4vdGVz
dC1kcml2ZXI6IGxpbmUgMTA3OiA1NTEwNSBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBk
dW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzRdOiAqKiogW01ha2VmaWxlOjExNzgw
OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExODg4OiBj
aGVjay1URVNUU10gRXJyb3IgMgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEyMzE3OiBjaGVjay1h
bV0gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyMzE5OiBjaGVja10gRXJyb3IgMgpt
YWtlOiAqKiogW01ha2VmaWxlOjEyMjQwOiBkaXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBC
bHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIu
YzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjkwNzo1OiBu
b3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXIt
dHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI5MDcgfCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+Ci4vdGVzdC1kcml2ZXI6
IGxpbmUgMTA3OiA3NTE0NiBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIk
QCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNzgwOiB0ZXN0LXN1
aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjExODg4OiBjaGVjay1URVNU
U10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyMzE3OiBjaGVjay1hbV0gRXJyb3Ig
MgptYWtlOiAqKiogW01ha2VmaWxlOjEyMzE5OiBjaGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAtIFBFTkRJTkcKRGVzYzog
SW5jcmVtZW50YWwgYnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzCk91dHB1dDoK
CgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============7853686835207763510==--
