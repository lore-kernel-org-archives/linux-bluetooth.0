Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECA172760
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871132; cv=none; b=s1RZR57rq1TE204/d3OYPOLLbcRPdtkhNGQmUE3VwsFZL4Ko2DlTq9GsX2SvCTAfHg+eBg7fcPVipy41p9oNyWritWIXtLTfog9o82FuZ/ip5dbhbeeKmuzBqrHcC7/6Y+qhxBn+icG2y+on2DT8lGcETPkRd+mjzxJjb4CggcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871132; c=relaxed/simple;
	bh=+VDvwBMaJzvPucR5pQBlmc2GEdV/J6mRFmZxC90NxZs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fr1/pDNZ/FJBRxfRJt8s1p7yuwfntumsvW7eAQMJdq/fszbGjAZLJKzy+K/Py7HN+Ohgo28vxSTvUSf31Z2VBk5upZTz12A+8zg3sbdqS7RycYSvV8CJI8KhjhYvu/Qnj1b9oBjUUBESwyfVhvFlQg4hQN5LtlZdlE4VD9rEQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFX3kuwr; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFX3kuwr"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70211abf4cbso1146105a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719871130; x=1720475930; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+VDvwBMaJzvPucR5pQBlmc2GEdV/J6mRFmZxC90NxZs=;
        b=MFX3kuwr9kNj1/yDTEUrjpTsE7w1YmRVjN634rrMZmDPJF2QBcao3GQ92maXJTOZ1j
         4HaPwglTVgMn1goL4tAS4vV3+cOGP7nF+i1xyxqnzw6GvRPjWvuKNtoRfu4z0a36FjOz
         cSAd1EUGs5SxNICaIkhtEaal6h8B9xzfWL/FtuyJao59HCqW9OxTM8OxP5RrKfcFBpp7
         F7PqJ3/GZoiMX8RvnfP+vaNmpzLbmR/3gfEMJNMmApUeClYj6UaVlfGHvNESZQ6VyjjO
         io1kKIWjBMk4c1r4Xy/KYA5u6XEDDKrtPEO/IgMfRow1ESgvMznqHAl7NCNSCRmxHDAl
         MJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719871130; x=1720475930;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VDvwBMaJzvPucR5pQBlmc2GEdV/J6mRFmZxC90NxZs=;
        b=nVsYGI8a432wi6t5N09lJE/areJ2/tnDUWf2MNTkTNuv0r6PEbENM/2pZ5vbAhzTuy
         BHLX57NdvH/VdAYLWpBagfP/i507lg/9hnpwfZOMD+5bCRIaSbo4G3w6PwVtcxkfKXsO
         6nbVJv/fa4wy4IiRpkE+BPz0sVw+OT6tzGfRIgQXI5VYR2ovawflpw+zd04D3e9JIJ03
         hI7X1q53JEo0U+cHhpM7Z1acsI4QKmy99gKitobJwFKFN7B7NbF79xJuTBzLR+Op6D0E
         byg8gWIO7NmtoamZuaPj1YnDv80bJ8tIkq862Ib2KZG98i2sZxqebJ7PpAEColrWQiKd
         4SQQ==
X-Gm-Message-State: AOJu0YxNY0QhuTuFbiQEo9uGOELNi4Kr51xM3rZ+NPwCP1G+HkzZM3VJ
	UOo547/jLqtetr5vQrMvfIv2e1nmO6I5Q3Ey2RWR5aMievvfLTmVsfkx8A==
X-Google-Smtp-Source: AGHT+IG2f4nw1vI5/W7nmkvcyOkXUmCeCJZeurEofT1/OUS6AmdnhwxAKXpxQFbZFQm+FGRV+dDEuA==
X-Received: by 2002:a9d:7491:0:b0:701:f368:c54 with SMTP id 46e09a7af769-70207686f04mr7276014a34.26.1719871129862;
        Mon, 01 Jul 2024 14:58:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.106.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69260065sm389436385a.5.2024.07.01.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:58:49 -0700 (PDT)
