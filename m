Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE2D16DEAB
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500438; cv=none; b=um399e5p8aFTQOlF24BGGYMYI+V4Bq9acdJT7F1G4yiCW1LrjzHUpW7nQ2VVVH+pKvouhBFyASVgewpKl8dAVqvz5oAdk6UvWhcXTHnbuCJcH822Av0udJ9Abi0ZvsXA0KSuo0GmUxwqAm/FALD/p5mtu3wih71kKXkbRRW3UoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500438; c=relaxed/simple;
	bh=0QLiPY9pS+wb3raHufGnnlgmksVYaYMO2yIEa9frdn8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lqXkdlcFpEdgHFQkF9sklQEVzu9xTdO0YshqFd+yFAql1HMNgd5XB8b6yxtMUJoouAwVEiMsUCGQegF5xc/zOuntwNb11aNskQPNWTCnfLFXw99dU224fEQK+P7I4PzHK2u5bLQsfOi6gBpjoCnm0vPL8YMP1hyn9VMrLj3YEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khcoN024; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khcoN024"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so321634085a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723500435; x=1724105235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0QLiPY9pS+wb3raHufGnnlgmksVYaYMO2yIEa9frdn8=;
        b=khcoN0245NkC0ljN+U5wY9MkQEc4FuFD1I6kKYQcYkD1IhepvP+Be9W9VmpHQfqkzu
         fuf8rkB1HVqtLlPS5sZD9JCaQ/Fc/A/wXfTTIty6DeNPDqwWXIZ7Z6jEpzYuEz4TU8Mq
         2W70t216ZOISIlmf8dFvJuvcvZpMlZ5AqBAXKHX+0/8a93tshxwn3O/Im+QijS9tKP1B
         hG+jo7HzF6JQ3Ht99gsTqH2E/Bcur0YxnRR/IYoWryE1hAQ6AgmrCzubttg842QJn37Q
         mGVQxnuAKrk2hw4yGGigVMYUzJ2qVI0oqZkCiHHK8y/DZuxUyxx02Yoz+sCXU1wavit3
         Ar4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723500435; x=1724105235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QLiPY9pS+wb3raHufGnnlgmksVYaYMO2yIEa9frdn8=;
        b=ludLEwsit9UEu3ZTlx0nLyu98w4dIUcblT7OvBD8DWY2AIYwEzYaXF0QedPzr88jhX
         Jk602cE6ffm/bZS7eIfsGzpNwkKyHQ/euLJjXrUzP4OenLqmbANGMk4HeveYXgAGf8TV
         jrFepeKapa+xxK4tQT+zLm2igDcxsPvdy6R1w5tI4oTjQ8WTJYY0fmT7+L9ZkGmNHSP0
         giOUuPLPWlw6yioHPAkizzlIgHOPwc9KSkrLR0g+qNxzcwZcJkb/eSFyW8bsGjI0XPTF
         KALmAdRexQJrkfPy6SFQ2GMXHXLqWVoxO3mOCMDctBseVAAGK4yjoMBautPE47WFLbU1
         TJXg==
X-Gm-Message-State: AOJu0YyuuRVazN17rC6YTOnNmIi9jSPIvCvNTFpgA9U/CLUwp5yisbNs
	8LnekUhqrQ1uUFOD9PE7L6A4/cLBVYJcSHqf9rJKw4adJSXo55BS/A8BLw==
X-Google-Smtp-Source: AGHT+IGCaDtZk7ZpS3k+TQntU2feUulFpN4lA9CpGnuA3lpiNj+7xnNAjbQ9CNW73sAoEyDF+5LLZQ==
X-Received: by 2002:a05:620a:3712:b0:79f:947:8915 with SMTP id af79cd13be357-7a4e15361c6mr195676785a.29.1723500435445;
        Mon, 12 Aug 2024 15:07:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.163.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d64284sm281986885a.4.2024.08.12.15.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 15:07:15 -0700 (PDT)
Message-ID: <66ba8793.050a0220.3b8558.8cbf@mx.google.com>
Date: Mon, 12 Aug 2024 15:07:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6652571041883510396=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/uhid: Fix registering UHID_START multiple times
In-Reply-To: <20240812200622.351942-1-luiz.dentz@gmail.com>
References: <20240812200622.351942-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6652571041883510396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODc4OTQ2CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi42NSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjEzIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0LjU1IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE2OTQuNTkgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuNjYgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTU5
LjIwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1MS4w
NiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTMuMjkg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTE5LjU0IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDMwMjQuMDcgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgOTk4LjUyIHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVj
ayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVszXTogKioq
IFtNYWtlZmlsZToxMTc2NDogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtN
YWtlZmlsZToxMTg3MjogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmls
ZToxMjMwMTogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMwMzogY2hl
Y2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VEaXN0
Y2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIERpc3RjaGVjawpPdXRwdXQ6CgpQYWNr
YWdlIGN1cHMgd2FzIG5vdCBmb3VuZCBpbiB0aGUgcGtnLWNvbmZpZyBzZWFyY2ggcGF0aC4KUGVy
aGFwcyB5b3Ugc2hvdWxkIGFkZCB0aGUgZGlyZWN0b3J5IGNvbnRhaW5pbmcgYGN1cHMucGMnCnRv
IHRoZSBQS0dfQ09ORklHX1BBVEggZW52aXJvbm1lbnQgdmFyaWFibGUKTm8gcGFja2FnZSAnY3Vw
cycgZm91bmQKbWFrZVs0XTogKioqIFtNYWtlZmlsZToxMTc2NDogdGVzdC1zdWl0ZS5sb2ddIEVy
cm9yIDEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTg3MjogY2hlY2stVEVTVFNdIEVycm9yIDIK
bWFrZVsyXTogKioqIFtNYWtlZmlsZToxMjMwMTogY2hlY2stYW1dIEVycm9yIDIKbWFrZVsxXTog
KioqIFtNYWtlZmlsZToxMjMwMzogY2hlY2tdIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZTox
MjIyNDogZGlzdGNoZWNrXSBFcnJvciAxCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjayB3aXRo
IFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG1h
aW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTI3MjU6NTogbm90ZTogdmFyaWFibGUgdHJhY2tp
bmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz
4oCZLCByZXRyeWluZyB3aXRob3V0CjEyNzI1IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFy
Z3ZbXSkKICAgICAgfCAgICAgXn5+fgptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNzY0OiB0ZXN0
LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjExODcyOiBjaGVjay1U
RVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjEyMzAxOiBjaGVjay1hbV0gRXJy
b3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEyMzAzOiBjaGVja10gRXJyb3IgMgoKCi0tLQpSZWdh
cmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6652571041883510396==--
