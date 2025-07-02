Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EE19DF5F
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 04:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429571; cv=none; b=GhLA+ziZa0t0di+aONoEwsGjThWZLF6CHKeZ7pzFbTkL+gOVxGmaV4APYU/Wue7WQIp5YCyloLERYShPPFz2J87o/Z50E6JQG7EqeDSQEm8FQwcNNagLrfm8IM91HOyOSWpFnmnm7ZwM9GFoIb9FEa6eA9hUfII9SZQ/fMAd7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429571; c=relaxed/simple;
	bh=CvAlwxNsGu5HcqDe8LCbbJntGRT+UrE6XdJfxWrZROg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OVR1q3t9mlrWG14KhpUhOwgzCuA/Yd0fUSko+thldbN794q9QjmnRtQ/o/C1ztKcCHUoB9CrxfFeFhIOVToIwchyZYOsmowO4Xxw2bdVmJjuI8AfrkW0nBfNO3m1mbGGx2/QDuFXzgdVjTK8wbJMUZhH8wQaVUi98+AGm8/FgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUq+D5a0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUq+D5a0"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a4312b4849so74909171cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 21:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751429568; x=1752034368; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CvAlwxNsGu5HcqDe8LCbbJntGRT+UrE6XdJfxWrZROg=;
        b=DUq+D5a0xHQdcG+ULGHwoXSe/XFrpSD5bxRKZEGM8Q6/XMASAJvyNlpTottqzWrSQA
         mN7cUICo6Yc0SsGqlrnrLeyV5ULY7Lc+XR3m+M/kAhDs9qxKDPaiXZjbEJ3ZDvk9xI2F
         QWPNgqxDL5VYL9Y9VdXbaqmKQPnC+TzqvfHCEkm9SNUu4kqQkPKX9dXo6J98hvlrkmv4
         T1q0gS2P2/ZWdY5fAY9rORar3MrZZDNwZtggVvBdSBvTtry212riv20/a5VzFKfZe7zD
         IzIHyu1tMhCZjoZ2Y37PKTvqADIAtbBCbdm6WvNPQdxbppSaKH3q9dfbWW62gVseOhIu
         42lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751429568; x=1752034368;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvAlwxNsGu5HcqDe8LCbbJntGRT+UrE6XdJfxWrZROg=;
        b=rSkWe6+yaSoPHDnO5P5SO6MojEbCp+KZzc3wj8lOEMqcv2DA9TIKyaelH7emwZ4uQI
         RwbQy8cILfyE5GlTVCm9P6OD735XAbI2nPM3K21lzh+j3yGwPpS8MjHk/ryioKnv6njT
         X5AakPS866ugRD8djXLC9sLe8DAI2Pv2G+KgC11shBOC0Wdha6Ushk3KHLjAadql5XzF
         heWKQsKVmjW0n+XpB/XTfrswIp0+WGllW/U5s7kiQlTiZ+elQ8k5a3rB/POQImjSmhP4
         YpkX0nEBqNiFcJU6m3Mo9hCUJaQPwruDeXKeedIgo2gW0zAT49NWUqlPCcxzKexe66Fy
         Gd0A==
X-Gm-Message-State: AOJu0Yyd64oEWSkHOTcu5F649obkTR95v60kFnQ82JTUFd0/HV2cMGeh
	xmilgJc11qzN4uLSV6yNnVHcJveeHZ5pKw82ydKGz+1IlBBa94qAZUzr5yW2QA==
X-Gm-Gg: ASbGnctJZOrMq68e6uUgQ3eM7HfzlYTYyxKPtjwiJ5k7mYiD63ZdlK47fHyrCNGaVdY
	2KqycJsZb2Z05PiUpYt/WwJ3XLl/0kXVeumspRm8soexJGfRw5XsBYIulk2YE9jmrZQ8IBC+2LM
	/LbT0kTuXeAzIauvQWrAYcIZ3FCsvZgq1cVZoDa2xpU+qAJLGpzk82u2OPU6jhVSee+sVxSqcwc
	c3TUgNWSzbmQXfzFY7ULnGEIb7Ut1BWRokPMfhHPKlfjpaGZeMlHr9p3VbsTUcLsQiApDy8OkYm
	fDNkzcOz52pwn3fmIesb6sGHWDE1YG2S+7SVDrLf4JAEO9uXzDxKbj4xlfjQpMvQ/dGi
