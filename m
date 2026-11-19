Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113263;
	b=QO5arhaSTp5lYbaGZuuX8SLDVqjITM48GWd3pMb5fmzAMRwO0uP/SKf7KESWnUGLO+zp
	 43Xz4hi3IHcbuOG7emhYFn5jRl/BFEdEqh4IvBdyDa5h0Qu0mrW8ji/uZ3D5E1ImG6Puf
	 JgegoMjnXB62M/LjFfB8LlwveHWfo9N5I/KtIFbHpqThtWdQZW/r06LOPX3Oin9YwWJ8d
	 IW3/vRz8PyGr8caadYsSAQi/qUJq57WNOVaZBLiCqpPLZa97+p+kU6pvQJ8saACmfYgRq
	 coue1inZdBCqLmW3T784Ml9G4EVRQywX3zxE7lVdIb6sirg7nAoxQBbMLTWB00GfghQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=dzZ66NqAnwniAYLfvKACARoSji1Hxsh0WH/2V8WWMz0=;
	b=CfzlDa3fV4pddivG0/bdZogNj+Lqm2wkZ2O7WvOG4+IYp6fFEQRuoJ2Vt5z8gS212/Pt
	 anhOiowNX19SwNlQedaLPYmps34X23BMJb8hzC6pKkGwMUAIdLWyALBH6xuvto00jSXvs
	 UAlIOksZcPnIyjkC0G3xbW/Gn8qAAvY2CtlZZA63VwUTe2Lrho5t8GU4PnBE+X1frPAo2
	 TlGMwO7qMYbJqDszi4WNvqPHge43da3IOSb+FfS8cVRlJ6OJ/Cm+N3H2s1fBAfY0sU4Fs
	 GBzulaCPNZWKqZzLXLEBY4EESme02saKMKiFajBJIQF15Bz7l85ksG8URxe9LbTS94g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqRguPNF;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1C606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 18:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E1C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqRguPNF
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso1341336d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 10:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795113262; x=1795718062; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dzZ66NqAnwniAYLfvKACARoSji1Hxsh0WH/2V8WWMz0=;
        b=VqRguPNF1+nibv4HC/BYuFvk90IaHoeMiy9a65C9fwihf2R/o0mbxuUSXW+Y3XI1X+
         2pyECqtIJOLbkjtiRcrbl2Ze7owjtSys8PHX7oU3zYkVfaSG6hkpJ/phT1ZxxV6bIqqc
         M9fFya6e5yG7LJlBxvH7h8MMM/dPEFdgZ91UI9FDBDwg77/jicv88+WCG011RYFl232Z
         aiR8Lh5uyrndZsa9Y8aPi8vxmnB5EqMOX5JjblhleVSXlmrhk86O2lucrJUmYlY+W2E5
         2wW54m95NgOsl9L299c9Ps13ZXKsTNGUSJsl66d+MBExDK6fI+tKO9aTOvzZuY+PH+5E
         tiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113262; x=1795718062;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dzZ66NqAnwniAYLfvKACARoSji1Hxsh0WH/2V8WWMz0=;
        b=nzZFcytr/1fX6ntBXa+z4NucvXCZu3GLp6bDY31kh2BvJ41T94Vs01/4Vw0gjQafVZ
         cjV0jE/ug3L3EAgcGdc+C5s0IPV84uhMEHQ9N/asaEPZD/Q/FxmawWArtJjzZUur33+o
         KuWd7iVPq0NirraDeYRPqscV5fZai7Ur+ub2Q6rUROftT1u1GzW7i72/mMzkGYqocQbK
         ZRHXhJspo938X81W6C7eb9IhcYnnU+7h3IVe0mV5GXpjpm2GqV2okXZ2favO6+bXJmsz
         F8m0x4nkDn5AEIcfGwOWgIph7OVGZU0MXIHLejyfLU7LICW2wBLJX1yDjJ0bq7E1c09W
         HXlQ==
X-Gm-Message-State: APuU4Z8nG8BF2kIrnKE4YS1YPlqiCTnu/1a4WT3Urz1S6ObKyPx4bxI2
	KbgEWOjaTx6bfkhQhxmvEYCnAVaj7y48UaZte9IdLd4ukENQmE1Y3QosMjwwZQ==
