Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485260;
	b=C2scw+MXH79HDj0G5hH2DKqYj/ljMgEYbiHgQlCY374EWui00tzJtgPoK0BWM5BAHSwK
	 3Ds7YqO2v4CKRRhg55QYzWgao62P3g/jTgxohZSLyI5hZgkcA1uW3Lv2ZrjNF9vF5tUIC
	 lIrwFu/EGWbtbccNfLBp+C2h+jgTBwNYUdEePLVd7zZgKDFWJRI63/gqNSTUwVwBHSMCL
	 lR4+T8DxBwhADEuhJl781MP+0SvqPkfbC+WJCz5rToURdwB6mPvXdC+YlByrToILYpow1
	 CqL/kfVhvspzHvuCXevNUNO3pohTeaJ+wutJbiHE3bJT8yAT+gwPO6sRIKY7SFopmxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=XefwgKzgeN6ex6gmkn59QjgCqR+iCJmfw9UKCK1lCqU=;
	b=Cc17BdLC/Yorigg7auwfhvmgkDHjo0ih/mvpSpYCQHY/UDfvMcT4z53DN3MR2xCwINtZ
	 Rr+B7I6F3ZcukkLRVyu6/Iz1JAIrEj8dho1qQpMhhHRVvC064ViINGINrhvVJovFwc1k2
	 nKmFqnpgu+gKP30W4EGUsC8II/Q4PdH6NhTx7+aF76nW2ywEL7ZlU+morA9ux0JRnnMda
	 Ikw7WVHX9tUaJVh+cYHd1+Oi5R+qJE8e91htWQ2TLkLO/QJoQKRjjEZ814j5FCwVyNoG4
	 vW26BX5kmg4Py9NIA1JN50kSjYBZbt9A86+4qFKaShhBpxCUOdwAYYnDubt/UxpbquA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PP4oGBGP;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FEA606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5FEA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PP4oGBGP
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so3450405c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795485259; x=1796090059; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XefwgKzgeN6ex6gmkn59QjgCqR+iCJmfw9UKCK1lCqU=;
        b=PP4oGBGP+BXaKbwm+/fGDQPcCQZtaC8GbOXjlOw1wOv9kAw0nZaN47VJWUvyYxRvxB
         ORssvujcCAOiPhFbklkFTlAyo39noJICjUWWSPA98UygVaOkMtb3olTpFqKoL1hSJP+Q
         pUhkXwW1tUjQZO9npI89vKUgxLr4/oceEuJWr6KRQY5Q7wyGWDs1CSlqVzAnxV7aUEQj
         dj401JfLMScf9J74SYC2F1iJlBTr8+vZLPSE1nXHTomhzaMQMHdhs56bEhF8qmFbW9+h
         yJLL3xOjcek4tnJHKXz16my/aZCworj90jdcjAB1zuPu8NM02bsXvshiGxmJT3LsPS4f
         oAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795485259; x=1796090059;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XefwgKzgeN6ex6gmkn59QjgCqR+iCJmfw9UKCK1lCqU=;
        b=e+yXNb0rxUyiv/VMQo92S5wGBFZT0hR7Q0P6iHjwuPnvmhwTEpKTcqZ1rINfBf/34m
         i84XVk/FzZpYMVpKkMtUcreKgTLoDxVIVtjIAFMSMiv3huxV6LNf8N8tbRXdLrnyknZf
         dpfqr6E8ZfUsp6P7bi0WG8LRHrAA+d5e++bFpmgrqyL/7AB8XAGQftkPTKRcDD8zKP7j
         LO7HxmoKDbY5YFERZWiiQiCylkhD+rTmb7sg7E4DUQXzkYMQ1q/6oNVK4Ssl62NfAnzP
         b0MUnjQeqd/Bg/+i0437io5njxFrfEe5am4h+YKZFoNr6Kl+mcuUKKjWp/emKyAo8+ad
         HqPw==
