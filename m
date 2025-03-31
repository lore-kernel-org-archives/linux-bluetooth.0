Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267487080D
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743444559; cv=none; b=NQTiJxT58zgojtEZqxa4ROpwkBNwAkdxs4UTr8GgBk3j4cPWCqF6GYQrcJiICKw+KDlBygI8hP0hsU6wbKiBbsstDL0GUXMSdrT+nDIsn2aMEZZCo8Iun7hkE5e2tnYsWE7atytSKyBJaRgXDokOR6koMJofHe6x6HXOEOG48pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743444559; c=relaxed/simple;
	bh=ZzF0LIRDcJoU7uM7qFWF+e57YdFNsBfF2wtDC0jOzbs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GWHovwlFLpq4n/Pj2HbWfZFO7q9zubvWc+QQFtCXDZAXJDCXzBhXcQwB9gBtIjX58hyyJ79jAS3wspJ6UVjpG8ewUbZjOTqb7E1sX90QadLCmS/9Xze6/qzY77GXM1GuxcMSKVBpJtrTprgb8Ga1b8jpjP35I/aEa0CNqemo+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BForRGSZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BForRGSZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301302a328bso8150930a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743444557; x=1744049357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzF0LIRDcJoU7uM7qFWF+e57YdFNsBfF2wtDC0jOzbs=;
        b=BForRGSZPyeKMk9gBYO3frPkn5dlsmApLxmVWP0YonDhU2VHpiZ9GE4dYdlFlVFzur
         HN15eLYXuVIHtyaxAW47vUS6b0gkrujZctQVoH+4P7GOQRpxg30GJCILegTpVozCrKUx
         nvfVP1K9TPcZNSWeCcBxYI0ltFPRv0WVjdBVX9C3HHtcoeLzxh5cQ/xvaxvvFyA192FF
         WCStGO6SSqahBJaJQWNrOpHvTa2duC9VDTPvNWVwkDL0L8GCBToozw6KlglKk1KmB0o7
         S0VbzYodLTjm5BRs8TP2/6ap9/4rNzhJYkGrJKVe6byf8hyBi0EqWt51ti9zhyXvA8hM
         Kx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743444557; x=1744049357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzF0LIRDcJoU7uM7qFWF+e57YdFNsBfF2wtDC0jOzbs=;
        b=BY/SbjNwsZCC9W3IThPKXC0w/xuGgGwrNKt3IYzifFg6ccel+5b/tT/sLIvQ5HHu1x
         /3SEHz9ie6gSMaTnI8/nHQJG/etwnnlPD0eKmO8zWylAltrWDHcHrs/MoHXDktbePyab
         1VX0tgDmMZ6x2zoQOt5WL33RLb9iEzsCdZlSYwf9IYXE67yya3of5n0aDfzUPdsw5qcN
         DappJbu5MJwkbLe4uNXqI9Vt+Bkj+XEcM0Ha7qJ+t7NsVc9AVDui2lOTDftlZf96O550
         GE5cBi16yWdQ9HTrCVlfU/FTFUTaYQ1kk5o03knFOTSVUzp1wbIKS2FjJ7EjTPAwrPK/
         Y+Zw==
X-Gm-Message-State: AOJu0Yw4TgdBgj1RVC4RCAS00t9D8sFipUGbCez/rhFQJJ/Xw0AVQSBV
	L/n9YEHtdBYXvYZ7KVL5JIMUSX7EHy/9+mwHh4v8bp2fMR09VXFQV21xqA==
X-Gm-Gg: ASbGncudNkcscNXdz6x1UUxnZIXyjnjFrOSHx7AWWdM1RuHSbNJz9FzkBu9esUF9rfz
	gglbKKvhf4cMEb6boa+gkmjtm4R9YZsGQb4gMu9DnJi0vrE8jc4e+m8OJ+lly7xehOoC4aaRWnB
	WNYB9SMtlHUVDIEusTJDORkPlTZwpqVCYP+4XkEevr/pXCNW8OAxXUuOL8RqP0X1UFIpNfQgGU4
	lsk256KgmdAbTm9+tRLACFvRGC6oCk8RIO41ocpS1TKXknCsQ/JwTEcAjmNbV0YI40i6qJY4PFD
	4TI2Lc60uF1i07hCK5IVOoXGdWj1JJCDG0A4L2FCfJyFkbXAq00y
