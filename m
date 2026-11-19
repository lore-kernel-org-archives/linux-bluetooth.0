Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053463;
	b=Nmsp3T07Ic5vttDsScbb5C6E84G34AkAazkd/GVtRlytNmMLjms4k8Vj2anztDIR+BYS
	 eTs9EzWF4HuH6xLX6ZL7RguGX/UfNZdz3r5xNqlTrkZreW30oLzpP2HKcyaMYfI7XOoj+
	 YKT1EKR//45fJYQZq4WseXP/OqPv0sXKK7B0rah4EAj6Bzgke30s2OowlPCZoR7j5dpSp
	 DwvpKvcIk7uZxkViFowBrcPvCqliy0jSc/YI2Ep4xrJhFaXp+fmK+VQYQ70RhvGDOL5ET
	 Tn9OrqRjNZ/aUXa4urv7i0BJ7JSrkfRELRTYfLpboXctSDz8DZX/mROr/NyseXGbXug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jrgdigz+/AWSI15miysuZ4jJInMHGq/Cr3ymSlDdPn4=;
	b=Su8ECDvwkX4slp3TW/54BScklRl2Wz5W1MCeD8sc8odvoPqvO0a8BShPPAqQNus1UmAJ
	 9LP5rEMQhTr4YwDXEJOScWvQMJTLjfMBkCg+ILPrfF6GEzjaXo+pTAnHI8aH0OBzCgl5N
	 NXzxPEVrvfLt25rtjYF7N8UYERWcPkYqBjtRQyS19AiToALE7INIvnooDDClHw46S3Ds4
	 rdKgNUHH8wC+ugSXOINcAtqmwM+Ny7siuEzl6LaZgpzYMilnYWz4xohgHkFurYmE/LX85
	 3nKHvYx8XSV1LKjK2M30Ig+npmK6tzo9OF07rxhSak8M8kD+t/wS77Y0gpnLjqqavzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZ5RDI5U;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAB606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 01:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CAB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZ5RDI5U
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so1145842a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 17:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795053462; x=1795658262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jrgdigz+/AWSI15miysuZ4jJInMHGq/Cr3ymSlDdPn4=;
        b=SZ5RDI5Uwlvuk1Temjl4wYmrsp4xdIbl8VaVbeHVqkMG2eH5xCmIOQxBJb0lyrsv9Q
         BTMQ1JPuA9Hl1eQj79Lj3sB8KrCfUm26FmUOJ6B8iHgQdrKvLroWNC3Uz+MbAIUyDcc5
         PR7rAyH53FDr1YjicymqbrOskustXufunLiy8zhhoqqa5mj1Spu1RvyVfsuLu1By3Vi8
         Moet+ONSINIPF8/JwOG5rSHqYaEbHjeRE8Z+oL30ikxsHWzUPbB2vscrFC+bF17tOrJ8
         9QRJUf0ZhSkNwxWPKqWbG9OmSIoGcaw3JZhnsIosx1yR45KIbPJZmGRZomZXyTR+KsAz
         NLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795053462; x=1795658262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jrgdigz+/AWSI15miysuZ4jJInMHGq/Cr3ymSlDdPn4=;
        b=IaSk23WLh+8vUIGxOghMtCXa1QVdPdu7dPUBV2ikLDO+BJ23FgHP4RH8zwVLi1alog
         lzAsc18Jh9tLRz0nC7xsqo4Gx0zNXRs4rGqQ4HA2gefUB2hy9mdHHMY0RLpHuXTnvskH
         HM+Njd0jlCE7iEjHnJHHCPspul0EKj2jtbvc9ECwWhRtXAywDIcmh7qE8W3q0AvNtTS3
         FPRXS5y5+zo4StB7I4X5etRP48wpr7q2W7KIZkwho0jxrIjkOQFo2DQgNF9wg+MYk82I
         R41GqKE1PIIZ0owQDhPDK/v8XfoL8C45VhhoUfS18fOUPcwjHEnPW/HTym+Re4xD2jdA
         pB9g==
