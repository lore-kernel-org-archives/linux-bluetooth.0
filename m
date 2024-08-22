Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F0181310
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331800; cv=none; b=lVcSwKs/ieXn4Cw9UnuyWG8gdXulg4SWZfCOfZ4cAnkpppu4HBTQmuwXUlwR/Z65VZiammknNdCHXoNn1+8WH6/O8JBTZoH9tjfax2cbaU//xm6vH0fHshxep4gjgo7UO6FG6K70yCxpUAZa7tMyZHmTD4Bp20MKCtWQI5b0mB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331800; c=relaxed/simple;
	bh=pwaQnqKyjrt6j4kum92jXbTlAwcfOUwYM+nQObEhVtM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=THIiRtBbvpwrtmMvMi7Is+Fra6whpFDuclJkXB4vs/dYgVkAYwedGqlKTYTBBj5KmzDgRdyIFVF+tw8bdbz/oPd8ZFAAoXp2b5A7b/d4rXVo2zqwMeDJG41JIVa1q/gcDg20ZSUDvgF/6WbEDP2DNj3nXoBtKpgi+INJoesZHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY30oJpI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY30oJpI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d984ed52so52787885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724331798; x=1724936598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pwaQnqKyjrt6j4kum92jXbTlAwcfOUwYM+nQObEhVtM=;
        b=OY30oJpIPMF8KxyuL9MXljkhOdjnKFdEQq5EZDyPCI83QaflbFpQF6dt4Hkrvi19Vb
         0YpXcw1UW04rkkDeHLt1n26f7FxYFJe2U7+QkaB8pTjxhDcU4+vF/fGwvrVvTZGqdriS
         tU1Uk25duCQvsoZxOJU8MVWyXWIGnrgesaAYqn1Y7KIWWMcczWg9xuEcPzkDFJynf/O1
         WZsN5SO6RRxx8TPa8Ij17kJu6nBapscpLf6sjJ+VhGUBc7tTgH0vsqMcLt0MKK2ndwv7
         rjSKfQoaJg8ZfGY+k2lYgYHQq2NG3yXhVDAsGpTpZK0q+hT7KnxGSkXvkRszkp/V4eAu
         B4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724331798; x=1724936598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwaQnqKyjrt6j4kum92jXbTlAwcfOUwYM+nQObEhVtM=;
        b=foxCP2ZfBMgwRh5pJz8CssOQfzyZsV3Yp0rQTxLGwRyWik0leymLnfAlNOOKJGf5Pz
         QLZhTW9xGMzryK/hR1ycEV9NUoQ56C4EXs2LNJTO6QOCsHgMBhmW6QYrb5WOKgANxLOx
         1xiq99uy67AWlnq+dPGsevoBRAgPW6EJZ8kQMgc74GPNOcH0ey3a05lpTj8N4MNmAU1C
         nRhYklxgCdVa0mxK6P8imvUB9hXwBo9ltbON7tIQzBj3ab2s31XdMoH+JITtPncPbpd3
         Fs3PMt1R65CAEL/7aAlG/nK1TcdH1ZcWIOZ4bpJcPeRESGd7754D7qQ/C4b+RfXnYoTS
         M72g==
X-Gm-Message-State: AOJu0Yxk/DzoOX4i/qrlMTUQRkjFo4vTTUWoQjZ4iT7b/TTJOlZgUMLJ
	xvL89rxSy7RbLAGOMjpS6qKuysLoLXgl9DEW2GaM+P07dTr38P9hSQ/0vA==
X-Google-Smtp-Source: AGHT+IFZypO0DAfoZvy0dFmjCF66P603c5B2dKbaxzR28ygU/RI3U5KfwNXup6OagWg2TMWZM9gAIw==
X-Received: by 2002:a05:620a:3907:b0:79f:66f:9daf with SMTP id af79cd13be357-7a6740c5c27mr657963985a.47.1724331797560;
        Thu, 22 Aug 2024 06:03:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.106.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb329sm66480585a.78.2024.08.22.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:03:17 -0700 (PDT)
Message-ID: <66c73715.050a0220.1226a.21a8@mx.google.com>
Date: Thu, 22 Aug 2024 06:03:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8888999212431472810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kupper.benedek@gmail.com
Subject: RE: [BlueZ] gatt-client: allow AcquireNotify when characteristic has indicate flag
In-Reply-To: <20240822113226.223790-1-kupper.benedek@gmail.com>
References: <20240822113226.223790-1-kupper.benedek@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8888999212431472810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgyMTMxCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC40NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMyIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0LjUwIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE2ODUuNDAgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuODIgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTU5
LjIwIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1MS4x
MCBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTMuOTUg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTE5LjcxIHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE0NDAuNjEgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTAzMS4xOSBzZWNv
bmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hl
Y2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoq
KiBbTWFrZWZpbGU6MTE3NjY6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBb
TWFrZWZpbGU6MTE4NzQ6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MTIzMDM6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDU6IGNo
ZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlz
dGNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFj
a2FnZSBjdXBzIHdhcyBub3QgZm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBl
cmhhcHMgeW91IHNob3VsZCBhZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0
byB0aGUgUEtHX0NPTkZJR19QQVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1
cHMnIGZvdW5kCm1ha2VbNF06ICoqKiBbTWFrZWZpbGU6MTE3NjY6IHRlc3Qtc3VpdGUubG9nXSBF
cnJvciAxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE4NzQ6IGNoZWNrLVRFU1RTXSBFcnJvciAy
Cm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6MTIzMDU6IGNoZWNrXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6
MTIyMjY6IGRpc3RjaGVja10gRXJyb3IgMQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogQ2hlY2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sgd2l0
aCBWYWxncmluZApPdXRwdXQ6Cgp0b29scy9tZ210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJht
YWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEyNzI1OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNr
aW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50
c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjcyNSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCiAgICAgIHwgICAgIF5+fn4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc2NjogdGVz
dC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg3NDogY2hlY2st
VEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMwMzogY2hlY2stYW1dIEVy
cm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMwNTogY2hlY2tdIEVycm9yIDIKCgotLS0KUmVn
YXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============8888999212431472810==--
