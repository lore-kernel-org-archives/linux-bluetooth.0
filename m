Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554602;
	b=ytrk348nrIWj0n1oEruE3OKgside2HWWpQf20W8FEvNSlipP55BUl1LujYqNJstW+fX/
	 XXozfIXiFvZxO9DztiK597XVBz2ltMKc9ctU91B2Mx1owWRb/9Nv9FiCd9slHHJ9wEPQX
	 fo6Yh//FBpM2bVo9PVplnjpw/FDvnrIOqorKbVf9rT73t5NRDQWcf9CYCtlyCsPd+XoLy
	 zNZ3ZfxwGeq8CIs/odGploKzFAlAtzhxO4fykM4z2TkVq1gsXBffJOgA3fQWI9DqBjxr3
	 7Ccgh+BsuZt5K44350qjguBs1AJxQ50wmHmzq7i4VSC/oUWqcfKa8EuNN21N/W7LzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=iPSu4I4j1XxDeiotUKLAP3oLTtdIIZEf8+tc5GZfBME=;
	b=tlCa2T9AUHdUgQ7FLKaZdOFAxRQ/uO+6xlwJyF1mu1T6RT8/zKmdCsxB9xgduWKuldKD
	 5gPcVE00MtEzYFoHMVPSthJqT/6EswLqZ9eu4jIUovuSyYrY9hxxA9k4Z2gCDvrwfJjKz
	 cW1R3EMHmw1oOH7gLooaaGFNn4YnXMxsCpGEEf9BxsSzkU0I62TVF3YvkXt5JPm7SHuJi
	 0GPqeDO2JEovVlYmAHuWYVeHKaeiK2hGUDfirdaXaAGkIhurFbrxyIjRHIoaZEf4w5B5m
	 y0rWORa++xTb9kqzQpDktya2a0XJRF/0OMU3HuK4j93Sp3Df24xqCR+MqJftkEiW1DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=op8lmCMh;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB0606A327
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 21:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BB0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=op8lmCMh
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53644ab1f7bso44779621cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795554601; x=1796159401; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iPSu4I4j1XxDeiotUKLAP3oLTtdIIZEf8+tc5GZfBME=;
        b=op8lmCMhVglU2jB5EhXImUoWAPeVcpcusqTNutpi3IVNmcFjq6Bt2SYClIEEA619pn
         BLHWs7iUGKi7rdvfH450PEJFsp4k0UkSUc5fPCjosXXWOXbZmW5NDgGPkZT0GCeC2tsY
         Yk4xdwsySlCpRHoileOBH6Dx6m3r66+MgK3jd/1gYh69Ys3IUJcBH0TD4wLEWwUtxY4C
         QPW6biAeaRIoL/3kU6h0uM9LZ3NHpT7uxs4YW4byRjUNJWDJ8hxUzBFyJA8VGtYBVETw
         uPf+QImAC8TdKR3kUJxmFA6DUvpZoDuIaxJwFfxz4hvd4IzghMZI650IKA71l9K83fb6
         V1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554601; x=1796159401;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iPSu4I4j1XxDeiotUKLAP3oLTtdIIZEf8+tc5GZfBME=;
        b=rNs0/RoZiTAAAe2nlj1TvjxOFQnbrpJGobO3ma+1uZLPc7JBSC4ffX6xBuna8Jgd+n
         bn5jCtybnvpa7vYdeenQCN++D9tde2Ox+ycIk4zSL0juc40EtAm5jwNa+j9exCwhpVuU
         ZYl97cdYmCTirsNg/bzfkAqTImLyHtqo1pV7x23NwlYG2QivPIag1V82FkxRgFiaMn5l
         VthaIxIsyI/D0O9zTlT3DLyE25pMeHmICpS0gpGRqVw4Am7Vb7BUJrbEZIDIAbSojRud
         IozkguDE2hx7nVTYMXgBWD/Hhmnjd0Bq1ReNkmU4cl4LIorNHQNvBoAEDZ5NDSTMWY0s
         nXbQ==
