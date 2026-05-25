Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AE3AC0C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692492; cv=none; b=Z9l4NeLfYGYXlH7kqfRtsmW2Mkvat/1gouhHtv8S65Pk7ZgAQWbKUDA2tRBZ12j/hyVBOzrN66FNXD7u7JaBirnPUZjerc0iR7Lrn1OGxK90I98dJU5ieX9XJ1IgzheU4w3RDAPUTCNUjsctOpV4Gh+NuGXSESrwPMpdqMZgtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692492; c=relaxed/simple;
	bh=fVYjk2AXomzcFp/C9wLekrVd34ZGdPzACcKYeJfYQf8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m8LFlbInbYjIkTo0MOni21qznY0ASuaN03VSlY/X+RWYeebxKxpZUI1140BTJQfHVHmZnfTfjkWRLorzl77ujf33sYVBp49aXVZIvNI+C0DQ4Lge3A/i+gQLBs0BbRGzBL5RhlfQLj5WHeGludKnD2M503JI0yp6v911MZyOXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVXVAJNo; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVXVAJNo"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1370417c01cso52835c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 00:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779692487; x=1780297287; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fVYjk2AXomzcFp/C9wLekrVd34ZGdPzACcKYeJfYQf8=;
        b=RVXVAJNoJyHy4Tie0uTr/ugAicKH6aINnRcf+tZ9whPwBFHxiqS92jZ0mv+n0sMhqI
         P99cn3bUOj/9+3uaUUwRl1kw6bB/NzyXeluned5eP6ngaJxAsLsaYJ40X/gyKnFWi9A0
         jdSfwUKwEV0AxIR8a0j9rdsMLo1mfUd84GOIDTkfHJYNeMv+sEB+5SQ7Hlc7lYvKOUoF
         5zdW3WmPGJzTnYwo4XIYPB2/QXdZLljyPG6CChNDtWqsLKC+1iVOeR/tL5OUizk4V8Cd
         EqQ2WpsWv+GVEhI0enIsZJH1CmsLJAiApbAp+Np/6XM5yGc9ovMnz7n5ZBpsKW21SDIm
         9uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779692487; x=1780297287;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVYjk2AXomzcFp/C9wLekrVd34ZGdPzACcKYeJfYQf8=;
        b=fQ6jydgD3FZztqp21oV+UG0Tl56Hl7LH7N049Gpkq2il9+6XW/m9ZVXFxRkPC72on6
         TYuVbYrn/jI5rRpKnDP2WjEq52saVr6+ySRT38GWA4OLTMoMT2VI5I6b1sbnO8DvofT+
         VSJIA3O7KSYjSOXQdNuP08VntJ8kRMpdZ35vtwTq1v1in2BD/yJEqQtMZXhtkVbfo4z7
         sLKDsrdoJM19hLrYjL5R1pEvFuNsx5gclBGejy3eaijjwlxJvQntV/JfRx9enqvDOjyc
         X6J3Me6J/PQ5WKdQzqQ7laAGWEvqFEsHsXCPzzjGoL/JR19XurUihwNXpx31fA7picm5
         TDZg==
X-Gm-Message-State: AOJu0YxMgDaHtnM/xLIRqPZlDU302sLKQjEbcU0smTl/cWOaWB9At/FV
	LcgfK9HKP8Uvtnii1eg7isfTgmW/v6xZIauHP0Q7epwoTLyXX4gBLZkRtjERwQ==
X-Gm-Gg: Acq92OFARceYJph4QEqZUT8Ygll9vkL85wmOqLyPnNDPyTddj5OnxWH+R/87z4GW+49
	KOrR0YFcNvdMco+qwCP7ixq4ZyqmRvwavbZpzLl4VwlDdw53PujFdkP6V5a74M69rYKtwcOmHtv
	zddTA8/PyYC5sNurlJEqTUQHYmSCvCWFg8fggj/XuRlSPL1VoptWX5ep7VJOkZOQFHfQWFCbEsu
	sDNGLWIgsI1NePwHVSTLqE206Y/qENJmKmsjDg+ZIEOb/9KFmRWeOlquu6+njFS72JdB6KOF9Ac
	B52sAicZ2pVtBNMIrCmxwo6rIF2BZp61p4gnskYshhMLhpOgqQe9OTL3SRZwPBCx0KO3U3I2PAv
	EXwwwqdkfARbOyr9FGGvXreG8pLGMhBOCgbHn1P1gFU45haPXEFNdhkEnXK65CMV8VDnCgIo4tB
	shSGXAuQ4LVqns6rmsIVKnn7Wsa+WE5ZU=