Message-ID: <66832699.050a0220.6be26.fc8a@mx.google.com>
Date: Mon, 01 Jul 2024 14:58:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3731094880704115870=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/5] Bluetooth: hci_core: Remove usage of hci_req_sync
In-Reply-To: <20240701211538.1420913-1-luiz.dentz@gmail.com>
References: <20240701211538.1420913-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3731094880704115870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODY3Mjk5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgNi41NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjQxIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuNTIgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzAuNDAgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzMu
Mzggc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzkuMDQg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMTAzLjE0IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI5LjQxIHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDU0Mi4wMyBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyMC41OSBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICA0Mi4wMSBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA0Ljg2IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgRkFJTCAgICAgIDExNi4yNSBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA3LjgzIHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE1LjEyIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10
ZXN0ZXIgICAgICAgUEFTUyAgICAgIDguMDUgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVy
ICAgICAgICBQQVNTICAgICAgNi4wMCBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAg
ICAgIFBBU1MgICAgICA3LjM1IHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAg
UEFTUyAgICAgIDUuMTUgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBGQUlM
ICAgICAgNzUuMjQgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQ2hlY2tQYXRjaCAtIEZBSUwKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0
Ck91dHB1dDoKW3YxLDUvNV0gQmx1ZXRvb3RoOiBSZW1vdmUgaGNpX3JlcXVlc3Que2MsaH0KV0FS
TklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBu
ZWVkIHVwZGF0aW5nPwojMTkyOiAKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBl
cnJvcnMsIDEgd2FybmluZ3MsIDAgY2hlY2tzLCA2MSBsaW5lcyBjaGVja2VkCgpOT1RFOiBGb3Ig
c29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUgYWJsZSB0bwog
ICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZp
eCBvciAtLWZpeC1pbnBsYWNlLgoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy8xMzcxODY0Ny5w
YXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1l
c3NhZ2UgdHlwZXM6IFVOS05PV05fQ09NTUlUX0lECgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVycm9y
cyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0FsbFdhcm5pbmcgLSBXQVJOSU5HCkRlc2M6IFJ1
biBsaW51eCBrZXJuZWwgd2l0aCBhbGwgd2FybmluZyBlbmFibGVkCk91dHB1dDoKbmV0L2JsdWV0
b290aC9oY2lfY29yZS5jOiBJbiBmdW5jdGlvbiDigJhoY2lfaW5xdWlyeeKAmTpuZXQvYmx1ZXRv
b3RoL2hjaV9jb3JlLmM6MzIwOjc6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHRpbWVv4oCZIHNldCBi
dXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdICAzMjAgfCAgbG9uZyB0aW1l
bzsgICAgICB8ICAgICAgIF5+fn5+bmV0L2JsdWV0b290aC9oY2lfY29yZS5jOiBJbiBmdW5jdGlv
biDigJhoY2lfaW5xdWlyeeKAmTpuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6MzIwOjc6IHdhcm5p
bmc6IHZhcmlhYmxlIOKAmHRpbWVv4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1z
ZXQtdmFyaWFibGVdICAzMjAgfCAgbG9uZyB0aW1lbzsgICAgICB8ICAgICAgIF5+fn5+bmV0L2Js
dWV0b290aC9oY2lfY29yZS5jOiBJbiBmdW5jdGlvbiDigJhoY2lfaW5xdWlyeeKAmTpuZXQvYmx1
ZXRvb3RoL2hjaV9jb3JlLmM6MzIwOjc6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHRpbWVv4oCZIHNl
dCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdICAzMjAgfCAgbG9uZyB0
aW1lbzsgICAgICB8ICAgICAgIF5+fn5+bmV0L2JsdWV0b290aC9oY2lfY29yZS5jOiBJbiBmdW5j
dGlvbiDigJhoY2lfaW5xdWlyeeKAmTpuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6MzIwOjc6IHdh
cm5pbmc6IHZhcmlhYmxlIOKAmHRpbWVv4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1
dC1zZXQtdmFyaWFibGVdICAzMjAgfCAgbG9uZyB0aW1lbzsgICAgICB8ICAgICAgIF5+fn5+CiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1NwYXJzZSAtIFdBUk5JTkcK
RGVzYzogUnVuIHNwYXJzZSB0b29sIHdpdGggbGludXgga2VybmVsCk91dHB1dDoKbmV0L2JsdWV0
b290aC9oY2lfZXZlbnQuYzogbm90ZTogaW4gaW5jbHVkZWQgZmlsZSAodGhyb3VnaCBpbmNsdWRl
L25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCk6CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBDaGVja1NtYXRjaCAtIFdBUk5JTkcKRGVzYzogUnVuIHNtYXRjaCB0b29sIHdpdGgg
c291cmNlCk91dHB1dDoKbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYzogbm90ZTogaW4gaW5jbHVk
ZWQgZmlsZSAodGhyb3VnaCBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCk6CiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX21nbXQtdGVzdGVyIC0g
RkFJTApEZXNjOiBSdW4gbWdtdC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6ClRvdGFs
OiA0OTIsIFBhc3NlZDogNDg5ICg5OS40JSksIEZhaWxlZDogMSwgTm90IFJ1bjogMgoKRmFpbGVk
IFRlc3QgQ2FzZXMKTEwgUHJpdmFjeSAtIEFkZCBEZXZpY2UgNCAoMiBEZXZpY2VzIHRvIEFMKSAg
ICAgICAgICBGYWlsZWQgICAgICAgMC4xNjggc2Vjb25kcwojIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAtIEZBSUwKRGVzYzogSW5jcmVtZW50YWwg
YnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzCk91dHB1dDoKW3YxLDQvNV0gQmx1
ZXRvb3RoOiBoY2lfc3luYzogUmVtb3ZlIHJlbWFpbmluZyBkZXBlbmRlbmNpZXMgb2YgaGNpX3Jl
cXVlc3QKCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NDM6
Cm5ldC9ibHVldG9vdGgvaGNpX3JlcXVlc3QuaDozMjo4OiBlcnJvcjogcmVkZWZpbml0aW9uIG9m
IOKAmHN0cnVjdCBoY2lfcmVxdWVzdOKAmQogICAzMiB8IHN0cnVjdCBoY2lfcmVxdWVzdCB7CiAg
ICAgIHwgICAgICAgIF5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUv
bmV0L2JsdWV0b290aC9oY2lfY29yZS5oOjM0LAogICAgICAgICAgICAgICAgIGZyb20gbmV0L2Js
dWV0b290aC9oY2lfY29yZS5jOjM5OgouL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfc3luYy5o
OjE4Ojg6IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCiAgIDE4IHwgc3RydWN0IGhjaV9y
ZXF1ZXN0IHsKICAgICAgfCAgICAgICAgXn5+fn5+fn5+fn4KbWFrZVs0XTogKioqIFtzY3JpcHRz
L01ha2VmaWxlLmJ1aWxkOjI0NDogbmV0L2JsdWV0b290aC9oY2lfY29yZS5vXSBFcnJvciAxCm1h
a2VbM106ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0ODU6IG5ldC9ibHVldG9vdGhdIEVy
cm9yIDIKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ4NTogbmV0XSBFcnJv
ciAyCm1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2VbMV06
ICoqKiBbL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy9NYWtlZmlsZToxOTM0OiAuXSBFcnJvciAy
Cm1ha2U6ICoqKiBbTWFrZWZpbGU6MjQwOiBfX3N1Yi1tYWtlXSBFcnJvciAyCgoKLS0tClJlZ2Fy
ZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============3731094880704115870==--