X-Gm-Message-State: APuU4Z8NmWRVyR3oXNvo2Bs4bWkwPVSF55V/yKbt2jLNUh74uY7CMX4p
	FWhNWYcBVUOKqn3YHytBLL1cryQWPspT7tfOqATSg8OjFdx+Nf4isogIoyQlkw==
X-Gm-Gg: AZFdTZeOiskT4QBMhL59P471vnSot8HVp+oUVzSsQ1zyB4c/Ct1jn6WmMO62mZLjN/h
	a0wKBhJIBK/RJgs1vAap5qiP9zwtAyoPvtdaOloqvipWpn53N+PB8c26LmH/kokN4+hIM+C+Q3I
	E0USCTjpmoTSy2uLb60khR8IMTaSnopjEtaQfSVVeZkokj2gvsKkvxDkw8gDlV+CofP4lQjWIix
	yWQGk+4ldGPQyFg7n/vKaG8AxyIPGvvCeObxqSgKPBFfVEQaXPX/JnfsRZnjYvp2ShDORqTMHzy
	22ChPov3FTe2wiqBauLVvncuwcR+rQHHwiY1X9ZZOiZTTVHfhvIaLRDO/HNUk79SD1yu4ZrcwOn
	yX+83VbVIglz86yxKkA2srlM6AvYags97ZqI3TL2+0pBO1ZOSkhI8LpnnVR3WP+39w0ZWbOl/d1
	76uy5is++3pPh7+ijVpLyVVBHbxZj0Hj5tPVKCsCO0RJ0mxNl93RQRoGsj+qmlCrY7HjDWQxVhz
	nCiQKz6vmbWIFIxsQbVcZGItrM20Rd3gq3M1tL3JUm4jPTNetSay4rbSz3Aoac=
X-Received: by 2002:ac8:5a46:0:b0:536:6bbc:6187 with SMTP id d75a77b69052e-55d76a4ffabmr297449971cf.31.1795554601343;
        Tue, 24 Nov 2026 13:10:01 -0800 (PST)
