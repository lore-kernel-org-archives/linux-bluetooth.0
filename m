Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A75DDC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743178338; cv=none; b=A/f1sNIZ30Tp5twpWhW6Z7enfmR/RuNpCgVHkfDtyAdKeAQqOVoHEulw0j6By25ytboxwyEve8n0MSStPqqH4ZL/8uYqIGYqhpguMU63w9rzO1F9shFgsP9ArU2j0wkutrz1gcfJpGS/hWkpvXARJIYiBxX4uaEawSnE0EL0jqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743178338; c=relaxed/simple;
	bh=ZuIGtKHjR1B6oizIA7NzB7bZGFP84f9xArI9KO/kegI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bbMTDmHvFFwUk3UvGtjAty7Ma6d/RFPspOLGUdNGyQCFXJNyd66bhTptsi/ig/P3zhRbGY92U3CWLRj3NmKi5lMT2PILKKZq74ZPs5oxUojpikyGfhpDMPiUkI1om9pnuEC5r3c7wVXzcUB3wZy6kookL/TNUvM1+S6bPpCjANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdG0kJyn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdG0kJyn"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47698757053so28106401cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Mar 2025 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743178333; x=1743783133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuIGtKHjR1B6oizIA7NzB7bZGFP84f9xArI9KO/kegI=;
        b=VdG0kJynCWNU/F/DUBGpj7FHqUopKkyaP9s3N3pemYgfRJ07l8fvtRwQ7sBe7BRa4H
         eH30zbGAsxF7x6C1r8yTClc08ebhzEgm0MnE3UWbNHmliQR7Ag1xQOKNJAGB/UkyqKrW
         4SRG/HDSn1OL3VTtX/ta36mZMna3wL2KFZXUR9EHX1CfUr1jMC6fENjiwtFDSR4lOnBH
         99VYOhD7xRwLsw/0w/4yoNjA9e+b/4tFUQfmfOljLmxFjxh2ssLr+9VsAliM/PRfYZ2i
         O3HInMRXENhPIzL95jXhX18Noje5k9ZjlLFFHC1U59c73tqwYZYUmzpbqz6ywO8lM4TN
         WB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743178333; x=1743783133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZuIGtKHjR1B6oizIA7NzB7bZGFP84f9xArI9KO/kegI=;
        b=xJfHZk127qhHxufnBI1nj0E0xZ3CUXh/icDn20oaO5hm308j6YPmpk8KQJPQTJQBvo
         wcuS3nPozDEXNDWqJ/gu2fc1b+tIvvDt+h7rfaRKCllOKcPaOPN5qmnlO/GiskGUsZTw
         k/A40T980Fm9KQm2GEfOrDgIFrZp0d/uJXkySEHWBQHiZgWD79/voZBCcDyyowQ7uk0G
         rozF9mZjoBh6GfS8gYlkNvIuBOSZBpix3KGa4UxlTMTadmBj0v3yCecEmuLJuuRjy8K2
         aykWmr5V5itqBYf4cktW1H4csjSrBtunjA+MoY1xhmDYhu+XhnqFFMvCpzBYYKXqjxtT
         8ggw==
X-Gm-Message-State: AOJu0YwiHTNz5fo9QVHvMRDr7WFpd3j3Yiosf4EuzJLHLZ9+ioZT3blF
	WgUj/vb36+eK2vTWbaUkpEcyINMtNyZ6h2qJ6ckHjZxsqsJz6XUgLxVkPA==
X-Gm-Gg: ASbGnctSOK7BoUKYa3ZLreMsX16e6u+480ArohJHHK66eANnRZoOkLs18JPt6kxHX36
	8Wy+jgm2AffN8Kvy+FLbnvrbME4Pfnt8ceFBnNxfS537MHJbDkPqD/gofNkKB1l4k1XT99/iYf+
	uej4sn/InWrVzL1Mz0s/3FvT/ITw/H/zNTlOngUtGf/kgm8woRAjjkNBT/JUuMzy3Bduic7minG
	1bxKAI4VCSW7LIkXvLDhK0qqhFF2jd9WYlyhwIU5aaL7FR+ljzUdSQOv2/a1GRCb9nihMIc1GgI
	CSUws/wlHr1S0c4b+oy1wSIbDqC8bgB6Jz1rP1HoFOZMu99rf5cdXQ==
X-Google-Smtp-Source: AGHT+IELqLwfNXIu5sHc30W9BCiUUPhT+iLCRIwre3GL4CUYHbOU4OCocHsq7Bjca8J2kLuTtRHuCw==
X-Received: by 2002:a05:622a:34f:b0:477:6c0e:d5b3 with SMTP id d75a77b69052e-4776e07ae37mr103588261cf.6.1743178332561;
        Fri, 28 Mar 2025 09:12:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.183.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-477831a3808sm12371811cf.77.2025.03.28.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 09:12:12 -0700 (PDT)
Message-ID: <67e6ca5c.050a0220.23edb6.6451@mx.google.com>
Date: Fri, 28 Mar 2025 09:12:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0277552952582479358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] a2dp: Fix removing local cache on restart
In-Reply-To: <20250328144406.3122778-1-luiz.dentz@gmail.com>
References: <20250328144406.3122778-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0277552952582479358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTQ4MDk3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4xOSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjIyIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIwLjc1IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE1MjcuMDEgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuMTYgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTQy
LjMwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDIxNS42
MSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyODUuOTkg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTAxLjA5IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVORElORyAgIDAuMzMgc2Vjb25k
cwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgODgzLjgzIHNlY29uZHMK
CkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2gg
LSBQRU5ESU5HCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdApPdXRwdXQ6CgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBFTkRJTkcKRGVzYzogUnVu
IGdpdGxpbnQKT3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2VDaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKLi90ZXN0
LWRyaXZlcjogbGluZSAxMDc6IDMyMjk5IEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1
bXBlZCkgIiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE3ODA6
IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE4ODg6IGNo
ZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzMTc6IGNoZWNrLWFt
XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMTk6IGNoZWNrXSBFcnJvciAyCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNj
OiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFja2FnZSBjdXBzIHdhcyBub3Qg
Zm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBlcmhhcHMgeW91IHNob3VsZCBh
ZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0byB0aGUgUEtHX0NPTkZJR19Q
QVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1cHMnIGZvdW5kCi4uLy4uL3Rl
c3QtZHJpdmVyOiBsaW5lIDEwNzogNTUxMDYgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUg
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
OiBsaW5lIDEwNzogNzUxNDggQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAi
JEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc4MDogdGVzdC1z
dWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg4ODogY2hlY2stVEVT
VFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMxNzogY2hlY2stYW1dIEVycm9y
IDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMxOTogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEluY3JlbWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6
IEluY3JlbWVudGFsIGJ1aWxkIHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6
CgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============0277552952582479358==--
