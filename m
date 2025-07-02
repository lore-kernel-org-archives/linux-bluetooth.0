Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81823956E
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459933; cv=none; b=qz1zhC4Id0taqWMg3r8eICu2JA10GaXPNECRAM0JAe3d7VtFXUddDo3T0KRcb0Fe59oxN8YxEEXhe0v/+ozPST8B6Nk+ZQC9kgcl1em0RC8LObRAJdBXcW9XVVasrRSJKEH5MN4YZV8l3IrqL+WEd6pzJaXk+YSq6YGm9bZ6+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459933; c=relaxed/simple;
	bh=kHlG3YJb+C7WSGdhVbciwv1CtLyxOaarD4MQfFgrgWs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L43PXwlgKl2QWPXvn2Wg7llKSQELzto6Kh5BRnyYCOXLpNHp8KRm98ygbue4pT7/N8OtRnSJBh7xamFXe9nm77hhMYbSHH0C9FARhENy2bR7A/nUBqCF0Eq3DrHNbD977T4HjYgPMmq8ytWH4uMui36vTgX9RBAC42M30KKtULI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFSCzj0Y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFSCzj0Y"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a97a67aa97so3314041cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751459930; x=1752064730; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kHlG3YJb+C7WSGdhVbciwv1CtLyxOaarD4MQfFgrgWs=;
        b=VFSCzj0Y0VEA0QsIBAqbUl+RJK0eNuwgjbb+UheDOXlQQ0qDQ739444sPeHzVv0V1s
         ectVPc7NmaVJiNmx54RCICJotDwF0492Gi6Sxhv6p5f68dozZJjch/758taJIasQjFJx
         YiDsJS3MbRt6caNyZpqwKxjxRNWyET8+ccS4GZhpHxzVrV6Upl18uQhrjkMcGQVtEnnT
         8lynSzHCs7eQX7+OxveqbXHGgKzGZhTFZvI4gPopquYCLdORvbkGDqIMqwvXl9bPDQII
         tkkZhSROHUbUI01CvaF4+ZAVs+vH3W61V/0bUgyH/d9+/hOjsMrrm7AXhncE4cvOeXe1
         7TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459930; x=1752064730;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHlG3YJb+C7WSGdhVbciwv1CtLyxOaarD4MQfFgrgWs=;
        b=GhNOQqaVsnwHaPYezCGmpLNwOjveu9+SSuaIdabZPUV9wf4x6aiUDk0Xv3Lha842gL
         3V6XzZDSgHQg9IW8xmiL3aOMMjQLOvRFmxoKNmAekoqHmVfjVYVKtO8AL0PCIxqxkLSi
         Fyw4Nvp5neuhhx0Vvz8TfLkvlyt1HkBSYtnN22yzqvQ/u4d+93LtYJkhpmt4bhrPWhcW
         sUFH7hoPeWkuWyb/mtMKYDESz2TZ9V92xC36QLaioCA8ZFjzfuwwFtTJAOIl1Tg2g1pG
         LddEfI378qTrvjGQFnd5smuNg4lokAWCrdwn12CTGvH0TiROxEs1wiebJ9ujjjAURm1o
         9TyA==
X-Gm-Message-State: AOJu0YypVN5SYXS2I+VE74mS+IUmO/SmNGpceMfY9emcwtPwHfVEMmap
	IiI/wn4v0mfFMosxRun84TgSIdNIUC9HrWIW6TvqLZ2sUq4xz0MjgeNcFsxkrA==
X-Gm-Gg: ASbGncuS0PoG9Psu5VuWw0fGuCjvvcTHZq4KVuxiKi25ClSiDJYrw6HKpVcfWfwBws+
	4mjAwcljfygwFq1j205zEGSYLkF6A81gmvQTPoKRxNkirt1aLZqV8U6KhNyNHoJ0T8LhJ9CrUMz
	ztkFbO4tw9V2rb/jezkUEwZ15EeJcb/jIAsK/4dccEtwVjXbCNism7BtZ/SGT7HMkxn3aWJ2B/c
	pDFR/dLmwRoxi+NbveRm/FlX9JWeG6t2YwwwYiOBapeEicnt7XjvQJX4vgRt3ORfQxzzLNTZkV8
	iDGWJIr3M1sjUNQkqehczbKJXC4bejJiSDIQfdrgIfja+c8pGMuWcUX0CUU6C9RWUHefFp0Fmp2
	IlHM=
X-Google-Smtp-Source: AGHT+IHOwXVnf+NUdHeNaO6j1veEo8GmMwIQP8F69D7xZoVrANpB8/R4Ekc3rPgMJp+YLNYN6qHfEA==
X-Received: by 2002:a05:622a:11cf:b0:4a4:3913:c1a5 with SMTP id d75a77b69052e-4a97690dbe0mr44707281cf.16.1751459929995;
        Wed, 02 Jul 2025 05:38:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.240.144.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc10620dsm90519621cf.7.2025.07.02.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 05:38:49 -0700 (PDT)
