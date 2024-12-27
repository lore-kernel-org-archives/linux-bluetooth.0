Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609773597A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735293272; cv=none; b=fgA08neKkMMQLx1osMlWNp5FVofZAt2hhb+vBOFsSdILIzmprTqw+RINMkWAwl8i+S+MESdoqI9WOeCDzVSyoWeoza++QZtE4Pm5MGlhBwBMX4pyQZJyIEYUCPrOXt+ayIdvrXju3sw+sP8Xl6jNY1D4k3YMUHgS3UpzXBLMk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735293272; c=relaxed/simple;
	bh=WDlcAePPvrpHcGg3pg793Bny+hapaYLWZHxuYnor27I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I3eGrPis+kuXgl7UwU2SW5fUImJK4eiaBUkqhlZmcGJfNH986wDyYM6TAymiIVa2mt06BeFui2QwYxwKKRmVZO011q5+zF125ebhv2mrxpVvWl2SnGbzkyG73L+52dkFlAvhTUd3L4B7hRdnMrVsi1h7L6wD60jZEDzlmGsc/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl9n0IqY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl9n0IqY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b662090so76070025ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2024 01:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735293270; x=1735898070; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WDlcAePPvrpHcGg3pg793Bny+hapaYLWZHxuYnor27I=;
        b=Fl9n0IqY81ml/oUxgr9PfuVDw0LqcqGbI206iU4FOwxZhfZS2s0JxYjDGsX/kpYXfG
         44EDEfhnAUSBxfLN8LDkHg+m+UREEFSpsJ2syTvV39lY6+o20yybqsZRa39c+UEs/VTk
         ehnfygKkNSMJr17gz0IuMz3mSEy9bQ1rv2ldX3KwqVkbf5bvsmmnp6m9eAc/zjPK2IiO
         qLmVg+elUXMJt7Xizz9QBDJ9YDLmi56NXGljWWZ8aBKXqN/1DKXlwGlKWUTtylvGpj0I
         NwtUwYla+2JBUnwWVTnEvyupBOCHiqOtL4g42898e4IE9mNyC5jjSyybrdMfBicVc1qP
         qwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735293270; x=1735898070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDlcAePPvrpHcGg3pg793Bny+hapaYLWZHxuYnor27I=;
        b=Qr6z+tS/yKhhaa9sjzFBitRebFUp+us1uC6rLCU4POOjt/Eei2ZJO2VIAvsicSm4/A
         h5zw3qxJBYR2W68siDCT7xuErY5Nvt3n2i3EVm3x85jxJbb0pgpnqipHrJT6/mMcKZHI
         8leDSkPTB1Y9Pqf4BsLAGW95ka6+aFEnBF0KLB3JEAwrhkK6JDAcd2kilpOzaM/FPZyz
         2xDvjP+TD+LPDTZqC82x5At+Mq4byavWJYc5mSq5wXqTSIlie9PvMg0IR08A6mwbZ1gR
         dllLVIjgbbR0T9D+y3AjP50WzAjT7CHcMrGwMabb/UtVRQqfxyeqggZdIY7J9dO23iOK
         7Fog==
X-Gm-Message-State: AOJu0YwlQssJpXGi5A1BAcYlFr1ITEJvCeHp6mrAoqlWAKMg0P0A09o6
	NuGjXsYOlANDqAkVQ8uq2n13KRIntZVJSu3fSaL8D+DzvhHwgvFaqDLykA==
X-Gm-Gg: ASbGncvQswtkyILBL5XX5iyizzA3GGBmyuce+7mNzV52xfcVkee4eHE9HwhEjWt3sU8
	gmI+14B6aaY7UCWxbv4hRPEVy7/2nmgdg19/WjvE3QlJGz7us6CNFey8+ibBspM5118jMvL6iyn
	Nhk+fpRrCrBMDKzobccrydliVCXLl7it5mt7T9b4adcTVjuv1XbFvxddIcf1gu/DEhnAK+770bg
	u9KdhyBv8Ntn30ZvcjsYGfgaIp5aH57gywevEcleAcO6KZV8K+vuD/A2X5HXQ==
X-Google-Smtp-Source: AGHT+IEgsRC4SFvzucpH60E1V4u1ygq6HzSt7r/WmUJIG5mezSsjChW5HdHWPLLkjPxIkhQhJEfWNw==
X-Received: by 2002:a17:902:f681:b0:216:7ee9:2227 with SMTP id d9443c01a7336-219e6f11630mr381484635ad.36.1735293270245;
        Fri, 27 Dec 2024 01:54:30 -0800 (PST)
