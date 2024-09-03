Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9E14293
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Sep 2024 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385641; cv=none; b=NdcaWahiefObqKYZao2r+b5HOgLzpt5oP7cqJCLVoDgvqzMm21qMAuDtN12b7LfToamIB0sl1wMKoXkKxTucwF6tMBHE1aIWXljq50oot2MXKD2FDoq1j15nZ9ezK4FI0+IJN+q7MNK+JBPR3i2SyFL+wC0ortSucd3mhCXSthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385641; c=relaxed/simple;
	bh=pjOH+ig6c5cgMl93cMpMEuYlPJtugxrysKDd/OSeC5A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RNP+I4+DqDo26kYTOREgpCA8gVD1ohTiyGC55AIDYPIRkE8NSnRgt3l96TbmDYyWbUGZZwnCU/ka06+k+Rfd/GbfRHeacnqdC6CNIIn+zXPh5EwvIjUJl4ZB/NpazzHahIyVf9eH8Sfo6byFaroBRY5TuYn50Js+2zIvL6EoZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUYbpOOl; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUYbpOOl"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a812b64d1cso295465985a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Sep 2024 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725385639; x=1725990439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pjOH+ig6c5cgMl93cMpMEuYlPJtugxrysKDd/OSeC5A=;
        b=kUYbpOOl+84lJoo1XppatSyxVy08ORGz8yMDKdLuhScsskyPqADSwAoDTqc9ATDTmc
         7HpMhLNOX12pqp4iyk32qN4bp4SvrWf6wCngVHV/pjD+Fbpg98wcanXcMgtI6N+JIP5o
         3wtuCD2L4z62Zfd1BwtBLsKDw0ZgCoqKqpKlt5nwEXalMyCeCOO8taLokA0mwoRHRaIo
         2svOecPDo7oYer8n/VI/Uv85a/PRHSU+3AtzTZnYmxL/jwIPW5tVpUf2Xb8irbPsh2Ho
         0A4QViqamcDc7z9IVbYtUlACtTm/tpXr+loy03PgVGYvS8rqHcQvRt/TxfnQkAN7X/sI
         W1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385639; x=1725990439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjOH+ig6c5cgMl93cMpMEuYlPJtugxrysKDd/OSeC5A=;
        b=Sr/E17rhb3CgtoKqEpsGOgFtCYpLQZ/OovKqlvv0sbIhhyEIlnNcVSEBLUyqdWQ+9g
         J1pmJmc9ILaqI4Jx9cNmnm56p9FSDRfWYyGzibohQwIKRe/DBkh7ZiQK07VZWVzoBkLl
         J/MaTrM+ZyMWH5PKpmuenRiJZnhL3qRavI+Kf+8KbMD5PnTFkbJUGg32WIOqplcbo6Z1
         1Zoq/FjrYlAPhMiTWj/rNNxHz+uXMcjySN8BR1Ge8V6KugWWyWIf7tbD9g1fjQwe0r0M
         LLzgn3sN+4m3oExas4ddXrrZlFYtogdM7TBxL4oonW8A+hOf+NryK/xU9qpWyqxCQsAO
         O1Zg==
X-Gm-Message-State: AOJu0YyBi9jgwhSMWPN1mJsV5mPa8EG3Z0a6zuSZ5+0RZ4oq7peYPsoQ
	n5ZL1r0rUSFYGZO/9FK+0SHmfFJ38Q3ieuSXWZt+bvMlCc00bjwn/OYVXQ==
X-Google-Smtp-Source: AGHT+IHeGhH6NktWXHzJmUV/mqUDQpSUTFJKfPoBLOdlKdsj+wKlVWeT4UY33MqPfDZO4zIXSE+gYA==
X-Received: by 2002:a05:620a:254b:b0:79f:17af:e360 with SMTP id af79cd13be357-7a8041d1819mr2439034285a.33.1725385638710;
        Tue, 03 Sep 2024 10:47:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.47.55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3c674sm544705685a.78.2024.09.03.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:47:18 -0700 (PDT)
Message-ID: <66d74ba6.050a0220.23dc6f.4c5c@mx.google.com>
Date: Tue, 03 Sep 2024 10:47:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7312707414118456038=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] gobex: Replace g_convert by utf16_to_utf8
In-Reply-To: <20240903161115.143632-1-frederic.danis@collabora.com>
References: <20240903161115.143632-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7312707414118456038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODg2MzgzCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC41MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMyIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0LjU1IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3MTMuMDcgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuODEgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTgw
LjU3IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1Mi4y
OSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTguMjQg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIwLjA1IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE1MDQuMTkgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTAwNS4zMCBzZWNv
bmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hl
Y2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoq
KiBbTWFrZWZpbGU6MTE3NjY6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBb
TWFrZWZpbGU6MTE4NzQ6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MTIzMDM6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDU6IGNo
ZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1Zh
bGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjayB3aXRoIFZhbGdyaW5kCk91
dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xz
L21nbXQtdGVzdGVyLmM6MTI3MjU6NTogbm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1p
dCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWlu
ZyB3aXRob3V0CjEyNzI1IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAg
fCAgICAgXn5+fgptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNzY2OiB0ZXN0LXN1aXRlLmxvZ10g
RXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjExODc0OiBjaGVjay1URVNUU10gRXJyb3Ig
MgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyMzAzOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAq
KiogW01ha2VmaWxlOjEyMzA1OiBjaGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogU2NhbkJ1aWxkIC0gV0FSTklORwpEZXNjOiBSdW4gU2NhbiBCdWlsZApP
dXRwdXQ6CmdvYmV4L2dvYmV4LWhlYWRlci5jOjg0Ojg6IHdhcm5pbmc6IFBvdGVudGlhbCBsZWFr
IG9mIG1lbW9yeSBwb2ludGVkIHRvIGJ5ICdidWYnCiAgICAgICAgKnV0ZjggPSBnX3V0ZjE2X3Rv
X3V0ZjgoYnVmLCAtMSwgTlVMTCwgJnV0ZjhfbGVuLCBlcnIpOwogICAgICAgIH5+fn5+fl5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpnb2JleC9nb2JleC1o
ZWFkZXIuYzo5MzoyOiB3YXJuaW5nOiBOdWxsIHBvaW50ZXIgcGFzc2VkIHRvIDJuZCBwYXJhbWV0
ZXIgZXhwZWN0aW5nICdub25udWxsJwogICAgICAgIG1lbWNweSh0bywgZnJvbSwgY291bnQpOwog
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CjIgd2FybmluZ3MgZ2VuZXJhdGVkLgoKCgot
LS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============7312707414118456038==--
