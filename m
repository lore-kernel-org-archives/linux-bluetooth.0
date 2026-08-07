Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D145D182
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140007; cv=none; b=JfFyYVBb81DLUbtC/Yd5csHPC7MHz8BgvWh8k6SIta0HEo+gwXWKInNo0znp39915960Grdjd315gB+wkHy3PfKgD+QZfWYKOyp/tTzczHtF1eYrRguW6c5uKvZniCXXA5ouhcT+mDL0RlYDsrZz3wG97L0+B/ABqsm10Ik6c6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140007; c=relaxed/simple;
	bh=01gmXO0AlaQ4iNT+ZZzBWiBhFaNvF/Rkd/DSc88cx4w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DLr+5MPxtAxGTRX9KxzoiksT/iuPul0PVzY2JnelpZs0GJ2m63PHQc0Lys2m/dQoRrBjMq5faUrIWL5kx/KntX5B0jK9oDuG5y2MChfrmEwpILUvc6S3VaJ19b7MfVre1/3yz/CNwe75NaUesfWYzD8bScY97P07b298vDsiHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljLiHO88; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljLiHO88"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6aaf3f54dbeso3664eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140005; x=1786744805; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=01gmXO0AlaQ4iNT+ZZzBWiBhFaNvF/Rkd/DSc88cx4w=;
        b=ljLiHO88q1zNIeUnLVwPeYzmAvgNvPQkm5GJvNrNv/wo9PBKJHr9xoOu1Pj1zJsUCq
         VXFVUdAsFsSm7e7TJjfg1kxI7KMh0l6BON6iA6gmQw7zYW7t+SwkQVkR1gYyOrACjCiP
         GywX9GfEtuH1QUyOkkm+w0/ykyKrrI2WsDAJqL6cehacW7GpapGF05PrZ7H0RlTWspnw
         zNpGZtiuxsdmZqQLvPcjkMTv24kLXTt4YNNsEFVKenwOykTlyd+Le6crA4FQ92M5Wmen
         G/LX3bygvDG8C7YNq9TM9GawmHipVktEEZl1tu6JrGk/y8aD/u4R6eTfrSX1062RjNx6
         egtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140005; x=1786744805;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=01gmXO0AlaQ4iNT+ZZzBWiBhFaNvF/Rkd/DSc88cx4w=;
        b=OrFjJ/5PxZPLV9BDM4bN0+eLuf/oSJRIJEW/igPM7qRm61sNn65srPehg0AA3f6ZJu
         Anm6unytgK+jANCJ0vh/sEXuC5B9ZmjwaxT9o8vXDQUvoOGdtdlyNUT2f4yj2RPV2HSY
         CjX1W54Opz3/VWYyB4mKhzg9d1gjcBTMt6oCHEQmaBZ1bAuqSLox4wbnm/Jjj9bp2TFB
         W7gKcX7Ml7FSTbye0RAui8yuxKfUKin5I99+nxiE2YoOercGeYqB1d5XSOLLj7PnWBx8
         D8sMKm/IN95Ch0VZC6Niky/xWiCBOOC3y83L0mkLYOEhf819PzeYKiK5VnmC7buBWR5Q
         8+fQ==
X-Gm-Message-State: AOJu0YxZoXPK+CKe1S4w8SdEJ82TZgUpgbSrbWa3WrUH/maV5kjgOufg
	1mNqkcFx3xz7JRUpc/7QLL7NuG8sQqF4y+rikaupAGlJuI7jkdlgJncgmsgn54f3