X-Gm-Gg: AZFdTZfCUc2auNGDfzJW8620oKgNJtacFlrRu+kTP+9lt8JR0pfCGWqcecP2kSg7YcX
	ibC7TN/HweB9wjj7qA3Lio8RuL1TCaIKYGnIBx0Y28FwEQRhM7eEzT1x0A2A6A2WDvmooBvnKK9
	BUvjLqAq/hmXsLDTsRAW+4m0MVC8zPphEBV4xw6McgD6x4JmMETH3/lCYHmZ/rsm82o0TqWBlMW
	UxqVQqCuG+rHeiGGABgRsMX7PaB8TU6iNswjNoP7mR8TdBWF+58Tsm8aIdbJ6HAkSpn3VCdOyW7
	NIr7fO18uCU8YWecGVJV2AyT44nT9DNCrW1QVQJBdDmZOqwEy+ShdE6s9DB9TmO2hKEH7Sas1eI
	6D9PsDbWwuzisHXsjel+DNCjCGbDqkzaay86hW4rjxDBHFPDMIoqYNtCnylL701nxmm5YLLSCOR
	A1ITmOMlqCP99O1X/VlUwiK4/bM6WpoiqekypqxgVXDwDloHeCgrQTvVm+AHEFXJr8Cxlrbsk23
	uDY6UfrTAQG10E8KJg0IZUz2lT4mdH4sIfv5S6vvB34zJ8lY3uxkTli5+G4MUwKSbkfmMDm5W62
	oCfKwmoCpoWhlY4jl/bdqFrglGth
