Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929821CCED8
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350223; cv=none; b=KWGiqaoQ3xGUshJYOdrt4RL1K2qDLu17ueMZjBfm7U5aKsfgCjSoAo4L3s37gEKVYIqv1Gam5CSIikrLLydEfnbB8vgLAw5epRpPOArT4TvB9feqYIzHUtFFvMKsvQGeGGnN7mr8bQgaHrH+Xvd+AIyAD1o4/5mEYycwljpEtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350223; c=relaxed/simple;
	bh=lfnP54Wb1PoLRO5Fym+FWYGq24h4xoT+ogHgY4MHAhQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ekxgl/Cy1pD0MUhWrV0elcm4XpPB++QZu+6hMbM4ZltKSoegDkKKpdSU/Uzw9C4Z3A1fZNhriFGyxtMdD9p4ajmmUyYgyio111lG7V4fFdWSQfpaSBZHC4sEa5frYmt6pvwHvcUOmxTlX68nhzuGVhYGnuCg3HL8/v/m3J3FcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdALL8dL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdALL8dL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2021aeee5e4so8465085ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724350222; x=1724955022; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lfnP54Wb1PoLRO5Fym+FWYGq24h4xoT+ogHgY4MHAhQ=;
        b=cdALL8dLzlD38ROy+kVNtbj2uvlVH4uGs8bJrgu62HcTP/DnS9+pMzVwVHgA8zuEKD
         JcAWFjZJtWSX/b3OOyRhML1mKdTubu9cc1v9fEyVfuZ69vCzunf+LYIdx9gNCsrrzkmc
         VOV3CLihDKFYMv5QwRsm5z9XiJzj1xP6WSLspHYYS6tPMwtPKD33nANRnUojfdns6r++
         P8fORQd6scuej+0OlUpt3OFST4rg37NkDWlHAGuJybu5+gLQtw+MD/CZ2Dn7yqfol/rs
         RvSNbDTEkL2c9ZzU1ggIWaTYEVfeFH2ko6s2Yu/fV35rCFGMJrMlaN4yZeWkCRrId5TO
         bDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350222; x=1724955022;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfnP54Wb1PoLRO5Fym+FWYGq24h4xoT+ogHgY4MHAhQ=;
        b=KrBSCZJw0CxG+VLUzVWXcrsc7qlPZY2/oAGiyorSZeZerJopyFgBEVwZgX8XP3lpPs
         c6fhQygGGqAnr5zP5aVvKp6ECQrzi6331m/V6q1rM1+r254FGKLNcu6GguqPrPAi2M+8
         pSU1OjKHQspQfLBzP3zO3rxZLOFjyBkCf2cnKjNLaFciKQ9Thw0SXxu52JVRDJE0b/Ev
         2vjLDfZ3MMWXrpPpq7t28R1GrqQYQTgyuuT/MJlYnUTzgwHUSBBH5P1nAr5knnsX/GAV
         Kzlp1XbEVAgFhUJYQw47KFdaYRRYA1Hs7EkLJQbNDvSNp/zIiaf5zZJPSgZCdZLCTT+x
         VNaQ==
X-Gm-Message-State: AOJu0Yz1kIY2XZVq7qTytTxfTAIp1uD4yoFEsemBLvqNQR5YNSk+JCX8
	Fdj/KssHu27js7uZ/quzwtiaj4R5eS1BIJjMGvD+xRbW8W7QoqYa/Dmlpw==
X-Google-Smtp-Source: AGHT+IGt29J3fvME4Q48o7M1maVjkmEYgCJcrdCf4j3jTyREN8XI7WwwzFPt576S6u3I6kmPSYeXPg==
X-Received: by 2002:a17:902:ecc8:b0:1fd:6c5b:afbc with SMTP id d9443c01a7336-20388b9b305mr35309565ad.49.1724350221641;
        Thu, 22 Aug 2024 11:10:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.137.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e182sm15425665ad.64.2024.08.22.11.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:10:21 -0700 (PDT)