X-Gm-Gg: AR+sD12bvBrBqcGZVcA2Bzw+kt/Obl7GCemwjLGKVXOKPvN44MrzNjDv9UrAJekD1Jf
	boxXk2SwroF+Ehb09YaFcE/Teg5X4sQHDI7CBf4IIQOXbXc2O50PuxAoH1qa+jRN7wg9Ut8jefr
	6CkZez4MxSOpvJzMVdLxGEB22SrJEPQkez7L//CwXi0VwvF1kgVJUx1In6ks5KRwRiwXiIss4n5
	e6zc2DnKrckfFYIxwdYQaGuvCvsW4g9ZLaABa1baKQsFlY3EY0sRecO2lE1oZ9f88GqbjqBnhxV
	fllF4kNKK2QAfWqwdtb8W+5dwXh5mVgWZz/gTXETfx8wHOndbGnkLjnui6mlDlgW22XN+4dm1VF
	meMVZhZj556nLNxu1jBN6B+55qISSDU8xsYG3Ya3tV6+gZ7snLQbKZwoAZll6aU2FZp3ESoUbe/
	/evEGJqJxSF7lmy78aU6RowhfE33MNDtIi+Qa1YiWtVx1WX0ZxtPLYwfrADKikYC9CpV+/9LWFi
	1BUZw==
X-Received: by 2002:a05:6820:f005:b0:6a1:47c8:c86 with SMTP id 006d021491bc7-6b041f59200mr2001482eaf.10.1786140004997;
        Fri, 07 Aug 2026 15:00:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.40.213.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b76ff85sm2013116a34.13.2026.08.07.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:00:04 -0700 (PDT)
