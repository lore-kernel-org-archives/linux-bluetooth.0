Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F33C6BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109377; cv=none; b=uNnbSWSX+P0XKoSPMxcH7gpTGfL8UaZxSAIyfjXL7pxiOQJ18nQBfrmXzPZo8/O5bjd0FglvRzCslfniZlE9WQJJ6jTtk0uVZDl0Gv3VblujGpHXJlei7rdNuLb+zhlUJEhzaeLsI4HbTjn6F3wQGmNaLF/YMJguMKeP+LnOmZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109377; c=relaxed/simple;
	bh=xU9krIdBZoNidBPazH5es1A0nV6TBF6sIW/oxYD2aJ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tr4FyMFiNCxd++d9LTxMualMxL87+0QcYO90kvvNhSsAUQ0r5PaVLhjGMHyjIoTfn+Dg+I9SaOb/VkuyGNbzxXc6XSUccMlFSKMr/OFn1uG9AyhyPQyAaZC7PVClGwkCavTZTP7OcrjA/EjZTr9lCKpbqRtRcSJNtHW4HO1lI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjRtD+kD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjRtD+kD"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4786741276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724109374; x=1724714174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xU9krIdBZoNidBPazH5es1A0nV6TBF6sIW/oxYD2aJ8=;
        b=OjRtD+kDaQ+e+EqpLKgaM7y8gNppvMoQYwwBAls1MlQHACAaJ7gKNt26YT94M3iQiA
         e5qsTgTS8eeYgMg91g7Eqnruqnh+Q1a3WU/Ifw3wa83v2hWANHIrJAL4rPFBeLfgeY4n
         qsnbG4poNlOksF92/rIwqFyiVP6AQImg9W2FCP87ixE86murZFyWQ4PECbLcE9WpXwu/
         lb1VdD33O0eQBNBjtfjWi1teJwIZcs34gcRVpISFf9tzvt88hvMvawxetqUKyMFicJ5z
         9uzDQh/OUQpJDFIYnfjwGQUhaOOepJhjnIBWwmi6pkb2yXFVFX+XzuvXvfG2s1C+8OiK
         l4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724109374; x=1724714174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xU9krIdBZoNidBPazH5es1A0nV6TBF6sIW/oxYD2aJ8=;
        b=CIkg5b4BqGX7bjtzHf88hq3H+mS9fUPYXc4cJoZVyqBklUhqAJX41tiYfQINvHkhet
         fmPxgBSrzQgd0Pl0mqTqN+4mlqAu1aJsSFGp9zLhNvyXKQAaSAvhILF014KIoKDWYkbl
         BvWeXCc7u+eXMTjksgW0mbKEgMj+CWn0n291/6QNSFYiw2Lw1BEhBT2qo2viMI5kwRKg
         var3gjPx2kq7nh8ffwJTIoJhOj5mKYmMJSrCcuNybq3WWr7IP8tU5TFeW/4/liyqYcUN
         OKpFJfYAgdZDxVe/2tCb1SmuhLMgwF845c0svWwRCaHcznmiaMI9MWBvyfMThy7A2YnS
         o+5g==
X-Gm-Message-State: AOJu0Yw9fD8+9yCG0+MxiyWM0+jaxWwo95rdgGYq5nneA/PInivm7g9Q
	bTNJtpMotJqG8ebZHO6GQHKqw483TtzeVXotqAE8w2XjkUW7fLMrhbz0Sw==
X-Google-Smtp-Source: AGHT+IHuJrZJ7B8bBtz6xxaTuhIckuD2zrq14iHgb9U/H3Dugnpjk//f2nGeRzZxa9ITaN+yBfhn+Q==
X-Received: by 2002:a05:6902:2209:b0:e13:e58b:1a32 with SMTP id 3f1490d57ef6-e13e58b1beemr7063847276.2.1724109374184;
        Mon, 19 Aug 2024 16:16:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.156.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff140f5sm46353276d6.146.2024.08.19.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 16:16:13 -0700 (PDT)
Message-ID: <66c3d23d.d40a0220.1eef8c.2e4d@mx.google.com>
Date: Mon, 19 Aug 2024 16:16:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2998885963468695753=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] hog-lib: Fix calling bt_uhid_destroy with invalid instance
In-Reply-To: <20240819205304.60594-1-luiz.dentz@gmail.com>
References: <20240819205304.60594-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2998885963468695753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgxMDQ1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC45MiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjY2IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI1LjI4IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE4MjguMDUgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTQuMDAgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTY4
Ljg1IHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI2NS4y
NyBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNzUuNDAg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTI3LjY3IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDMxOTkuMzAgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQRU5ESU5HICAgMTEyNy4xOCBzZWNv
bmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hl
Y2sgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoq
KiBbTWFrZWZpbGU6MTE3NjQ6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBb
TWFrZWZpbGU6MTE4NzI6IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZp
bGU6MTIzMDE6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNo
ZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlz
dGNoZWNrIC0gRkFJTApEZXNjOiBSdW4gQmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKUGFj
a2FnZSBjdXBzIHdhcyBub3QgZm91bmQgaW4gdGhlIHBrZy1jb25maWcgc2VhcmNoIHBhdGguClBl
cmhhcHMgeW91IHNob3VsZCBhZGQgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIGBjdXBzLnBjJwp0
byB0aGUgUEtHX0NPTkZJR19QQVRIIGVudmlyb25tZW50IHZhcmlhYmxlCk5vIHBhY2thZ2UgJ2N1
cHMnIGZvdW5kCm1ha2VbNF06ICoqKiBbTWFrZWZpbGU6MTE3NjQ6IHRlc3Qtc3VpdGUubG9nXSBF
cnJvciAxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE4NzI6IGNoZWNrLVRFU1RTXSBFcnJvciAy
Cm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTIzMDE6IGNoZWNrLWFtXSBFcnJvciAyCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6MTIzMDM6IGNoZWNrXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6
MTIyMjQ6IGRpc3RjaGVja10gRXJyb3IgMQojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogQ2hlY2tWYWxncmluZCAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sgd2l0
aCBWYWxncmluZApPdXRwdXQ6Cgp0b29scy9tZ210LXRlc3Rlci5jOiBJbiBmdW5jdGlvbiDigJht
YWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEyNzI1OjU6IG5vdGU6IHZhcmlhYmxlIHRyYWNr
aW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10cmFja2luZy1hc3NpZ25tZW50
c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjcyNSB8IGludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCiAgICAgIHwgICAgIF5+fn4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMTc2NDogdGVz
dC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMTg3MjogY2hlY2st
VEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMjMwMTogY2hlY2stYW1dIEVy
cm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMjMwMzogY2hlY2tdIEVycm9yIDIKIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFNjYW5CdWlsZCAtIFBFTkRJTkcKRGVzYzogUnVu
IFNjYW4gQnVpbGQKT3V0cHV0OgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============2998885963468695753==--
