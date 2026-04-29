Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A0F9C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423045; cv=none; b=thJSCDQE9XgRw60m0Hq1G0A/phxzbw4pFB3rHQEopmAwoTww1TNPW81EqKPol9ANppxqlPA/F0cBd8RwvpgTJevytS0q/lFVNRwvSmt9vojo1kWbOIBeylKgeGIT668FCgo/yrcQFshzUgx3AUvFt2WYY0fR/Y0Zc2IL0B0qSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423045; c=relaxed/simple;
	bh=ITjPIloQF5/RHU05LOivsaq9eqXO1R9dKvq2qrmAPtU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uPv01FfRBJdYNRYqAvVgPPkL1by848Hv6Uam/z/722vLOx+iz9HtqOIqFz9fgHIjgMmLMc3siykMrgAPCIcBqxcqu/szNveh7xF+bOaFNY/HXSJBnalq+kLfDHqIBFrZpQS1CTAF7ajAqcr9dI4r0rh7PJk5zmsBXv62v7jgbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ8Ifcgg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ8Ifcgg"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50fc496c8baso69275611cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 17:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777423043; x=1778027843; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ITjPIloQF5/RHU05LOivsaq9eqXO1R9dKvq2qrmAPtU=;
        b=CJ8IfcggA70TH6RgP2P2n7FGUH4w77BAtXX9Mn3CryQWqMKBuBuIdRHLC+7nZeFhja
         81J2+BQ2Gly9mFbUuUTQqp7Ak3rhbHbhjnWlna4+7VhbvvoADLhbHEJuWZ08IC+pOuhI
         8/6ytpuKoKZu4CyL+xWcmFJDGKwktQ5/O3zNf/UNvvZManvUqJJO+xBA3Bb9MYEA8qEB
         Ib3yR7krnMZOlrCB8MfXQ1J0pRVCmYkgkJczZntJbT5awCZIRBjsIdHEqhqCuwAhMb/U
         nQ5NV6KvymXS/o21VCIX4cTywMZeHM8nmKximNNnf/p/KPp9N9eLMEm8oSUb+RNYpfIA
         dM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777423043; x=1778027843;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITjPIloQF5/RHU05LOivsaq9eqXO1R9dKvq2qrmAPtU=;
        b=HBf8ah7pWsw4lPZpRPeqDAgVS/QhzfuS9LYHuZM6vn28kCdicd4AoGQ7T2aJfqOS9q
         WZz/0GXf4SOlehC02bmGcHsmY2Fu3xKN+LY+br2A/RSNzWc/0i7+WMlGQ1HTeSO21kvw
         hacrM1tmlE4veHj32VExJMHqUgtaBVBPM3y5QXbg5uDoM+cjWVAAd5kp8KL3SH15gDQ4
         /MCPFV3+jQZGTlLfIgdanRusctm9CtIwzmGV5wozvwOE+0j4fx9TdDUWOq+/5UnBSlEu
         vrSm5UP6zxlldabqjPlzEwBR1RjwAhZ11wI8dqtVOuYdq0uZnMcErAZTsUyZpgkF/d4X
         rqCQ==
X-Gm-Message-State: AOJu0YwBMt6fWbySh5JnOP0t1GfoJQvPm1qUhPWRNpckStysitKFDD9K
	YA/L4jaIvrPCmg1Lv0OgpihIZHqZfyvO+yi/sFlYOjC0Lc85g1QkHmu8CSh+50kB
