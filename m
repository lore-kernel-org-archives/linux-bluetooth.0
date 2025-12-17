Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7B283C83
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007411; cv=none; b=GydR/y1rmZqwFZMOCeLJjayijOnZsopabB4f5E8ePYAurNn/yUzgQlEeGbhcA2C3TkJt3rCI9XizKH35r7w/ptBTpNCL6tSWlrV2RVzPz8aL0y/iiwZt1OECMas18JntB7Jkd3lwlwLuKqbU7hbnBm4c4XOzMWRj5wFJuUXoWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007411; c=relaxed/simple;
	bh=b00U8Y/Aok18kpRRvIaKFEx00BsfoAwz3OyAHbKIIN0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=McdNq3Tr9L4LjmycAraSHgJDHAMDX1uyZ8DuabdjSg17TheIsTfjabpcv1s1WaKsbef9sSEZZecBemcWitc/xRXxfLytzgcfzlbmecUY4wfNxfoLPgHXtKzdoCjaBQ3g8Sw6D/0D1tZAjX1ZqzW9jZ50W6HeJ6m2zgT87LEiRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8Sek8bt; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8Sek8bt"
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4f0013c54efso23376831cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766007408; x=1766612208; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b00U8Y/Aok18kpRRvIaKFEx00BsfoAwz3OyAHbKIIN0=;
        b=J8Sek8btWBtM5XmE4gbFwvGrjCHEEt5XPo6yqEhnD0raaTeKlbi6NPk2ZlqOavrMXF
         CvkeBTaMYDL2ZdhosgWlTE334WKqX0xs7SEMN4B39BsKvk1S4FGpdIsy6dG+yV1pCblO
         98V9tk5PrdbY7mdUBEmNWLU5thoJHWYJAzwYUD8SmMAqDx4G6cjB2ujcVhRcT+LedAmL
         WmihVPtjvggTAk3pphA6dZgdlxeB6M7G2ujqfP7kZG12pbdYLt6qvfkN+2kpjoi4PtEY
         TaiqIqlO7rhMOFlHFJW8R75S2ETUIOfLRwyOmI/GmmMhtBxWumvU3Ol6ybslh7rzmIjl
         9cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766007408; x=1766612208;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b00U8Y/Aok18kpRRvIaKFEx00BsfoAwz3OyAHbKIIN0=;
        b=MiNNK70x+0P30cyBeMtMDMqzy9nA+lpvKB97Uc/ruI8Ql9IwS/qacA3vF4n23/Nuo5
         cYMxd8fzTfSmTXGpShY1g+AQSXy7CykZDRSzuW5y1DUQQIuwboELlIaCx46j/f+M0R3x
         qkpgLxVwcuXibHEwgYVtL7WRcgBWcUacipYUE4t437fdbrdzLntktBV0HE8kjieJe1Re
         /wzqqdZD3g8+c0/kfKEtnLKt1GAJ6/mrOLSCt6PVnrVHXqWtNoZ5rqgma49JfHkw8gCW
         9soesA/Km2hkUT5gWLFZhvPkrFdnJ/vYjfhb+lvbC/Sc0UKJzmzbauVTWovi0HbXyhT+
         vQVQ==
X-Gm-Message-State: AOJu0YymUwjm7yu6S9DNNTnDuMPDazJgphL5hdYoARJJy8vHV62/wgMb
	Z16UpTtsDScgbhNLBA6K/c3QBvnDmg28cyAD6NhN/4jWE98CPnKydBe4sp/lVvss
