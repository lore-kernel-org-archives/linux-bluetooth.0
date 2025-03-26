Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92A17A318
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021116; cv=none; b=jjR4gKe+nY57R+Sw+Fb4rIEyyLxsrhjJ56LTYIPf1nMYJMxljc5BS3VpCTkt35hcWoaHij8J3Kpi9JFH1HPTzUZ7dBec+sulZGUjTPa7X2p627uZ3OkYBC5i7yoy+YhERq8TX+vvnCzb2jYbFpr4N3PLApwrzbpZX+5/cdi2dmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021116; c=relaxed/simple;
	bh=IGmi5FDjkLQSIjuexi57fgL6EWXNqJQjqpvWL4sz8AU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D0xEhYB+JaoR8eE8AyyenILxMhp9EnRasoWIROYk8Q9pCr8pM8t0f14Mqgb5pPWODa8JXy+RJ/Py3v6DTYPVOoCrjHSMvtI9NOu6UInv0FmTjB52jWSaJ/3ad4CEZvd939KjUkdNtAT3e1vY0CgA44/lbDUNbU+Y1IHFB42F0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCFUbTig; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCFUbTig"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso262319a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743021114; x=1743625914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IGmi5FDjkLQSIjuexi57fgL6EWXNqJQjqpvWL4sz8AU=;
        b=SCFUbTigZTeV4eUARvZ4GLUr0eJx7kW3jcbugG/bl2gZHiY0XMFAO/XXw3tiC4r70k
         tkh/NM8Gz0E1OM+dHHiHXlAAZVAtM6wGgZDKGYFLE222anKWcjdhWIUw8R4+O0xP1Pff
         w08tVSfLmPquYAvbodSqcsEdSv3EJkzp1IRrLs6FQ6iJzCYqf7uJUXthqhfhopKCFTca
         bfiQxppPyUPyF5DZlbyplcTUQ87GoNqZ3P6KFd1k/ASGBlB2ZCB+16TQUbkgpe+W94rz
         ToetYVBxl6BjtynWZGuAcxDsPzPBf3gbKOe5Q/QTXHIyacRykVfol0Y9tl2LjiaVITV/
         gM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021114; x=1743625914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGmi5FDjkLQSIjuexi57fgL6EWXNqJQjqpvWL4sz8AU=;
        b=r/vtS4anRLdCc2klUMao9nciKCpy8TG81dHIaUkqcbvsLwF2i9T8LIh6D90d7rvR4S
         py9wjWFvWVYvvcuU8AaHdQvUeP9aZFA0RQbobjeRsdPzYgwybkm2KQblJA/d5YFImA3i
         B6wrNBo+ZZYu0Z3cVr2yNBFq88Ss8+1oS4zn5iNpWZTb4DvwoKsCxARrNO2Qhzc0fgjQ
         N7biHkCOVVp9oUcb22JVwpx/+s6jWKtJd7bfQuNHtk/miF7XnhJruwKfbguWQxGdYYV+
         pie3bR49KsBjmp122dUzpwcb8IRkAaQrGWORVTcwkQ/qw3e6zgy7+lroFOuIXt9t3xbF
         YFxA==
X-Gm-Message-State: AOJu0YxiaHrtl1O//pL+LOCjCRfQhg632W/PO0brZSxfGHlkQz7A73l4
	CJ0cPkNco3CSAtKiMK1UT/vG9ddakKkD5hFe7puRelseVpFVZKH8pQXy5w==
X-Gm-Gg: ASbGncuVB7sFrBE7c0O8M+SqTN+sX/REZlgGAwulR8Ntpa4IV15K4GZo0XhdTtSFbKK
	rI9M6CNenxDZSj4LP/M2Ewm5gEBgCJSng1naGBrcZUKd9tN0sU1ufLQwrNdRwuM/UrPplOAfoA3
	Ts2QtfFjmLpORsPJl1srnyp3zYh/PJGBGJcx/9slh8oTxozjC2VQUWruuPdwx4ieLUVUp7gEzva
	7etqEWKKCZ5lJxmPN4MIaZR7/9PxHj6wWg6kYOZ2cOgCw4FuSesteMN8MaVhcxWs0xre84TeY5w
	RHFVXIdVkZmxM82qYL5/jiWhM470WSAAeI2HAyKGBsUjoGsroty1XrQrWw==
X-Google-Smtp-Source: AGHT+IEv3J617Qa/CFh2Q+XYgbvBXuAUAEANwvfOguUiUaMK0rhaEtbncwk60NyOFZgVbW7aFwheEg==
X-Received: by 2002:a17:90a:f947:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-303a8d81f65mr1604931a91.24.1743021113917;
        Wed, 26 Mar 2025 13:31:53 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.7.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dcf48fcsm708052a91.0.2025.03.26.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:31:53 -0700 (PDT)
Message-ID: <67e46439.170a0220.1305fb.177d@mx.google.com>
Date: Wed, 26 Mar 2025 13:31:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7913133184725834113=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] device: Attempt to elevate security on Pair while connected
In-Reply-To: <20250326193133.2718934-1-luiz.dentz@gmail.com>
References: <20250326193133.2718934-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7913133184725834113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTQ3NTYyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4yNCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjI2IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIwLjY3IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE1NDcuNDggc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuMzEgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTQ0
LjEwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDIxNS4w
NyBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyODguMzMg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTAwLjM4IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVORElORyAgIDAuMzEgc2Vjb25k
cwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgODc5LjI5IHNlY29uZHMK
CkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2gg
LSBQRU5ESU5HCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdApPdXRwdXQ6CgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBFTkRJTkcKRGVzYzogUnVu
IGdpdGxpbnQKT3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2VDaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKLi90ZXN0
LWRyaXZlcjogbGluZSAxMDc6IDMyMjgyIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1
bXBlZCkgIiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE3ODA6
IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE4ODg6IGNo
ZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzMTc6IGNoZWNrLWFt
XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMTk6IGNoZWNrXSBFcnJvciAyCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNj
OiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFja2FnZSBjdXBzIHdhcyBub3Qg
Zm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBlcmhhcHMgeW91IHNob3VsZCBh
ZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0byB0aGUgUEtHX0NPTkZJR19Q
QVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1cHMnIGZvdW5kCi4uLy4uL3Rl
c3QtZHJpdmVyOiBsaW5lIDEwNzogNTUwODUgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUg
ZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVs0XTogKioqIFtNYWtlZmlsZToxMTc4
MDogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTg4ODog
Y2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMjMxNzogY2hlY2st
YW1dIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMxOTogY2hlY2tdIEVycm9yIDIK
bWFrZTogKioqIFtNYWtlZmlsZToxMjI0MDogZGlzdGNoZWNrXSBFcnJvciAxCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4g
Qmx1ZXogTWFrZSBDaGVjayB3aXRoIFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVy
LmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTI5MDc6NTog
bm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFy
LXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CjEyOTA3IHwgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgouL3Rlc3QtZHJpdmVy
OiBsaW5lIDEwNzogNzUxMjMgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAi
JEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc4MDogdGVzdC1z
dWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg4ODogY2hlY2stVEVT
VFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMxNzogY2hlY2stYW1dIEVycm9y
IDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMxOTogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEluY3JlbWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6
IEluY3JlbWVudGFsIGJ1aWxkIHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6
CgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============7913133184725834113==--
