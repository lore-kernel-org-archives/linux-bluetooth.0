Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E61E501C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087227; cv=none; b=RRAyUNuyb1ukM5rt/GTNEs2490UuvN7MChTxqbQ52ltkaWfF9qXuKvyoVe7rnjVYwq7jqFCnU+Qi7njAIffxErnV/LqgjTwWlPl2ImUseOcgOkT8x14y+BqP1kgxeXfKEFO6b69QTKFeKT6GasGXbDFDW8f7sk6oM0T1NowidRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087227; c=relaxed/simple;
	bh=b64zrgBxo9K3MqYEfXWt0MZXt/3fu3Q0mi8QZT1Qn8A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GBSQrfkPi9o/h6xDviQXtl+bePCdlVpdUfYgyvUp0c61pV64TmTMvaZKsvNwO988uUy4gutA4VwyRo/PuGcZY4+tkU6iiYFnA+CTlTw9Pz7CpS63XZ1GOU0LNfGWgzZ1hUJwvBwn4B0XnLUPQoD36l32EhqkBg23bznqZ2Cg/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn2f4a7b; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn2f4a7b"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so3993729a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750087225; x=1750692025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b64zrgBxo9K3MqYEfXWt0MZXt/3fu3Q0mi8QZT1Qn8A=;
        b=jn2f4a7bMIagpCcT/b0RjluLVG7WPqu5/0D77nisaRkT8thOFmVSKPD4vVy/yUkK4w
         nuUp+vK6hfn8J5ElMhE6NgbNEMlviLj9syLdCmYIJ6SP6vca+cggKv6fzzKiEEY0q4//
         OiT8tICrjKwaHfstTPmtXK3OQb8BNprdERxj2yGMIf87epp+HpKYK63ucQwQiIaso2lW
         hV8w5EQ8yfl3ndaGk9FTxr8oiUhCef29QFx3Hd/5U+p7+W58qqRr82BLcx0rP66TWOl/
         n0LlYH+xwmDsHT9IFOtUIhlA1xcJBFY1O4uqCnx+kerW78R5buSJGNLi9iEdhqt/PW4R
         EAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750087225; x=1750692025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b64zrgBxo9K3MqYEfXWt0MZXt/3fu3Q0mi8QZT1Qn8A=;
        b=kBcIyt47IBZUT9vfpC874cSsAIQqonSSvQ0RlVJj2zfmfZByxdbvc1fe9ONDKVgy4R
         ogLyv4A138M7IY5MfQ4aIl9cYh1xjPPBW9ELhrH0TycxUIspmuGUmRMEZsXyfIGssxgp
         EagU9gN5Panpe1QIYZaiSSwWMFRLDJmbUr8kNzqahudZvIBFvazvxiaJTvNI1Nlh/h5D
         uvZ53d9nm1ILBd6NLE7LWTFTWRbo5F9wqHDG4mCLrKTpCBJWcbxLR3Oyb1HTSZf7rajG
         5IIogL7Cx8/hSq1c2Xoyoaux6lG1dbLXoEB0262hDGD78kPFYqnDn1mF2EjZXdJXFuwo
         KxCA==
X-Gm-Message-State: AOJu0YyN5PRWV/LwlI9QGsFCGeEyRho1VxUKUQGAymoeSsLkzazXXLpd
	qUE1q7u6325dGVbHl8TW3EfF/OLoUueUc9oLDdIiwCkmKYJHinx2HPyxu5Tqqg==
X-Gm-Gg: ASbGnctoZwLKoOlhNOGPJ6j9N8weubnTPa8bnG+Rof/dwJVs9T1CO9jSxwEX9+PfdWU
	8a0ylbyI2YL1aUGJd4TZweue5OXBKW/Lw8w0SXjuE/9WXeq2rjdJoYM2Hsm0afm5juR+w5+r2lN
	An/yBZYgsg9zWi7PMZ+wG1KZZ3iyB3eWsx/GAHt1x4ApCZPBzz8JJp7t3WV3P5ay6UeLE0D45Dg
	cH0hLIiXiJVob02+Bft2oRA3hW3zi/eJC8iwkjHrG+/TxKXjbLhfQiipDY/+Z9Tomgqdo2q+NGQ
	aqa2vBSSJdnmYC1OOYl3N+s/HYZImQ3p5j++w1+JmhbbxF6eIZaJRmVLtQ75gZIPQVCR
X-Google-Smtp-Source: AGHT+IFdk9d6vW6TA7RfYqQcLrTXSZDimPtOkhezhfmxo6YU0TuztoNuckAfsTGWPOuBlTU2WkXuyw==
X-Received: by 2002:a17:90b:3c8a:b0:311:ba32:164f with SMTP id 98e67ed59e1d1-313f1c9d429mr15200695a91.8.1750087224606;
        Mon, 16 Jun 2025 08:20:24 -0700 (PDT)