X-Gm-Message-State: APuU4Z9UQ3L4su3WFfUoGEuPVme+2kRxXRLY3MV2Bll2CUCgB/gDILGh
	UBN6jYblJR852L7HTpvTh0KiUGl8qSTB6fmW77/qRiH1gyuKsuj3VmVUMKg+x00S
X-Gm-Gg: AZFdTZfKB2VHIe/pzhf+xUK9dEr8lOe3ndivR+S5hXuSXkOmeXK4QF6hcnpyEibsvyf
	LvR4shogEEvhleyk2fX2lAda+cl0GzmDqG1GLTo2t+mgddfH57HD2SSX2nWo2UEP7YOagQGva2s
	cnArDn1KCx+Af82k0/iub7dZgFRa3GdtpR4vTrsfPda85Qyh3qLYJJg4CNWXtZp1Mcy9L0YerkJ
	tweAfcTOtZgP41NVXiqP0AW+w7+MHPnYn+ghgySTwBMfucHoiE8NRIXe69R/zsZPjH1aeEpZkXw
	QWB5QMEp4yNsffnnmO3WZ3Su35nepR797yPcl9jNP2keIVpUr7VgA8eTH2REfBFsf4bvTHp4h5o
	bq0HDR56aXTHC3JZBbfHot+mG7ObyeEuUiBThwkdSo3AGpMnA7v5+4hg+IuVpOmES57Jsym5kP6
	nNDUcKuIaTilPlSGysj9YDsgVWB64MeM6dr4AgGYrqQIAOMXkabpPXqDL+1zXUdNEDdLnVF9e95
	pf8wLlGqxF4kkGrQ9jw1gQT5mphZv0FcY1e5m3qifn+HIczcfIw6s2QQANeEVs=
X-Received: by 2002:a05:7022:b0c8:b0:1b2:6855:998a with SMTP id a92af1059eb24-1b556911007mr11861650c88.34.1795485258768;
        Mon, 23 Nov 2026 17:54:18 -0800 (PST)
