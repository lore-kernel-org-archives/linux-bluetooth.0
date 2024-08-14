Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398A1BA860
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655075; cv=none; b=qUN1YvPvUpP3i7ptb3qmhBf5XsBAZ+OPX76rU6ftpznJdx4Va1hNVhyxePYObZenpx+wppGEt2YNCQuaTdjZYdZ7Bkb7WgeE8P7TvrVsLrtR7yrh14LjMu9sKZSJ8NC/N1X9kJWW/rjgEQ2Li9dZn83i0txHoQKd7vgPHGoO+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655075; c=relaxed/simple;
	bh=3HfiSSCTlBVLwsF0AS3R3UJ4FONBX1JFbQdsl2g8d6U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eQYMJDRHs36NPRHkzX7k81I+xyctqMieMH+duqF3m6Ub+6sM6n4GkLiO6uq3Cd4e2EoJLRW01tk3Z5MdynNGVoxCmKkYkgrzzcc3YRsiubFpmxAMwY5zGoN1r3qz1yU35Ytf6vB3oezWdO7Dsoci9+8BwVLv/+zzJolguMO04LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmCX4Oex; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmCX4Oex"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so108467a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2024 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723655073; x=1724259873; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3HfiSSCTlBVLwsF0AS3R3UJ4FONBX1JFbQdsl2g8d6U=;
        b=jmCX4OexeH6qBufyrMePGXkBieDZtJ+2urN2WsfHePz4rCbGadCuDAe018CYaXbZOd
         jI0tg3SkufqegdTRt98YQDE9ECmps0Fi3Fs51sHdU/lRbLjAAYLrW7gepIYQ2zL3Wlfa
         ZBdkCdHlX///a8sSXwqUw1xpsFJEGmsyItT/pewOciEH/NrpTonwMA2s+QXEOhtMBuIM
         x7DHXA2KwDQ5Ku8B8CmggXrb5YnJUV0Hrfn0Suzu+OPNM5uFYF1L/hRb17JLnSwvYyx9
         wbYsZ5CDmxXz3eH2bNkVXaqqsNca79zBV7PC+emHlcjse4jcfwdRrpB8CMNhl/zYcKRP
         DrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655073; x=1724259873;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HfiSSCTlBVLwsF0AS3R3UJ4FONBX1JFbQdsl2g8d6U=;
        b=VUnQjLtTzz8f4tct9tiSfoeMAB+2RDtpS0QXQChlomUz2V0czmkTjmru9QD16e5eCU
         +BdgyNhKLHW+8mlo0UCX4usdssbg9N/ceC+MmS+wEEJ7psnuIcuQL8eJQ+PD+HIKJzXE
         +/kst8PvNYBqCqcFD8aQlpBm2yypnN4JTyhSTV8br6teaSkIVnOC9KCDG2cxesJ80obl
         imgwviUTMUasOvhG6WSAO2ykHApnUhtWglvWrXGB1UgJ5NRxyg33NvN99+jlKXsJ10uO
         saEclaQ4Lsrg24tmHQpanjHx5fjMLNdT/5rGT5TLWn6oEqYNiKwK/9/UwxXF0qTkemjE
         T5fw==
X-Gm-Message-State: AOJu0Yzxleb0kRqGHyMySkDivwRRtZxOeuuV2YNW97vLH3pAydWOYk+g
	JGBz+rtTPannuSgt666VPwy6OlJDNDOYiof4tIOyWjdsVqaNXD8ZylQneA==
X-Google-Smtp-Source: AGHT+IGt/daamwLWV1ciZnkX5ZthLn3pf7OA82jU60bdFkqeVmKaWfTkRZewt3IMbjfe5tgApnTlCQ==
X-Received: by 2002:a17:90a:9a90:b0:2ca:4fca:2892 with SMTP id 98e67ed59e1d1-2d3aaa7af5cmr3878572a91.7.1723655072568;
        Wed, 14 Aug 2024 10:04:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.25.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a06af5sm3404026a12.45.2024.08.14.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:04:32 -0700 (PDT)