Received: from [172.17.0.2] ([104.40.91.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bdc49asm8777892a91.17.2025.06.16.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:20:24 -0700 (PDT)
Message-ID: <68503638.170a0220.87feb.0a7d@mx.google.com>
Date: Mon, 16 Jun 2025 08:20:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1042345808198071439=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix not using metadata set on stream->meta
In-Reply-To: <20250616135200.2551871-1-luiz.dentz@gmail.com>
References: <20250616135200.2551871-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1042345808198071439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTcyNTM4CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zMCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjMwIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIwLjQ3IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDMwNjYuNDcgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTQuMjMgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTc5
LjA0IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI0OS41
OCBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFdBUk5JTkcgICAzMDYuMzMg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTMyLjY4IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEVORElORyAgIDAuMzYgc2Vjb25k
cwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgOTI4LjA5IHNlY29uZHMK
CkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0Y2gg
LSBQRU5ESU5HCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdApPdXRwdXQ6CgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBFTkRJTkcKRGVzYzogUnVu
IGdpdGxpbnQKT3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2VDaGVjayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKLi90ZXN0
LWRyaXZlcjogbGluZSAxMDc6IDMyMzM1IEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1
bXBlZCkgIiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE4MDY6
IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE5MTQ6IGNo
ZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIzNDM6IGNoZWNrLWFt
XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzNDU6IGNoZWNrXSBFcnJvciAyCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNj
OiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFja2FnZSBjdXBzIHdhcyBub3Qg
Zm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBlcmhhcHMgeW91IHNob3VsZCBh
ZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0byB0aGUgUEtHX0NPTkZJR19Q
QVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1cHMnIGZvdW5kCi4uLy4uL3Rl
c3QtZHJpdmVyOiBsaW5lIDEwNzogNTUyNzIgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUg
ZHVtcGVkKSAiJEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVs0XTogKioqIFtNYWtlZmlsZToxMTgw
NjogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTkxNDog
Y2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMjM0MzogY2hlY2st
YW1dIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjM0NTogY2hlY2tdIEVycm9yIDIK
bWFrZTogKioqIFtNYWtlZmlsZToxMjI2NjogZGlzdGNoZWNrXSBFcnJvciAxCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApEZXNjOiBSdW4g
Qmx1ZXogTWFrZSBDaGVjayB3aXRoIFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21nbXQtdGVzdGVy
LmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6MTI5MDc6NTog
bm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRoIOKAmC1mdmFy
LXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CjEyOTA3IHwgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgouL3Rlc3QtZHJpdmVy
OiBsaW5lIDEwNzogNzUyMjAgQWJvcnRlZCAgICAgICAgICAgICAgICAgKGNvcmUgZHVtcGVkKSAi
JEAiID4gJGxvZ19maWxlIDI+JjEKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTgwNjogdGVzdC1z
dWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTkxNDogY2hlY2stVEVT
VFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjM0MzogY2hlY2stYW1dIEVycm9y
IDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjM0NTogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrU21hdGNoIC0gV0FSTklORwpEZXNjOiBSdW4g
c21hdGNoIHRvb2wgd2l0aCBzb3VyY2UKT3V0cHV0OgpzcmMvc2hhcmVkL2JhcC5jOjMxNzoyNTog
d2FybmluZzogYXJyYXkgb2YgZmxleGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6IG5v
dGU6IGluIGluY2x1ZGVkIGZpbGU6Li9zcmMvc2hhcmVkL2FzY3MuaDo4ODoyNTogd2FybmluZzog
YXJyYXkgb2YgZmxleGlibGUgc3RydWN0dXJlc3NyYy9zaGFyZWQvYmFwLmM6MzE3OjI1OiB3YXJu
aW5nOiBhcnJheSBvZiBmbGV4aWJsZSBzdHJ1Y3R1cmVzc3JjL3NoYXJlZC9iYXAuYzogbm90ZTog
aW4gaW5jbHVkZWQgZmlsZTouL3NyYy9zaGFyZWQvYXNjcy5oOjg4OjI1OiB3YXJuaW5nOiBhcnJh
eSBvZiBmbGV4aWJsZSBzdHJ1Y3R1cmVzc3JjL3NoYXJlZC9iYXAuYzozMTc6MjU6IHdhcm5pbmc6
IGFycmF5IG9mIGZsZXhpYmxlIHN0cnVjdHVyZXNzcmMvc2hhcmVkL2JhcC5jOiBub3RlOiBpbiBp
bmNsdWRlZCBmaWxlOi4vc3JjL3NoYXJlZC9hc2NzLmg6ODg6MjU6IHdhcm5pbmc6IGFycmF5IG9m
IGZsZXhpYmxlIHN0cnVjdHVyZXMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6
IEluY3JlbWVudGFsQnVpbGQgLSBQRU5ESU5HCkRlc2M6IEluY3JlbWVudGFsIGJ1aWxkIHdpdGgg
dGhlIHBhdGNoZXMgaW4gdGhlIHNlcmllcwpPdXRwdXQ6CgoKCi0tLQpSZWdhcmRzLApMaW51eCBC
bHVldG9vdGgKCg==

--===============1042345808198071439==--