X-Received: by 2002:a05:7022:7e88:b0:136:f0d9:5e8c with SMTP id a92af1059eb24-136f0d960f1mr458657c88.19.1779692487180;
        Mon, 25 May 2026 00:01:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.209.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a2e672asm6974381c88.3.2026.05.25.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:01:25 -0700 (PDT)
Message-ID: <6a13f3c5.19a9dfc2.8bff4.65d5@mx.google.com>
Date: Mon, 25 May 2026 00:01:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2703090965803699826=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michal.dzik@streamunlimited.com
Subject: RE: [BlueZ] advertising: add property with advertisement ID
In-Reply-To: <20260525041151.3893522-1-michal.dzik@streamunlimited.com>
References: <20260525041151.3893522-1-michal.dzik@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2703090965803699826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTEwMDE3MQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgIDAuMzQgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4yMyBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAxOS44OSBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA2MzguMDggc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTkuMTkgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjI3
LjE2IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI5MC4x
NiBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFdBUk5JTkcgICAzNDcuODIg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTg3Ljg0IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDY1OC4zMiBzZWNv
bmRzClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMDI2LjE0IHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVj
ayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVszXTogKioq
IFtNYWtlZmlsZToxMDIzOTogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtN
YWtlZmlsZToxMDM0NzogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmls
ZToxMDgxODogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMDgyMDogY2hl
Y2tdIEVycm9yIDIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VEaXN0
Y2hlY2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIERpc3RjaGVjawpPdXRwdXQ6CgptYWtl
WzRdOiAqKiogW01ha2VmaWxlOjEwMjM5OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQptYWtlWzNd
OiAqKiogW01ha2VmaWxlOjEwMzQ3OiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzJdOiAqKiog
W01ha2VmaWxlOjEwODE4OiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFdOiAqKiogW01ha2VmaWxl
OjEwODIwOiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjEwNzQxOiBkaXN0Y2hl
Y2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrVmFs
Z3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3JpbmQKT3V0
cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMv
bWdtdC10ZXN0ZXIuYzoxMjk5MDo1OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0
IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5n
IHdpdGhvdXQKMTI5OTAgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8
ICAgICBefn5+Cm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTAyMzk6IHRlc3Qtc3VpdGUubG9nXSBF
cnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTAzNDc6IGNoZWNrLVRFU1RTXSBFcnJvciAy
Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTA4MTg6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoq
KiBbTWFrZWZpbGU6MTA4MjA6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIwpUZXN0OiBDaGVja1NtYXRjaCAtIFdBUk5JTkcKRGVzYzogUnVuIHNtYXRjaCB0b29s
IHdpdGggc291cmNlCk91dHB1dDoKc3JjL2FkdmVydGlzaW5nLmM6IG5vdGU6IGluIGluY2x1ZGVk
IGZpbGU6Li9zcmMvc2hhcmVkL21nbXQuaDo5NToyNTogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiB1
bnNpZ25lZCBpbnQgZW51bSBtZ210X2lvX2NhcGFiaWxpdHlzcmMvYWR2ZXJ0aXNpbmcuYzogbm90
ZTogaW4gaW5jbHVkZWQgZmlsZTouL3NyYy9zaGFyZWQvbWdtdC5oOjk1OjI1OiBlcnJvcjogcmVk
ZWZpbml0aW9uIG9mIHVuc2lnbmVkIGludCBlbnVtIG1nbXRfaW9fY2FwYWJpbGl0eQoKCmh0dHBz
Oi8vZ2l0aHViLmNvbS9ibHVlei9ibHVlei9wdWxsLzIxNDkKCi0tLQpSZWdhcmRzLApMaW51eCBC
bHVldG9vdGgKCg==

--===============2703090965803699826==--
