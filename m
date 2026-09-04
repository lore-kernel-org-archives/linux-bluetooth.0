Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78654388E6F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565672; cv=none; b=DpILMScwHcqfBR7j/faEb1pAlvZ5WQVHMYZX3vdGXO/xPLshjKpiCM9pYKZU1kgk1ifQiaGORUl8ef3qPoeRMBgRvv6XaMTLFzTLEDGXTFBXnOB0genaUSwVRbltOhnZDbXG8fn2B3Yyntu0CIws+Zh73XxsHMe+LBTDN/aKg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565672; c=relaxed/simple;
	bh=8BKFBCBE8jaUj6H0QDSJzWHnhvI/FjLWE/b6kRT+jGE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bdKHwHgf21oQUiqMJxqqhvSsHNbysyw5aHunWRBDEd4gzLIcwG/a8+p9GON7lG7uyMrd0tzIl2mfZmsweU7PAouzy5k43wY7e4E/tooNaRY62ZhKzfgrIU9BZ6OJYE3AWck7SSyzJ5Gp40nN9nVDUCvLcN3YHj90LMCWaz2WTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2LAlQ6V; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2LAlQ6V"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso1033279a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788565670; x=1789170470; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8BKFBCBE8jaUj6H0QDSJzWHnhvI/FjLWE/b6kRT+jGE=;
        b=U2LAlQ6VSQucXtfFdxt9kmnkTznbSdBTuuF41ZOTfe3LFZ9fcjVLLZos+jePNjCEnd
         SaF5i74oyWqcESavXU9CKm6TytlRvtiUP7cVqAAR1oiA5w5OwDvG3NXSY5LuNEzTJ1EX
         0fsxq1/7RBo2bZX+Cw0yoCArjxRJR5SBSvPsKnrMdVyDyO04DxNFoPQBmcKNCLkwArye
         Irmul8IYPPzCFhVGLweVYvKFV4M4wQgO6vRkS6T1vHGjR2okDJ8ZiJ+/rPsAKHZXAgIZ
         137INRgYN8CnDZ2kp0g06GSKJ7+8y3r88ftz5VzYw4PfsHfJ3o601qERkgbDawHNegfb
         +pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788565670; x=1789170470;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8BKFBCBE8jaUj6H0QDSJzWHnhvI/FjLWE/b6kRT+jGE=;
        b=Aokk+OjHUdLk1Nxf8C1GYGreGL4nvaZF1R5BPUoTxtEm+EtajVMDd097pydtvaPaUN
         t8h4RC5nxrDqj4jGHj74lotKQXjNFnlKsYDRImEyBqzmzMTejwBV9IpU8+qONVrSYLBX
         Ol/HUHOb4jormf0X3bvi//ncXyZhGwHYHnGBW22ucZ20/AzX3RgXH+TOhP9l158V9n5w
         TfCIpUUM7JZhvYKQHnFSr8n8LJp6Sf+K53n1RQ5kipV+O7tQkQvYcINGyKBtoFBoQLs0
         zGIt0g2B39FqT1Z1Eya6ZndPf+1gZZCfAuXwqC63MVz6hBKA11Nodlj+lIRVcOq1nAa3
         Iizw==
X-Gm-Message-State: AFuF++kiSg9Wr8ig0HcA3Z/cWuRopKPsimZG+aH/xXMD+NLgthz9QNc4
	aXpx5VgM9q1QRcY9rnL0mrdZ6CSfL1pVkFyKf98IGDmgvM+r8B5UiOLHfykpHw==
X-Gm-Gg: AYBFou33G+AcmmWWULrhp5xmqbUkHQN1+0T0lj/ziVNMwgsm9oOVYlUbnAul7lBMTux
	vyVxKDpbLxXvHDs6AKBOAMToBF/8Zh+UQdTXdxjbIzCJmARtH4wATE0iOaxhPtxhzeqdex676rA
	Aa/+6XU4l6bxVaXJthsGLr596aedQpmuAZb8/HGZUIVvjoQIBvI3zHNxKNGgh/D26WBbcZi7162
	adbc25toAO7/vclrUAITuuYCLDOBrGtkqC0mXBAbesYcOo7HQuA8gNUyBug/6cyMTJFZbgsBOsH
	lIj3W8e/SjbFzYt+JLt6l2x5Ry759SXR27tYT+SpiLqtnuQBnLjwMP0kshsZsH6MIY+i1IXl5QZ
	0syQ6vTY0AcEgcwTItFFNTo07NK+8WmmKHeS+jzvgGNCH5bWUs+vwGfA678+xPF027JRsgpgmgZ
	rf8oPgMLjtZO2jW+Wd89PGoiZWneKm0R4IJSWJtGJxywQZGibcKyjR0ckz8p9W54sozEdo