Received: from [172.17.0.2] ([20.171.199.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm24078008c88.11.2026.11.23.17.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:54:18 -0800 (PST)
Message-ID: <6b04ee4a.f51f0d36.3c0615.cfb5@mx.google.com>
Date: Mon, 23 Nov 2026 17:54:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7211354376721715621=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Channel Sounding and RAP fixes
In-Reply-To: <20261123175125.3642617-2-luiz.dentz@gmail.com>
References: <20261123175125.3642617-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7211354376721715621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9zZXJpZXMvMTIxOTkxNy8KCi0tLVRlc3QgcmVzdWx0LS0tCgpUZXN0IFN1
bW1hcnk6CkNoZWNrUGF0Y2ggICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA2LjkxIHNlY29u
ZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDQuMTQgc2Vjb25kcwpC
dWlsZEVsbCAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTYuMDAgc2Vjb25kcwpCbHVl
ek1ha2UgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjM4LjMyIHNlY29uZHMKTWFrZUNo
ZWNrICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDE0Ljc5IHNlY29uZHMKTWFrZURpc3Rj
aGVjayAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDEyMi40NCBzZWNvbmRzCkNoZWNrVmFsZ3Jp
bmQgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyOTMuOTIgc2Vjb25kcwpDaGVja1NtYXRjaCAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjIzLjM5IHNlY29uZHMKYmx1ZXptYWtlZXh0ZWxs
ICAgICAgICAgICAgICAgUEFTUyAgICAgIDgwLjgyIHNlY29uZHMKVGVzdEZ1bmN0aW9uYWwgICAg
ICAgICAgICAgICAgUEFTUyAgICAgIDEwMzAuNzkgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAg
ICAgICAgICAgICBQQVNTICAgICAgNDA1Ljk3IHNlY29uZHMKU2NhbkJ1aWxkICAgICAgICAgICAg
ICAgICAgICAgUEFTUyAgICAgIDg0Ny41NSBzZWNvbmRzCgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0gRkFJTApEZXNjOiBSdW4gZ2l0bGludApP
dXRwdXQ6CltCbHVlWix2NSwwMy8xOF0gc2hhcmVkL3JhcDogU3Vic2NyaWJlIG9uLWRlbWFuZCBk
YXRhIHdpdGggdGhlIHJlcXVlc3RlZCB0cmFuc3BvcnQKCjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4
IGxlbmd0aCAoODI+ODApOiAiW0JsdWVaLHY1LDAzLzE4XSBzaGFyZWQvcmFwOiBTdWJzY3JpYmUg
b24tZGVtYW5kIGRhdGEgd2l0aCB0aGUgcmVxdWVzdGVkIHRyYW5zcG9ydCIKW0JsdWVaLHY1LDA4
LzE4XSBwcm9maWxlcy9yYW5naW5nOiBMZXQgU3RhcnRNZWFzdXJlbWVudCgpIHBpY2sgdGhlIElu
aXRpYXRvciBmb3IgQm90aAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4NT44MCk6
ICJbQmx1ZVosdjUsMDgvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IExldCBTdGFydE1lYXN1cmVtZW50
KCkgcGljayB0aGUgSW5pdGlhdG9yIGZvciBCb3RoIgpbQmx1ZVosdjUsMTIvMThdIHByb2ZpbGVz
L3Jhbmdpbmc6IERlZmVyIENTIFNlY3VyaXR5IEVuYWJsZSB1bnRpbCB0aGUgbGluayBpcyBlbmNy
eXB0ZWQKCjE6IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODc+ODApOiAiW0JsdWVaLHY1
LDEyLzE4XSBwcm9maWxlcy9yYW5naW5nOiBEZWZlciBDUyBTZWN1cml0eSBFbmFibGUgdW50aWwg
dGhlIGxpbmsgaXMgZW5jcnlwdGVkIgpbQmx1ZVosdjUsMTMvMThdIHByb2ZpbGVzL3Jhbmdpbmc6
IENob29zZSB0aGUgQ1MgYW50ZW5uYSBjb25maWd1cmF0aW9uIGZyb20gYm90aCBlbmRzCgoxOiBU
MSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTogIltCbHVlWix2NSwxMy8xOF0gcHJv
ZmlsZXMvcmFuZ2luZzogQ2hvb3NlIHRoZSBDUyBhbnRlbm5hIGNvbmZpZ3VyYXRpb24gZnJvbSBi
b3RoIGVuZHMiCltCbHVlWix2NSwxNC8xOF0gcHJvZmlsZXMvcmFuZ2luZzogRG8gbm90IHN0YXJ0
IGEgcHJvY2VkdXJlIGFmdGVyIFN0b3BNZWFzdXJlbWVudCgpCgoxOiBUMSBUaXRsZSBleGNlZWRz
IG1heCBsZW5ndGggKDgzPjgwKTogIltCbHVlWix2NSwxNC8xOF0gcHJvZmlsZXMvcmFuZ2luZzog
RG8gbm90IHN0YXJ0IGEgcHJvY2VkdXJlIGFmdGVyIFN0b3BNZWFzdXJlbWVudCgpIgpbQmx1ZVos
djUsMTUvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IEtlZXAgQ1Mgc2Vzc2lvbnMgYXBhcnQgZnJvbSBz
dGFsZSBhbmQgdW5yZWxhdGVkIGV2ZW50cwoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3Ro
ICg4OT44MCk6ICJbQmx1ZVosdjUsMTUvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IEtlZXAgQ1Mgc2Vz
c2lvbnMgYXBhcnQgZnJvbSBzdGFsZSBhbmQgdW5yZWxhdGVkIGV2ZW50cyIKW0JsdWVaLHY1LDE2
LzE4XSBzaGFyZWQvcmFwOiBTdGFydCB0aGUgUmVhbC10aW1lIHRpbWVvdXQgd2hlbiB0aGUgcHJv
Y2VkdXJlIHN0YXJ0cwoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4Mj44MCk6ICJb
Qmx1ZVosdjUsMTYvMThdIHNoYXJlZC9yYXA6IFN0YXJ0IHRoZSBSZWFsLXRpbWUgdGltZW91dCB3
aGVuIHRoZSBwcm9jZWR1cmUgc3RhcnRzIgpbQmx1ZVosdjUsMTcvMThdIHVuaXQvdGVzdC1yYXA6
IEFkZCB0ZXN0cyBmb3IgUmFuZ2luZyBEYXRhIHN1YnNjcmlwdGlvbiBhbmQgY291bnRlcnMKCjE6
IFQxIFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODQ+ODApOiAiW0JsdWVaLHY1LDE3LzE4XSB1
bml0L3Rlc3QtcmFwOiBBZGQgdGVzdHMgZm9yIFJhbmdpbmcgRGF0YSBzdWJzY3JpcHRpb24gYW5k
IGNvdW50ZXJzIgpbQmx1ZVosdjUsMTgvMThdIHNoYXJlZC9yYXA6IERlZmVyIFJhbmdpbmcgRGF0
YSBtb2RlIHNlbGVjdGlvbiB1bnRpbCBGZWF0dXJlcyBpcyByZWFkCgoxOiBUMSBUaXRsZSBleGNl
ZWRzIG1heCBsZW5ndGggKDg1PjgwKTogIltCbHVlWix2NSwxOC8xOF0gc2hhcmVkL3JhcDogRGVm
ZXIgUmFuZ2luZyBEYXRhIG1vZGUgc2VsZWN0aW9uIHVudGlsIEZlYXR1cmVzIGlzIHJlYWQiCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlQ2hlY2sgLSBGQUlMCkRlc2M6
IFJ1biBCbHVleiBNYWtlIENoZWNrCk91dHB1dDoKCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTA0
MzY6IHRlc3Qtc3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTA1NzE6
IGNoZWNrLVRFU1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTEwNzQ6IGNoZWNr
LWFtXSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEwNzY6IGNoZWNrXSBFcnJvciAyCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1ZhbGdyaW5kIC0gRkFJTApE
ZXNjOiBSdW4gQmx1ZXogTWFrZSBDaGVjayB3aXRoIFZhbGdyaW5kCk91dHB1dDoKCnRvb2xzL21n
bXQtdGVzdGVyLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CnRvb2xzL21nbXQtdGVzdGVyLmM6
MTQ1MTg6NTogbm90ZTogdmFyaWFibGUgdHJhY2tpbmcgc2l6ZSBsaW1pdCBleGNlZWRlZCB3aXRo
IOKAmC1mdmFyLXRyYWNraW5nLWFzc2lnbm1lbnRz4oCZLCByZXRyeWluZyB3aXRob3V0CjE0NTE4
IHwgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgfCAgICAgXn5+fgptYWtl
WzNdOiB3YXJuaW5nOiAtajQgZm9yY2VkIGluIHN1Ym1ha2U6IHJlc2V0dGluZyBqb2JzZXJ2ZXIg
bW9kZS4KbWFrZVszXTogKioqIFtNYWtlZmlsZToxMDQzNjogdGVzdC1zdWl0ZS5sb2ddIEVycm9y
IDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMDU3MTogY2hlY2stVEVTVFNdIEVycm9yIDIKbWFr
ZVsxXTogKioqIFtNYWtlZmlsZToxMTA3NDogY2hlY2stYW1dIEVycm9yIDIKbWFrZTogKioqIFtN
YWtlZmlsZToxMTA3NjogY2hlY2tdIEVycm9yIDIKCgpodHRwczovL2dpdGh1Yi5jb20vYmx1ZXov
Ymx1ZXovcHVsbC8yODg5CgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============7211354376721715621==--