X-Gm-Gg: AeBDievsil6+CbBlCQ1PCjnfqLjg1ax3JKXdxw0AH5p1joDRmE6VfxrCn/WDpOvae4e
	82Z6A/T0UK4K04JV4rycsnoqbo8m4vLZGQrer4hvtO+t1PHoLywEG8Uh1WAzBFYmntpIAYHmQIB
	guVnEVsceb6wozi0t8Vm9YccAItO6/AOtjb4BbYF6HZFUgyzrX7rMH8/Pr3RGZos8S9UhFXYMHf
	umS6HwRU/4j2qAdjap52WV2e+V8gxRhVoI3Fk/p59h94UuBRVF5B1Bfya0yberiV+fHZqbl0tXt
	hSWQ/D1q5VXAOBwtzz7tziKK/i8sxE3rqNcJAOseg4qjp0FX+PZUQPzHA2TgNluZFcNpiXSb5hm
	x0OEqyV1YfEtWxZa+cAXQmpsfLHmiCoT08FF4njJJlK5Da69/Yla4012xkop8xJH1rC/nrnsNRU
	NIr0PinVBjKxMOsiNKfexuVbWjRrtSojL+vJso+FLsFqlyB5r96JS7
X-Received: by 2002:a05:622a:4d45:b0:509:26f4:64f5 with SMTP id d75a77b69052e-5100e1f0d79mr75495961cf.48.1777423043030;
        Tue, 28 Apr 2026 17:37:23 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5101ae8c6aesm4859431cf.24.2026.04.28.17.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 17:37:22 -0700 (PDT)
Message-ID: <69f152c2.050a0220.a3aa4.0045@mx.google.com>
Date: Tue, 28 Apr 2026 17:37:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4856897538482645825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, safa.karakus@secunnix.com
Subject: RE: Bluetooth: l2cap: fix UAF race in l2cap_sock_cleanup_listen
In-Reply-To: <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
References: <AS8P250MB079109F82C16BEDC4F9FE584EB372@AS8P250MB0791.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4856897538482645825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTA4NzE1OQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgRkFJTCAgICAgIDAuNjggc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4yOSBzZWNvbmRzClN1YmplY3RQcmVmaXggICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAwLjExIHNlY29uZHMKQnVpbGRLZXJuZWwgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDI2LjExIHNlY29uZHMKQ2hlY2tBbGxXYXJuaW5nICAgICAgICAgICAgICAgUEFTUyAgICAgIDI4
LjYxIHNlY29uZHMKQ2hlY2tTcGFyc2UgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI3LjE3
IHNlY29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDI0Ljg5IHNl
Y29uZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDU2NC4xOSBzZWNv
bmRzClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAyNy40MyBzZWNvbmRz
CkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1MgICAgICAyNC4wNiBzZWNvbmRzCgpE
ZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNoIC0g
RkFJTApEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgpCbHVldG9vdGg6IGwy
Y2FwOiBmaXggVUFGIHJhY2UgaW4gbDJjYXBfc29ja19jbGVhbnVwX2xpc3RlbgpXQVJOSU5HOiBG
cm9tOi9TaWduZWQtb2ZmLWJ5OiBlbWFpbCBuYW1lIG1pc21hdGNoOiAnRnJvbTogU2FmYSBLYXJh
a3XFnyA8c2FmYS5rYXJha3VzQHNlY3Vubml4LmNvbT4nICE9ICdTaWduZWQtb2ZmLWJ5OiBTYWZh
IEthcmFrdXM8c2FmYS5rYXJha3VzQHNlY3Vubml4LmNvbT4nCgp0b3RhbDogMCBlcnJvcnMsIDEg
d2FybmluZ3MsIDAgY2hlY2tzLCAzMyBsaW5lcyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0
aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNo
YW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZp
eC1pbnBsYWNlLgoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3BhdGNoLzE0NTQ1NjA1LnBhdGNoIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVzc2FnZSB0
eXBlczogVU5LTk9XTl9DT01NSVRfSUQKCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBm
YWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKV2lkZSBjaGFyYWN0ZXIgaW4gcHJp
bnQgYXQgL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgbGlu
ZSA3ODUzLgoKCmh0dHBzOi8vZ2l0aHViLmNvbS9ibHVlei9ibHVldG9vdGgtbmV4dC9wdWxsLzEy
OQoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============4856897538482645825==--