Received: from [172.17.0.2] ([13.91.69.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9705d7sm131770835ad.102.2024.12.27.01.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 01:54:29 -0800 (PST)
Message-ID: <676e7955.170a0220.926d9.73c4@mx.google.com>
Date: Fri, 27 Dec 2024 01:54:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1912696968379736668=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hanchunchao@inspur.com
Subject: RE: Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()
In-Reply-To: <20241227092046.23304-1-hanchunchao@inspur.com>
References: <20241227092046.23304-1-hanchunchao@inspur.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1912696968379736668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTIxMDgwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zNiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjI2IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMDcgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjUuMzYgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMjcu
NDYgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzAuOTcg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjQuNzIgc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDQwLjk2IHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDIwLjU3IHNlY29uZHMK
VGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDMyLjUzIHNlY29uZHMKVGVz
dFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDQuODkgc2Vjb25kcwpUZXN0UnVu
bmVyX21nbXQtdGVzdGVyICAgICAgICBGQUlMICAgICAgMTIxLjE5IHNlY29uZHMKVGVzdFJ1bm5l
cl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDcuNzIgc2Vjb25kcwpUZXN0UnVubmVyX3Nj
by10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOS40NiBzZWNvbmRzClRlc3RSdW5uZXJfaW9jdGwt
dGVzdGVyICAgICAgIFBBU1MgICAgICA4LjYwIHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNoLXRlc3Rl
ciAgICAgICAgUEFTUyAgICAgIDYuMTMgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIgICAg
ICAgICBQQVNTICAgICAgNy4xMyBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVyICAg
IFBBU1MgICAgICA1LjExIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVO
RElORyAgIDAuOTUgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBFTkRJTkcKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2Ny
aXB0Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50
IC0gUEVORElORwpEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6CgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpEZXNjOiBSdW4gbGlu
dXgga2VybmVsIHdpdGggYWxsIHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6CmRyaXZlcnMvYmx1ZXRv
b3RoL2J0YmNtLmM6IEluIGZ1bmN0aW9uIOKAmGJ0YmNtX2dldF9ib2FyZF9uYW1l4oCZOmRyaXZl
cnMvYmx1ZXRvb3RoL2J0YmNtLmM6NTU3OjEwOiB3YXJuaW5nOiByZXR1cm5pbmcg4oCYaW504oCZ
IGZyb20gYSBmdW5jdGlvbiB3aXRoIHJldHVybiB0eXBlIOKAmGNvbnN0IGNoYXIgKuKAmSBtYWtl
cyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBbLVdpbnQtY29udmVyc2lvbl0g
IDU1NyB8ICAgcmV0dXJuIC1FTk9NRU07ICAgICAgfCAgICAgICAgICBeCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1NwYXJzZSAtIFdBUk5JTkcKRGVzYzogUnVuIHNw
YXJzZSB0b29sIHdpdGggbGludXgga2VybmVsCk91dHB1dDoKZHJpdmVycy9ibHVldG9vdGgvYnRi
Y20uYzogSW4gZnVuY3Rpb24g4oCYYnRiY21fZ2V0X2JvYXJkX25hbWXigJk6ZHJpdmVycy9ibHVl
dG9vdGgvYnRiY20uYzo1NTc6MTA6IHdhcm5pbmc6IHJldHVybmluZyDigJhpbnTigJkgZnJvbSBh
IGZ1bmN0aW9uIHdpdGggcmV0dXJuIHR5cGUg4oCYY29uc3QgY2hhciAq4oCZIG1ha2VzIHBvaW50
ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFstV2ludC1jb252ZXJzaW9uXWRyaXZlcnMv
Ymx1ZXRvb3RoL2J0YmNtLmM6NTU3OjI0OiB3YXJuaW5nOiBpbmNvcnJlY3QgdHlwZSBpbiByZXR1
cm4gZXhwcmVzc2lvbiAoZGlmZmVyZW50IGJhc2UgdHlwZXMpZHJpdmVycy9ibHVldG9vdGgvYnRi
Y20uYzo1NTc6MjQ6ICAgIGV4cGVjdGVkIGNoYXIgY29uc3QgKmRyaXZlcnMvYmx1ZXRvb3RoL2J0
YmNtLmM6NTU3OjI0OiAgICBnb3QgaW50CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBUZXN0UnVubmVyX21nbXQtdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gbWdtdC10ZXN0ZXIg
d2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6ClRvdGFsOiA0OTAsIFBhc3NlZDogNDg1ICg5OS4wJSks
IEZhaWxlZDogMSwgTm90IFJ1bjogNAoKRmFpbGVkIFRlc3QgQ2FzZXMKTEwgUHJpdmFjeSAtIFN0
YXJ0IERpc2NvdmVyeSAyIChEaXNhYmxlIFJMKSAgICAgICAgICBGYWlsZWQgICAgICAgMC4xNzkg
c2Vjb25kcwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxC
dWlsZCAtIFBFTkRJTkcKRGVzYzogSW5jcmVtZW50YWwgYnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBp
biB0aGUgc2VyaWVzCk91dHB1dDoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============1912696968379736668==--
