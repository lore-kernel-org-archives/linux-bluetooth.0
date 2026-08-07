Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE23F39E4
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140190; cv=none; b=oeT4Iwq4zo2s4m5EjeRFhdN+YcM/9jqejZcOOMY9mFcDhajMG71T3UQxHZ/p9+G207upA0js2tct0Ntjexiy/dQu7Hp2u6GPLcRblxEyGqwF0P7F36G9c0ioYLGHXVKi+i+wI2fFzjEbcO5d95K9wX1rhLXr9U0zjxn9+piIV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140190; c=relaxed/simple;
	bh=wRT2sUTH5lHS3KmVGERNjIFF1FOG02beFwvfY8Juaug=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a7NqUn74tn67N0XbSQgFc/uOWBwRJoVd0EsdXyrX9Z7vT7mU5ObgrM6ibBWjXPB7n5U5y75Opk8zf/vVWd49eesEuBGETPrQHvkhy3kTlmBmX9Lc00ixiJtclWKPT58KNAXQUBV4Fe8v3CCA7SyK/abQPylkizHlS/FntcEZzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2QFdW+Z; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2QFdW+Z"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efbafa1bacso22606206d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140187; x=1786744987; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wRT2sUTH5lHS3KmVGERNjIFF1FOG02beFwvfY8Juaug=;
        b=F2QFdW+ZxayY+586SIi7SB71//ne9tY7sFk2xbtKVuWXOXlfTSryw4BbNffGA2xLK+
         zxhvQ4ekXLMgU+g0jbbO7soVxzwVb2LbecBPzdBQSRLf14QZKbNWN7ITIb8rHQ5XXCqQ
         dy2xRat1VHkCzSUraMMz8287QL9xItJRPfe3HKR89SKXBCUwynAqmlclWXClMqM0HwjZ
         QYxFKyAUHG9pUfSj4DQSY0Eb9lKABG+D3RevFJWNAmg5vUHLwxyN/E3/frxPo08gU7m9
         tzKqsvaEyQLbfEgrDZA7IFfDh+mEKpVKN1sCes5JWM+V1/xItZkK0EG3dO98i+LhNw4g
         6iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140187; x=1786744987;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wRT2sUTH5lHS3KmVGERNjIFF1FOG02beFwvfY8Juaug=;
        b=GtqqrQJmdgSnkNoU6IPDUNOjLFo4SeAQ7K3p472BRejDSYAOTU0sLEEFZTwmQl3p7y
         E9DHE+jp8fk9cjTNLMPhZMQCVHeheKBDxW3aqHT+udyGLJYUzX3L0eyh9RTz9sSeozSI
         5SiOV0oaAKj0Xthr6KUo8tN6riZIXow+uPVVGtkOxkzTklHF8tiOKNIyxJ7rRIlCaHJT
         iA5wCiPmQft6nnz/qefZcfpZnf2t7TGE3/oRkH9CQbHlX+aYc3HNszEc2kl0bDDvCt3V
         y4LxNA2MvB/YYhrxyUxKwmA/+WioNjH/XJw9fuNqOM0v2OIEgk4dM5ad3leePDbg8vwp
         U66g==
X-Gm-Message-State: AOJu0YzxKuyXnbEn0HTiLWxWOxzn0lns7v6UyPzi3OXR1LaVs1mN86aJ
	VmYRSUhdVIe58KdGs9qZ0xNg1E5G0SSOSDPyc7VZjnqHc2RzE32u9RVHwcy2poqv
X-Gm-Gg: AR+sD1118zo2/vUoOYHqVfaVfI6Iukl08zlQd9gemRJjQdafLdUdUbmwi9KNHfkmhLG
	JSfl1aVtgPjif2YM1nPX8hHy1lBpep9CjSDs9RPrlIem7iMsfGS7POOvo8RzyAZSjR2Vy7O3VyT
	U9z3U7kjxVoCjDhbtBdN6qiBRjKKU/0EoK0VihCs4yWTFXzQ2l1xDF+712InonCL55cJA5M1gy7
	V4ABYxR4Ivj8j51T1fdrdfzjqPoLU0ka4CYq7a1MNyPZjxl0wcG23Y7I9WecgoovvytGO6zF+0/
	dfr+MqimP2ci6ZmLHG/BOi0VXya29Fs38qBoyQ8hI4amk21Z12hsByoQFRE6Cr/3Stl6bdlsncZ
	MsKua+5GFv9rxQLBM+wd9Yn1HbIci3emuPr8RKewOoMU/fEXnWEEub7l0FzfIG0HHt17tOOYCMl
	+5ID6oSNzhX0M5Ax7jZNVAsKMYsZXvOsHXoZPi/fSLxmU2kWSZyYmsOyZLsMTjJ2GWZ7M=
