Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FB23ED75
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Feb 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938693; cv=none; b=N6oCDPmHon6Uspe27hD9+4dTBIfIsQHPyjuBA+FS3ci2gv8skFmG+qW5EUJoeEfgPhgDpp+DVE0wB8vDMJQBnKAh7fchvyvbAY0r00YqJ66WbZZN94WhsxBjI5pbLjnymQ1NET5j2kJZk2okedeZC5AOeLA3PYRI+niAIBDCvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938693; c=relaxed/simple;
	bh=Rfaa7nJ36fGCR/wdumx79Neo89+6aRnxkMFnXVhkOx0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n1IN/qarNlxzNmAp8i0/jOj7I5zweam/6WAdBa3MBHsdFmJYOiAhRKuClr0kuNPa+mpxdwLbfh85SlQsfiwSx8FljDxekSLVSMh9sqcrx7H2k+JR3tOOfXdINXjxkw+e0yJj9pdQ8Ju9tMvKoW7AQFrQ/OoE27C53gKEUVvvVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksWlB1FV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksWlB1FV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2165448243fso53016925ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2025 06:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738938690; x=1739543490; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfaa7nJ36fGCR/wdumx79Neo89+6aRnxkMFnXVhkOx0=;
        b=ksWlB1FVNA2jBm/f0BHfiRLOfDFFdpAYbNH7U8cm93gNrD2TLTw2Rj1Mg+0+xZBX6Y
         zrTRBik3kzxzx0ha9RP7l7PHduLXQDMGTw9ZrvsY2pZLdZsFSFMxUtF+dWpbZZ1cktxh
         ENOU7wnzBvvOlGO1hDY06WtsQ4UUKFBxkdqBlRWgs3bv1Fzwb5iLUlh5MdvDh2lIMw5g
         NVIBiXiywJohZTzeHmy9RnxwX+144KTN1XXw0hN79mGS5pD06EhmXmHUVfGmNig7tZiC
         zWmUF2VuCR7oFdZTikI4e6Z1bjmVBwzOrZKXPTw4Illm6LeV9Sri/HPBVnJUuv28zv3P
         NOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938690; x=1739543490;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfaa7nJ36fGCR/wdumx79Neo89+6aRnxkMFnXVhkOx0=;
        b=FbvwPDCKAuPy81aMOGwsjEzISb8NjiLsUZuHagxZ2WED2XVu1QrwU+2NfRHP/2+AJh
         RS+yBElfqsoTdX1J1dy3+K2whYz8J45Vefac15s+gvffDlDRlTlsNzaE1rZu+gK5myWO
         4pr1p02hcp9R8/WMBuL3o1wopB/lGOLZOi9AXISo+5DhaKGdxY4HYRvEze8tBrDyta34
         nD3PQ66H/Sp0SlFazEZmS2vGBkQm1/etC+nf16qDOENfBdIslyewL5Ys425Fq0k4pLfw
         FzOlR6WN7sB92xp0KCHNwph/B8BkQLDogDMWu/UOtGY4T3ijGrj0pEBdTTlED4uhL1v7
         upBA==
X-Gm-Message-State: AOJu0YxAvZ09CZ8P0Rsxgv8OTE2cut1xCk+OgqsAbAU9hekZYz18ExGE
	Sn27bmtJcNrWQ8xchb/gIYNuGOJBwBKPF9m3T7kQ+R/g8aBjLIwxtQdfDw==
X-Gm-Gg: ASbGncvoYx4qLCoetRp/EVm3VdPBqCi/o7Zi47s5tXwF2oKLVRt/XMPU5jLYQN4Kjgf
	nE0Vp/m3DuZpTkzR0FcQBC4VP6zcCKq8AVo+QTUE4TlKFAcWLJPBWB8rDoU1kouMgNGuQBSodyl
	/rcZVoqZcbGeTJVCbKdsFHeDlw5o4uW9c1jto52dQ85H79EOHugAPEqlT/bfjMH+bBNzk7oTjhf
	+HZNRCW46ZdC1JPvUDdBg3q+708RQcSLiDDMAmPX5gVDB4ezDCQD2Q3LoZTopEzIVH2NV5mmqPl
	ycGkkqicHxBxWNVGtF8YTQ==
X-Google-Smtp-Source: AGHT+IFflYV6dGkKS6AQL68Hw41IEeHnX1Bzlfemrhp+AjQCSiqTJw1O3LgCeGMtvYTbWN7WoAAPIQ==
X-Received: by 2002:a17:902:fc47:b0:215:385e:921c with SMTP id d9443c01a7336-21f4e7e2b32mr56458555ad.51.1738938690399;
        Fri, 07 Feb 2025 06:31:30 -0800 (PST)