X-Gm-Gg: AY/fxX6kAXYVpjAFEZFnVv2gOHvBm8Kk4RJoGoNcDDyB928DB1FnuhR4yeikJLMOJkv
	1VYH1gXuC1fOVvwbIcs/74MzbVRjAf8DWt7pdOL1jozM0y2VuESeXhAqrtFtAL9mOGEde5SQc4U
	SrENqAHdkiRmEps6+B8NnxC7rTBTW9kfoIddQB8lVxuf4DRUoEvCZGfFn+08QFQvoEz1UJ1P+ju
	DCP8ombLdxUqRVZHYAFUAe0tZtQhxlpATW0U/Vr76ZlNAhac6RWhvl0iVjzIrXSV365zKbt3iOd
	ZClE/AyoqDrOuowRUpNbs3VGBUOgEkJ+jWdtwUSmqNF2CGdA/fLEFKnaP974ZkXT/fwjCQfBBUb
	zj0sEGTi0JOLqABC93G52LWSVzEVQwWwmP1Y/QyxRhLsMse6PZn+2Xhp3l0WYGpXFtZkMzNVs30
	z0eHRZ6RTcTt8atrFM
X-Google-Smtp-Source: AGHT+IEX/u7UG28/2WzOOLH9tnkprhlgeiIgUamqZAFMVFTIHz38jFjVRz1kk0Rj4HomPILPQZ/aSA==
X-Received: by 2002:ac8:5a8f:0:b0:4f1:acb9:a929 with SMTP id d75a77b69052e-4f1d06701b4mr263231151cf.83.1766007408422;
        Wed, 17 Dec 2025 13:36:48 -0800 (PST)
