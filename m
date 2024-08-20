Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BD194129
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169286; cv=none; b=GvGd7bgecJffoo/xJmjUgnhdirD5TeY91eAfmcnATjFp2WOeDof78Gxlf7Oj7ORO+lpvTh8DvjxkyfgPqD8FU0glsjfFu+cjCCX9sJialco/XabNa1zOnnf8vT0HEU9GMboethL/6WX9zIpvfsnIyQ+WfidnWGaPJtXNeGl1AOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169286; c=relaxed/simple;
	bh=opQI35izZ6WQtBEicSMe5AQ7UT/vnA8rTEHw3gUCOjY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mYrRV3W8Mg6v8MnyjoHCbB3maKYjRiUxwN09BNYwylV+uqHFTnBLqdfQPKa5HBbPlO+PSdVPT0mWpejbHmUkatYxib74gERyQPppcZjxlJCmiOcCQ2YESDOaH/6sDmsdNFSqAZT77eC8+FoyHKDlPaeiHAl4uiUPB2VsENUoOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clvoS3Q0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clvoS3Q0"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a3574acafeso356410485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169284; x=1724774084; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=opQI35izZ6WQtBEicSMe5AQ7UT/vnA8rTEHw3gUCOjY=;
        b=clvoS3Q0hb2NYzGUE0Mv/llHaf67GxByAhYsYXNP+h16vGB9qmfBm2Q+IOmV/j2IcS
         TqSG5X7+Pe26AO+om3IVot47bo1irmu9AsodhqBf+EUDucYz54h4FqnWvHNz+pSkvSeE
         V06UN9muzjRjwwjiqaKMsK7OS6mZg7T0MebhujzT2MVa9LyPvoU7EWiPVykAXsjBUbav
         KdiJE2dti0GcL+nMYVOmto7+OYDZDORd3o0YVp+Ysz5haNdi8bf3otU2nwUai64OV4fT
         YqHoLem3aQvWQmkilbpojBINNz8lSS6CdK3uPZYYMlA571llPZ8GmsBlKKO+DFapueQb
         C+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169284; x=1724774084;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opQI35izZ6WQtBEicSMe5AQ7UT/vnA8rTEHw3gUCOjY=;
        b=KaLWMq1DdN6K7IW6tl2UyiwhBzPyHAT4SWT9X/XLSxP1kkxXnDvfP4ByUpQsicf3OE
         TiZO/LOKATPpd/+Plvn12x7LrxtICI1BvO39+rdELlNOZ0SAwF0pCevzokG5wZxY2kNM
         JWP8fGjfGl2Z/5H9YLTlpzq/lFxUCL4873cTHKiNHk8QrNAttL6UHoSWqbBPkBgy32yt
         Rm7XN3G6TfVjA4YQ25JFKlReRE3CDpRMQKOUbA1Q/vt0JfjB7gwKoe4Er+C9u8c3uCqb
         8Ebg2OBPFevALMeiGJxsBBiAdIdkcyZbHjivR38bwhj0wgCS0FBBP/ulYRzcYT1RrA5/
         qmJw==
X-Gm-Message-State: AOJu0YxXwBjLVBA8G6wbKRVcgEkLPUHfalFwNh++nTkd0U+dqJpKndqa
	IsGuNdhbVWXKcMLWPIK9y0Z16tqiycN8N5zho+bhV/giIOg2BXDYEuVzwg==
X-Google-Smtp-Source: AGHT+IHbsbbdQtNgGyaLztAOTTQu65IW0OEP9vUDU9VPZLwA1/e/cJOqCEVRbwuHF40rQ+ICOhtQZQ==
X-Received: by 2002:a05:620a:17a7:b0:79f:37f:9c40 with SMTP id af79cd13be357-7a5068e98a6mr1626640985a.12.1724169283870;
        Tue, 20 Aug 2024 08:54:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e3592sm540973985a.92.2024.08.20.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:54:43 -0700 (PDT)
Message-ID: <66c4bc43.050a0220.c15f3.62c6@mx.google.com>
Date: Tue, 20 Aug 2024 08:54:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3466313948557150407=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Add support for setting bcode on bcast sink
In-Reply-To: <20240820103918.24246-2-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3466313948557150407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgxMzAwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMy43OSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAyLjYwIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0Ljc3IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3NTUuNDMgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuMTggc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTYx
LjIyIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1My43
MSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFdBUk5JTkcgICAzNTguODYg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIwLjYyIHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDEzMDYwLjQwIHNl
Y29uZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDEwMTYuOTUgc2Vj
b25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNo
ZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjawpPdXRwdXQ6CgptYWtlWzNdOiAq
KiogW01ha2VmaWxlOjExNzY0OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzJdOiAqKiog
W01ha2VmaWxlOjExODcyOiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2Vm
aWxlOjEyMzAxOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEyMzAzOiBj
aGVja10gRXJyb3IgMgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZURp
c3RjaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgRGlzdGNoZWNrCk91dHB1dDoKClBh
Y2thZ2UgY3VwcyB3YXMgbm90IGZvdW5kIGluIHRoZSBwa2ctY29uZmlnIHNlYXJjaCBwYXRoLgpQ
ZXJoYXBzIHlvdSBzaG91bGQgYWRkIHRoZSBkaXJlY3RvcnkgY29udGFpbmluZyBgY3Vwcy5wYycK
dG8gdGhlIFBLR19DT05GSUdfUEFUSCBlbnZpcm9ubWVudCB2YXJpYWJsZQpObyBwYWNrYWdlICdj
dXBzJyBmb3VuZAptYWtlWzRdOiAqKiogW01ha2VmaWxlOjExNzY0OiB0ZXN0LXN1aXRlLmxvZ10g
RXJyb3IgMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExODcyOiBjaGVjay1URVNUU10gRXJyb3Ig
MgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEyMzAxOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFd
OiAqKiogW01ha2VmaWxlOjEyMzAzOiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxl
OjEyMjI0OiBkaXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdp
dGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCY
bWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjcyNTo1OiBub3RlOiB2YXJpYWJsZSB0cmFj
a2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVu
dHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI3MjUgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQogICAgICB8ICAgICBefn5+Cm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE3NjQ6IHRl
c3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE4NzI6IGNoZWNr
LVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzMDE6IGNoZWNrLWFtXSBF
cnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMj
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

--===============3466313948557150407==--