X-Received: by 2002:a05:6214:1c82:b0:8ec:235c:7a66 with SMTP id 6a1803df08f44-9088137475dmr295038466d6.27.1786140187379;
        Fri, 07 Aug 2026 15:03:07 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.173.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a92ff8c6sm17949036d6.28.2026.08.07.15.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:03:07 -0700 (PDT)
Message-ID: <6a76561b.c404bc25.352e7a.36b0@mx.google.com>
Date: Fri, 07 Aug 2026 15:03:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2091753234965308318=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@oss.qualcomm.com
Subject: RE: [v3] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2091753234965308318==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTEzODE2NAoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgIDIuMzMgc2Vjb25kcwpWZXJpZnlGaXhlcyAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4xMyBzZWNvbmRzClZlcmlmeVNpZ25lZG9mZiAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAwLjEzIHNlY29uZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMzMgc2Vjb25kcwpTdWJqZWN0UHJlZml4ICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC4x
MiBzZWNvbmRzCkJ1aWxkS2VybmVsICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyNy42NyBz
ZWNvbmRzCkNoZWNrQWxsV2FybmluZyAgICAgICAgICAgICAgIFBBU1MgICAgICAzMC4wNyBzZWNv
bmRzCkNoZWNrU3BhcnNlICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyOC43NCBzZWNvbmRz
CkJ1aWxkS2VybmVsMzIgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyNi40MiBzZWNvbmRzCkNo
ZWNrS2VybmVsTExWTSAgICAgICAgICAgICAgIFNLSVAgICAgICAwLjAwIHNlY29uZHMKVGVzdFJ1
bm5lclNldHVwICAgICAgICAgICAgICAgRkFJTCAgICAgIDQ4NS42NCBzZWNvbmRzClRlc3RSdW5u
ZXJfbDJjYXAtdGVzdGVyICAgICAgIEZBSUwgICAgICAwLjEzIHNlY29uZHMKVGVzdFJ1bm5lcl9p
c28tdGVzdGVyICAgICAgICAgRkFJTCAgICAgIDAuMTMgc2Vjb25kcwpUZXN0UnVubmVyX2JuZXAt
dGVzdGVyICAgICAgICBGQUlMICAgICAgMC4xMyBzZWNvbmRzClRlc3RSdW5uZXJfbWdtdC10ZXN0
ZXIgICAgICAgIEZBSUwgICAgICAwLjEzIHNlY29uZHMKVGVzdFJ1bm5lcl9yZmNvbW0tdGVzdGVy
ICAgICAgRkFJTCAgICAgIDAuMTMgc2Vjb25kcwpUZXN0UnVubmVyX3Njby10ZXN0ZXIgICAgICAg
ICBGQUlMICAgICAgMC4xMyBzZWNvbmRzClRlc3RSdW5uZXJfaW9jdGwtdGVzdGVyICAgICAgIEZB
SUwgICAgICAwLjEyIHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNoLXRlc3RlciAgICAgICAgRkFJTCAg
ICAgIDAuMTMgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIgICAgICAgICBGQUlMICAgICAg
MC4xMyBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVyICAgIEZBSUwgICAgICAwLjEz
IHNlY29uZHMKVGVzdFJ1bm5lcl82bG93cGFuLXRlc3RlciAgICAgRkFJTCAgICAgIDAuMTMgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNTICAgICAgMjYuNDMgc2Vjb25k
cwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogU3ViamVjdFBy
ZWZpeCAtIEZBSUwKRGVzYzogQ2hlY2sgc3ViamVjdCBjb250YWlucyAiQmx1ZXRvb3RoIiBwcmVm
aXgKT3V0cHV0OgoiQmx1ZXRvb3RoOiAiIHByZWZpeCBpcyBub3Qgc3BlY2lmaWVkIGluIHRoZSBz
dWJqZWN0CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0tlcm5lbExM
Vk0gLSBTS0lQCkRlc2M6IEJ1aWxkIGtlcm5lbCB3aXRoIExMVk0gKyBjb250ZXh0IGFuYWx5c2lz
Ck91dHB1dDoKQ2xhbmcgbm90IGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBUZXN0UnVubmVyU2V0dXAgLSBGQUlMCkRlc2M6IFNldHVwIGtlcm5lbCBhbmQgYmx1ZXog
Zm9yIHRlc3QtcnVubmVyCk91dHB1dDoKS2VybmVsOiAKZHJpdmVycy9ibHVldG9vdGgvYnRueHB1
YXJ0LmM6IEluIGZ1bmN0aW9uIOKAmG54cF9zZXJkZXZfcHJvYmXigJk6CmRyaXZlcnMvYmx1ZXRv
b3RoL2J0bnhwdWFydC5jOjE4NzU6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uIOKAmHB3cnNlcV9wb3dlcl9vbuKAmSBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1k
ZWNsYXJhdGlvbl0KIDE4NzUgfCAgIGVyciA9IHB3cnNlcV9wb3dlcl9vbihwd3JzZXEpOwogICAg
ICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+CmNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6Mjg5OiBk
cml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQub10gRXJyb3IgMQptYWtlWzNdOiAqKiogW3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQ6NTQ5OiBkcml2ZXJzL2JsdWV0b290aF0gRXJyb3IgMgptYWtlWzJd
OiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTQ5OiBkcml2ZXJzXSBFcnJvciAyCm1ha2Vb
MV06ICoqKiBbL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy9NYWtlZmlsZToyMTg3OiAuXSBFcnJv
ciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MjQ4OiBfX3N1Yi1tYWtlXSBFcnJvciAyCiMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX2wyY2FwLXRlc3RlciAtIEZB
SUwKRGVzYzogUnVuIGwyY2FwLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKCk5vIGtl
cm5lbCBpbWFnZSBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVz
dFJ1bm5lcl9pc28tdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gaXNvLXRlc3RlciB3aXRoIHRlc3Qt
cnVubmVyCk91dHB1dDoKCk5vIGtlcm5lbCBpbWFnZSBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9ibmVwLXRlc3RlciAtIEZBSUwKRGVzYzogUnVu
IGJuZXAtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdlIGZv
dW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX21nbXQt
dGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gbWdtdC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRw
dXQ6CgpObyBrZXJuZWwgaW1hZ2UgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IFRlc3RSdW5uZXJfcmZjb21tLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIHJmY29tbS10
ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6CgpObyBrZXJuZWwgaW1hZ2UgZm91bmQKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfc2NvLXRlc3RlciAt
IEZBSUwKRGVzYzogUnVuIHNjby10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6CgpObyBr
ZXJuZWwgaW1hZ2UgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRl
c3RSdW5uZXJfaW9jdGwtdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gaW9jdGwtdGVzdGVyIHdpdGgg
dGVzdC1ydW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdlIGZvdW5kCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX21lc2gtdGVzdGVyIC0gRkFJTApEZXNj
OiBSdW4gbWVzaC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6CgpObyBrZXJuZWwgaW1h
Z2UgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJf
c21wLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIHNtcC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpP
dXRwdXQ6CgpObyBrZXJuZWwgaW1hZ2UgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjClRlc3Q6IFRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gdXNl
cmNoYW4tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdlIGZv
dW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyXzZsb3dw
YW4tdGVzdGVyIC0gRkFJTApEZXNjOiBSdW4gNmxvd3Bhbi10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5l
cgpPdXRwdXQ6CgpObyBrZXJuZWwgaW1hZ2UgZm91bmQKCgpodHRwczovL2dpdGh1Yi5jb20vYmx1
ZXovYmx1ZXRvb3RoLW5leHQvcHVsbC81NTQKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK
Cg==

--===============2091753234965308318==--
