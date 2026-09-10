Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257EA57D210
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067308; cv=none; b=OFL+mM4H2kRdapP33z/az3jRnQz2juOgACjvz5S61uxiVVCU/TkEF6xGuQNgwsj3SsMGYPnIoprAr/ltK1Hvwn9MsRexvkm/GObKFOLIpkIcnaKz7654C8uDo+ExgoQ+pOU50F3k7ImXpQhgN1ne5lemixBaXRQsG/TV6FIf/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067308; c=relaxed/simple;
	bh=LQ5aWYgbSy/mOCJJ53jrqVbw/kTJfkW6ffVVGf/XtlM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eyaXtRswtThIHFbStmcOj/ULnKJ5FEjEboIl2VRh6mReYgFImfRWb+oIp4o32m5yJedR8WkY7qFhfQ6xu7CbIX2rshkHuoGgRYirdSKsdawMOh15lQM232HlFmRfMELRQeWpsGYNWmR69y7VPzyN6CRRr3cnohdIm9dCfl8Ah5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbvruQjF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbvruQjF"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so88576a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789067306; x=1789672106; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LQ5aWYgbSy/mOCJJ53jrqVbw/kTJfkW6ffVVGf/XtlM=;
        b=RbvruQjFpZY378/bPpx0BTj7B4Kdh98gUP8W6/2/o73JeILP42/vC6aoPFSgrp+fRn
         McXg1nqe5JSnAciKo+WzNyOQeUV/VvQ8Fv7YCqT1JIP3PBcG6kHSHitY4H1jvsgOAUpu
         zjCSYxkHl4yeATQPknAizkb5LOzR/Fnyt8IxqAgqfTGNgO9p2h6RpB4PgikEQrozbK4e
         mm/XDQCG6xmd1GE9Kw/Y37+O6z6TYLcrJe6VOflhXfIEiOyGqs7omQDz9GwP24NH+Vms
         s/5EF/TV72Kjy4ZBok+ZcVjUk9uxfKCEJj7xB4sEjBwti60ixN+kIjwD8o2/4iNVqIH5
         AdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789067306; x=1789672106;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LQ5aWYgbSy/mOCJJ53jrqVbw/kTJfkW6ffVVGf/XtlM=;
        b=azIXls2k/QDFCkCpkiDCZf/9Ktbv251ji+YzVdJHdKgGff5a9NwRUg8lMreC5KvrOr
         /VcfFjMdopX/ITuaQmHYxyUTdt/0unknRXDBkmhQUx4rO8A29HJuTRmsMCMkumvt/hCT
         MX/bvAAS6+ajapcmJSIXS0mAyrsyhY7yfUzv8e+Do+U0RXBh9+swg9aPpT6tHH6ljDl6
         kcM2IJP1kYnNiqoMLT0WhbsQ45ESBKIKfEEKBo7McqOfqQ9b7pIFZq442X/GJRjK9d3I
         2uuFF0MEHQa6r3BBPATkUytSvWj0BxGRK3UPAAFqbN3d9zgjzG+TuQnzTBmBLf2wD9IX
         kwGw==
X-Gm-Message-State: AFuF++lYCtU4OtpUE+Y1u3Bzodk/FIvIZbC0kmTVE4w27V9pKYIfDB98
	nOYJ7qJTW7pdEZcHVAP8icZyR+caPUxzc5jTOx0Zfu7XUKaO7MRbnu9x4k7knA==
X-Gm-Gg: AYBFou1h3Ue+XfUsFYhfQBQl6noApWHOeTrrbrUsyEyyqAKOR1/OKRecqputBFtH9Hr
	+OmrLEiyQsTlUIG8SShYkK9N5sfkA8RVrzTfbubqw5YP9OJf2wk7Vou6VD8/7Uvn9zZIj9wbJ4F
	hae6Ry95jskmlaZsNGOj/epEu1aFrB+7q+kkFp2g3Kq2J4vf9Rmhj+dkVosf0PlDay7FOna+yW6
	IRB3F48xIoy5aX2tkJOE158ohuExuApIlPJALwOaspZNhTRV7KaBMeJ8lCNAJpUQrY3InuPsXj1
	o0YAzYJCHKBH7hbyip98NQY9IkTXjVLcVGDco4sOrF6jz9RS7v5hV1eRcY5zCuWxekaiZWkRKoa
	Nepl7i7og/ASW+fq++93EiGEoRSvuq9gaL2kioXwR715P2lZH0jpWJXOOedMRaDYNsd7EjRfsrM
	DJWoQJjMULuDqa7H5KlYeDcnY3Tj4/ZYi2YsCxcoixYLUnMlJGYjBTGMD6TL+pL9R1j5THXuOJp
	+oOVaA=
X-Received: by 2002:a17:90b:57e6:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-39d9bec3f25mr235511a91.9.1789067306151;
        Thu, 10 Sep 2026 12:08:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.159.167])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9b359sm104655eec.14.2026.09.10.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:08:22 -0700 (PDT)
