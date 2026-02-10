Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691891624D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770696138; cv=none; b=UcfGLDOrUKYpOUYhuOjXRPj2Uvr8kTu7LyqAeqfDifDtQC+EKGOgHY4cbezAYR6eNDqGfJ1NZi/Zdz6n7H7G7M5m2ckk/e5Qto7VVYTQwj/PXblyesdS8UNSSDx9NYVXVKzT2y2+UwFT4l+8lnHXbtMNGGJRwinMJddY0mZE5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770696138; c=relaxed/simple;
	bh=k0YPAnAXTr6Hzmtu44FovV5NKXSFt6qFC2qsj7Lat6M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LihL1QccMmdXjQpe3hpYtBZnnIRsYUA+QhHrMEHh53CkWymPLrKbGhbXADIAPp3iVjpOSI1WVycsSSO9n3fwYVoUtYAvcnSoHmzNjMMf/2w9Hx+d+/a/wuf6LpjkiYIy7ZBYFsAAG7Zze26pq7SsF4Jlbbfd0MGPsWaa7oYRUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeiJuXSl; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeiJuXSl"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233b953bebso730104c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 20:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770696136; x=1771300936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k0YPAnAXTr6Hzmtu44FovV5NKXSFt6qFC2qsj7Lat6M=;
        b=VeiJuXSlfS6xcarx7FEn3wkjofYmNa7IuLlNpfgOAm7b2MiYt6xo4BouGDPIUJzTJq
         BYJmtpVnehk7xqH+eYu2PjMqqJarp6YmUPu3vNmRMO78fuqrznRq2GVR5zbxEZsVTaMM
         tVflyo/UyK67LoM+/pt9eiU/4SyCsiQRXB9w8CYEq+dUAGvsumhEs5d70CaDpvUVQ41T
         iAG9we7JFC1ppZKWlPDmqZbVV6CnPmjKegREjaS7qzdgLOPU9GHfWUPQOoBDWiJHu2iJ
         mmcunZ+VqvXMsWaIBzs5DQr2s78Y7izKWzPV1LEqgI3/TpX2aqGfhBV80wWKCMBV0avS
         CMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770696136; x=1771300936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0YPAnAXTr6Hzmtu44FovV5NKXSFt6qFC2qsj7Lat6M=;
        b=Vl575zKg3BQLtZG7ZJIk6lR5I60rLfbpOHOGLKrlBCM3UYy6MFQMFoSh97hK5IGou3
         8IuJqVuR0ZBJ4WCQgwny7G8LvgpqzfHlonpEuNLvKD6kFkOjjeJdG5+Jh8zRCmVtT0R2
         5LZTbXhourQz0HNZjTLZ7HbX07kmJRMmJOHGTGPVhGggoy8B8NqUDdstoWvO+/zkZsTf
         hqL0YHJS/NpQCCGK+Fx3B/9rRkJwcLB2w2xLfn1eQNgKGfAyAZENhJDDZBVKyxpOc+w/
         Gih8WzROrYnmx0sQs5O6zK7fQgCoK+Xf0zyMCNf0Lj5JkXqY4c/FH1rlVrzrx478APd6
         +p4Q==
X-Gm-Message-State: AOJu0YzcLyNfsOvnWz8GozioQFpAoLJQr+v/K/e9T+Muolk0XgWw7bJS
	q3DNsnjeVCuyePHbMp4AI8xltaWfG/ChXdtyh5HmlgzqEKCVepAcCOgewrfPoMRe
X-Gm-Gg: AZuq6aJo+kQEjR/aTv+gq5ZlhAqJxN9cRBrNNpwRXnUevukFKJBUJWZ/Eq2n9M0dwz4
	25dwZq1icp2Im9ZvCsZQ3lPVmGVpD+A/aOnUw0Gi0gLN4kYThN70HIconCnesSa9rZAv+vFwGgb
	XJekTsTRDs++FuQl9D2ufP4ai9rOANQjvRIK7RpxKAA1CXR0ZqC8sDHK9NIHq3hNzVaHwosyJtd
	tNfy3VT8fSA4d33zkpmlwTzA34ef62zveiaBHyXF1h2AVEe9E3vKpBK778KdsMpvwl7uGn6SL/8
	pKIZSHKGF2bh4U8lQy4IuunTYOxIKMlctPxUmlKqkS9zSbXRyhX0+zdP0O7sHDsuf93nxWE32cM
	Y2wDMvidefXthIzUmSFyyDKDT/4k8Pp90s3+NDDC051vGDbwUTRyWJR4mvL/TXKbTPJsSObKZrr
	x0aJRsgp03CEo8qer1hdey9u8Z+DGMAg==