Message-ID: <66c77f0d.170a0220.124115.6a56@mx.google.com>
Date: Thu, 22 Aug 2024 11:10:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3195018126127527916=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add support for setting bcode on bcast sink
In-Reply-To: <20240822131232.531952-2-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3195018126127527916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgyMTY5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMi41MCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjY2IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0LjY0IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3NDYuOTMgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuMzggc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTY2
Ljg4IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1OS45
NyBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFdBUk5JTkcgICAzNjMuNDYg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIyLjMwIHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDEzNjg0Ljc2IHNl
Y29uZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDEwMzUuOTAgc2Vj
b25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNo
ZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjawpPdXRwdXQ6CgptYWtlWzNdOiAq
KiogW01ha2VmaWxlOjExNzY2OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiog
W01ha2VmaWxlOjExODc0OiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2Vm
aWxlOjEyMzAzOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEyMzA1OiBj
aGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZURp
c3RjaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgRGlzdGNoZWNrCk91dHB1dDoKClBh
Y2thZ2UgY3VwcyB3YXMgbm90IGZvdW5kIGluIHRoZSBwa2ctY29uZmlnIHNlYXJjaCBwYXRoLgpQ
ZXJoYXBzIHlvdSBzaG91bGQgYWRkIHRoZSBkaXJlY3RvcnkgY29udGFpbmluZyBgY3Vwcy5wYycK
dG8gdGhlIFBLR19DT05GSUdfUEFUSCBlbnZpcm9ubWVudCB2YXJpYWJsZQpObyBwYWNrYWdlICdj
dXBzJyBmb3VuZAptYWtlWzRdOiAqKiogW01ha2VmaWxlOjExNzY2OiB0ZXN0LXN1aXRlLmxvZ10g
RXJyb3IgMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExODc0OiBjaGVjay1URVNUU10gRXJyb3Ig
MgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEyMzAzOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFd
OiAqKiogW01ha2VmaWxlOjEyMzA1OiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxl
OjEyMjI2OiBkaXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdp
dGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCY
bWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjcyNTo1OiBub3RlOiB2YXJpYWJsZSB0cmFj
a2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVu
dHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI3MjUgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQogICAgICB8ICAgICBefn5+Cm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE3NjY6IHRl
c3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE4NzQ6IGNoZWNr
LVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNoZWNrLWFtXSBF
cnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDU6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1NtYXRjaCAtIFdBUk5JTkcKRGVzYzog
UnVuIHNtYXRjaCB0b29sIHdpdGggc291cmNlCk91dHB1dDoKc3JjL3NoYXJlZC9iYXAuYzoyODg6
MjU6IHdhcm5pbmc6IGFycmF5IG9mIGZsZXhpYmxlIHN0cnVjdHVyZXNzcmMvc2hhcmVkL2JhcC5j
OiBub3RlOiBpbiBpbmNsdWRlZCBmaWxlOi4vc3JjL3NoYXJlZC9hc2NzLmg6ODg6MjU6IHdhcm5p
bmc6IGFycmF5IG9mIGZsZXhpYmxlIHN0cnVjdHVyZXNzcmMvc2hhcmVkL2JhcC5jOjI4ODoyNTog
d2FybmluZzogYXJyYXkgb2YgZmxleGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6IG5v
dGU6IGluIGluY2x1ZGVkIGZpbGU6Li9zcmMvc2hhcmVkL2FzY3MuaDo4ODoyNTogd2FybmluZzog
YXJyYXkgb2YgZmxleGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6Mjg4OjI1OiB3YXJu
aW5nOiBhcnJheSBvZiBmbGV4aWJsZSBzdHJ1Y3R1cmVzc3JjL3NoYXJlZC9iYXAuYzogbm90ZTog
aW4gaW5jbHVkZWQgZmlsZTouL3NyYy9zaGFyZWQvYXNjcy5oOjg4OjI1OiB3YXJuaW5nOiBhcnJh
eSBvZiBmbGV4aWJsZSBzdHJ1Y3R1cmVzCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============3195018126127527916==--