Message-ID: <66bce3a0.630a0220.13e7c3.d52d@mx.google.com>
Date: Wed, 14 Aug 2024 10:04:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5131113220861917663=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test-uhid: Add support for device specific testing
In-Reply-To: <20240814151135.725001-1-luiz.dentz@gmail.com>
References: <20240814151135.725001-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5131113220861917663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODc5NjgwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC42NCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjQ1IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI1LjYwIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE2OTAuNzIgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuODMgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTY0
LjAxIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI2MC41
NyBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNjYuODcg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTI0LjY5IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE0OTYuNTIgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTA2Ni42NyBzZWNv
bmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1Bh
dGNoIC0gRkFJTApEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgpbQmx1ZVos
djFdIHRlc3QtdWhpZDogQWRkIHN1cHBvcnQgZm9yIGRldmljZSBzcGVjaWZpYyB0ZXN0aW5nCldB
Uk5JTkc6Q09NTUlUX0xPR19MT05HX0xJTkU6IFBvc3NpYmxlIHVud3JhcHBlZCBjb21taXQgZGVz
Y3JpcHRpb24gKHByZWZlciBhIG1heGltdW0gNzUgY2hhcnMgcGVyIGxpbmUpCiM5NTogCmlucHV0
OiBNWCBBbnl3aGVyZSAzIGFzIC9kZXZpY2VzL3ZpcnR1YWwvbWlzYy91aGlkLzAwMDU6MDQ2RDpC
MDI1LjAwMzEvaW5wdXQvaW5wdXQ4NgoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy8xMzc2MzYz
NC5wYXRjaCB0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDEyNyBsaW5lcyBjaGVja2VkCgpO
T1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUg
YWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1
c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy8x
Mzc2MzYzNC5wYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJ
Z25vcmVkIG1lc3NhZ2UgdHlwZXM6IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFDUk8gQ09OU1Rf
U1RSVUNUIEZJTEVfUEFUSF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVSX1BBQ0tFRCBT
UERYX0xJQ0VOU0VfVEFHIFNQTElUX1NUUklORyBTU0NBTkZfVE9fS1NUUlRPCgpOT1RFOiBJZiBh
bnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVwb3J0CiAgICAg
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gRkFJTApEZXNj
OiBSdW4gZ2l0bGludApPdXRwdXQ6CltCbHVlWix2MV0gdGVzdC11aGlkOiBBZGQgc3VwcG9ydCBm
b3IgZGV2aWNlIHNwZWNpZmljIHRlc3RpbmcKCldBUk5JTkc6IEkzIC0gaWdub3JlLWJvZHktbGlu
ZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1c2luZyBQeXRob24gcmVnZXggJ21h
dGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAobWF0Y2ggYW55d2hlcmUpIHNlbWFu
dGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5LWxpbmVzLnJlZ2V4IG9wdGlvbiBh
Y2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywgc2V0IGdlbmVyYWwucmVnZXgtc3R5
bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6Ly9qb3Jpc3Jvb3ZlcnMuZ2l0aHVi
LmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2VhcmNoCjk6IEIxIExpbmUg
ZXhjZWVkcyBtYXggbGVuZ3RoICg4ND44MCk6ICJpbnB1dDogTVggQW55d2hlcmUgMyBhcyAvZGV2
aWNlcy92aXJ0dWFsL21pc2MvdWhpZC8wMDA1OjA0NkQ6QjAyNS4wMDMxL2lucHV0L2lucHV0ODYi
CjEwOiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTIxPjgwKTogImxvZ2l0ZWNoLWhpZHBw
LWRldmljZSAwMDA1OjA0NkQ6QjAyNS4wMDMxOiBpbnB1dCxoaWRyYXcxMDogQkxVRVRPT1RIIEhJ
RCB2MC4xNCBNb3VzZSBbTVggQW55d2hlcmUgM10gb24gMDA6MDA6MDA6MDA6MDA6MDAiCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1
biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE3NjQ6
IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE4NzI6IGNo
ZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzMDE6IGNoZWNrLWFt
XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNoZWNrXSBFcnJvciAyCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNj
OiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFja2FnZSBjdXBzIHdhcyBub3Qg
Zm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBlcmhhcHMgeW91IHNob3VsZCBh
ZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0byB0aGUgUEtHX0NPTkZJR19Q
QVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1cHMnIGZvdW5kCm1ha2VbNF06
ICoqKiBbTWFrZWZpbGU6MTE3NjQ6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbM106ICoq
KiBbTWFrZWZpbGU6MTE4NzI6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMl06ICoqKiBbTWFr
ZWZpbGU6MTIzMDE6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIz
MDM6IGNoZWNrXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIyMjQ6IGRpc3RjaGVja10g
RXJyb3IgMQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tWYWxncmlu
ZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sgd2l0aCBWYWxncmluZApPdXRwdXQ6
Cgp0b29scy9tZ210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210
LXRlc3Rlci5jOjEyNzI1OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhj
ZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0
aG91dAoxMjcyNSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAg
IF5+fn4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc2NDogdGVzdC1zdWl0ZS5sb2ddIEVycm9y
IDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg3MjogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFr
ZVsxXTogKioqIFtNYWtlZmlsZToxMjMwMTogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtN
YWtlZmlsZToxMjMwMzogY2hlY2tdIEVycm9yIDIKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRv
b3RoCgo=

--===============5131113220861917663==--
