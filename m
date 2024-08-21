Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030C18E34F
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724212317; cv=none; b=ZZaCJt6HYdKrw7aAYR3MawcxAUzjl+Q/agbI45gvb5i6Y0oF8nuBEiQvWMjbzo/SKguws6A5lRpPHGw6npNrAUrFG21oM4zx/vVDtWqgg8oqVceoGd5TTRlYaNaLzryPdkb+bdPD5ZCd0pg7637ZWsKz4ONCn3wiC6DRHtoDow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724212317; c=relaxed/simple;
	bh=pjUDQ/5g4GPx1GqsGJPX+cFBZ9vMRHO4l4r+ZVpshPs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=U6drOU2qXjf9mD6XzXLno+pSppp/Yzothp/a2GAJDEbBZkzfs1COhTIjNKMpENyx8qkwsoY5TlSEfp9GE+9ai6bKw1SCV6V4Yd9oJ1R8fQ6puub+0kvnE+gLRJ2nNXN3gxXmB2p3CxB/+iiO81BaOui5XX+Sk17glstaZ+5BGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS7dfo8p; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS7dfo8p"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4503ccbc218so2714391cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724212314; x=1724817114; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pjUDQ/5g4GPx1GqsGJPX+cFBZ9vMRHO4l4r+ZVpshPs=;
        b=fS7dfo8pejc4uYu8okItNn42fOEB6d08b4F429D77/r5JZVaZMpJgkEmzAT0fsoxNB
         u94FP06JWpFMTLMaQ9eeSy6mA4bpj6s9ft1KsSNYJWTV99c1MGe4oB5Uvzv6Rp5RslfL
         CzR+2G/5qv3vCQ8gjGBXtg6umemP67a3sNUyxOuEmurxlhV1cAg6t0913uN0oS1AhNj2
         qkM/k+PJSwoyFk6uzvhCs6RekfEEaBCaol8zG3GaxsyrWZbjTiGR0c+rDmsrkc9Ga0Dl
         GpjTqR6x7CESKt7+7jfh+e0zisrKMlwrYlVdwBRwIvtQLe41jkZVC/qx1UXex9WNL+fm
         jEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724212314; x=1724817114;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjUDQ/5g4GPx1GqsGJPX+cFBZ9vMRHO4l4r+ZVpshPs=;
        b=PAtDiX62yJxLAtoN0CPb12Qp/pIGJmA5jr+wgN7SBHJ19VnuUzG7mqAgsx6Pxl9e0k
         X5jqMYAt8F7XROp8cTAVlgPcETeQl1dfkS8xGnaY/Nqa/Oho9iOh63LhtOw40Qf1RJCj
         Ps2GDmIAtD9299tKU+91BdsZ3iRJq4bMGp50lOlkLEbfLdOkqnFbeyC8pGW10//NO9E+
         2Rts7HXjswBiABVpXThJldXO9QEMzLuMMlmxkWWuzwT7cZ9WTp7W3lMLe8NKhmzXtaZp
         gCa+dZYoE0XSQ8kvBJqLSY+twvijl5PSh7FDfVfcCsE25UGnmdKplaax6riuoSFw76jL
         MEvQ==
X-Gm-Message-State: AOJu0Yy3TEQ5ld09YAuAazFwfwBycZDTVnvhbGJx0hEff7vo63QWtsei
	s5VZGTTmvPaZkubI5FgpqPOvoFWxcRvGoxqninxN/xsBIi6ZlfNHr5HghA==
X-Google-Smtp-Source: AGHT+IGK2g6G/9K8uA+tk7aYcLWHII3P+SR5O4YFV9JJH6oPdojyIN5qqiAok0jBqDwJawaim5V0Yg==
X-Received: by 2002:ac8:6f1a:0:b0:453:57b0:8814 with SMTP id d75a77b69052e-454f1fd2e66mr21342121cf.6.1724212314415;
        Tue, 20 Aug 2024 20:51:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.58.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd729fsm55877921cf.17.2024.08.20.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:51:53 -0700 (PDT)
Message-ID: <66c56459.050a0220.2cc798.781d@mx.google.com>
Date: Tue, 20 Aug 2024 20:51:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2190299310962995451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: [BlueZ] adapter: Fix execute "LE Add Device To Resolving List" command fail
In-Reply-To: <20240821013505.1344247-1-clancy_shang@163.com>
References: <20240821013505.1344247-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2190299310962995451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgxNTI5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC40NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjI4IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0LjY4IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3MzQuNjYgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuNTQgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTU5
LjEwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1MC4z
MiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTIuNTMg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIwLjkwIHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE1NjguNzUgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgOTk2Ljk1IHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVj
ayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVszXTogKioq
IFtNYWtlZmlsZToxMTc2NjogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtN
YWtlZmlsZToxMTg3NDogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmls
ZToxMjMwMzogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMwNTogY2hl
Y2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VEaXN0
Y2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIERpc3RjaGVjawpPdXRwdXQ6CgpQYWNr
YWdlIGN1cHMgd2FzIG5vdCBmb3VuZCBpbiB0aGUgcGtnLWNvbmZpZyBzZWFyY2ggcGF0aC4KUGVy
aGFwcyB5b3Ugc2hvdWxkIGFkZCB0aGUgZGlyZWN0b3J5IGNvbnRhaW5pbmcgYGN1cHMucGMnCnRv
IHRoZSBQS0dfQ09ORklHX1BBVEggZW52aXJvbm1lbnQgdmFyaWFibGUKTm8gcGFja2FnZSAnY3Vw
cycgZm91bmQKbWFrZVs0XTogKioqIFtNYWtlZmlsZToxMTc2NjogdGVzdC1zdWl0ZS5sb2ddIEVy
cm9yIDEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTg3NDogY2hlY2stVEVTVFNdIEVycm9yIDIK
bWFrZVsyXTogKioqIFtNYWtlZmlsZToxMjMwMzogY2hlY2stYW1dIEVycm9yIDIKbWFrZVsxXTog
KioqIFtNYWtlZmlsZToxMjMwNTogY2hlY2tdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZTox
MjIyNjogZGlzdGNoZWNrXSBFcnJvciAxCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjayB3aXRo
IFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG1h
aW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTI3MjU6NTogbm90ZTogdmFyaWFibGUgdHJhY2tp
bmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz
4oCZLCByZXRyeWluZyB3aXRob3V0CjEyNzI1IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKICAgICAgfCAgICAgXn5+fgptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNzY2OiB0ZXN0
LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjExODc0OiBjaGVjay1U
RVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyMzAzOiBjaGVjay1hbV0gRXJy
b3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEyMzA1OiBjaGVja10gRXJyb3IgMgoKCi0tLQpSZWdh
cmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============2190299310962995451==--
