Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4714294
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634183; cv=none; b=aGeCsojU1Bh38Lde2O1ItpmAdrQRKzif+sdOpe8JtXLz9IChV1JdYT4qqJskGq31ITajtLXy0HGJqUvftz4D2WR0+xi9CkMalh0wd4+E9eqB9Gfe9Z6J7u6+BYlIk3fGHKaDQZn5OQQ5lP1NKddkyl6IOlV2i1/e/+BuZABqAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634183; c=relaxed/simple;
	bh=IU4XXk/dVOpvBlPNZhWupwrTFWUF3RgBd6moQXPKOys=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HzoCnbOUnodc3vwPGrlGwSE/JD3QjcRShqSRt6ruUwCcuyg8l7vKKoszVrPtGzEZNcvZf4v4n36aD0q2ciNWuDeFu7Jx0JqczoGMm9g0sepT8N6BW1cJqSvV+IiwKbIuOjL4v2p3fIle14BDYUceEiQO6j1BqIbfZ28oPY6B0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE58R7qB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE58R7qB"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-432b72c706cso3410191cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711634180; x=1712238980; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IU4XXk/dVOpvBlPNZhWupwrTFWUF3RgBd6moQXPKOys=;
        b=bE58R7qBbDqCPlq1pJaNq/KXo4ZAuscP2pXd1hDuCf++AZdZiQilXS/tLiglh9mIV6
         z0kS5SyAY9S3f0OY5OAsQ1CgVep78/FaoiCE6tnC9v/zIcqjjUVYkU5DYoJpOOgkr8L7
         d50/2tSH2V27pmL/0cQ7Qn11YfCmgD1JnIW/npJjFvEfiGYcMZOj989Nftds5B7sLX55
         GOLkV+vtIAmedcztpR6q8aKtrCzE/51V0Xie0weWBcEg+4d1tziezY20Q/INoSASxFGD
         moIDg0W0u2L6o9z/ReNY3Aiug252qo0hY5g7Ef+kRE0cZ9QWU4i5WELp9RDu1rIUQ0ku
         MtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634180; x=1712238980;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IU4XXk/dVOpvBlPNZhWupwrTFWUF3RgBd6moQXPKOys=;
        b=ijnxljtwD0+Nj8BiNg1mPI7gVSwh2vyBg0Iuk/ug4qcg+Eb/sYNkDpX1fOFA7OboLx
         yqOTRv8h/Mzzq3oZciy0jjbLA+ZliNOZR71kjL8PTfKzCp1DaRVuTsy1rkMt/UuC2fc3
         0JwNjfRnztyz82++5hKJVQH2mRBsobQHJk7Jo5kS/9xdbzfKbTBGQs1uT3r4CHjh7EGQ
         ggTn1piOUqdhn81wMQx1a9eZ7UZh3GcKSOk5zSWyugKcKAgBEpbGYecYDsVNtlSP4ZaZ
         fkrA9BS/YfHqBC5+Y8e9nvN4JQ4w2SWNBaQW0C5oEKgUSqotm4AynhnNQo1Lz8FkxTyP
         xfgA==
X-Gm-Message-State: AOJu0YwVhTHwxyTM8KIheKe65BUnjkFHB64Y5xUUU9Vk/jCXLGcp6rww
	MVOox6QLMl+QejUDQ4wVhTrpUn23FJNtekXevwfLgxa3CRFKPDDYkVyZdNf7GVw=
X-Google-Smtp-Source: AGHT+IGdN2XKtxjR6tFDnCEv3Ah2HL8exA+Ql86K8RSqHlicZLWrAnIO6tOfedTyQExdDtTXFUo6dg==
X-Received: by 2002:a05:622a:2ca:b0:431:481e:fcaf with SMTP id a10-20020a05622a02ca00b00431481efcafmr3829267qtx.14.1711634180552;
        Thu, 28 Mar 2024 06:56:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.148])
        by smtp.gmail.com with ESMTPSA id bw5-20020a05622a098500b00432bb012607sm139456qtb.47.2024.03.28.06.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:56:20 -0700 (PDT)
