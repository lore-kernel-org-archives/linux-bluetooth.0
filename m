Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AE19005F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177357; cv=none; b=omdhGCWHD1xrumkqLbLtYYZBMSkbOfeEFHqaVjvBzGQp+OX0MSkx1BRGj7D4ghKO7XlxYFfHH0FLuzXbzcDsYwo5PuC/B8yRc/TD4y30ldkz9pDL0iE1BqFqBVoDjZe8G84gVrJSmWwP3kubOupFxt7S6mqsH0LQyx9ICCDWBRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177357; c=relaxed/simple;
	bh=jwxfKzYbx+vJXhmbHAVswAHygX0i8xI1T0Isf/IHlK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PNTIGXszr3YUTTqa3viQKf9u+VcDU3W0UkUNFpu3ZhChO3FSMaSZTNDXG90enu+jizK7ygJ1grOR0CSZK39GtrP3tLTusz936eIU+hfE7wnvi8ungrHKDKJOHlLna49t3T+5H2c2JTtXCTB0CR3VDhQp1uxCA+CQFTTYc4MWa+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncvPy+MO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncvPy+MO"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a5074ebb9aso288558485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724177354; x=1724782154; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jwxfKzYbx+vJXhmbHAVswAHygX0i8xI1T0Isf/IHlK8=;
        b=ncvPy+MO1QB/uA9Zc5cJaOl+tDnxQcmcRxcHTiVWBL87bGI8tZwHKV+FbVPQnSIcBi
         S5XIrAAt5aBn4ctXIy3ENtxRStg+qf7kX32S+X+6pSVVAe2EOH2KLdHe+D+V1MI4SOFL
         H6eS/n0SpHu44um8pd1cPPcoJCvJ24l9UnxVKdvV3gkXu9b6Uv1VrFHAt+10n0G6o2gH
         tP/7Kf9tp7DV1AkXWP6EvPoVfuXx/axKqSghzmepGmm+fQqOq4TqGHOGYL9bacjR0NXO
         +wxt+EiR2yLyeMGm+++vHChYZki7ECJRbGAPy2vvBrUiJz0qZTagMyhimgG7VQPNDX5+
         RS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724177354; x=1724782154;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwxfKzYbx+vJXhmbHAVswAHygX0i8xI1T0Isf/IHlK8=;
        b=G/8EFPvniE5+cTlKW/Cjwor8mWd6QJBMYHdakpPLGPeQYQWkecvjBjGQhoShBG5XH9
         EPJIhABY+1WHzvHBCdOenQULslVlUDg6TU8g22mvrDu4u7BjB2yafcxrpZIPyevKPv1E
         IE8W5ocwwjo/C7miMQ6I23rOEplRu8xq7VGxWmJYB7plLUnDfU79T9lH0MTApjCEBq2/
         h7g5X2ybdHpoIXSgZ28uNAD/eFB8dWtJVlh1uoR8R57ExAl0nLWsnIk4825nI/LAvBsP
         b+q5YrJBs6wQNhAM5fVlcPPZihba7St6p1RWS9hybtZIx2SdIC0aT4x3l2r0DX2UZfk/
         98xw==
X-Gm-Message-State: AOJu0Yy530GmHQpI/siKpwsCmdqQXXwoU088WuFDq/hrkm8HcqHDBdbz
	DdWIVD5Y0Kq046HajMibxbkQc7JP6WOB7614Wq6vkclZIg/BRH7aErFGnw==
X-Google-Smtp-Source: AGHT+IFCPxjlwLr0iMtTqyLRr9CXuWQqKOLENANd/XHxerAsYSkKZdzb1pVGzm9ksaMRp2KwhIvvtg==
X-Received: by 2002:a05:620a:400a:b0:7a2:bd9:70d0 with SMTP id af79cd13be357-7a6740d6a17mr11786885a.63.1724177354081;
        Tue, 20 Aug 2024 11:09:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff051b84sm549453185a.35.2024.08.20.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 11:09:13 -0700 (PDT)
Message-ID: <66c4dbc9.050a0220.1bfeb9.714c@mx.google.com>
Date: Tue, 20 Aug 2024 11:09:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1214412028557862720=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bluetoothctl-endpoint.1: Update documentation
In-Reply-To: <20240820162817.179210-1-luiz.dentz@gmail.com>
References: <20240820162817.179210-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1214412028557862720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODgxNDM0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC42NiBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMzIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI1LjA2IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDE3MDkuNjUgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAg
MTMuMTEgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBGQUlMICAgICAgMTYw
LjMyIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDI1Mi45
OSBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAzNTguNDcg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTIwLjM5IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDE2MzguMjEgc2Vj
b25kcwpTY2FuQnVpbGQgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTAwMi40NCBzZWNv
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

--===============1214412028557862720==--
