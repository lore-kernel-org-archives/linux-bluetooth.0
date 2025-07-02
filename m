Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB18261584
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456878; cv=none; b=I/td/0G/sjBfn2OQvuS8427tdbFl7asWDqa77t6N4RnMVOfBhVKJZroQu59gAF+/n58T6T+mkysioD2N+urhNnQmOgRi6vAhGYOh9qbn61K93qQSBamfJ/4j7gN86UB39eoCZ0WgDZbec55dmVx6U2CqyXMzjrOeVlP+owBCprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456878; c=relaxed/simple;
	bh=Od2VKxsbcOIO3AQGbI5UmRiivn2imScEUn0PYcDfEek=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MA3Q62YtnBpJTslSPsl0S3F5JMPsJCIUm2jrLID0cqaASiWfa2ngxaVpzfA2rmWoj/q0VMbKyj1EKnGtv+gUscSXm+Q920s5wuMuM1a/07+cPCPBQPqf8fMhsL7wiuCKtMntzbxQY79Eb65eaHpInZ9lD3pZxBmoxvzPXnRyIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFVL+Por; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFVL+Por"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d219896edeso714711385a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751456875; x=1752061675; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Od2VKxsbcOIO3AQGbI5UmRiivn2imScEUn0PYcDfEek=;
        b=ZFVL+PorkXG50Y4DBZrODlHIb5oZ7g6tPkIO5I6I+YL3ovsiSE9BuT1eGd9Tn/vp6I
         hAKgWnkMZ88w9+OsCM/GxJnKwipFwzfyfAaVII38oXahYJ9wXAUd8abvhim1vItxk2wq
         cPqF7o1Eb2OKjFJHbfarjYkjYoNYoMl3tfT9ciNXCAByVR9eJTCJqzhILFnk09Kcq+jD
         KFSBzAfdYY07/rScDP+EE19oIsXcY8iIWbLATy5sKm0U/m6dmBdxzOjMJggOCN2gG4Zk
         VKjti1aqH7FzKqlU+16oLfi1luun6hyryx5UqHwFXIS/cLN00BmlekzqUIQC3jPHQCEy
         GXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751456875; x=1752061675;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od2VKxsbcOIO3AQGbI5UmRiivn2imScEUn0PYcDfEek=;
        b=D8Lgn4fuvG0eAvOS12a4MJ58TDSU2IfNARu5EkdZJHI9w46jFF0PAbqaKVqXNqThEZ
         d1hcdXhGcE//yJbBCMTitbDoFcc/2adv1EMe/6am5TX7hgr3jGTT9nJd2mGwcajTV1GC
         V931BdOLLen0NLsdLIidCUdn1afUeTjg/KbEnfaPoCmB6i/55SdSuvja+1RmmpQTY3UT
         4fRsUmuJOo6i2S1jMr0guVfD7XT1SLAzQ5IGBYCxYLloYmn1Ld3rcONMct59SNIYays0
         udh689fo7/c3CNTpTL2+nePTSUqoojPvoG5WAsagyAwQCMSI9fZoojG/gMzXpjMDdDYC
         5WvQ==
X-Gm-Message-State: AOJu0YwX5UAw7npXXc10pHefi03/CTLqmnm87c+A9Zgc5EhV83i+TpRY
	FnTR++aMlIRBe8huX/OUKoqEhvsVg1l4tAqbc7NUh+Ys3bCeJk0pvEl2S6hBLQ==
X-Gm-Gg: ASbGnctdPZAc36GOkegejk4Y/s4k0flVKvcmM2HtLTQp3VqlRZZe2LU/EnHrhfk3wb5
	K/jkEF54y617Xqbxlr8mWcAnZJgUV4SH1rU0wMzThvM8p4JXZIRKJ2AnmjLlIVLxZHZm6U4IISx
	0mlMD7/i5Zr1b9oaQGvDJ+0jnbidiyjUhYv89xPNRY+jCNqe/JjZKUAjpBGUfhCibYTncIUH78J
	7GRLhcy0QsFEJVe5i8+p3N7Dm4zRaqiX4KnJIYkTR0wYI8vPGxZ6V/z4Hk4nbKN055pE/zkcntW
	xHfEGTNlAg5jaxNmyj78Poa28077ry2YjoMnNgxUGSVChORDshokaSWcnY0Ek3Wri/eN
X-Google-Smtp-Source: AGHT+IFpW2F2DhOOBdpwBV9ZDN7UA5ub1rYcGxVPLnPw8tXiw1wAI2Ed6mCw6EsibErshcWD+955LA==
X-Received: by 2002:a05:6214:ccd:b0:6e8:9dfa:d932 with SMTP id 6a1803df08f44-702b1a11cdfmr33360426d6.15.1751456874979;
        Wed, 02 Jul 2025 04:47:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.115.232])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771b883csm98383896d6.39.2025.07.02.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:47:54 -0700 (PDT)
Message-ID: <68651c6a.0c0a0220.6fde4.0796@mx.google.com>
Date: Wed, 02 Jul 2025 04:47:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6372598082073598079=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [v2] Bluetooth: ISO: Support SOCK_RCVTSTAMP via CMSG for ISO sockets
In-Reply-To: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
References: <20250702-iso_ts-v2-1-723d199c8068@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6372598082073598079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTc4MTkwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zMiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjI0IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjQuNDYgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMjcu
MDQgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzAuMzUg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjQuNTMgc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBGQUlMICAgICAgMTAwLjMzIHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgRkFJTCAgICAgIDAuMTIgc2Vjb25kcwpU
ZXN0UnVubmVyX2lzby10ZXN0ZXIgICAgICAgICBGQUlMICAgICAgMC4xMiBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIEZBSUwgICAgICAwLjEyIHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgRkFJTCAgICAgIDAuMTIgc2Vjb25kcwpUZXN0UnVubmVyX3Jm
Y29tbS10ZXN0ZXIgICAgICBGQUlMICAgICAgMC4xMiBzZWNvbmRzClRlc3RSdW5uZXJfc2NvLXRl
c3RlciAgICAgICAgIEZBSUwgICAgICAwLjE0IHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10ZXN0
ZXIgICAgICAgRkFJTCAgICAgIDAuMTIgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVyICAg
ICAgICBGQUlMICAgICAgMC4xMiBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAgICAg
IEZBSUwgICAgICAwLjEyIHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAgRkFJ
TCAgICAgIDAuMTIgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5H
ICAgMC44OCBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
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

--===============6372598082073598079==--
