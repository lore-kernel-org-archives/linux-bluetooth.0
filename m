Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828B1D515A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746219531; cv=none; b=iEc4Dx2vkmAitXNvOsxtF5QJ72BBqom3u9u0x5wpnRoBpYmF0eZFfNkTB/bHhqRL66mV6Tq+dKTYVuTMWOHvgllizwa8f06YycvTbSXxUHMIGMot5AfLfr3zwaqR9wPqKPpw6SWAsqXawsqLUW0MGdaHgvmj6qDNC4slpLr2anE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746219531; c=relaxed/simple;
	bh=zJZ23VRxbUcum+nF1ST7yNGZbEC/j9kKAKAb4upatZE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pqfNS656mFDaIFvpRO+j4HgIj6VcVODJT9HkJLtx/bXPp5P2nxKXHJO6oNfy52ckay4aYcSfdkEX3rn3HcWDETurs79A0XKt6pBuw9Tj5XgUHyoHpUVX6TmoeM8p+nG7xmeoQEFeWc96y8iZ7heTxj5DjGdjCVNxcV8Kftvu1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3u1mAMk; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3u1mAMk"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso25544656d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 May 2025 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746219528; x=1746824328; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zJZ23VRxbUcum+nF1ST7yNGZbEC/j9kKAKAb4upatZE=;
        b=Q3u1mAMkh483+J36vqoOgy2kdyhxZe5psq/7JrFJ7gcLRIrdZZJp/opzeTcs/FHqEB
         lHCxRO4rdEHMHRB4O429Pd7fn45lwt2wwpJm5u+r1bnmAT14LXBXH9yixe/r14TvoEZD
         DqhnYAYcOugtKxDAKJ0bVqfF4/5Cu0EAYVwPsSZgtPEetFqELUM6zT/ZOL9nSu82G202
         xPy3Bow7bBHgj5KmbvT3+kvLwHPFn++yIaD6mkZjfX1LFnPsnR6TyTUUl50s5TwdG+L6
         1RZycz9KnpYXrLRbgqsOV33tG7kJ2A4czzGfh76nbSdhT51iP/Ru2aWXTK5XIz1Zd1za
         DlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746219528; x=1746824328;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJZ23VRxbUcum+nF1ST7yNGZbEC/j9kKAKAb4upatZE=;
        b=Ry8RnTNgRQW7OeP96pmCAcwAPoQq3g3MNJeelsZskR05Wta5zJEnTOA5HIWXTLCWdN
         SfVhltjBH2rnk5cCBBvq5myiFLlaVOiR7XrhSJgQBgbY27IZdvjc3pQAEL7HfHar6L6k
         eiCoVhyD0oLfy5USNgsjzFOpGdxRKNuCNuVOnrFG7T3wmJOtijeag+wTxiysH2orJ9KS
         jT/B88+6R32bi/n5kYh5pY7esqN8wW6j5O+S8jIFRfMs+snluc9uuhAu+Xd1uyTMTd7X
         fmDy2zaDaI37QZcjfJtTaivczQOqJ4UgsnApzILq1Hy7Z3ZNBUHiP7xUQgk+y9z1mTfb
         n3hg==
X-Gm-Message-State: AOJu0YyWlPZ0cEkxlLu1hjkvYjtHWRRvcpaBiv8Imn2A6CtdBMp/bxMp
	maqzaKcBTMjKah1ANk9fakdCLibBh+RYlLCQ1EyYuxtnF9Ye88OS557xJw==
X-Gm-Gg: ASbGncusDbekHBgmpuRunNaUBQXQdy01EY4plGoJgsnF+OuPEIbaR49A/9a4DXy0rF8
	1jFJj3Es2Mn2X1x8L4Jm9fVeClmOLHQ2kBDisCf81Du2l4xkimznvRYT0ldHTHyV3pdaWY2YxJD
	TCwQhjsLUKoTRnH6Y51PLTbp0ytLp6Vs7mY8CJUiWa79KzK7McFggSksbeE965u8t7ko3TZCttV
	pmfuL3snUjlzlVQvIF7zgopKpwFYxdkfGRPXFhCyG/8eWmKuYKHBcScV98MXhRVrc7NGzRXuZaG
	wJk2Es9CMzsxNSTXvdah0QW0jqoH/SM65pqYYJUZBA6Y2Q==
X-Google-Smtp-Source: AGHT+IFIEoGNV6Kd7BpRDxRYxkHq68f/fpLsnRctrDl+P+xqjarHZAovkZHvWmAunU87l21UWurE6A==
X-Received: by 2002:a05:6214:2249:b0:6e8:9bcd:bba6 with SMTP id 6a1803df08f44-6f515730808mr79518286d6.7.1746219528406;
        Fri, 02 May 2025 13:58:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.63.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3d1645sm23378366d6.51.2025.05.02.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:58:48 -0700 (PDT)
