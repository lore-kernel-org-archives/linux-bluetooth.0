Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092729293D
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520401; cv=none; b=gO1m7WvLiyet9SBRqu7j2guCQL9wTmedWp/GxHDMV60Sy3CLVdFCsIYlqZPr6fRwbyUMM9bd6Obi5vD8A64zF+Y9HrnHwuzquqgbnOpl/RIAGu/WNhR+U1jPo5Yq9q5ikMxDRV/5nhDq4wbWU4VC/rrTid57yYOfEKrjiTf2alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520401; c=relaxed/simple;
	bh=sAAWL8JnczIFLlslqdXqjIL5vrjFaa1956uuNQavB2E=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=CCApEnvN6Z86tiHBs+HcCv0CraaCQswAXizmijihtxTnIlhNIHzqOuZKJAiaKglnvVWKULabj4dFyhXRPFMlKCW95HHFAPKN113WIQbxGUOUCqk3WdLkeikZ1nFgaNd7ypq6nFlOHLsTM+fShB/1W475BAHRQQRzUEmWcIREL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+E7FDSh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+E7FDSh"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so5218271b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 18:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520399; x=1764125199; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGKh45PX2YuPhhLkZxUqZlEKFdV7EEliBN8nMwa6g8I=;
        b=G+E7FDShWnAwU2O92GWEei3yuefpKxMULlnYNufT1ILOxsRgyU86bEdVapep3dryf0
         o9S5liAytdQFTBERyc04wojj9SnekxltMhcZwBujLTsFtXhselDjdw7hooZlOWaKDdF1
         wjszTHNbqRbMHZT57u0YCtmzWonPgA0fVj1n9SSdUUQRzkQP/kAQHoUvFdDngTRAn/Km
         TBUrsXT1tVxg2QhlHeB/Us8Wizy6UH/8R4u9SHyp+1mgvgTd/h+7rfzGWELXlNRRBwlf
         CtUU/GdlINQxDzxWpWdn2lQWDFRAOi38YAs+Kyenkh6HLtmd30bNc4Ig0YRmdHtItZOD
         vq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520399; x=1764125199;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGKh45PX2YuPhhLkZxUqZlEKFdV7EEliBN8nMwa6g8I=;
        b=tCTZ9DzuVmUp0ugFQr9Ttf92VeK/OP0r866vA3eBjEdcNbRi5hYLb2oeaOCtVKS8ZO
         imftzqv6D95yC+iNvhRwhysiiQ1bdYwWFJAG5eh7Sk8lbYsXFgSvGsH+fglgu5dD0tK2
         FrtwixwRi3uW4IH3ze3DEyHxgu/9/TRlAfj8kHpbPFagbbkBQdFB4cvO22OO4EYdJZPO
         xzm3Fqa2y7Ku7hAoMrwWDsQhKFmJflr6OJv+Fk2h45JqfNL0cUB1b7ZYMKH+h4zv9RCM
         +5IEJ4wRpNQcq+jvCZIffuU4umI/VCflwaT0gQ+cT8zUV4PHaTfgVb0LfghPZI7hE/3r
         Qu2g==
X-Gm-Message-State: AOJu0YyIfpjGCM0RIH4U0Z/uuf5QPkGg6mrR0jpko3A47cMfQD4NVve/
	jnquoqpU6ZrGum19bGt9vjWoIwPOnJmWXzTlhrIYyKGmz66WYuZzijTn
X-Gm-Gg: ASbGncv/4zisfeSibwG/X/8p5z8fKQBnhtjnJV3UGYSbA0xFwmZk0QIDU7cmB6p3htD
	I7O9XvIvooAE/gtex9dwRuC8brW5DyJJ2FUPR6lX8tNmKAuW+mR2G+Q4T90pJvFaYQE/FFNmMma
	S1q2ZXsKehfq5kIWxhPBmxuKXOTE8sgp4EEVMg8bbaD12iz69t+39R8vvJwXq4jo3z0j+gTwGZV
	HTyCtqLqTKnS4G4GVvnPXljGrwjd2kCnE0t8413h/hRwP7P5KGbhP0AVty9zUnk+H8dYbRo5kMJ
	gcZJdgjYQAcixY5V+bhLk818qg9DZDJUEVk25y34FPZN/++rooUX3VGIYHoejdgYlsmzAeQQsOk
	rh6cxt5ocTdMk2NGI0kIi9SN+F5ct2+TKM9vfvxbjBFI11ARSiIsuz5fl8S87CazGPiJF2t0EQg
	ZC0C85q3QYIonfKxFklqQ4cy9tzKs=
X-Google-Smtp-Source: AGHT+IHyHc9h5I9T1VPJZh1zTHku9FC8IXvkQm1itcNWDgvJXca6bSSR3htJpCW+yVPHQXC0rvaKgQ==
X-Received: by 2002:a05:6a20:2449:b0:35f:e2c8:247 with SMTP id adf61e73a8af0-35fe2c80442mr10371141637.32.1763520399117;
        Tue, 18 Nov 2025 18:46:39 -0800 (PST)
