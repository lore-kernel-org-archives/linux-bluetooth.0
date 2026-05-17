Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22243382DE
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779055533; cv=none; b=tRlGVaHFlF7jr4xQgqGB44d1/yO6zDkq/Of//jxBhRsbiJZn50WU8ZitvGAJxwTkg+nRI01sdBizWrm4DJvI+gfSLD7dGv1Ov1KOG+uMLP0f+1lEyf1CRIpyOxYQnSsaaax3aMFMpHAHwhfSaL6IQMTg9aUBv5/WaxL9yCiIvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779055533; c=relaxed/simple;
	bh=sj44hc8TKLafhcGNS/WbGYZnLmOlPDEwM1xWkZcs3DQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XrQ7CJgCjwueO22veAS4Jmej1fzrkGqZdz+c+QgGbE1kf7wR7pbNaufpjeK/vXTy3bmPqN9oq+0tBGPJmum2QGmreENsrhHRkICNqnrA++1UAK2e9e0D1yk02xNVK3UJvMwD/wz7+NS7cL1CjqBHRmxk1+zJTXZXCUaT4LMQNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb5J4IGb; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb5J4IGb"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651c366f7efso1762198d50.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779055529; x=1779660329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sj44hc8TKLafhcGNS/WbGYZnLmOlPDEwM1xWkZcs3DQ=;
        b=Lb5J4IGbopC04VXRKFdI0LPISO6W39FDgXoH/md3u5b8OdtHaD8cZ+tjPILWKuvBCF
         ZZ0vE7B1QrYnp3R+xiCBQMCfJmBVUfn+wrrW+J70rUPrhSjQHGhMy2Y/eVFCTp4VYzuG
         2foGyUpTvOnvQGAXIq+OQG8EQD2tp36y6MRtfKjWhhERp3iQiZ1gYSUtvA+9OXiPp+gC
         f18vPQ1TPrJnnAlRY2bqHNZ+FHCpHZwldo0mBP8DFsWf9lFkhKnkuYgMORtfnYtaT1HZ
         la90jgBJREkPCSsfUeeWdgLcBFZJCyi8Gy+jcoXNaXxJaMt6OVPkzXSzU4r1IUT/qs1l
         pk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779055529; x=1779660329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj44hc8TKLafhcGNS/WbGYZnLmOlPDEwM1xWkZcs3DQ=;
        b=GxWa36qQI0qMAyZkKUqwghWfeOCuCdpaHWqXXSP8Y5FHhMZ2MHEKs0dRCJo5afXBF/
         rWM5Of4La2jXEyh+h/7XfSF5tl5+7tQBdy3M0mK3dN2Z5gMKjqxOGTl2pjcEoau4wJiR
         w1tM3rofGWwDiVCqgdQHiicqwVoxjsFVNTvJ+S5/gJh/a/VF+PffsciFcSysX8OZeUcI
         fwI5tYhUiUTfdUGD+FSuDHnM5aZVX+jJjnPmsCDQyscqOvwcsSlV1KIN7aN2kUREKofq
         lXmQy4H1nFJ4U0336k4cePuNrUxJHBxzgInVbH37m6dYB1CynOQZUl4+kdsq1YuLr9GO
         Yqwg==
X-Gm-Message-State: AOJu0YxjJOTk7+Ehh/6LRKDMFq1Wpl4lyOSndLA/vqnEF9+CK7slRmDA
	xnXBJiF2bIsVn90u1fv4Lo9eQvJ8RKThqr5QfhLuWy9nTFv3y7ymKJ8TCj7BhA==
X-Gm-Gg: Acq92OEdUuV0uSe5ANM4OowPSV1MEqvywDJBUbXTcibO8RLhMYpYhw6ujKL4SEuBE3w
	O7AUPsapzaErYOUSh8hq4Yfb52Czg7LGygXO69mFJSnnEdBWi4/QbuGF69IHuua3d6ZHXPkme+L
	V1X/4vHfgxrG94DrAwVoPXqPBLmF63sN0KIsza/uNk6bcaS15vSDfWa2Lsfg8o2v95Mpalm/7P4
	CXGQmdc9VczWGuMEsKUggUcQGCmHwGFxt/1FnvzfFg253LqKhxpfjBhfkc7A3+SKi81E3HmFj2M
	jnD4MISSRq5hvLIkSMJbtD69s+PMSO/6CrKoYmSXKPKnmv6Y6FfMXRQ02o5iiWmAk+nZvmWCxJj
	Zs4QqxJUpWbNjXjban7MFMRM3bIEdaRY43weP6O2N2Z2Bl9cX2OOeOyvr/WPFjY2C6p8j1f69LY
	qRdLRnxDoPez13UvTtXdujQgCNzgn9z9A=
X-Received: by 2002:a05:690e:2504:10b0:65e:1d95:29da with SMTP id 956f58d0204a3-65e22847153mr10226600d50.32.1779055529049;
        Sun, 17 May 2026 15:05:29 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.153.145])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0dbd1031sm5621069d50.20.2026.05.17.15.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 15:05:28 -0700 (PDT)
