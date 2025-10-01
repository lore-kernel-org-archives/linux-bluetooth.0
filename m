Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AA1DA62E
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351173; cv=none; b=TaTIhDl0QpC6hVLKZe1tBfNb81i2j2qVcKx5sqej3ZLTV/yjAArTG1NpAyHmPJigUaJMdV1BYjxIxqRThzvheplyC19R5c7DEU2FwiiDfokj2MY8JLab3l7CHu7JgKeQdVmPIGor07Cy2Gbnx+ZrCexod9aGuds4AgsTs2CIEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351173; c=relaxed/simple;
	bh=YtNFUU6zgQZBFMYE4wz5Z1BlDp+NVYbi2JU3R9qlR78=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EqGcV9BDExVpOlD9LjINvKc0SNywWjog5JJkE7OMV2Uber6xOgtjsRnXb9TuG5mtNhGB7I3zdFIV6f+X7Pc3qBKMh4/chik0xk0kd77ehw4AdewMlSEtCyZp14bF0Dz4F+VJ9Klw9TrGVCQhb7pz/jjG2rInpiUOR8CRPeCx74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPaEnf02; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPaEnf02"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-271d1305ad7so2972175ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759351171; x=1759955971; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YtNFUU6zgQZBFMYE4wz5Z1BlDp+NVYbi2JU3R9qlR78=;
        b=PPaEnf02ZxqTWTivk5vzmOBmsT2PNsKDweaIJ3/UmEDIX1y5JqJuJvaPE+4xTyGD7/
         FqMFEGtUeEXxsK8JlarFCZf4Wt4u0guAfHpfFjMiWMB9/UvR84assIjf2AW3BSD7T0ek
         sAnc8xVPVDMhs+XlefPIIqUKqnwsQjPfp+P9lPlVTnSx5+hs8aZTvTTxpTNOg0CmzvZV
         cdQyqNeZbosQx91LikOPUrTDyFWMHuvC2qlDEQEp47pEZi+RT9CSRgxZ/7DLuF2WTd14
         JFgJ0FgCzBGP5j/QYZXaO90ySRoF+RERuszwENH0eH6U0oWjN3peCARFKDws95/EMeDS
         zX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759351171; x=1759955971;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtNFUU6zgQZBFMYE4wz5Z1BlDp+NVYbi2JU3R9qlR78=;
        b=ZYFAcbt80x5EOb+n91ROzBdx+XdFAGysGxEibShe5fu+ocorigQgGmJXDPPe1apUSW
         9DBuZKZ4wj+EhtviRFD7WHB8KNZJnToIcxv8KpRvzzOya5LD/WKDm0qrQeo15G1Mpl7k
         IaFV1AGDkZgjSWS+GurPQxCfkrX0Q0Ty11JLN58oqnH5BT6CQS1qwDO8bL1R5IqJ/Nxe
         kcoxBW3Y9/V/2CMYHOI844dqoFGgHaa/WVm/7YzZLnHZU3sKq5/A3WVrEF15bM8HtPpT
         NUhhTwgk51ChXhND7KbFZXzWbxHAln4eM4Csmi2ZHJc0VwIS9R2dWnz+T1RelPOVex6V
         +y5g==
X-Gm-Message-State: AOJu0YxaedQbqZL9iskHjto/xr1t/gja5++pu/9Xm3EBAGs7EkmXfUA5
	tKHtOOGtFZTNitq3SWHQ+BikQAjvA1XIKcaQakTmOpKVIpsr0PljCFcseYsovg==
X-Gm-Gg: ASbGncvs4LDWk7I8mNvqZvZgyl2w7T+7Xg57AlWGW4kgz3MTlqTtDlcCRdvtXsq/Hm7
	i1Ev3BSxnnMY/IP+JbSSsdjFVoWfk8kyB/WgGJ9rgxGy0aU6lh+eWYkUnqOej1j6pmavDoWiQm7
	y71Z5GqQ/6/UE5FANygjI/I4/x1QgHthy+aZtWQ7IHJtMe67kvB96Yo7J3ErDHw+QfB1TSaaaHB
	OMZflqBbOgKXWS4Zfw3BisjFf2H3nr1mG0bUq6Wr4dlJWO97wA58H6oc1V95hnZp9FwAQyMdjpJ
	6xKa2gcpQ7IlgV/hvtvoKdAv1z95TywoqJzAEXgaSw6BQYD/lQyOSo/JIseIgbR19ux0WlFLL2g
	ZwcPCioHugvME1eczQBMq9ePffuIUvZekzgw7fwozN3AKXA+dhVfiPrY3bDAVb1w=
