Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF873F8C2
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823094; cv=none; b=Lz5593PEs9wR44mQdNBtQxSESI5f8b93nl66ybwJNW061nv7uO0EFrY0wgAIPxTnK1aPh57RFVIe3CaPGJGGTvZ9wpLT1ns8Z/P30MmEsBGlOivLYuPWxNhMH19URTbx+j8mtU5dpWOm40V/pc5wOCsfPvJ9dyoI9TRJWLpdo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823094; c=relaxed/simple;
	bh=suVtpdOhca70bxJ48ymrODVhPCCXAWw5iIh6NF/KbnE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o7nAhYS3GOeDZWIpcLdUh/nJcOJeKDKdRrP44CRyaa5wtG5JwGzTg6igV6/G095gE4L8GCDEA3HmqG8oNAeKvsg+gMRGtxe/rkZlIQF+vhW4yUt5ltZPmoyHvJpUi5vaHRLicTAoXRKJmwyY0x6y3AwBnzDr53YhJ25FkJXHMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk11sZrF; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk11sZrF"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c4673eff5so7649176d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706823091; x=1707427891; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=suVtpdOhca70bxJ48ymrODVhPCCXAWw5iIh6NF/KbnE=;
        b=gk11sZrFjw3BDJPrPM2ubyHFq7lqiTpEKXwFBiEAkAIY2sfw1jfOP0L8rSPoT8zIsR
         wTE21m6UE7a86yGEaHeeiGxOZfvDlVnO5pQ2VUc0IfhW5VGiF/hbKSUj2EqvLRYamGco
         k4H8gNicl2E8C63uiICd8XLMBQib7g3th0igvdU3IT+khp7r+epQSvr6G6L+CInno4FS
         QxXWMACfjWgRO2S4eu2L2TDrpphhjzMk+DnxL+1AUEs2nepnp76zGDkCpNDI9I1g9RU3
         hSpKoa9Q3U3uy5PKBlXuzmc4gCDW243ohseZcax0oKnwl8PZLrOlylPC4kh5FkNlyDGf
         fguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823091; x=1707427891;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suVtpdOhca70bxJ48ymrODVhPCCXAWw5iIh6NF/KbnE=;
        b=BQQLKHBPnsB4tcqmcDq7ONrF2AiPMR2kmXgBA4tTD2T8bOZ+lqaEBuDK9RYWRpkp/Y
         WhZRif1mPnKze/SvaMzmhFAQVpnHTVzGLdjQggbZFNkcBsQw9N66q6wg6AkBS0Sruhxx
         BUHWik6uczBRDqlTbbPxNXjelP4ZqngbgFEkP60PsUn72G/1KFSJfxO/lx5ZNaY8ft3F
         Nt00A+ba5weym8O046aMWp77P2CS9FKAyquancBCTxXGkHcfCjdc2sA4BETEqDZwGsZr
         N4SMzVFQVmZ17kBXtC82yYtn+FR5be0ZOpWzBwQBT+9LplK6zwzg6bgEUMc59Y0qU6jv
         979g==
X-Gm-Message-State: AOJu0YzgNh+c/WMXTaOzDPVi9XIlRwTUwuhO4gsad7cu6I7QeAUhXpff
	zD+snopYTsJqeIEvdWTncZ+jiYKP22jvl1rR9W6GuKMIYV1x2h2xP/zEOr41
X-Google-Smtp-Source: AGHT+IHqjkDSlZjMQou/2OG8+v5UG+zPMWdFDqyGz7VDnaT20I0kT6VzOGbRVyXKyctUjVDqxs1ueA==
X-Received: by 2002:a0c:f541:0:b0:685:7125:67e6 with SMTP id p1-20020a0cf541000000b00685712567e6mr49870qvm.1.1706823091013;
        Thu, 01 Feb 2024 13:31:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFnutQs0JkcsGlUJgH8ZfLvQQuheKF7eaCCJmNtYTrQeg02lllE6SL3zmcA1GqFw4GVOImQ3RhhaVTjgsJhbKDFZYMXQ==
Received: from [172.17.0.2] ([20.97.191.178])
        by smtp.gmail.com with ESMTPSA id mz9-20020a0562142d0900b0068c4b6000ccsm144748qvb.121.2024.02.01.13.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:31:30 -0800 (PST)