Message-ID: <6a0a3ba8.09f534dc.1da071.8352@mx.google.com>
Date: Sun, 17 May 2026 15:05:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8950354186449136063=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tester.config: add missing CRYPTO_AES
In-Reply-To: <478a4d370bc0b20b98223507166dfd580ae8477d.1779051031.git.pav@iki.fi>
References: <478a4d370bc0b20b98223507166dfd580ae8477d.1779051031.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8950354186449136063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTA5NjE4MQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgRkFJTCAgICAgIDAuNDAgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBG
QUlMICAgICAgMC4zMCBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAyMC43NiBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA2NTguNDcgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTguNDQgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjI4
LjM1IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI5My4w
OSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTAuMzMg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTgyLjA4IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDY0NS4zNCBzZWNv
bmRzClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMDE4LjI2IHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0
Y2ggLSBGQUlMCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdApPdXRwdXQ6CltCbHVlWl0g
dGVzdGVyLmNvbmZpZzogYWRkIG1pc3NpbmcgQ1JZUFRPX0FFUwpXQVJOSU5HOlVOS05PV05fQ09N
TUlUX0lEOiBVbmtub3duIGNvbW1pdCBpZCAnNGExNTA3NjI1YjAnLCBtYXliZSByZWJhc2VkIG9y
IG5vdCBwdWxsZWQ/CiM4MTogCktlcm5lbCBjb21taXQgNGExNTA3NjI1YjAgKCJCbHVldG9vdGg6
IFNNUDogVXNlIEFFUy1DTUFDIGxpYnJhcnkKCi9naXRodWIvd29ya3NwYWNlL3NyYy9wYXRjaC8x
NDU3NzY0OC5wYXRjaCB0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDIxIGxpbmVzIGNoZWNr
ZWQKCk5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1h
eSBiZSBhYmxlIHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0
eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMv
cGF0Y2gvMTQ1Nzc2NDgucGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LgoK
Tk9URTogSWdub3JlZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVYX01BQ1JP
IENPTlNUX1NUUlVDVCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBSRUZFUl9Q
QUNLRUQgU1BEWF9MSUNFTlNFX1RBRyBTUExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJUTwoKTk9U
RTogSWYgYW55IG9mIHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNlIHJlcG9y
dAogICAgICB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIEZB
SUwKRGVzYzogUnVuIGdpdGxpbnQKT3V0cHV0OgpbQmx1ZVpdIHRlc3Rlci5jb25maWc6IGFkZCBt
aXNzaW5nIENSWVBUT19BRVMKCldBUk5JTkc6IEkzIC0gaWdub3JlLWJvZHktbGluZXM6IGdpdGxp
bnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1c2luZyBQeXRob24gcmVnZXggJ21hdGNoJyAobWF0
Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAobWF0Y2ggYW55d2hlcmUpIHNlbWFudGljcy4gUGxl
YXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5LWxpbmVzLnJlZ2V4IG9wdGlvbiBhY2NvcmRpbmds
eS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywgc2V0IGdlbmVyYWwucmVnZXgtc3R5bGUtc2VhcmNo
PVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6Ly9qb3Jpc3Jvb3ZlcnMuZ2l0aHViLmlvL2dpdGxp
bnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2VhcmNoCjI2OiBCMiBMaW5lIGhhcyB0cmFp
bGluZyB3aGl0ZXNwYWNlOiAiICAgICIKMjg6IEIyIExpbmUgaGFzIHRyYWlsaW5nIHdoaXRlc3Bh
Y2U6ICIgICAgIgozMDogQjIgTGluZSBoYXMgdHJhaWxpbmcgd2hpdGVzcGFjZTogIiAgICAiCjMx
OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTE1PjgwKTogIiAgICBodHRwczovL2dpdGh1
Yi5jb20vYmx1ZXovYmx1ZXRvb3RoLW5leHQvY29tbWl0Lzg0ZWJkZTZmODE5YzA2Y2MxZDgwNGE0
NzFkOWZiNjBiNzk4NmUxOTAvY2hlY2tzLzc2NDA4OTIwMjIxL2xvZ3MiCjMyOiBCMiBMaW5lIGhh
cyB0cmFpbGluZyB3aGl0ZXNwYWNlOiAiICAgICIKMzM6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVu
Z3RoICgxMTU+ODApOiAiICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9ibHVlei9ibHVldG9vdGgtbmV4
dC9jb21taXQvODJmMGUwYzdkMDhlYjIxZDA1Nzk0NzFhM2I1YzAwNGNmOTVkZGEwOC9jaGVja3Mv
NzU4NjI0NjQwNjUvbG9ncyIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2VDaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVsz
XTogKioqIFtNYWtlZmlsZToxMDIzOTogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTog
KioqIFtNYWtlZmlsZToxMDM0NzogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtN
YWtlZmlsZToxMDgxODogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMDgy
MDogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2VEaXN0Y2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIERpc3RjaGVjawpPdXRwdXQ6
CgptYWtlWzRdOiAqKiogW01ha2VmaWxlOjEwMjM5OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQpt
YWtlWzNdOiAqKiogW01ha2VmaWxlOjEwMzQ3OiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzJd
OiAqKiogW01ha2VmaWxlOjEwODE4OiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFdOiAqKiogW01h
a2VmaWxlOjEwODIwOiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEwNzQxOiBk
aXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENo
ZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3Jp
bmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToK
dG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjk5MDo1OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXpl
IGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJl
dHJ5aW5nIHdpdGhvdXQKMTI5OTAgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQog
ICAgICB8ICAgICBefn5+Cm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTAyMzk6IHRlc3Qtc3VpdGUu
bG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTAzNDc6IGNoZWNrLVRFU1RTXSBF
cnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTA4MTg6IGNoZWNrLWFtXSBFcnJvciAyCm1h
a2U6ICoqKiBbTWFrZWZpbGU6MTA4MjA6IGNoZWNrXSBFcnJvciAyCgoKaHR0cHM6Ly9naXRodWIu
Y29tL2JsdWV6L2JsdWV6L3B1bGwvMjEzMQoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============8950354186449136063==--
