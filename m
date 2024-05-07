Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9216DEAE
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715111772; cv=none; b=BTrY28/LxfLFchPhX/xd41OWO7lGwXitOI37KmOe330oiPTgudRFYr8ceF9zOZ1M1AZVGrvSB6LKd+U9O3fzJXI5jXz3BKR5CjR6aR6jE9ENihOaK1YIUY/CZFCmzVoTHy9+Z0DqCsx/iFYwU27N3qiUzEgyB34ep7SUKvI/f30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715111772; c=relaxed/simple;
	bh=3iVq3GU2bKw5l9Lwn4n/q5qEwSNGMYKG+obOvEHgo0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qk3+P90Zia71uT5lPWMyoU9K1P213965+UDAQyu7A6cgXqyKen0vuHyM7BbgYP7LWO7FqB0XyLJoImHsue7Bo6ID8ffOWsTC+xICwgqfpZ86UbuO1fqUXVj4JuZEX9jcs8zbWGOUa7CkG/PeKjZ8xW8geHNEkzkfgI583wr8DFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDiCVpKH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDiCVpKH"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69b50b8239fso1138316d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715111770; x=1715716570; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3iVq3GU2bKw5l9Lwn4n/q5qEwSNGMYKG+obOvEHgo0w=;
        b=EDiCVpKHfMYicLI7nfSzceNbhIIBCI4cfcLW5XjvmpEsrPbfQGegBVluFSH1lA7vkK
         NrASyQdzEjcc3RFZPtLGnNaTqI9p3iS9AHdS2xMw4h+PpIkOjRqfoj5RvryZrVb3mCyU
         70lKg+I85N04837omYOf8mzlG2k4FNn9YJDgfc+XBuee+fxalb3HZlwQtwIKBYRjpZm8
         4wC2/4pgXy1p5UPndCBwIbDr3DVWvsa5f9iHy0V0p7LJRmFVDAU9je/AUXt4UgaFdhey
         2KfPoPdQvg2eX++3M4rrjpO7fk9e/PUlznn67GO7Mwt3I3M0MKcXk1ycwktlTXExYY/C
         sP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715111770; x=1715716570;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iVq3GU2bKw5l9Lwn4n/q5qEwSNGMYKG+obOvEHgo0w=;
        b=ht820j+/uNSrVraMSu1SxAGQEdPYZCU0LlzgtQnwEF1dFsLeH3TJC4YgzPPAnXB5Td
         FTAaGt39FMwYANy9EizcZLN/YsJI1XxmNXAcpplIX9PlnEngbWcuyh79d0BiGK8qtIUA
         TKkqbpSJ0o6irAQiYPQCTDv7yi/Bn/40YyAFe68rml9JANpbwLGaSglLiWhXDEmDC2N4
         qHiVA7zmZqq8w8S/jmgMpRIsfNfrEVbh0UzSkB4QavILg2aOtarey0DvCdnCg+HhmvWe
         UkyCo5Q9Ecjb1gOjVCmw5dvdPHXvSvCmyiUODSZDLrmPXqv3oiFjkb/4UeylN9S6SaTm
         UcAg==
X-Gm-Message-State: AOJu0Yw2duIxsfE4s8L+v3Am581JOL79oDhsUm5i+h+eaqgX4VjCC5lc
	6ny/nrKe9sY6cacqfmsRU3A+5l0vTwrXwu6g/uGityGGx653UdUnb8s+hQ==
X-Google-Smtp-Source: AGHT+IFNDTz6k68raqaamaT8juYo9FcLkXYzLqiL6mMZlaHk+nG181Igi++2QS/ItSx9CjvfSAa/YQ==
X-Received: by 2002:a05:6214:76b:b0:6a0:ea1e:833d with SMTP id 6a1803df08f44-6a1514ce653mr15595476d6.27.1715111769715;
        Tue, 07 May 2024 12:56:09 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.4])
        by smtp.gmail.com with ESMTPSA id y17-20020ad45311000000b006a0eb265a6asm4878519qvr.65.2024.05.07.12.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 12:56:09 -0700 (PDT)