Message-ID: <65bc0db2.050a0220.28980.1341@mx.google.com>
Date: Thu, 01 Feb 2024 13:31:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4258234585541463178=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: Remove BT_HS
In-Reply-To: <20240201210707.1204633-1-luiz.dentz@gmail.com>
References: <20240201210707.1204633-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4258234585541463178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODIyMjc5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMi41OSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjM0IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjcuNDAgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMzAu
NTIgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzUuNjIg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgOTguMzQgc2Vj
b25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjYuODYgc2Vjb25k
cwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDM4LjM3IHNlY29uZHMK
VGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDIzLjA5IHNlY29uZHMKVGVz
dFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDQzLjMwIHNlY29uZHMKVGVzdFJ1
bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDYuODggc2Vjb25kcwpUZXN0UnVubmVy
X21nbXQtdGVzdGVyICAgICAgICBGQUlMICAgICAgMTYyLjIzIHNlY29uZHMKVGVzdFJ1bm5lcl9y
ZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDEwLjczIHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDE0LjUyIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10
ZXN0ZXIgICAgICAgUEFTUyAgICAgIDEyLjIzIHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNoLXRlc3Rl
ciAgICAgICAgUEFTUyAgICAgIDguNzggc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIgICAg
ICAgICBQQVNTICAgICAgMTEuOTQgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAg
ICBQQVNTICAgICAgNy4zMiBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBB
U1MgICAgICAyNi4zOSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIwpUZXN0OiBDaGVja1BhdGNoIC0gRkFJTApEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3Jp
cHQKT3V0cHV0OgpbdjJdIEJsdWV0b290aDogUmVtb3ZlIEJUX0hTCldBUk5JTkc6IFByZWZlciBh
IG1heGltdW0gNzUgY2hhcnMgcGVyIGxpbmUgKHBvc3NpYmxlIHVud3JhcHBlZCBjb21taXQgZGVz
Y3JpcHRpb24/KQojOTQ6IApodHRwczovL3d3dy5ibHVldG9vdGguY29tL2Jsb2cvbmV3LWNvcmUt
c3BlY2lmaWNhdGlvbi12NS0zLWZlYXR1cmUtZW5oYW5jZW1lbnRzLwoKV0FSTklORzogYWRkZWQs
IG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5n
PwojMjYzOiAKZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDIgd2Fy
bmluZ3MsIDAgY2hlY2tzLCAxNTA3IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRo
ZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hh
bmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4
LWlucGxhY2UuCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMvc3JjLzEzNTQxODE0LnBhdGNoIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBl
czogVU5LTk9XTl9DT01NSVRfSUQKCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBmYWxz
ZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjClRlc3Q6IENoZWNrQWxsV2FybmluZyAtIFdBUk5JTkcKRGVzYzogUnVuIGxpbnV4IGtl
cm5lbCB3aXRoIGFsbCB3YXJuaW5nIGVuYWJsZWQKT3V0cHV0OgpuZXQvYmx1ZXRvb3RoL2wyY2Fw
X2NvcmUuYzoxMjI0OjEzOiB3YXJuaW5nOiDigJhsMmNhcF9tb3ZlX3NldHVw4oCZIGRlZmluZWQg
YnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0gMTIyNCB8IHN0YXRpYyB2b2lkIGwyY2Fw
X21vdmVfc2V0dXAoc3RydWN0IGwyY2FwX2NoYW4gKmNoYW4pICAgICAgfCAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+fn5+bmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmM6MTY4OjI3OiB3YXJuaW5n
OiDigJhsMmNhcF9nZXRfY2hhbl9ieV9pZGVudOKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtZnVuY3Rpb25dICAxNjggfCBzdGF0aWMgc3RydWN0IGwyY2FwX2NoYW4gKmwyY2FwX2dl
dF9jaGFuX2J5X2lkZW50KHN0cnVjdCBsMmNhcF9jb25uICpjb25uLCAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tTcGFyc2UgLSBXQVJOSU5HCkRlc2M6IFJ1biBzcGFy
c2UgdG9vbCB3aXRoIGxpbnV4IGtlcm5lbApPdXRwdXQ6Cm5ldC9ibHVldG9vdGgvaGNpX2V2ZW50
LmM6IG5vdGU6IGluIGluY2x1ZGVkIGZpbGUgKHRocm91Z2ggaW5jbHVkZS9uZXQvYmx1ZXRvb3Ro
L2hjaV9jb3JlLmgpOm5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjEyMjQ6MTM6IHdhcm5pbmc6
IOKAmGwyY2FwX21vdmVfc2V0dXDigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1
bmN0aW9uXW5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjE2ODoyNzogd2FybmluZzog4oCYbDJj
YXBfZ2V0X2NoYW5fYnlfaWRlbnTigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1
bmN0aW9uXQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tTbWF0Y2gg
LSBXQVJOSU5HCkRlc2M6IFJ1biBzbWF0Y2ggdG9vbCB3aXRoIHNvdXJjZQpPdXRwdXQ6Cm5ldC9i
bHVldG9vdGgvaGNpX2V2ZW50LmM6IG5vdGU6IGluIGluY2x1ZGVkIGZpbGUgKHRocm91Z2ggaW5j
bHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgpOm5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5j
OjEyMjQ6MTM6IHdhcm5pbmc6IOKAmGwyY2FwX21vdmVfc2V0dXDigJkgZGVmaW5lZCBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXW5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jOjE2ODoy
Nzogd2FybmluZzog4oCYbDJjYXBfZ2V0X2NoYW5fYnlfaWRlbnTigJkgZGVmaW5lZCBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogVGVzdFJ1bm5lcl9tZ210LXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIG1nbXQtdGVzdGVy
IHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpUb3RhbDogNDk3LCBQYXNzZWQ6IDQ4NiAoOTcuOCUp
LCBGYWlsZWQ6IDUsIE5vdCBSdW46IDYKCkZhaWxlZCBUZXN0IENhc2VzClJlYWQgRXh0IENvbnRy
b2xsZXIgSW5mbyAxICAgICAgICAgICAgICAgICAgICAgICAgICAgRmFpbGVkICAgICAgIDAuMTY2
IHNlY29uZHMKUmVhZCBFeHQgQ29udHJvbGxlciBJbmZvIDIgICAgICAgICAgICAgICAgICAgICAg
ICAgICBGYWlsZWQgICAgICAgMC4xOTMgc2Vjb25kcwpSZWFkIEV4dCBDb250cm9sbGVyIEluZm8g
MyAgICAgICAgICAgICAgICAgICAgICAgICAgIEZhaWxlZCAgICAgICAwLjE4NCBzZWNvbmRzClJl
YWQgRXh0IENvbnRyb2xsZXIgSW5mbyA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgRmFpbGVk
ICAgICAgIDAuMTc5IHNlY29uZHMKUmVhZCBFeHQgQ29udHJvbGxlciBJbmZvIDUgICAgICAgICAg
ICAgICAgICAgICAgICAgICBGYWlsZWQgICAgICAgMC4yMDYgc2Vjb25kcwoKCi0tLQpSZWdhcmRz
LApMaW51eCBCbHVldG9vdGgKCg==

--===============4258234585541463178==--