X-Received: by 2002:a05:6830:81f8:b0:7e6:d384:459e with SMTP id 46e09a7af769-7fa1e1b7625mr10772693a34.3.1788565670176;
        Fri, 04 Sep 2026 16:47:50 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.180.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f470a34fsm4690237a34.3.2026.09.04.16.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:47:49 -0700 (PDT)
Message-ID: <6a9b58a5.1059eef8.20e04.a017@mx.google.com>
Date: Fri, 04 Sep 2026 16:47:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2874976647475378640=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [BlueZ,v3,1/2] shared/gatt-client: verify a synthesized CCC before writing
In-Reply-To: <20260904213642.68792-1-proxy-alt@proxy-alt.dev>
References: <20260904213642.68792-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2874976647475378640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTE1ODM3OAoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgIDAuODAgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC41MCBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAxMy4yNyBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA0MjguOTAgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
Ni45MiBzZWNvbmRzCk1ha2VEaXN0Y2hlY2sgICAgICAgICAgICAgICAgIEZBSUwgICAgICA4NS41
MiBzZWNvbmRzCkNoZWNrVmFsZ3JpbmQgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMTcuMzEg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTc3LjE4IHNl
Y29uZHMKYmx1ZXptYWtlZXh0ZWxsICAgICAgICAgICAgICAgUEFTUyAgICAgIDYzLjM2IHNlY29u
ZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDQzOS4yMCBzZWNvbmRz
ClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA1NTkuMDUgc2Vjb25kcwoK
RGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNoZWNrIC0g
RkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjawpPdXRwdXQ6CgouL3Rlc3QtZHJpdmVyOiBs
aW5lIDEwNzogMzE3MjAgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAiJEAi
ID4gJGxvZ19maWxlIDI+JjEKLi90ZXN0LWRyaXZlcjogbGluZSAxMDc6IDMxNzc5IEFib3J0ZWQg
ICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkgIiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2Vb
M106ICoqKiBbTWFrZWZpbGU6MTA0MTM6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06
ICoqKiBbTWFrZWZpbGU6MTA1MjE6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBb
TWFrZWZpbGU6MTEwMDY6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEw
MDg6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBN
YWtlRGlzdGNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0
OgoKLi4vLi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA1MzYyOCBBYm9ydGVkICAgICAgICAgICAg
ICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQouLi8uLi90ZXN0LWRyaXZl
cjogbGluZSAxMDc6IDUzOTA4IEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkg
IiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2VbNF06ICoqKiBbTWFrZWZpbGU6MTA0MTM6IHRlc3Qt
c3VpdGUubG9nXSBFcnJvciAxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTA1MjE6IGNoZWNrLVRF
U1RTXSBFcnJvciAyCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTEwMDY6IGNoZWNrLWFtXSBFcnJv
ciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTEwMDg6IGNoZWNrXSBFcnJvciAyCm1ha2U6ICoq
KiBbTWFrZWZpbGU6MTA5Mjk6IGRpc3RjaGVja10gRXJyb3IgMQojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1h
a2UgQ2hlY2sgd2l0aCBWYWxncmluZApPdXRwdXQ6Cgp0b29scy9tZ210LXRlc3Rlci5jOiBJbiBm
dW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEzMTMxOjU6IG5vdGU6IHZh
cmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2lu
Zy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMzEzMSB8IGludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KLi90ZXN0LWRyaXZlcjogbGluZSAx
MDc6IDczMTc3IEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkgIiRAIiA+ICRs
b2dfZmlsZSAyPiYxCi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA3MzIzMSBBYm9ydGVkICAgICAg
ICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4mMQptYWtlWzNdOiAq
KiogW01ha2VmaWxlOjEwNDEzOiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiog
W01ha2VmaWxlOjEwNTIxOiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2Vm
aWxlOjExMDA2OiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjExMDA4OiBj
aGVja10gRXJyb3IgMgoKCmh0dHBzOi8vZ2l0aHViLmNvbS9ibHVlei9ibHVlei9wdWxsLzI0OTUK
Ci0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============2874976647475378640==--