Received: from [172.17.0.2] ([74.235.126.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7888fb27sm134921781cf.25.2026.11.24.13.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:10:01 -0800 (PST)
Message-ID: <6b05fd29.51ceb238.2bba0e.923b@mx.google.com>
Date: Tue, 24 Nov 2026 13:10:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7667887018552463370=="
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
In-Reply-To: <20261124153856.216054-2-luiz.dentz@gmail.com>
References: <20261124153856.216054-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7667887018552463370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9zZXJpZXMvMTIyMTAzOC8KCi0tLVRlc3QgcmVzdWx0LS0tCgpUZXN0IFN1
bW1hcnk6CkNoZWNrUGF0Y2ggICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMC4xMSBzZWNv
bmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA1Ljk2IHNlY29uZHMK
QnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIxLjEwIHNlY29uZHMKQmx1
ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMxNy42NCBzZWNvbmRzCk1ha2VD
aGVjayAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNS44MyBzZWNvbmRzCk1ha2VEaXN0
Y2hlY2sgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxNTQuMzMgc2Vjb25kcwpDaGVja1ZhbGdy
aW5kICAgICAgICAgICAgICAgICBGQUlMICAgICAgMzY0LjEyIHNlY29uZHMKQ2hlY2tTbWF0Y2gg
ICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMyMy41MyBzZWNvbmRzCmJsdWV6bWFrZWV4dGVs
bCAgICAgICAgICAgICAgIFBBU1MgICAgICAxMDIuOTIgc2Vjb25kcwpUZXN0RnVuY3Rpb25hbCAg
ICAgICAgICAgICAgICBGQUlMICAgICAgMTI5NC4wOSBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQg
ICAgICAgICAgICAgIFBBU1MgICAgICA1MzAuMTUgc2Vjb25kcwpTY2FuQnVpbGQgICAgICAgICAg
ICAgICAgICAgICBQQVNTICAgICAgMTIwOC41MyBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gRkFJTApEZXNjOiBSdW4gZ2l0bGlu
dApPdXRwdXQ6CltCbHVlWix2NiwwMy8xOF0gc2hhcmVkL3JhcDogU3Vic2NyaWJlIG9uLWRlbWFu
ZCBkYXRhIHdpdGggdGhlIHJlcXVlc3RlZCB0cmFuc3BvcnQKCjE6IFQxIFRpdGxlIGV4Y2VlZHMg
bWF4IGxlbmd0aCAoODI+ODApOiAiW0JsdWVaLHY2LDAzLzE4XSBzaGFyZWQvcmFwOiBTdWJzY3Jp
YmUgb24tZGVtYW5kIGRhdGEgd2l0aCB0aGUgcmVxdWVzdGVkIHRyYW5zcG9ydCIKW0JsdWVaLHY2
LDA4LzE4XSBwcm9maWxlcy9yYW5naW5nOiBMZXQgU3RhcnRNZWFzdXJlbWVudCgpIHBpY2sgdGhl
IEluaXRpYXRvciBmb3IgQm90aAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4NT44
MCk6ICJbQmx1ZVosdjYsMDgvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IExldCBTdGFydE1lYXN1cmVt
ZW50KCkgcGljayB0aGUgSW5pdGlhdG9yIGZvciBCb3RoIgpbQmx1ZVosdjYsMTIvMThdIHByb2Zp
bGVzL3Jhbmdpbmc6IERlZmVyIENTIFNlY3VyaXR5IEVuYWJsZSB1bnRpbCB0aGUgbGluayBpcyBl
bmNyeXB0ZWQKCjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODc+ODApOiAiW0JsdWVa
LHY2LDEyLzE4XSBwcm9maWxlcy9yYW5naW5nOiBEZWZlciBDUyBTZWN1cml0eSBFbmFibGUgdW50
aWwgdGhlIGxpbmsgaXMgZW5jcnlwdGVkIgpbQmx1ZVosdjYsMTMvMThdIHByb2ZpbGVzL3Jhbmdp
bmc6IENob29zZSB0aGUgQ1MgYW50ZW5uYSBjb25maWd1cmF0aW9uIGZyb20gYm90aCBlbmRzCgox
OiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTogIltCbHVlWix2NiwxMy8xOF0g
cHJvZmlsZXMvcmFuZ2luZzogQ2hvb3NlIHRoZSBDUyBhbnRlbm5hIGNvbmZpZ3VyYXRpb24gZnJv
bSBib3RoIGVuZHMiCltCbHVlWix2NiwxNC8xOF0gcHJvZmlsZXMvcmFuZ2luZzogRG8gbm90IHN0
YXJ0IGEgcHJvY2VkdXJlIGFmdGVyIFN0b3BNZWFzdXJlbWVudCgpCgoxOiBUMSBUaXRsZSBleGNl
ZWRzIG1heCBsZW5ndGggKDgzPjgwKTogIltCbHVlWix2NiwxNC8xOF0gcHJvZmlsZXMvcmFuZ2lu
ZzogRG8gbm90IHN0YXJ0IGEgcHJvY2VkdXJlIGFmdGVyIFN0b3BNZWFzdXJlbWVudCgpIgpbQmx1
ZVosdjYsMTUvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IEtlZXAgQ1Mgc2Vzc2lvbnMgYXBhcnQgZnJv
bSBzdGFsZSBhbmQgdW5yZWxhdGVkIGV2ZW50cwoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVu
Z3RoICg4OT44MCk6ICJbQmx1ZVosdjYsMTUvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IEtlZXAgQ1Mg
c2Vzc2lvbnMgYXBhcnQgZnJvbSBzdGFsZSBhbmQgdW5yZWxhdGVkIGV2ZW50cyIKW0JsdWVaLHY2
LDE2LzE4XSBzaGFyZWQvcmFwOiBTdGFydCB0aGUgUmVhbC10aW1lIHRpbWVvdXQgd2hlbiB0aGUg
cHJvY2VkdXJlIHN0YXJ0cwoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4Mj44MCk6
ICJbQmx1ZVosdjYsMTYvMThdIHNoYXJlZC9yYXA6IFN0YXJ0IHRoZSBSZWFsLXRpbWUgdGltZW91
dCB3aGVuIHRoZSBwcm9jZWR1cmUgc3RhcnRzIgpbQmx1ZVosdjYsMTcvMThdIHVuaXQvdGVzdC1y
YXA6IEFkZCB0ZXN0cyBmb3IgUmFuZ2luZyBEYXRhIHN1YnNjcmlwdGlvbiBhbmQgY291bnRlcnMK
CjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODQ+ODApOiAiW0JsdWVaLHY2LDE3LzE4
XSB1bml0L3Rlc3QtcmFwOiBBZGQgdGVzdHMgZm9yIFJhbmdpbmcgRGF0YSBzdWJzY3JpcHRpb24g
YW5kIGNvdW50ZXJzIgpbQmx1ZVosdjYsMTgvMThdIHNoYXJlZC9yYXA6IERlZmVyIFJhbmdpbmcg
RGF0YSBtb2RlIHNlbGVjdGlvbiB1bnRpbCBGZWF0dXJlcyBpcyByZWFkCgoxOiBUMSBUaXRsZSBl
eGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTogIltCbHVlWix2NiwxOC8xOF0gc2hhcmVkL3JhcDog
RGVmZXIgUmFuZ2luZyBEYXRhIG1vZGUgc2VsZWN0aW9uIHVudGlsIEZlYXR1cmVzIGlzIHJlYWQi
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hlY2sgLSBGQUlMCkRl
c2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6
MTA0MzY6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTA1
NzE6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTEwNzQ6IGNo
ZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEwNzY6IGNoZWNrXSBFcnJvciAy
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJ
TApEZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjayB3aXRoIFZhbGdyaW5kCk91dHB1dDoKCnRvb2xz
L21nbXQtdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xzL21nbXQtdGVzdGVy
LmM6MTQ1MTg6NTogbm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3
aXRoIOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CjE0
NTE4IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgpt
YWtlWzNdOiB3YXJuaW5nOiAtajQgZm9yY2VkIGluIHN1Ym1ha2U6IHJlc2V0dGluZyBqb2JzZXJ2
ZXIgbW9kZS4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMDQzNjogdGVzdC1zdWl0ZS5sb2ddIEVy
cm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMDU3MTogY2hlY2stVEVTVFNdIEVycm9yIDIK
bWFrZVsxXTogKioqIFtNYWtlZmlsZToxMTA3NDogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioq
IFtNYWtlZmlsZToxMTA3NjogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjClRlc3Q6IFRlc3RGdW5jdGlvbmFsIC0gRkFJTApEZXNjOiBSdW4gdGVzdC1mdW5jdGlv
bmFsCk91dHB1dDoKRkFJTCBmdW5jdGlvbmFsLnRlc3RfYmFwOjp0ZXN0X2Jhc3NfcGFzdF9lYXJi
dWRzX3RyYW5zcG9ydF9hY3F1aXJlW2hvc3RzMTEtdm0zXTogQXNzZXJ0aW9uRXJyb3I6IEZhaWxl
ZCB0byBhY3F1aXJlOiBvcmcuYmx1ZXouRXJyb3IuRmFpbGVkCgoKaHR0cHM6Ly9naXRodWIuY29t
L2JsdWV6L2JsdWV6L3B1bGwvMjkxMAoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============7667887018552463370==--