Received: from [172.17.0.2] ([172.183.89.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fc749dasm2975621cf.1.2025.12.17.13.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:36:48 -0800 (PST)
Message-ID: <69432270.c80a0220.a1bbd.332b@mx.google.com>
Date: Wed, 17 Dec 2025 13:36:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3875564071994931100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: L2CAP: Add support for setting BT_PHY
In-Reply-To: <20251217205221.285777-1-luiz.dentz@gmail.com>
References: <20251217205221.285777-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3875564071994931100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTAzNDMzNwoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgUEVORElORyAgIDAuMzUgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
RU5ESU5HICAgMC4yOSBzZWNvbmRzClN1YmplY3RQcmVmaXggICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAwLjA5IHNlY29uZHMKQnVpbGRLZXJuZWwgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDIyLjczIHNlY29uZHMKQ2hlY2tBbGxXYXJuaW5nICAgICAgICAgICAgICAgV0FSTklORyAgIDI0
LjkyIHNlY29uZHMKQ2hlY2tTcGFyc2UgICAgICAgICAgICAgICAgICAgV0FSTklORyAgIDI3LjU1
IHNlY29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDIyLjE5IHNl
Y29uZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ5NC40NyBzZWNv
bmRzClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyNC43MCBzZWNvbmRz
ClRlc3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICA3Mi44MiBzZWNvbmRzClRl
c3RSdW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA2LjIzIHNlY29uZHMKVGVzdFJ1
bm5lcl9tZ210LXRlc3RlciAgICAgICAgRkFJTCAgICAgIDExMC43MSBzZWNvbmRzClRlc3RSdW5u
ZXJfcmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA5LjE5IHNlY29uZHMKVGVzdFJ1bm5lcl9z
Y28tdGVzdGVyICAgICAgICAgRkFJTCAgICAgIDE0LjExIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0
bC10ZXN0ZXIgICAgICAgUEFTUyAgICAgIDkuODUgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVz
dGVyICAgICAgICBGQUlMICAgICAgMTEuNDcgc2Vjb25kcwpUZXN0UnVubmVyX3NtcC10ZXN0ZXIg
ICAgICAgICBQQVNTICAgICAgOC40NSBzZWNvbmRzClRlc3RSdW5uZXJfdXNlcmNoYW4tdGVzdGVy
ICAgIFBBU1MgICAgICA2LjM2IHNlY29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAg
UEVORElORyAgIDAuNzAgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBFTkRJTkcKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwg
c2NyaXB0Ck91dHB1dDoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRM
aW50IC0gUEVORElORwpEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6CgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tBbGxXYXJuaW5nIC0gV0FSTklORwpEZXNjOiBSdW4g
bGludXgga2VybmVsIHdpdGggYWxsIHdhcm5pbmcgZW5hYmxlZApPdXRwdXQ6Cm5ldC9ibHVldG9v
dGgvaGNpX2Nvbm4uYzogSW4gZnVuY3Rpb24g4oCYaGNpX2Nvbm5fc2V0X3BoeeKAmTpuZXQvYmx1
ZXRvb3RoL2hjaV9jb25uLmM6MzAzODoxODogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmGhk
ZXbigJkgWy1XdW51c2VkLXZhcmlhYmxlXSAzMDM4IHwgIHN0cnVjdCBoY2lfZGV2ICpoZGV2ID0g
Y29ubi0+aGRldjsgICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tTcGFyc2UgLSBXQVJOSU5HCkRlc2M6IFJ1biBzcGFy
c2UgdG9vbCB3aXRoIGxpbnV4IGtlcm5lbApPdXRwdXQ6Cm5ldC9ibHVldG9vdGgvaGNpX2Nvbm4u
YzogSW4gZnVuY3Rpb24g4oCYaGNpX2Nvbm5fc2V0X3BoeeKAmTpuZXQvYmx1ZXRvb3RoL2hjaV9j
b25uLmM6MzAzODoxODogd2FybmluZzogdW51c2VkIHZhcmlhYmxlIOKAmGhkZXbigJkgWy1XdW51
c2VkLXZhcmlhYmxlXW5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6IG5vdGU6IGluIGluY2x1ZGVk
IGZpbGUgKHRocm91Z2ggaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgpOgojIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9tZ210LXRlc3RlciAtIEZB
SUwKRGVzYzogUnVuIG1nbXQtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpUb3RhbDog
NDk0LCBQYXNzZWQ6IDQ4OSAoOTkuMCUpLCBGYWlsZWQ6IDEsIE5vdCBSdW46IDQKCkZhaWxlZCBU
ZXN0IENhc2VzClJlYWQgRXhwIEZlYXR1cmUgLSBTdWNjZXNzICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRmFpbGVkICAgICAgIDAuMTAyIHNlY29uZHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjClRlc3Q6IFRlc3RSdW5uZXJfc2NvLXRlc3RlciAtIEZBSUwKRGVzYzogUnVuIHNjby10
ZXN0ZXIgd2l0aCB0ZXN0LXJ1bm5lcgpPdXRwdXQ6CldBUk5JTkc6IHBvc3NpYmxlIGNpcmN1bGFy
IGxvY2tpbmcgZGVwZW5kZW5jeSBkZXRlY3RlZApCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxl
ZCBmcm9tIGludmFsaWQgY29udGV4dCBhdCBuZXQvY29yZS9zb2NrLmM6Mzc4MgpUb3RhbDogMzAs
IFBhc3NlZDogMzAgKDEwMC4wJSksIEZhaWxlZDogMCwgTm90IFJ1bjogMAojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogVGVzdFJ1bm5lcl9tZXNoLXRlc3RlciAtIEZBSUwKRGVz
YzogUnVuIG1lc2gtdGVzdGVyIHdpdGggdGVzdC1ydW5uZXIKT3V0cHV0OgpUb3RhbDogMTAsIFBh
c3NlZDogOCAoODAuMCUpLCBGYWlsZWQ6IDIsIE5vdCBSdW46IDAKCkZhaWxlZCBUZXN0IENhc2Vz
Ck1lc2ggLSBTZW5kIGNhbmNlbCAtIDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVGlt
ZWQgb3V0ICAgIDIuMDg1IHNlY29uZHMKTWVzaCAtIFNlbmQgY2FuY2VsIC0gMiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBUaW1lZCBvdXQgICAgMS45OTEgc2Vjb25kcwojIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogSW5jcmVtZW50YWxCdWlsZCAtIFBFTkRJTkcKRGVz
YzogSW5jcmVtZW50YWwgYnVpbGQgd2l0aCB0aGUgcGF0Y2hlcyBpbiB0aGUgc2VyaWVzCk91dHB1
dDoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============3875564071994931100==--