Received: from [10.118.151.26] ([49.36.115.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aedb73sm17689426b3a.12.2025.11.18.18.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 18:46:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------2xwNknjuEzUmVcT0dKGsv6ua"
Message-ID: <38e4d1b9-016f-419b-b545-83c9f2f84b9d@gmail.com>
Date: Wed, 19 Nov 2025 08:16:32 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+f098d64cc684b8dbaf65@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <691b301e.a70a0220.f6df1.0011.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] [usb?] memory leak in __hci_cmd_sync_sk
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <691b301e.a70a0220.f6df1.0011.GAE@google.com>

This is a multi-part message in MIME format.
--------------2xwNknjuEzUmVcT0dKGsv6ua
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    #syz test:<br>
    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    master
  </body>
</html>
--------------2xwNknjuEzUmVcT0dKGsv6ua
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Bluetooth-hci_sync-fix-memory-leak-in-__hci_cmd_sync.patch"
Content-Disposition: attachment;
 filename*0="0001-Bluetooth-hci_sync-fix-memory-leak-in-__hci_cmd_sync.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkYTczZWM4NTFhYTVlYzE5YjQyOWM0Y2Y4YjllMmNkNmE0MmU2ZTFlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogV2VkLCAxOSBOb3YgMjAyNSAwODowMTozMyArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIEJsdWV0b290aDogaGNpX3N5bmM6IGZpeCBtZW1vcnkgbGVhayBpbiBfX2hj
aV9jbWRfc3luY19zawoKRml4IGEgbWVtb3J5IGxlYWsgaW4gX19oY2lfY21kX3N5bmNfc2sg
d2hlcmUgYWxsb2NhdGVkIHJlcXVlc3QgY29tbWFuZApTS0JzIGFyZSBub3QgcHJvcGVybHkg
Y2xlYW5lZCB1cCB3aGVuIHRoZSBmdW5jdGlvbiBmYWlscy4KClRoZSBpc3N1ZSBvY2N1cnMg
d2hlbiBoY2lfY21kX3N5bmNfYWxsb2MoKSBzdWNjZXNzZnVsbHkgYWxsb2NhdGVzIGFuIFNL
QgphbmQgaXQgZ2V0cyBxdWV1ZWQgdmlhIGhjaV9jbWRfc3luY19hZGQoKSwgYnV0IHRoZW4g
X19oY2lfY21kX3N5bmNfc2soKQpmYWlscyBkdWUgdG8gdGltZW91dCwgaW50ZXJydXB0aW9u
LCBvciBjYW5jZWxsYXRpb24uIEluIHRoZXNlIGVycm9yCnBhdGhzLCB0aGUgcmVxX3NrYiB0
aGF0IHdhcyBjbG9uZWQgYW5kIHN0b3JlZCBpbiBoZGV2LT5yZXFfc2tiIGlzIG5vdApmcmVl
ZCwgbGVhZGluZyB0byBtZW1vcnkgbGVha3MuCgpUaGUgbWVtb3J5IGxlYWsgY2FuIGJlIHJl
cHJvZHVjZWQgd2hlbiBfX2hjaV9jbWRfc3luY19zaygpIGFsbG9jYXRlcwphbmQgcXVldWVz
IGFuIEhDSSBjb21tYW5kIFNLQiwgYW5kIGhjaV9yZXFfc3luY19ydW4oKSB0cmFuc2ZlcnMg
dGhpcwpTS0IgdG8gaGRldi0+Y21kX3EgYW5kIGNsb25lcyBpdCB0byBoZGV2LT5yZXFfc2ti
LiBJZiB0aGUgc3Vic2VxdWVudAp3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCgp
IGNhbGwgZmFpbHMgKGR1ZSB0byB0aW1lb3V0IG9yCmludGVycnVwdGlvbiksIHRoZSBmdW5j
dGlvbiByZXR1cm5zIGFuIGVycm9yIHdpdGhvdXQgaGRldi0+cmVxX3NrYgpldmVyIGJlaW5n
IGNsZWFuZWQgdXAuCgpUaGUgZml4IGVuc3VyZXMgdGhhdCB3aGVuIF9faGNpX2NtZF9zeW5j
X3NrKCkgcmV0dXJucyBhbiBlcnJvciwgYW55CnBlbmRpbmcgcmVxdWVzdCBjb21tYW5kIFNL
QiBpbiBoZGV2LT5yZXFfc2tiIGlzIHByb3Blcmx5IGZyZWVkIGJlZm9yZQpyZXR1cm5pbmcu
IFRoaXMgbWF0Y2hlcyB0aGUgY2xlYW51cCBwYXR0ZXJuIHVzZWQgZWxzZXdoZXJlIGluIHRo
ZSBIQ0kKc3luYyBjb2RlLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCtmMDk4ZDY0Y2M2ODRiOGRi
YWY2NUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWYwOThkNjRjYzY4NGI4ZGJhZjY1ClNpZ25lZC1v
ZmYtYnk6IFNoYXVyeWEgUmFuZSA8c3NyYW5lX2IyM0BlZS52anRpLmFjLmluPgotLS0KIG5l
dC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMgYi9u
ZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKaW5kZXggNmU3Njc5OGVjNzg2Li5mYmFhNTc0OWFk
N2IgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYworKysgYi9uZXQvYmx1
ZXRvb3RoL2hjaV9zeW5jLmMKQEAgLTIwMyw2ICsyMDMsMTEgQEAgc3RydWN0IHNrX2J1ZmYg
Kl9faGNpX2NtZF9zeW5jX3NrKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB1MTYgb3Bjb2RlLCB1
MzIgcGxlbiwKIAogCWlmIChlcnIgPCAwKSB7CiAJCWtmcmVlX3NrYihza2IpOworCQkvKiBD
bGVhbiB1cCBhbnkgcGVuZGluZyByZXF1ZXN0IGNvbW1hbmQgKi8KKwkJaWYgKGhkZXYtPnJl
cV9za2IpIHsKKwkJCWtmcmVlX3NrYihoZGV2LT5yZXFfc2tiKTsKKwkJCWhkZXYtPnJlcV9z
a2IgPSBOVUxMOworCQl9CiAJCXJldHVybiBFUlJfUFRSKGVycik7CiAJfQogCi0tIAoyLjM0
LjEKCg==

--------------2xwNknjuEzUmVcT0dKGsv6ua--