X-Received: by 2002:a05:6214:5298:b0:921:2427:ac08 with SMTP id 6a1803df08f44-92134a37147mr8457886d6.11.1795113261657;
        Thu, 19 Nov 2026 10:34:21 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-70.compute-1.amazonaws.com. [3.41.210.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f2186sm5446336d6.29.2026.11.19.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 10:34:21 -0800 (PST)
Message-ID: <6aff412d.7970f310.ab4a9.ad39@mx.google.com>
Date: Thu, 19 Nov 2026 10:34:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1702897154376812675=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Channel Sounding and RAP fixes
In-Reply-To: <20261119171625.1014004-2-luiz.dentz@gmail.com>
References: <20261119171625.1014004-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1702897154376812675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9zZXJpZXMvMTIxNjQ2MC8KCi0tLVRlc3QgcmVzdWx0LS0tCgpUZXN0IFN1
bW1hcnk6CkNoZWNrUGF0Y2ggICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA3LjIxIHNlY29u
ZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDQuOTcgc2Vjb25kcwpC
dWlsZEVsbCAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTMuNzQgc2Vjb25kcwpCbHVl
ek1ha2UgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjA1LjE2IHNlY29uZHMKTWFrZUNo
ZWNrICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDEyLjU0IHNlY29uZHMKTWFrZURpc3Rj
aGVjayAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDEwMy44OCBzZWNvbmRzCkNoZWNrVmFsZ3Jp
bmQgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyNDkuNjcgc2Vjb25kcwpDaGVja1NtYXRjaCAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTgyLjMzIHNlY29uZHMKYmx1ZXptYWtlZXh0ZWxs
ICAgICAgICAgICAgICAgUEFTUyAgICAgIDY1LjIwIHNlY29uZHMKVGVzdEZ1bmN0aW9uYWwgICAg
ICAgICAgICAgICAgRkFJTCAgICAgIDk0OS40MSBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAg
ICAgICAgICAgIFBBU1MgICAgICAzMjIuOTUgc2Vjb25kcwpTY2FuQnVpbGQgICAgICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgNzAwLjI2IHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBGQUlMCkRlc2M6IFJ1biBnaXRsaW50Ck91
dHB1dDoKW0JsdWVaLHYzLDAzLzE2XSBzaGFyZWQvcmFwOiBTdWJzY3JpYmUgb24tZGVtYW5kIGRh
dGEgd2l0aCB0aGUgcmVxdWVzdGVkIHRyYW5zcG9ydAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXgg
bGVuZ3RoICg4Mj44MCk6ICJbQmx1ZVosdjMsMDMvMTZdIHNoYXJlZC9yYXA6IFN1YnNjcmliZSBv
bi1kZW1hbmQgZGF0YSB3aXRoIHRoZSByZXF1ZXN0ZWQgdHJhbnNwb3J0IgpbQmx1ZVosdjMsMDgv
MTZdIHByb2ZpbGVzL3Jhbmdpbmc6IExldCBTdGFydE1lYXN1cmVtZW50KCkgcGljayB0aGUgSW5p
dGlhdG9yIGZvciBCb3RoCgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTog
IltCbHVlWix2MywwOC8xNl0gcHJvZmlsZXMvcmFuZ2luZzogTGV0IFN0YXJ0TWVhc3VyZW1lbnQo
KSBwaWNrIHRoZSBJbml0aWF0b3IgZm9yIEJvdGgiCltCbHVlWix2MywxMi8xNl0gcHJvZmlsZXMv
cmFuZ2luZzogRGVmZXIgQ1MgU2VjdXJpdHkgRW5hYmxlIHVudGlsIHRoZSBsaW5rIGlzIGVuY3J5
cHRlZAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4Nz44MCk6ICJbQmx1ZVosdjMs
MTIvMTZdIHByb2ZpbGVzL3Jhbmdpbmc6IERlZmVyIENTIFNlY3VyaXR5IEVuYWJsZSB1bnRpbCB0
aGUgbGluayBpcyBlbmNyeXB0ZWQiCltCbHVlWix2MywxMy8xNl0gcHJvZmlsZXMvcmFuZ2luZzog
Q2hvb3NlIHRoZSBDUyBhbnRlbm5hIGNvbmZpZ3VyYXRpb24gZnJvbSBib3RoIGVuZHMKCjE6IFQx
IFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODU+ODApOiAiW0JsdWVaLHYzLDEzLzE2XSBwcm9m
aWxlcy9yYW5naW5nOiBDaG9vc2UgdGhlIENTIGFudGVubmEgY29uZmlndXJhdGlvbiBmcm9tIGJv
dGggZW5kcyIKW0JsdWVaLHYzLDE0LzE2XSBwcm9maWxlcy9yYW5naW5nOiBEbyBub3Qgc3RhcnQg
YSBwcm9jZWR1cmUgYWZ0ZXIgU3RvcE1lYXN1cmVtZW50KCkKCjE6IFQxIFRpdGxlIGV4Y2VlZHMg
bWF4IGxlbmd0aCAoODM+ODApOiAiW0JsdWVaLHYzLDE0LzE2XSBwcm9maWxlcy9yYW5naW5nOiBE
byBub3Qgc3RhcnQgYSBwcm9jZWR1cmUgYWZ0ZXIgU3RvcE1lYXN1cmVtZW50KCkiCltCbHVlWix2
MywxNS8xNl0gc2hhcmVkL3JhcDogU3RhcnQgdGhlIFJlYWwtdGltZSB0aW1lb3V0IHdoZW4gdGhl
IHByb2NlZHVyZSBzdGFydHMKCjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODI+ODAp
OiAiW0JsdWVaLHYzLDE1LzE2XSBzaGFyZWQvcmFwOiBTdGFydCB0aGUgUmVhbC10aW1lIHRpbWVv
dXQgd2hlbiB0aGUgcHJvY2VkdXJlIHN0YXJ0cyIKW0JsdWVaLHYzLDE2LzE2XSB1bml0L3Rlc3Qt
cmFwOiBBZGQgdGVzdHMgZm9yIFJhbmdpbmcgRGF0YSBzdWJzY3JpcHRpb24gYW5kIGNvdW50ZXJz
CgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg0PjgwKTogIltCbHVlWix2MywxNi8x
Nl0gdW5pdC90ZXN0LXJhcDogQWRkIHRlc3RzIGZvciBSYW5naW5nIERhdGEgc3Vic2NyaXB0aW9u
IGFuZCBjb3VudGVycyIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VD
aGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVszXTog
KioqIFtNYWtlZmlsZToxMDQzNjogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioq
IFtNYWtlZmlsZToxMDU3MTogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtl
ZmlsZToxMTA3NDogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMTA3Njog
Y2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
VmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3JpbmQK
T3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9v
bHMvbWdtdC10ZXN0ZXIuYzoxNDUxODo1OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxp
bWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5
aW5nIHdpdGhvdXQKMTQ1MTggfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAg
ICB8ICAgICBefn5+Cm1ha2VbM106IHdhcm5pbmc6IC1qNCBmb3JjZWQgaW4gc3VibWFrZTogcmVz
ZXR0aW5nIGpvYnNlcnZlciBtb2RlLgptYWtlWzNdOiAqKiogW01ha2VmaWxlOjEwNDM2OiB0ZXN0
LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEwNTcxOiBjaGVjay1U
RVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxlOjExMDc0OiBjaGVjay1hbV0gRXJy
b3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjExMDc2OiBjaGVja10gRXJyb3IgMgojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdEZ1bmN0aW9uYWwgLSBGQUlMCkRlc2M6IFJ1
biB0ZXN0LWZ1bmN0aW9uYWwKT3V0cHV0OgpGQUlMIGZ1bmN0aW9uYWwudGVzdF9iYXA6OnRlc3Rf
YmFzc19wYXN0X2VhcmJ1ZHNfdHJhbnNwb3J0X2FjcXVpcmVbaG9zdHMxMS12bTNdOiBBc3NlcnRp
b25FcnJvcjogRmFpbGVkIHRvIGFjcXVpcmU6IG9yZy5ibHVlei5FcnJvci5GYWlsZWQKCgpodHRw
czovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovcHVsbC8yODUyCgotLS0KUmVnYXJkcywKTGludXgg
Qmx1ZXRvb3RoCgo=

--===============1702897154376812675==--