X-Google-Smtp-Source: AGHT+IHsZiCKIZgMg12Z8qeVg06q/AZ9uoCZCwr49auKvWdHKfk9fdPfTkQ/SFcOURNIK8Mm7Io+6g==
X-Received: by 2002:a17:90a:c88f:b0:2ff:5016:7fd2 with SMTP id 98e67ed59e1d1-3053215e085mr18292333a91.24.1743444557032;
        Mon, 31 Mar 2025 11:09:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.160.165.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305175cb0eesm7515669a91.46.2025.03.31.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 11:09:16 -0700 (PDT)
Message-ID: <67eada4c.170a0220.3c3a50.8975@mx.google.com>
Date: Mon, 31 Mar 2025 11:09:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4247256793638724891=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix swallowing states transitions
In-Reply-To: <20250331171157.3608035-1-luiz.dentz@gmail.com>
References: <20250331171157.3608035-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4247256793638724891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTQ4NjQwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zMiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjM0IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIwLjcyIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE0OTMuNjggc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTIuNzggc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTYw
LjUwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDIxNS43
NyBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFdBUk5JTkcgICAyODYuNTQg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgOTkuMTIgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQRU5ESU5HICAgMC4zOSBzZWNvbmRz
ClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA4ODguMDcgc2Vjb25kcwoK
RGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAt
IFBFTkRJTkcKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0Ck91dHB1dDoKCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gUEVORElORwpEZXNjOiBSdW4g
Z2l0bGludApPdXRwdXQ6CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFr
ZUNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjawpPdXRwdXQ6CgptYWtlWzNd
OiAqKiogW01ha2VmaWxlOjExNzgwOiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAq
KiogW01ha2VmaWxlOjExODg4OiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01h
a2VmaWxlOjEyMzE3OiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEyMzE5
OiBjaGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hl
Y2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sgd2l0aCBWYWxncmlu
ZApPdXRwdXQ6Cgp0b29scy9tZ210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0
b29scy9tZ210LXRlc3Rlci5jOjEyOTA3OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUg
bGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0
cnlpbmcgd2l0aG91dAoxMjkwNyB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAg
ICAgIHwgICAgIF5+fn4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc4MDogdGVzdC1zdWl0ZS5s
b2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg4ODogY2hlY2stVEVTVFNdIEVy
cm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMxNzogY2hlY2stYW1dIEVycm9yIDIKbWFr
ZTogKioqIFtNYWtlZmlsZToxMjMxOTogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrU21hdGNoIC0gV0FSTklORwpEZXNjOiBSdW4gc21hdGNo
IHRvb2wgd2l0aCBzb3VyY2UKT3V0cHV0OgpzcmMvc2hhcmVkL2JhcC5jOjMxNDoyNTogd2Fybmlu
ZzogYXJyYXkgb2YgZmxleGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6IG5vdGU6IGlu
IGluY2x1ZGVkIGZpbGU6Li9zcmMvc2hhcmVkL2FzY3MuaDo4ODoyNTogd2FybmluZzogYXJyYXkg
b2YgZmxleGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6MzE0OjI1OiB3YXJuaW5nOiBh
cnJheSBvZiBmbGV4aWJsZSBzdHJ1Y3R1cmVzc3JjL3NoYXJlZC9iYXAuYzogbm90ZTogaW4gaW5j
bHVkZWQgZmlsZTouL3NyYy9zaGFyZWQvYXNjcy5oOjg4OjI1OiB3YXJuaW5nOiBhcnJheSBvZiBm
bGV4aWJsZSBzdHJ1Y3R1cmVzc3JjL3NoYXJlZC9iYXAuYzozMTQ6MjU6IHdhcm5pbmc6IGFycmF5
IG9mIGZsZXhpYmxlIHN0cnVjdHVyZXNzcmMvc2hhcmVkL2JhcC5jOiBub3RlOiBpbiBpbmNsdWRl
ZCBmaWxlOi4vc3JjL3NoYXJlZC9hc2NzLmg6ODg6MjU6IHdhcm5pbmc6IGFycmF5IG9mIGZsZXhp
YmxlIHN0cnVjdHVyZXMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEluY3Jl
bWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6IEluY3JlbWVudGFsIGJ1aWxkIHdpdGggdGhlIHBh
dGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9v
dGgKCg==

--===============4247256793638724891==--