X-Google-Smtp-Source: AGHT+IFMFkiJDVAmejoQ72hdzJ3uIz4bpv0o4hzUc5L3x68qpKr5ZeMdr8N04zh1KZz0DzH65OC+JA==
X-Received: by 2002:ac8:5743:0:b0:494:ad3f:cb7e with SMTP id d75a77b69052e-4a976a96ae7mr27713661cf.50.1751429568371;
        Tue, 01 Jul 2025 21:12:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.241.73.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc138d7esm87186341cf.21.2025.07.01.21.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 21:12:48 -0700 (PDT)
Message-ID: <6864b1c0.c80a0220.295916.d630@mx.google.com>
Date: Tue, 01 Jul 2025 21:12:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1773691607616566767=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: hci_event: Hold PA sync conn when BIG sync established
In-Reply-To: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
References: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1773691607616566767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTc3OTk0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zMyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjI5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTAgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjQuNDggc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMjcu
Mjkgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzAuOTYg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjUuMDIgc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBGQUlMICAgICAgMTAzLjMyIHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgRkFJTCAgICAgIDAuMTAgc2Vjb25kcwpU
ZXN0UnVubmVyX2lzby10ZXN0ZXIgICAgICAgICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIEZBSUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgRkFJTCAgICAgIDAuMTEgc2Vjb25kcwpUZXN0UnVubmVyX3Jm
Y29tbS10ZXN0ZXIgICAgICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RSdW5uZXJfc2NvLXRl
c3RlciAgICAgICAgIEZBSUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10ZXN0
ZXIgICAgICAgRkFJTCAgICAgIDAuMTAgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVyICAg
ICAgICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAgICAg
IEZBSUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAgRkFJ
TCAgICAgIDAuMTAgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5H
ICAgMC40NCBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja1BhdGNoIC0gUEVORElORwpEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQK
T3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBQ
RU5ESU5HCkRlc2M6IFJ1biBnaXRsaW50Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBDaGVja1NwYXJzZSAtIFdBUk5JTkcKRGVzYzogUnVuIHNwYXJzZSB0b29s
IHdpdGggbGludXgga2VybmVsCk91dHB1dDoKbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYzogbm90
ZTogaW4gaW5jbHVkZWQgZmlsZSAodGhyb3VnaCBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2Nv
cmUuaCk6CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyU2V0
dXAgLSBGQUlMCkRlc2M6IFNldHVwIGtlcm5lbCBhbmQgYmx1ZXogZm9yIHRlc3QtcnVubmVyCk91
dHB1dDoKQmx1ZXo6IApzcmMvZGV2aWNlLmM6IEluIGZ1bmN0aW9uIOKAmGNvbm5lY3RfcHJvZmls
ZXPigJk6CnNyYy9kZXZpY2UuYzoyNjg5OjY6IGVycm9yOiDigJhFUlJfQlJFRFJfQ09OTl9QUk9G
SUxFX1VOQVZBSUxBQkxF4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQogMjY4OSB8ICAgICAgRVJSX0JSRURSX0NPTk5fUFJPRklMRV9VTkFWQUlMQUJMRSk7CiAgICAg
IHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CnNyYy9kZXZpY2UuYzoy
Njg5OjY6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkg
b25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MTExNjI6IHNyYy9ibHVldG9vdGhkLWRldmljZS5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDY5MDog
YWxsXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVu
bmVyX2wyY2FwLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIGwyY2FwLXRlc3RlciB3aXRoIHRlc3Qt
cnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBUZXN0UnVubmVyX2lzby10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBpc28tdGVz
dGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfYm5lcC10ZXN0ZXIgLSBGQUlMCkRl
c2M6IFJ1biBibmVwLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZv
dW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX21nbXQt
dGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gbWdtdC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRw
dXQ6Ck5vIHRlc3RlciBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDog
VGVzdFJ1bm5lcl9yZmNvbW0tdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gcmZjb21tLXRlc3RlciB3
aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX3Njby10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1
biBzY28tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfaW9jdGwtdGVzdGVy
IC0gRkFJTApEZXNjOiBSdW4gaW9jdGwtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpO
byB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RS
dW5uZXJfbWVzaC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBtZXNoLXRlc3RlciB3aXRoIHRlc3Qt
cnVubmVyCk91dHB1dDoKTm8gdGVzdGVyIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBUZXN0UnVubmVyX3NtcC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBzbXAtdGVz
dGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVyIC0gRkFJ
TApEZXNjOiBSdW4gdXNlcmNoYW4tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpObyB0
ZXN0ZXIgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEluY3JlbWVu
dGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6IEluY3JlbWVudGFsIGJ1aWxkIHdpdGggdGhlIHBhdGNo
ZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK
Cg==

--===============1773691607616566767==--