Message-ID: <6aa30026.beccbaf7.219350.7679@mx.google.com>
Date: Thu, 10 Sep 2026 12:08:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2347825193469141995=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, uldixxion@gmail.com
Subject: =?utf-8?q?RE=3A_MT7925_=280e8d=3A0717=29=3A_HFP_microphone_unusable_=E2=80=94_firmware_delivers_zero-filled_=28e=29SCO_frames_on_sentinel_handle_0x0E00?=
In-Reply-To: <CAPCBbk7t6OKtOGynNhf6oGnxGrSEqkh-SfweO_Yfms5NXDSCZQ@mail.gmail.com>
References: <CAPCBbk7t6OKtOGynNhf6oGnxGrSEqkh-SfweO_Yfms5NXDSCZQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2347825193469141995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9zZXJpZXMvMTE1MTExOS8KCi0tLVRlc3QgcmVzdWx0LS0tCgpUZXN0IFN1
bW1hcnk6CkNoZWNrUGF0Y2ggICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyLjQ3IHNlY29u
ZHMKVmVyaWZ5Rml4ZXMgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDAuMDYgc2Vjb25kcwpW
ZXJpZnlTaWduZWRvZmYgICAgICAgICAgICAgICBQQVNTICAgICAgMC4zOCBzZWNvbmRzCkdpdExp
bnQgICAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxLjg2IHNlY29uZHMKU3ViamVjdFBy
ZWZpeCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDAuMDUgc2Vjb25kcwpCdWlsZEtlcm5lbCAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjkuMDMgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcg
ICAgICAgICAgICAgICBQQVNTICAgICAgMzMuNzEgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAg
ICAgICAgICAgICBQQVNTICAgICAgMzUuNzYgc2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgMjkuMjcgc2Vjb25kcwpDaGVja0tlcm5lbExMVk0gICAgICAgICAg
ICAgICBQQVNTICAgICAgMzIuOTkgc2Vjb25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAg
ICBQQVNTICAgICAgNzc5LjAwIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAg
UEFTUyAgICAgIDI2Ljc5IHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBGQUlMCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNj
cmlwdApPdXRwdXQ6Ck1UNzkyNSAoMGU4ZDowNzE3KTogSEZQIG1pY3JvcGhvbmUgdW51c2FibGUg
4oCUIGZpcm13YXJlIGRlbGl2ZXJzIHplcm8tZmlsbGVkIChlKVNDTyBmcmFtZXMgb24gc2VudGlu
ZWwgaGFuZGxlIDB4MEUwMApFUlJPUjogSW52YWxpZCBjb21taXQgc2VwYXJhdG9yIC0gc29tZSB0
b29scyBtYXkgaGF2ZSBwcm9ibGVtcyBhcHBseWluZyB0aGlzCiMxMjA6IAotLS0tLS0tLS0tLS0t
LS0tLS0tCgpFUlJPUjogSW52YWxpZCBjb21taXQgc2VwYXJhdG9yIC0gc29tZSB0b29scyBtYXkg
aGF2ZSBwcm9ibGVtcyBhcHBseWluZyB0aGlzCiMxMzU6IAotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CgpFUlJPUjogSW52YWxpZCBjb21taXQgc2VwYXJhdG9yIC0gc29tZSB0b29scyBtYXkgaGF2ZSBw
cm9ibGVtcyBhcHBseWluZyB0aGlzCiMxNTA6IAotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KCkVSUk9SOiBJbnZhbGlkIGNvbW1pdCBzZXBhcmF0b3IgLSBzb21lIHRvb2xzIG1heSBo
YXZlIHByb2JsZW1zIGFwcGx5aW5nIHRoaXMKIzE3ODogCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQoKRVJST1I6IEludmFsaWQgY29tbWl0IHNlcGFyYXRvciAtIHNvbWUgdG9vbHMg
bWF5IGhhdmUgcHJvYmxlbXMgYXBwbHlpbmcgdGhpcwojMjA4OiAKLS0tLS0tLS0tLS0tLS0tLS0t
LS0KCldBUk5JTkc6IFByZWZlciBhIG1heGltdW0gNzUgY2hhcnMgcGVyIGxpbmUgKHBvc3NpYmxl
IHVud3JhcHBlZCBjb21taXQgZGVzY3JpcHRpb24/KQojMjY0OiAKMDk6MDAuMCBOZXR3b3JrIGNv
bnRyb2xsZXIgWzAyODBdOiBNRURJQVRFSyBDb3JwLiBNVDc5MjUgKFJaNzE3KSBXaS1GaSA3IDE2
ME1IeiBbMTRjMzowNzE3XQoKRVJST1I6IEF2b2lkIHVzaW5nIGRpZmYgY29udGVudCBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UgLSBwYXRjaCgxKSBtaWdodCBub3Qgd29yawojMjcxOiAKLS0tIGEvZHJp
dmVycy9ibHVldG9vdGgvYnR1c2IuYwoKRVJST1I6IEludmFsaWQgY29tbWl0IHNlcGFyYXRvciAt
IHNvbWUgdG9vbHMgbWF5IGhhdmUgcHJvYmxlbXMgYXBwbHlpbmcgdGhpcwojMjcxOiAKLS0tIGEv
ZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYwoKRVJST1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTog
bGluZShzKQoKdG90YWw6IDggZXJyb3JzLCAxIHdhcm5pbmdzLCA0NiBsaW5lcyBjaGVja2VkCgpO
T1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUg
YWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1
c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3BhdGNo
LzE0NzY2MDMxLnBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6
IElnbm9yZWQgbWVzc2FnZSB0eXBlczogVU5LTk9XTl9DT01NSVRfSUQKCk5PVEU6IElmIGFueSBv
ZiB0aGUgZXJyb3JzIGFyZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBGQUlMCkRlc2M6IFJ1
biBnaXRsaW50Ck91dHB1dDoKTVQ3OTI1ICgwZThkOjA3MTcpOiBIRlAgbWljcm9waG9uZSB1bnVz
YWJsZSDigJQgZmlybXdhcmUgZGVsaXZlcnMgemVyby1maWxsZWQgKGUpU0NPIGZyYW1lcyBvbiBz
ZW50aW5lbCBoYW5kbGUgMHgwRTAwCgoxOiBDQzEgQm9keSBkb2VzIG5vdCBjb250YWluIGEgJ1Np
Z25lZC1vZmYtYnknIGxpbmUKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMTU+ODAp
OiAiTVQ3OTI1ICgwZThkOjA3MTcpOiBIRlAgbWljcm9waG9uZSB1bnVzYWJsZSDigJQgZmlybXdh
cmUgZGVsaXZlcnMgemVyby1maWxsZWQgKGUpU0NPIGZyYW1lcyBvbiBzZW50aW5lbCBoYW5kbGUg
MHgwRTAwIgoxMTY6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICg4NT44MCk6ICJbIDQ4Mzcu
ODc2MDQ4XSBCbHVldG9vdGg6IGhjaTA6IEhXL1NXIFZlcnNpb246IDB4MDAwMDAwMDAsIEJ1aWxk
IFRpbWU6IDIwMjYwNjA1MTg0OTM1IgoxMTg6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgx
MTU+ODApOiAiWyA0ODM5LjcwNTMyNF0gQmx1ZXRvb3RoOiBoY2kwOiBIQ0kgRW5oYW5jZWQgU2V0
dXAgU3luY2hyb25vdXMgQ29ubmVjdGlvbiBjb21tYW5kIGlzIGFkdmVydGlzZWQsIGJ1dCBub3Qg
c3VwcG9ydGVkLiIKMTQyOiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTAzPjgwKTogIkxp
bnV4IHVsZGl4eGlvbiA3LjIuMC0xLWNhY2h5b3MgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBUaHUs
IDIwIEF1ZyAyMDI2IDA2OjA2OjMwICswMDAwIHg4Nl82NCBHTlUvTGludXgiCjE1NTogQjEgTGlu
ZSBleGNlZWRzIG1heCBsZW5ndGggKDkxPjgwKTogIjA5OjAwLjAgTmV0d29yayBjb250cm9sbGVy
IFswMjgwXTogTUVESUFURUsgQ29ycC4gTVQ3OTI1IChSWjcxNykgV2ktRmkgNyAxNjBNSHogWzE0
YzM6MDcxN10iCjE1OTogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDExMD44MCk6ICLQsNCy
0LMgMjQgMTU6NDg6MzAgdWxkaXh4aW9uIGtlcm5lbDogbXQ3OTI1ZSAwMDAwOjA5OjAwLjA6IEhX
L1NXIFZlcnNpb246IDB4OGExMDhhMTAsIEJ1aWxkIFRpbWU6IDIwMjYwNjA1MTg0NjUxYSIKMTYw
OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTE1PjgwKTogItCw0LLQsyAyNCAxNTo0ODoz
MCB1bGRpeHhpb24ga2VybmVsOiBtdDc5MjVlIDAwMDA6MDk6MDAuMDogV00gRmlybXdhcmUgVmVy
c2lvbjogX19fXzAwMDAwMCwgQnVpbGQgVGltZTogMjAyNjA2MDUxODQ4MDUiCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBTdWJqZWN0UHJlZml4IC0gRkFJTApEZXNjOiBDaGVj
ayBzdWJqZWN0IGNvbnRhaW5zICJCbHVldG9vdGgiIHByZWZpeApPdXRwdXQ6CiJCbHVldG9vdGg6
ICIgcHJlZml4IGlzIG5vdCBzcGVjaWZpZWQgaW4gdGhlIHN1YmplY3QKCgpodHRwczovL2dpdGh1
Yi5jb20vYmx1ZXovYmx1ZXRvb3RoLW5leHQvcHVsbC83NDQKCi0tLQpSZWdhcmRzLApMaW51eCBC
bHVldG9vdGgKCg==

--===============2347825193469141995==--