X-Received: by 2002:a05:7022:220b:b0:119:e56b:c74b with SMTP id a92af1059eb24-12704001542mr6333839c88.16.1770696136109;
        Mon, 09 Feb 2026 20:02:16 -0800 (PST)
Received: from [172.17.0.2] ([20.171.125.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12715c4dd76sm6478827c88.10.2026.02.09.20.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:02:15 -0800 (PST)
Message-ID: <698aadc7.050a0220.122e9b.d67f@mx.google.com>
Date: Mon, 09 Feb 2026 20:02:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4265204079367727214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mengshi.wu@oss.qualcomm.com
Subject: RE: [v4] gatt-client:Implement error handling for DB_OUT_OF_SYNC in GATT caching
In-Reply-To: <20260210011347.3237740-1-mengshi.wu@oss.qualcomm.com>
References: <20260210011347.3237740-1-mengshi.wu@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4265204079367727214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTA1MjQ3NAoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEVORElORyAgIDAuMzcgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
RU5ESU5HICAgMC40MSBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAxOS45NSBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAg
ICAxMy42MSBzZWNvbmRzCk1ha2VDaGVjayAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAy
NS42MCBzZWNvbmRzCk1ha2VEaXN0Y2hlY2sgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyNDIu
NDEgc2Vjb25kcwpDaGVja1ZhbGdyaW5kICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTEuOTcg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTMuOTggc2Vj
b25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBGQUlMICAgICAgMTEuMjcgc2Vjb25k
cwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5HICAgMC40MCBzZWNvbmRzClNj
YW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNC4xOSBzZWNvbmRzCgpEZXRh
aWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNoIC0gUEVO
RElORwpEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgoKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQRU5ESU5HCkRlc2M6IFJ1biBnaXRs
aW50Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCbHVlek1h
a2UgLSBGQUlMCkRlc2M6IEJ1aWxkIEJsdWVaCk91dHB1dDoKCnNyYy9zaGFyZWQvYXR0LmM6MTg3
Mjo2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmGJ0X2F0dF9kYl9zeW5j
X2NhbmNlbOKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xhcmF0aW9uc10KIDE4NzIgfCBib29sIGJ0
X2F0dF9kYl9zeW5jX2NhbmNlbChzdHJ1Y3QgYnRfYXR0X2NoYW4gKmNoYW4sIHVuc2lnbmVkIGlu
dCBpZCkKICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fgpjYzE6IGFsbCB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjc4MDM6IHNy
Yy9zaGFyZWQvbGlic2hhcmVkX21haW5sb29wX2xhLWF0dC5sb10gRXJyb3IgMQptYWtlWzFdOiAq
KiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW01ha2VmaWxlOjQy
MDU6IGFsbF0gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFr
ZUNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjawpPdXRwdXQ6CgpzcmMvc2hh
cmVkL2F0dC5jOjE4NzI6NjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9uIGZvciDigJhi
dF9hdHRfZGJfc3luY19jYW5jZWzigJkgWy1XZXJyb3I9bWlzc2luZy1kZWNsYXJhdGlvbnNdCiAx
ODcyIHwgYm9vbCBidF9hdHRfZGJfc3luY19jYW5jZWwoc3RydWN0IGJ0X2F0dF9jaGFuICpjaGFu
LCB1bnNpZ25lZCBpbnQgaWQpCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtl
ZmlsZTo3NTIzOiBzcmMvc2hhcmVkL2xpYnNoYXJlZF9nbGliX2xhLWF0dC5sb10gRXJyb3IgMQpt
YWtlOiAqKiogW01ha2VmaWxlOjEwODY4OiBjaGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6
IE1ha2UgQ2hlY2sgd2l0aCBWYWxncmluZApPdXRwdXQ6CgpzcmMvc2hhcmVkL2F0dC5jOjE4NzI6
NjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9uIGZvciDigJhidF9hdHRfZGJfc3luY19j
YW5jZWzigJkgWy1XZXJyb3I9bWlzc2luZy1kZWNsYXJhdGlvbnNdCiAxODcyIHwgYm9vbCBidF9h
dHRfZGJfc3luY19jYW5jZWwoc3RydWN0IGJ0X2F0dF9jaGFuICpjaGFuLCB1bnNpZ25lZCBpbnQg
aWQpCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3ODAzOiBzcmMv
c2hhcmVkL2xpYnNoYXJlZF9tYWlubG9vcF9sYS1hdHQubG9dIEVycm9yIDEKbWFrZVsxXTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZToxMDg2
ODogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENo
ZWNrU21hdGNoIC0gRkFJTApEZXNjOiBSdW4gc21hdGNoIHRvb2wgd2l0aCBzb3VyY2UKT3V0cHV0
OgoKc3JjL3NoYXJlZC9jcnlwdG8uYzoyNzE6MjE6IHdhcm5pbmc6IFZhcmlhYmxlIGxlbmd0aCBh
cnJheSBpcyB1c2VkLgpzcmMvc2hhcmVkL2NyeXB0by5jOjI3MjoyMzogd2FybmluZzogVmFyaWFi
bGUgbGVuZ3RoIGFycmF5IGlzIHVzZWQuCnNyYy9zaGFyZWQvZ2F0dC1oZWxwZXJzLmM6NzY4OjMx
OiB3YXJuaW5nOiBWYXJpYWJsZSBsZW5ndGggYXJyYXkgaXMgdXNlZC4Kc3JjL3NoYXJlZC9nYXR0
LWhlbHBlcnMuYzo4NDY6MzE6IHdhcm5pbmc6IFZhcmlhYmxlIGxlbmd0aCBhcnJheSBpcyB1c2Vk
LgpzcmMvc2hhcmVkL2F0dC5jOjE4NzI6NjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9u
IGZvciDigJhidF9hdHRfZGJfc3luY19jYW5jZWzigJkgWy1XZXJyb3I9bWlzc2luZy1kZWNsYXJh
dGlvbnNdCiAxODcyIHwgYm9vbCBidF9hdHRfZGJfc3luY19jYW5jZWwoc3RydWN0IGJ0X2F0dF9j
aGFuICpjaGFuLCB1bnNpZ25lZCBpbnQgaWQpCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn4Kc3JjL3NoYXJlZC9nYXR0LWhlbHBlcnMuYzoxMzM5OjMxOiB3YXJuaW5nOiBWYXJpYWJs
ZSBsZW5ndGggYXJyYXkgaXMgdXNlZC4Kc3JjL3NoYXJlZC9nYXR0LWhlbHBlcnMuYzoxMzcwOjIz
OiB3YXJuaW5nOiBWYXJpYWJsZSBsZW5ndGggYXJyYXkgaXMgdXNlZC4KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3ODAzOiBz
cmMvc2hhcmVkL2xpYnNoYXJlZF9tYWlubG9vcF9sYS1hdHQubG9dIEVycm9yIDEKbWFrZVsxXTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo0
MjA1OiBhbGxdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IGJs
dWV6bWFrZWV4dGVsbCAtIEZBSUwKRGVzYzogQnVpbGQgQmx1ZXogd2l0aCBFeHRlcm5hbCBFTEwK
T3V0cHV0OgoKc3JjL3NoYXJlZC9hdHQuYzoxODcyOjY6IGVycm9yOiBubyBwcmV2aW91cyBkZWNs
YXJhdGlvbiBmb3Ig4oCYYnRfYXR0X2RiX3N5bmNfY2FuY2Vs4oCZIFstV2Vycm9yPW1pc3Npbmct
ZGVjbGFyYXRpb25zXQogMTg3MiB8IGJvb2wgYnRfYXR0X2RiX3N5bmNfY2FuY2VsKHN0cnVjdCBi
dF9hdHRfY2hhbiAqY2hhbiwgdW5zaWduZWQgaW50IGlkKQogICAgICB8ICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1h
a2VbMV06ICoqKiBbTWFrZWZpbGU6NzgwMzogc3JjL3NoYXJlZC9saWJzaGFyZWRfbWFpbmxvb3Bf
bGEtYXR0LmxvXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDIwNTogYWxsXSBFcnJvciAyCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBJbmNyZW1lbnRhbEJ1aWxkIC0gUEVORElORwpEZXNj
OiBJbmNyZW1lbnRhbCBidWlsZCB3aXRoIHRoZSBwYXRjaGVzIGluIHRoZSBzZXJpZXMKT3V0cHV0
OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFNjYW5CdWlsZCAtIEZBSUwK
RGVzYzogUnVuIFNjYW4gQnVpbGQKT3V0cHV0OgoKc3JjL3NoYXJlZC9hdHQuYzoxODcyOjY6IGVy
cm9yOiBubyBwcmV2aW91cyBkZWNsYXJhdGlvbiBmb3Ig4oCYYnRfYXR0X2RiX3N5bmNfY2FuY2Vs
4oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRpb25zXQogMTg3MiB8IGJvb2wgYnRfYXR0X2Ri
X3N5bmNfY2FuY2VsKHN0cnVjdCBidF9hdHRfY2hhbiAqY2hhbiwgdW5zaWduZWQgaW50IGlkKQog
ICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5n
IHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6NzgwMzogc3JjL3NoYXJl
ZC9saWJzaGFyZWRfbWFpbmxvb3BfbGEtYXR0LmxvXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDIwNTogYWxs
XSBFcnJvciAyCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============4265204079367727214==--