X-Google-Smtp-Source: AGHT+IF+KYqkDH5bjNj1gJESQEThN2XmtLWagcubZ4YMA0U1y2VokvEG+aeyL6804t/S1a8jAvn7zA==
X-Received: by 2002:a17:902:ea0f:b0:27e:f005:7d0f with SMTP id d9443c01a7336-28e7f32fa44mr59858195ad.44.1759351170667;
        Wed, 01 Oct 2025 13:39:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.229.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5635sm4609235ad.102.2025.10.01.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:39:30 -0700 (PDT)
Message-ID: <68dd9182.170a0220.2e7a98.2ac7@mx.google.com>
Date: Wed, 01 Oct 2025 13:39:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4096605771159723260=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/bass: Fix permissions not requiring encryption
In-Reply-To: <20251001191352.77542-1-luiz.dentz@gmail.com>
References: <20251001191352.77542-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4096605771159723260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTAwNzc5OQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEVORElORyAgIDAuNTMgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
RU5ESU5HICAgMC4zNSBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAxOS44NyBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICAyNjg2LjQxIHNlY29uZHMKTWFrZUNoZWNrICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAg
IDIwLjgyIHNlY29uZHMKTWFrZURpc3RjaGVjayAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDE2
OS4xMSBzZWNvbmRzCkNoZWNrVmFsZ3JpbmQgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyMzcu
Nzkgc2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzA1LjE2
IHNlY29uZHMKYmx1ZXptYWtlZXh0ZWxsICAgICAgICAgICAgICAgUEFTUyAgICAgIDEyNy40MSBz
ZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBFTkRJTkcgICAwLjM5IHNlY29u
ZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDkyNi41OCBzZWNvbmRz
CgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNo
IC0gUEVORElORwpEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgoKIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQRU5ESU5HCkRlc2M6IFJ1
biBnaXRsaW50Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBN
YWtlQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCi4vdGVz
dC1kcml2ZXI6IGxpbmUgMTA3OiAzMDYzOCBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBk
dW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjk5Mzc6
IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTAwNDU6IGNo
ZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTA0Njc6IGNoZWNrLWFt
XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0Njk6IGNoZWNrXSBFcnJvciAyCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNj
OiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFja2FnZSBjdXBzIHdhcyBub3Qg
Zm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBlcmhhcHMgeW91IHNob3VsZCBh
ZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0byB0aGUgUEtHX0NPTkZJR19Q
QVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1cHMnIGZvdW5kCi4uLy4uL3Rl
c3QtZHJpdmVyOiBsaW5lIDEwNzogNTEwODggQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUg
ZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVs0XTogKioqIFtNYWtlZmlsZTo5OTM3
OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjEwMDQ1OiBj
aGVjay1URVNUU10gRXJyb3IgMgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEwNDY3OiBjaGVjay1h
bV0gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEwNDY5OiBjaGVja10gRXJyb3IgMgpt
YWtlOiAqKiogW01ha2VmaWxlOjEwMzkwOiBkaXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBC
bHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIu
YzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjkwNDo1OiBu
b3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXIt
dHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI5MDQgfCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+Ci4vdGVzdC1kcml2ZXI6
IGxpbmUgMTA3OiA2OTUxNiBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIk
QCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjk5Mzc6IHRlc3Qtc3Vp
dGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTAwNDU6IGNoZWNrLVRFU1RT
XSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTA0Njc6IGNoZWNrLWFtXSBFcnJvciAy
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0Njk6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbEJ1aWxkIC0gUEVORElORwpEZXNjOiBJ
bmNyZW1lbnRhbCBidWlsZCB3aXRoIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMKT3V0cHV0OgoK
CgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============4096605771159723260==--