Message-ID: <68153208.d40a0220.1199c8.003f@mx.google.com>
Date: Fri, 02 May 2025 13:58:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3666220783764451953=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: hci_event: Fix not using key encryption size when its known
In-Reply-To: <20250502202052.2802441-1-luiz.dentz@gmail.com>
References: <20250502202052.2802441-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3666220783764451953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9OTU5MjIyCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQRU5ESU5HICAgMC4zMCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjI5IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDEuNzYgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MjUuNDAgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBXQVJOSU5HICAgMjcu
ODIgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBXQVJOSU5HICAgMzEuOTAg
c2Vjb25kcwpCdWlsZEtlcm5lbDMyICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjUuMDMgc2Vj
b25kcwpUZXN0UnVubmVyU2V0dXAgICAgICAgICAgICAgICBQQVNTICAgICAgNDY1LjA1IHNlY29u
ZHMKVGVzdFJ1bm5lcl9sMmNhcC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDI0LjMzIHNlY29uZHMK
VGVzdFJ1bm5lcl9pc28tdGVzdGVyICAgICAgICAgUEFTUyAgICAgIDMxLjIxIHNlY29uZHMKVGVz
dFJ1bm5lcl9ibmVwLXRlc3RlciAgICAgICAgUEFTUyAgICAgIDQuODIgc2Vjb25kcwpUZXN0UnVu
bmVyX21nbXQtdGVzdGVyICAgICAgICBGQUlMICAgICAgMTIwLjgxIHNlY29uZHMKVGVzdFJ1bm5l
cl9yZmNvbW0tdGVzdGVyICAgICAgUEFTUyAgICAgIDcuODggc2Vjb25kcwpUZXN0UnVubmVyX3Nj
by10ZXN0ZXIgICAgICAgICBQQVNTICAgICAgMTMuMTAgc2Vjb25kcwpUZXN0UnVubmVyX2lvY3Rs
LXRlc3RlciAgICAgICBQQVNTICAgICAgOC4zNSBzZWNvbmRzClRlc3RSdW5uZXJfbWVzaC10ZXN0
ZXIgICAgICAgIFBBU1MgICAgICA2LjE5IHNlY29uZHMKVGVzdFJ1bm5lcl9zbXAtdGVzdGVyICAg
ICAgICAgUEFTUyAgICAgIDcuMjQgc2Vjb25kcwpUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAg
ICBQQVNTICAgICAgNS4wNCBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBF
TkRJTkcgICAwLjYzIHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IENoZWNrUGF0Y2ggLSBQRU5ESU5HCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNj
cmlwdApPdXRwdXQ6CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGlu
dCAtIFBFTkRJTkcKRGVzYzogUnVuIGdpdGxpbnQKT3V0cHV0OgoKIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrQWxsV2FybmluZyAtIFdBUk5JTkcKRGVzYzogUnVuIGxp
bnV4IGtlcm5lbCB3aXRoIGFsbCB3YXJuaW5nIGVuYWJsZWQKT3V0cHV0OgpuZXQvYmx1ZXRvb3Ro
L2hjaV9ldmVudC5jOiBJbiBmdW5jdGlvbiDigJhoY2lfcmVhZF9lbmNfa2V5X3NpemXigJk6bmV0
L2JsdWV0b290aC9oY2lfZXZlbnQuYzozMDgzOjY6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDi
gJhlcnLigJkgWy1XdW51c2VkLXZhcmlhYmxlXSAzMDgzIHwgIGludCBlcnI7ICAgICAgfCAgICAg
IF5+fgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tTcGFyc2UgLSBX
QVJOSU5HCkRlc2M6IFJ1biBzcGFyc2UgdG9vbCB3aXRoIGxpbnV4IGtlcm5lbApPdXRwdXQ6Cm5l
dC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6IEluIGZ1bmN0aW9uIOKAmGhjaV9yZWFkX2VuY19rZXlf
c2l6ZeKAmTpuZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jOjMwODM6Njogd2FybmluZzogdW51c2Vk
IHZhcmlhYmxlIOKAmGVycuKAmSBbLVd1bnVzZWQtdmFyaWFibGVdbmV0L2JsdWV0b290aC9oY2lf
ZXZlbnQuYzogbm90ZTogaW4gaW5jbHVkZWQgZmlsZSAodGhyb3VnaCBpbmNsdWRlL25ldC9ibHVl
dG9vdGgvaGNpX2NvcmUuaCk6CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBU
ZXN0UnVubmVyX21nbXQtdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gbWdtdC10ZXN0ZXIgd2l0aCB0
ZXN0LXJ1bm5lcgpPdXRwdXQ6ClRvdGFsOiA0OTAsIFBhc3NlZDogNDg1ICg5OS4wJSksIEZhaWxl
ZDogMSwgTm90IFJ1bjogNAoKRmFpbGVkIFRlc3QgQ2FzZXMKTEwgUHJpdmFjeSAtIFN0YXJ0IERp
c2NvdmVyeSAyIChEaXNhYmxlIFJMKSAgICAgICAgICBGYWlsZWQgICAgICAgMC4xNzQgc2Vjb25k
cwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAt
IFBFTkRJTkcKRGVzYzogSW5jcmVtZW50YWwgYnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUg
c2VyaWVzCk91dHB1dDoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============3666220783764451953==--