Message-ID: <66057704.050a0220.52638.0edd@mx.google.com>
Date: Thu, 28 Mar 2024 06:56:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4619196343578491133=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wse@tuxedocomputers.com
Subject: RE: Bluetooth: btintel: Add devices to HCI_QUIRK_BROKEN_LE_CODED
In-Reply-To: <20240328131800.63328-1-wse@tuxedocomputers.com>
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4619196343578491133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODM5MzM1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC42MyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMwIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTEgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzAuMDEgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzMu
MjIgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzguNDkg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMzUuMzEgc2Vj
b25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjkuMzMgc2Vjb25k
cwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNTIzLjQ0IHNlY29uZHMK
VGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDIwLjE1IHNlY29uZHMKVGVz
dFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDM3LjE5IHNlY29uZHMKVGVzdFJ1
bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuMjYgc2Vjb25kcwpUZXN0UnVubmVy
X21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTEzLjAwIHNlY29uZHMKVGVzdFJ1bm5lcl9y
ZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDcuMzcgc2Vjb25kcwpUZXN0UnVubmVyX3Njby10
ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTQuODcgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3RsLXRl
c3RlciAgICAgICBQQVNTICAgICAgNy44MCBzZWNvbmRzClRlc3RSdW5uZXJfbWVzaC10ZXN0ZXIg
ICAgICAgIFBBU1MgICAgICA1LjgxIHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVzdGVyICAgICAg
ICAgUEFTUyAgICAgIDYuODUgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAgICBQ
QVNTICAgICAgNC45NiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1Mg
ICAgICAzMi42NyBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBDaGVja0FsbFdhcm5pbmcgLSBXQVJOSU5HCkRlc2M6IFJ1biBsaW51eCBrZXJuZWwg
d2l0aCBhbGwgd2FybmluZyBlbmFibGVkCk91dHB1dDoKZHJpdmVycy9ibHVldG9vdGgvYnRpbnRl
bC5jOiBJbiBmdW5jdGlvbiDigJhidGludGVsX3NldHVwX2NvbWJpbmVk4oCZOmRyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWwuYzozMDM0OjM6IHdhcm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxs
IHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XSAzMDM0IHwgICBzZXRfYml0KEhDSV9R
VUlSS19CUk9LRU5fTEVfQ09ERUQsICZoZGV2LT5xdWlya3MpOyAgICAgIHwgICBefn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+ZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbC5jOjMwMzU6Mjogbm90ZTogaGVyZSAzMDM1IHwgIGNhc2UgMHgxYjogICAgICB8ICBe
fn5+CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1NwYXJzZSAtIFdB
Uk5JTkcKRGVzYzogUnVuIHNwYXJzZSB0b29sIHdpdGggbGludXgga2VybmVsCk91dHB1dDoKZHJp
dmVycy9ibHVldG9vdGgvYnRpbnRlbC5jOiBJbiBmdW5jdGlvbiDigJhidGludGVsX3NldHVwX2Nv
bWJpbmVk4oCZOmRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYzozMDM0OjM6IHdhcm5pbmc6IHRo
aXMgc3RhdGVtZW50IG1heSBmYWxsIHRocm91Z2ggWy1XaW1wbGljaXQtZmFsbHRocm91Z2g9XWRy
aXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYzozMDM1OjI6IG5vdGU6IGhlcmUKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrU21hdGNoIC0gRkFJTApEZXNjOiBSdW4gc21h
dGNoIHRvb2wgd2l0aCBzb3VyY2UKT3V0cHV0OgoKU2VnbWVudGF0aW9uIGZhdWx0IChjb3JlIGR1
bXBlZCkKbWFrZVs0XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0NDogbmV0L2JsdWV0
b290aC9oY2lfY29yZS5vXSBFcnJvciAxMzkKbWFrZVs0XTogKioqIERlbGV0aW5nIGZpbGUgJ25l
dC9ibHVldG9vdGgvaGNpX2NvcmUubycKbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1
aWxkOjQ4NTogbmV0L2JsdWV0b290aF0gRXJyb3IgMgptYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFr
ZWZpbGUuYnVpbGQ6NDg1OiBuZXRdIEVycm9yIDIKbWFrZVsyXTogKioqIFdhaXRpbmcgZm9yIHVu
ZmluaXNoZWQgam9icy4uLi4KU2VnbWVudGF0aW9uIGZhdWx0IChjb3JlIGR1bXBlZCkKbWFrZVs0
XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0NDogZHJpdmVycy9ibHVldG9vdGgvYmNt
MjAzeC5vXSBFcnJvciAxMzkKbWFrZVs0XTogKioqIERlbGV0aW5nIGZpbGUgJ2RyaXZlcnMvYmx1
ZXRvb3RoL2JjbTIwM3gubycKbWFrZVs0XTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ4NTogZHJpdmVycy9i
bHVldG9vdGhdIEVycm9yIDIKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ4
NTogZHJpdmVyc10gRXJyb3IgMgptYWtlWzFdOiAqKiogWy9naXRodWIvd29ya3NwYWNlL3NyYy9z
cmMvTWFrZWZpbGU6MTkxOTogLl0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjI0MDogX19z
dWItbWFrZV0gRXJyb3IgMgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4619196343578491133==--