Received: from [172.17.0.2] ([20.169.13.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650cf56sm31336465ad.11.2025.02.07.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:31:30 -0800 (PST)
Message-ID: <67a61942.170a0220.2def5c.6b76@mx.google.com>
Date: Fri, 07 Feb 2025 06:31:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7921177043915643696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lizhi.xu@windriver.com
Subject: RE: [next] Bluetooth: l2cap: protect conn refcnt under hci dev lock
In-Reply-To: <20250207140216.3076952-1-lizhi.xu@windriver.com>
References: <20250207140216.3076952-1-lizhi.xu@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7921177043915643696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTMxNjEwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zNyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjIyIHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMzMgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjQuNDMgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMjgu
MDEgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzAuNzAg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjQuNTAgc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDM2LjI3IHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDIwLjM1IHNlY29uZHMK
VGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDM1LjUwIHNlY29uZHMKVGVz
dFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDQuODEgc2Vjb25kcwpUZXN0UnVu
bmVyX21nbXQtdGVzdGVyICAgICAgICBGQUlMICAgICAgMTIwLjY3IHNlY29uZHMKVGVzdFJ1bm5l
cl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDcuOTUgc2Vjb25kcwpUZXN0UnVubmVyX3Nj
by10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgOS44MiBzZWNvbmRzClRlc3RSdW5uZXJfaW9jdGwt
dGVzdGVyICAgICAgIFBBU1MgICAgICA4LjE1IHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNoLXRlc3Rl
ciAgICAgICAgUEFTUyAgICAgIDYuODcgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIgICAg
ICAgICBQQVNTICAgICAgNy4wMSBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVyICAg
IFBBU1MgICAgICA1LjAyIHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVO
RElORyAgIDAuNzIgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBFTkRJTkcKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2Ny
aXB0Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50
IC0gUEVORElORwpEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6CgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpEZXNjOiBSdW4gbGlu
dXgga2VybmVsIHdpdGggYWxsIHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6Cm5ldC9ibHVldG9vdGgv
bDJjYXBfY29yZS5jOjc0Nzc6Mjc6IHdhcm5pbmc6IOKAmGwyY2FwX2Nvbm5faG9sZF91bmxlc3Nf
emVyb+KAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dIDc0NzcgfCBz
dGF0aWMgc3RydWN0IGwyY2FwX2Nvbm4gKmwyY2FwX2Nvbm5faG9sZF91bmxlc3NfemVybyhzdHJ1
Y3QgbDJjYXBfY29ubiAqYykgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBDaGVja1NwYXJzZSAtIFdBUk5JTkcKRGVzYzogUnVuIHNwYXJzZSB0b29sIHdpdGggbGludXgg
a2VybmVsCk91dHB1dDoKbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmM6NzQ3NzoyNzogd2Fybmlu
Zzog4oCYbDJjYXBfY29ubl9ob2xkX3VubGVzc196ZXJv4oCZIGRlZmluZWQgYnV0IG5vdCB1c2Vk
IFstV3VudXNlZC1mdW5jdGlvbl0KIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6
IFRlc3RSdW5uZXJfbWdtdC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBtZ210LXRlc3RlciB3aXRo
IHRlc3QtcnVubmVyCk91dHB1dDoKVG90YWw6IDQ5MCwgUGFzc2VkOiA0ODQgKDk4LjglKSwgRmFp
bGVkOiAyLCBOb3QgUnVuOiA0CgpGYWlsZWQgVGVzdCBDYXNlcwpMTCBQcml2YWN5IC0gU2V0IEZs
YWdzIDMgKDIgRGV2aWNlcyB0byBSTCkgICAgICAgICAgIEZhaWxlZCAgICAgICAwLjE5NCBzZWNv
bmRzCkxMIFByaXZhY3kgLSBTZXQgRGV2aWNlIEZsYWcgMSAoRGV2aWNlIFByaXZhY3kpICAgICAg
RmFpbGVkICAgICAgIDAuMTQyIHNlY29uZHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IEluY3JlbWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6IEluY3JlbWVudGFsIGJ1aWxk
IHdpdGggdGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CgoKCi0tLQpSZWdhcmRzLApM
aW51eCBCbHVldG9vdGgKCg==

--===============7921177043915643696==--