Message-ID: <68652859.050a0220.250d4b.df47@mx.google.com>
Date: Wed, 02 Jul 2025 05:38:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3878543631472766231=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, catalin.popescu@leica-geosystems.com
Subject: RE: [next,v4,1/2] dt-bindings: net: bluetooth: nxp: add support for supply and reset
In-Reply-To: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
References: <20250702114105.2229008-1-catalin.popescu@leica-geosystems.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3878543631472766231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTc4MTk0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4yMyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjE5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgRkFJTCAg
ICAgIDAuMzkgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjQuMzAgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMjYu
OTggc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzAuMDEg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjQuMDggc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBGQUlMICAgICAgMTAwLjEzIHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgRkFJTCAgICAgIDAuMTAgc2Vjb25kcwpU
ZXN0UnVubmVyX2lzby10ZXN0ZXIgICAgICAgICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIEZBSUwgICAgICAwLjA5IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgRkFJTCAgICAgIDAuMTAgc2Vjb25kcwpUZXN0UnVubmVyX3Jm
Y29tbS10ZXN0ZXIgICAgICBGQUlMICAgICAgMC4xNyBzZWNvbmRzClRlc3RSdW5uZXJfc2NvLXRl
c3RlciAgICAgICAgIEZBSUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10ZXN0
ZXIgICAgICAgRkFJTCAgICAgIDAuMDkgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVyICAg
ICAgICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAgICAg
IEZBSUwgICAgICAwLjA5IHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAgRkFJ
TCAgICAgIDAuMTAgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5H
ICAgMC45MSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja1BhdGNoIC0gUEVORElORwpEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQK
T3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQ
RU5ESU5HCkRlc2M6IFJ1biBnaXRsaW50Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBTdWJqZWN0UHJlZml4IC0gRkFJTApEZXNjOiBDaGVjayBzdWJqZWN0IGNv
bnRhaW5zICJCbHVldG9vdGgiIHByZWZpeApPdXRwdXQ6CiJCbHVldG9vdGg6ICIgcHJlZml4IGlz
IG5vdCBzcGVjaWZpZWQgaW4gdGhlIHN1YmplY3QKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IFRlc3RSdW5uZXJTZXR1cCAtIEZBSUwKRGVzYzogU2V0dXAga2VybmVsIGFuZCBi
bHVleiBmb3IgdGVzdC1ydW5uZXIKT3V0cHV0OgpCbHVlejogCnNyYy9kZXZpY2UuYzogSW4gZnVu
Y3Rpb24g4oCYY29ubmVjdF9wcm9maWxlc+KAmToKc3JjL2RldmljZS5jOjI2ODk6NjogZXJyb3I6
IOKAmEVSUl9CUkVEUl9DT05OX1BST0ZJTEVfVU5BVkFJTEFCTEXigJkgdW5kZWNsYXJlZCAoZmly
c3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAyNjg5IHwgICAgICBFUlJfQlJFRFJfQ09OTl9QUk9G
SUxFX1VOQVZBSUxBQkxFKTsKICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4Kc3JjL2RldmljZS5jOjI2ODk6Njogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50
aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMg
aW4KbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMTE2Mjogc3JjL2JsdWV0b290aGQtZGV2aWNlLm9d
IEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFr
ZTogKioqIFtNYWtlZmlsZTo0NjkwOiBhbGxdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4g
bDJjYXAtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfaXNvLXRlc3RlciAt
IEZBSUwKRGVzYzogUnVuIGlzby10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6Ck5vIHRl
c3RlciBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5l
cl9ibmVwLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIGJuZXAtdGVzdGVyIHdpdGggdGVzdC1ydW5u
ZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IFRlc3RSdW5uZXJfbWdtdC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBtZ210LXRlc3Rl
ciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5kCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX3JmY29tbS10ZXN0ZXIgLSBGQUlMCkRl
c2M6IFJ1biByZmNvbW0tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIg
Zm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfc2Nv
LXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIHNjby10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRw
dXQ6Ck5vIHRlc3RlciBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
VGVzdFJ1bm5lcl9pb2N0bC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBpb2N0bC10ZXN0ZXIgd2l0
aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6Ck5vIHRlc3RlciBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9tZXNoLXRlc3RlciAtIEZBSUwKRGVzYzogUnVu
IG1lc2gtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfc21wLXRlc3RlciAt
IEZBSUwKRGVzYzogUnVuIHNtcC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6Ck5vIHRl
c3RlciBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5l
cl91c2VyY2hhbi10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biB1c2VyY2hhbi10ZXN0ZXIgd2l0aCB0
ZXN0LXJ1bm5lcgpPdXRwdXQ6Ck5vIHRlc3RlciBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAtIFBFTkRJTkcKRGVzYzogSW5jcmVtZW50
YWwgYnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzCk91dHB1dDoKCgoKLS0tClJl
Z2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============3878543631472766231==--