X-Gm-Message-State: APuU4Z/2fdkiFKaPKqeag2nrJwkTeN4ZbY3L2xWSXxfgt1M+xOfDELM1
	AjTrNOBRv9VM8mlWXuqplAKzIvRRmKIzLcPHFhyVXLBpuhVjYTmirAWOIrTqIQ==
X-Gm-Gg: AZFdTZc7pHUavv6sCgdGP2knS/KLQ8yP79FASJJgbFEl7LHJQZrr16E12uhIbhd9YMT
	AYWhB8buQviMAJwyrIe5Ecjxw2st5EpVN/Zg0rt13uC78mI2KwBtMWB5Um2yF1EgBLviUk/jp6c
	7eAd+t2z/imV+8Y6mgU+eDk/+1iEuPMh23qDlM8C60swDZiHcU9/6OlELzUrafiXIHAsYE7u+QH
	Wdw3HHfX22S/9RldQ04/nYsJhEKbKCGpvo4pW6asl7BWDmO9hSZ4Vh1Z97570pXtSrR5kle6DVO
	Zm1h7vEors9feD5c0reMNmqlfLUKTHhs4EloFrFZp/VP39UGhSpY/eVLSLkBRbr5uib9JTcE/hL
	d2DApUvrq4IcOrZKEnTq7v0AeExuxrFb23b44jCp3WSdPk/odTVqNPiK4a6+Q4uvkvIp8Z5uwd4
	W38/GLYk79BwAoKFFIjIBufdBedoFG0Lflgm1sPsYMZOrbozNyqL2y5coaPIC6Vye+0Fd6FQvLf
	/98tubO44laF1nvPW01eIw1duw8GiEmcM40E2H9IWqVEqtEHigvwn9M0e/F7w==
X-Received: by 2002:a17:90b:164b:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3b3d0642049mr4247963a91.8.1795053462270;
        Wed, 18 Nov 2026 17:57:42 -0800 (PST)