Message-ID: <663a8759.d40a0220.14bf7.2317@mx.google.com>
Date: Tue, 07 May 2024 12:56:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0376442488191573308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [v4,1/5] Bluetooth: btmtk: add the function to get the fw name
In-Reply-To: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0376442488191573308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODUxMzIyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMy41NSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAxLjcwIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuNjUgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjkuODggc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzIu
ODMgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzguMDgg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMzQuNTUgc2Vj
b25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjguNzAgc2Vjb25k
cwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNTE1LjcyIHNlY29uZHMK
VGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDE4LjMyIHNlY29uZHMKVGVz
dFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDMxLjE1IHNlY29uZHMKVGVzdFJ1
bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDQuNjcgc2Vjb25kcwpUZXN0UnVubmVy
X21nbXQtdGVzdGVyICAgICAgICBQQVNTICAgICAgMTEwLjc2IHNlY29uZHMKVGVzdFJ1bm5lcl9y
ZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDcuMjAgc2Vjb25kcwpUZXN0UnVubmVyX3Njby10
ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTQuOTkgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3RsLXRl
c3RlciAgICAgICBQQVNTICAgICAgNy43MCBzZWNvbmRzClRlc3RSdW5uZXJfbWVzaC10ZXN0ZXIg
ICAgICAgIFBBU1MgICAgICA1Ljc5IHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVzdGVyICAgICAg
ICAgUEFTUyAgICAgIDYuNzkgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAgICBQ
QVNTICAgICAgNC44OSBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1Mg
ICAgICA0OC41NiBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBHaXRMaW50IC0gRkFJTApEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6Clt2NCw0LzVd
IEJsdWV0b290aDogYnR1c2I6IG1lZGlhdGVrOiByZXNldCB0aGUgY29udHJvbGxlciBiZWZvcmUg
ZG93bmxvYWRpbmcgdGhlIGZ3CgpXQVJOSU5HOiBJMyAtIGlnbm9yZS1ib2R5LWxpbmVzOiBnaXRs
aW50IHdpbGwgYmUgc3dpdGNoaW5nIGZyb20gdXNpbmcgUHl0aG9uIHJlZ2V4ICdtYXRjaCcgKG1h
dGNoIGJlZ2lubmluZykgdG8gJ3NlYXJjaCcgKG1hdGNoIGFueXdoZXJlKSBzZW1hbnRpY3MuIFBs
ZWFzZSByZXZpZXcgeW91ciBpZ25vcmUtYm9keS1saW5lcy5yZWdleCBvcHRpb24gYWNjb3JkaW5n
bHkuIFRvIHJlbW92ZSB0aGlzIHdhcm5pbmcsIHNldCBnZW5lcmFsLnJlZ2V4LXN0eWxlLXNlYXJj
aD1UcnVlLiBNb3JlIGRldGFpbHM6IGh0dHBzOi8vam9yaXNyb292ZXJzLmdpdGh1Yi5pby9naXRs
aW50L2NvbmZpZ3VyYXRpb24vI3JlZ2V4LXN0eWxlLXNlYXJjaAoxOiBUMSBUaXRsZSBleGNlZWRz
IG1heCBsZW5ndGggKDgzPjgwKTogIlt2NCw0LzVdIEJsdWV0b290aDogYnR1c2I6IG1lZGlhdGVr
OiByZXNldCB0aGUgY29udHJvbGxlciBiZWZvcmUgZG93bmxvYWRpbmcgdGhlIGZ3IgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpE
ZXNjOiBSdW4gbGludXgga2VybmVsIHdpdGggYWxsIHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6CmRy
aXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmM6IEluIGZ1bmN0aW9uIOKAmGJ0bXRrX2Z3X2dldF9maWxl
bmFtZeKAmTpkcml2ZXJzL2JsdWV0b290aC9idG10ay5jOjExNToxNDogd2FybmluZzog4oCYbWVk
aWF0ZWsvQlRfUkFNX0NPREVfTVTigJkgZGlyZWN0aXZlIG91dHB1dCB0cnVuY2F0ZWQgd3JpdGlu
ZyAyMyBieXRlcyBpbnRvIGEgcmVnaW9uIG9mIHNpemUgOCBbLVdmb3JtYXQtdHJ1bmNhdGlvbj1d
ICAxMTUgfCAgICAgIm1lZGlhdGVrL0JUX1JBTV9DT0RFX01UJTA0eF8xYV8leF9oZHIuYmluIiwg
ICAgICB8ICAgICAgfn5+fn5+fn5efn5+fn5+fn5+fn5+fn5kcml2ZXJzL2JsdWV0b290aC9idG10
ay5jOjExNTo1OiBub3RlOiBkaXJlY3RpdmUgYXJndW1lbnQgaW4gdGhlIHJhbmdlIFsxLCAyNTZd
ICAxMTUgfCAgICAgIm1lZGlhdGVrL0JUX1JBTV9DT0RFX01UJTA0eF8xYV8leF9oZHIuYmluIiwg
ICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+ZHJp
dmVycy9ibHVldG9vdGgvYnRtdGsuYzoxMTQ6Mzogbm90ZTog4oCYc25wcmludGbigJkgb3V0cHV0
IGJldHdlZW4gNDEgYW5kIDQzIGJ5dGVzIGludG8gYSBkZXN0aW5hdGlvbiBvZiBzaXplIDggIDEx
NCB8ICAgc25wcmludGYoYnVmLCBzaXplb2Yoc2l6ZSksICAgICAgfCAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fiAgMTE1IHwgICAgICJtZWRpYXRlay9CVF9SQU1fQ09ERV9NVCUwNHhfMWFf
JXhfaGRyLmJpbiIsICAgICAgfCAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4gIDExNiB8ICAgICBkZXZfaWQgJiAweGZmZmYsIChmd192ZXIgJiAweGZmKSAr
IDEpOyAgICAgIHwgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrU21hdGNoIC0gRkFJTApEZXNj
OiBSdW4gc21hdGNoIHRvb2wgd2l0aCBzb3VyY2UKT3V0cHV0OgoKU2VnbWVudGF0aW9uIGZhdWx0
IChjb3JlIGR1bXBlZCkKbWFrZVs0XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0NDog
bmV0L2JsdWV0b290aC9oY2lfY29yZS5vXSBFcnJvciAxMzkKbWFrZVs0XTogKioqIERlbGV0aW5n
IGZpbGUgJ25ldC9ibHVldG9vdGgvaGNpX2NvcmUubycKbWFrZVszXTogKioqIFtzY3JpcHRzL01h
a2VmaWxlLmJ1aWxkOjQ4NTogbmV0L2JsdWV0b290aF0gRXJyb3IgMgptYWtlWzJdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDg1OiBuZXRdIEVycm9yIDIKbWFrZVsyXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KU2VnbWVudGF0aW9uIGZhdWx0IChjb3JlIGR1bXBl
ZCkKbWFrZVs0XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0NDogZHJpdmVycy9ibHVl
dG9vdGgvYmNtMjAzeC5vXSBFcnJvciAxMzkKbWFrZVs0XTogKioqIERlbGV0aW5nIGZpbGUgJ2Ry
aXZlcnMvYmx1ZXRvb3RoL2JjbTIwM3gubycKbWFrZVs0XTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ4NTog
ZHJpdmVycy9ibHVldG9vdGhdIEVycm9yIDIKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkOjQ4NTogZHJpdmVyc10gRXJyb3IgMgptYWtlWzFdOiAqKiogWy9naXRodWIvd29ya3Nw
YWNlL3NyYy9zcmMvTWFrZWZpbGU6MTkxOTogLl0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxl
OjI0MDogX19zdWItbWFrZV0gRXJyb3IgMgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK
Cg==

--===============0376442488191573308==--