Message-ID: <6a765564.91d695f4.1c6cc1.fca2@mx.google.com>
Date: Fri, 07 Aug 2026 15:00:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5338698589600798286=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@oss.qualcomm.com
Subject: RE: [RFC] power: sequencing: rename pwrseq_power_on/off() to pwrseq_vote_on/off()
In-Reply-To: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5338698589600798286==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTEzNTA1MQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEFTUyAgICAgIDIuNDUgc2Vjb25kcwpWZXJpZnlGaXhlcyAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4xMSBzZWNvbmRzClZlcmlmeVNpZ25lZG9mZiAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAwLjEwIHNlY29uZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMjUgc2Vjb25kcwpTdWJqZWN0UHJlZml4ICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC4x
MCBzZWNvbmRzCkJ1aWxkS2VybmVsICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMS4xMCBz
ZWNvbmRzCkNoZWNrQWxsV2FybmluZyAgICAgICAgICAgICAgIFBBU1MgICAgICAyMy43MSBzZWNv
bmRzCkNoZWNrU3BhcnNlICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMi4yNiBzZWNvbmRz
CkJ1aWxkS2VybmVsMzIgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyNi4yOCBzZWNvbmRzCkNo
ZWNrS2VybmVsTExWTSAgICAgICAgICAgICAgIFNLSVAgICAgICAwLjAwIHNlY29uZHMKVGVzdFJ1
bm5lclNldHVwICAgICAgICAgICAgICAgRkFJTCAgICAgIDM2MC4xNSBzZWNvbmRzClRlc3RSdW5u
ZXJfbDJjYXAtdGVzdGVyICAgICAgIEZBSUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5lcl9p
c28tdGVzdGVyICAgICAgICAgRkFJTCAgICAgIDAuMTAgc2Vjb25kcwpUZXN0UnVubmVyX2JuZXAt
dGVzdGVyICAgICAgICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RSdW5uZXJfbWdtdC10ZXN0
ZXIgICAgICAgIEZBSUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5lcl9yZmNvbW0tdGVzdGVy
ICAgICAgRkFJTCAgICAgIDAuMTAgc2Vjb25kcwpUZXN0UnVubmVyX3Njby10ZXN0ZXIgICAgICAg
ICBGQUlMICAgICAgMC4xMCBzZWNvbmRzClRlc3RSdW5uZXJfaW9jdGwtdGVzdGVyICAgICAgIEZB
SUwgICAgICAwLjEwIHNlY29uZHMKVGVzdFJ1bm5lcl9tZXNoLXRlc3RlciAgICAgICAgRkFJTCAg
ICAgIDAuMTAgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIgICAgICAgICBGQUlMICAgICAg
MC4xMSBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVyICAgIEZBSUwgICAgICAwLjEw
IHNlY29uZHMKVGVzdFJ1bm5lcl82bG93cGFuLXRlc3RlciAgICAgRkFJTCAgICAgIDAuMTAgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNTICAgICAgMjAuMTMgc2Vjb25k
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
bmN0aW9uIOKAmHB3cnNlcV9wb3dlcl9vbuKAmTsgZGlkIHlvdSBtZWFuIOKAmHB3cnNlcV92b3Rl
X29u4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KIDE4NzUgfCAg
IGVyciA9IHB3cnNlcV9wb3dlcl9vbihwd3JzZXEpOwogICAgICB8ICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+CiAgICAgIHwgICAgICAgICBwd3JzZXFfdm90ZV9vbgpjYzE6IHNvbWUgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVs0XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1
aWxkOjI4OTogZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0Lm9dIEVycm9yIDEKbWFrZVszXTog
KioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjU0OTogZHJpdmVycy9ibHVldG9vdGhdIEVycm9y
IDIKbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjU0OTogZHJpdmVyc10gRXJy
b3IgMgptYWtlWzFdOiAqKiogWy9naXRodWIvd29ya3NwYWNlL3NyYy9zcmMvTWFrZWZpbGU6MjE4
NzogLl0gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxlOjI0ODogX19zdWItbWFrZV0gRXJyb3Ig
MgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9sMmNhcC10
ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBsMmNhcC10ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRw
dXQ6CgpObyBrZXJuZWwgaW1hZ2UgZm91bmQKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IFRlc3RSdW5uZXJfaXNvLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIGlzby10ZXN0ZXIg
d2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6CgpObyBrZXJuZWwgaW1hZ2UgZm91bmQKIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfYm5lcC10ZXN0ZXIgLSBGQUlM
CkRlc2M6IFJ1biBibmVwLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKCk5vIGtlcm5l
bCBpbWFnZSBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1
bm5lcl9tZ210LXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIG1nbXQtdGVzdGVyIHdpdGggdGVzdC1y
dW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdlIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX3JmY29tbS10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1
biByZmNvbW0tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdl
IGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX3Nj
by10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBzY28tdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0
cHV0OgoKTm8ga2VybmVsIGltYWdlIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBUZXN0UnVubmVyX2lvY3RsLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIGlvY3RsLXRl
c3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKCk5vIGtlcm5lbCBpbWFnZSBmb3VuZAojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9tZXNoLXRlc3RlciAt
IEZBSUwKRGVzYzogUnVuIG1lc2gtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgoKTm8g
a2VybmVsIGltYWdlIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBU
ZXN0UnVubmVyX3NtcC10ZXN0ZXIgLSBGQUlMCkRlc2M6IFJ1biBzbXAtdGVzdGVyIHdpdGggdGVz
dC1ydW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdlIGZvdW5kCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBUZXN0UnVubmVyX3VzZXJjaGFuLXRlc3RlciAtIEZBSUwKRGVz
YzogUnVuIHVzZXJjaGFuLXRlc3RlciB3aXRoIHRlc3QtcnVubmVyCk91dHB1dDoKCk5vIGtlcm5l
bCBpbWFnZSBmb3VuZAojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1
bm5lcl82bG93cGFuLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIDZsb3dwYW4tdGVzdGVyIHdpdGgg
dGVzdC1ydW5uZXIKT3V0cHV0OgoKTm8ga2VybmVsIGltYWdlIGZvdW5kCgoKaHR0cHM6Ly9naXRo
dWIuY29tL2JsdWV6L2JsdWV0b290aC1uZXh0L3B1bGwvNTUyCgotLS0KUmVnYXJkcywKTGludXgg
Qmx1ZXRvb3RoCgo=

--===============5338698589600798286==--