Received: from [172.17.0.2] ([4.154.155.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4021b056dsm392791a91.9.2026.11.18.17.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:57:41 -0800 (PST)
Message-ID: <6afe5795.e1fc1a02.8bcf5.55bb@mx.google.com>
Date: Wed, 18 Nov 2026 17:57:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6211744548708456163=="
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
In-Reply-To: <20261118195846.393710-2-luiz.dentz@gmail.com>
References: <20261118195846.393710-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6211744548708456163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9zZXJpZXMvMTIxNTQwMS8KCi0tLVRlc3QgcmVzdWx0LS0tCgpUZXN0IFN1
bW1hcnk6CkNoZWNrUGF0Y2ggICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA0LjQ1IHNlY29u
ZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDIuOTkgc2Vjb25kcwpC
dWlsZEVsbCAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTMuOTIgc2Vjb25kcwpCbHVl
ek1ha2UgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTg1Ljg2IHNlY29uZHMKTWFrZUNo
ZWNrICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDEzLjA4IHNlY29uZHMKTWFrZURpc3Rj
aGVjayAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDEwMi42NiBzZWNvbmRzCkNoZWNrVmFsZ3Jp
bmQgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyMzIuNTEgc2Vjb25kcwpDaGVja1NtYXRjaCAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTgyLjUyIHNlY29uZHMKYmx1ZXptYWtlZXh0ZWxs
ICAgICAgICAgICAgICAgUEFTUyAgICAgIDYyLjQxIHNlY29uZHMKVGVzdEZ1bmN0aW9uYWwgICAg
ICAgICAgICAgICAgUEFTUyAgICAgIDg5NS45OCBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAg
ICAgICAgICAgIFBBU1MgICAgICAyOTguNzIgc2Vjb25kcwpTY2FuQnVpbGQgICAgICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgNjIzLjQxIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBGQUlMCkRlc2M6IFJ1biBnaXRsaW50Ck91
dHB1dDoKW0JsdWVaLHYyLDAzLzE2XSBzaGFyZWQvcmFwOiBTdWJzY3JpYmUgb24tZGVtYW5kIGRh
dGEgd2l0aCB0aGUgcmVxdWVzdGVkIHRyYW5zcG9ydAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXgg
bGVuZ3RoICg4Mj44MCk6ICJbQmx1ZVosdjIsMDMvMTZdIHNoYXJlZC9yYXA6IFN1YnNjcmliZSBv
bi1kZW1hbmQgZGF0YSB3aXRoIHRoZSByZXF1ZXN0ZWQgdHJhbnNwb3J0IgpbQmx1ZVosdjIsMDgv
MTZdIHByb2ZpbGVzL3Jhbmdpbmc6IExldCBTdGFydE1lYXN1cmVtZW50KCkgcGljayB0aGUgSW5p
dGlhdG9yIGZvciBCb3RoCgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTog
IltCbHVlWix2MiwwOC8xNl0gcHJvZmlsZXMvcmFuZ2luZzogTGV0IFN0YXJ0TWVhc3VyZW1lbnQo
KSBwaWNrIHRoZSBJbml0aWF0b3IgZm9yIEJvdGgiCltCbHVlWix2MiwxMi8xNl0gcHJvZmlsZXMv
cmFuZ2luZzogRGVmZXIgQ1MgU2VjdXJpdHkgRW5hYmxlIHVudGlsIHRoZSBsaW5rIGlzIGVuY3J5
cHRlZAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4Nz44MCk6ICJbQmx1ZVosdjIs
MTIvMTZdIHByb2ZpbGVzL3Jhbmdpbmc6IERlZmVyIENTIFNlY3VyaXR5IEVuYWJsZSB1bnRpbCB0
aGUgbGluayBpcyBlbmNyeXB0ZWQiCltCbHVlWix2MiwxMy8xNl0gcHJvZmlsZXMvcmFuZ2luZzog
Q2hvb3NlIHRoZSBDUyBhbnRlbm5hIGNvbmZpZ3VyYXRpb24gZnJvbSBib3RoIGVuZHMKCjE6IFQx
IFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODU+ODApOiAiW0JsdWVaLHYyLDEzLzE2XSBwcm9m
aWxlcy9yYW5naW5nOiBDaG9vc2UgdGhlIENTIGFudGVubmEgY29uZmlndXJhdGlvbiBmcm9tIGJv
dGggZW5kcyIKW0JsdWVaLHYyLDE0LzE2XSBwcm9maWxlcy9yYW5naW5nOiBEbyBub3Qgc3RhcnQg
YSBwcm9jZWR1cmUgYWZ0ZXIgU3RvcE1lYXN1cmVtZW50KCkKCjE6IFQxIFRpdGxlIGV4Y2VlZHMg
bWF4IGxlbmd0aCAoODM+ODApOiAiW0JsdWVaLHYyLDE0LzE2XSBwcm9maWxlcy9yYW5naW5nOiBE
byBub3Qgc3RhcnQgYSBwcm9jZWR1cmUgYWZ0ZXIgU3RvcE1lYXN1cmVtZW50KCkiCltCbHVlWix2
MiwxNS8xNl0gc2hhcmVkL3JhcDogU3RhcnQgdGhlIFJlYWwtdGltZSB0aW1lb3V0IHdoZW4gdGhl
IHByb2NlZHVyZSBzdGFydHMKCjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODI+ODAp
OiAiW0JsdWVaLHYyLDE1LzE2XSBzaGFyZWQvcmFwOiBTdGFydCB0aGUgUmVhbC10aW1lIHRpbWVv
dXQgd2hlbiB0aGUgcHJvY2VkdXJlIHN0YXJ0cyIKW0JsdWVaLHYyLDE2LzE2XSB1bml0L3Rlc3Qt
cmFwOiBBZGQgdGVzdHMgZm9yIFJhbmdpbmcgRGF0YSBzdWJzY3JpcHRpb24gYW5kIGNvdW50ZXJz
CgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg0PjgwKTogIltCbHVlWix2MiwxNi8x
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
b3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjExMDc2OiBjaGVja10gRXJyb3IgMgoKCmh0dHBzOi8v
Z2l0aHViLmNvbS9ibHVlei9ibHVlei9wdWxsLzI4NDYKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVl
dG9vdGgKCg==

--===============6211744548708456163==--
