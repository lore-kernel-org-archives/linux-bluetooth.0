Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A83D34B7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840964; cv=none; b=unL1lzNa4UGw3aiRxWwFvAHlrtjjY+6p2ykZLkTvPNh5JGzbqv+ZVA/RxfTvn/YC6wXj4QoRbXYNhAR2kO+kxprPqYfl8y1RfTII+ueo2DD+Eq8U5HvGOVJc52JueAJf8sQ07Bk9QewK9nIvI9z9gm8hqe3l50w/R4kAQQCma7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840964; c=relaxed/simple;
	bh=1rVmIGM+JEcYLngbKuRxr8MoUgEUGPnmc8y8t3+xOAQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=mq96T03QIb43a4KV1o1Q+KdW0mlOxxvmSdM5gglbcpF3MxqEwvGWc5byq1+redwiBh/MEZ1huOTq/6xx+GqbkZ/AYcZKl+PSioOjOXLOAEI0CR2pLQB72IjOA53IpIr9vqBOo5HQ2dL+hK9R9n+tQjaSkCVN49JSKCmHLwR0e+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtCmyGsn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtCmyGsn"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so711224466b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778840961; x=1779445761; darn=vger.kernel.org;
        h=subject:cc:to:from:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1rVmIGM+JEcYLngbKuRxr8MoUgEUGPnmc8y8t3+xOAQ=;
        b=EtCmyGsnynxNlNjYb4TfB7GNp/ava0GDbLjA70hanm01P18gSTNbF4LKclm+FbNVjw
         AV8Xo/4wr2F0BBrH0MsEPDhonTNEt5FyMpY3rbjbKYLhnDjakKnS07Q3THyPVxVL/42E
         8h4PHpH446SfW/F/VyuurgYRKupxtDsNbp9SLmoTKZMV1NB/vRdkM0dnBB5cCVE9HtvM
         OyeakUETl9JaC6wAhopwu7w1xYXBCyjPNy/pGl5UlqADBM3qw6BBDd/2TzHYaQa4okcL
         HTUF/dCbbX53CE9p3vjjkt9qJN3VvEoPXLiI+zy5EcVCawmFY4YNdrv/Vn29voKcNW0a
         xpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840961; x=1779445761;
        h=subject:cc:to:from:content-transfer-encoding:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rVmIGM+JEcYLngbKuRxr8MoUgEUGPnmc8y8t3+xOAQ=;
        b=qrWsDh6LaQ9fq7aBFxAg70SKYPCU/VsC4jW3qatlz3bOYBS5oSzBJrY5Tz6pFT1/Q9
         Eboby2/f7Wj2WNEIb8rWjc+rC+UdZIiUrTigmvm43B74zfDdaW/z5bGNj/gQF9r73qTt
         /+RAU9lPt3Kjax5wsEyBJE0QySNky03PRBv8f3jheimgGL2+ZI8ugIxaFLQo/PV18Ygt
         uBQOj1/NSr5e67+iOl+Vvwg/aJXM5JhKPF+FuP9qfFASMvsTvnmcvNXqjW3Xq2dC9n9N
         R0K3mQ3Uj18ckb1wg23xJS8T/kp+wJ29L95m/VSSNkZbNChhPRx0QYzOFj+l3jvO2HCW
         XqRg==
X-Gm-Message-State: AOJu0YxJ+KpCbrvPeO55mNo7d0wV+COtNAsqMxVIpWIWyiXlh3f1i7YS
	kvMvXK3kzxhXtLQROoXA9edbcLteV/B6KjsnZRghAnZsBvFf9LHme1WvvxKEmIeR
X-Gm-Gg: Acq92OEjICi5MWrF4YT3W/t+z1AQlBaRsf/0au3wRsRyJo6+miHjGZ1fcCmJPX3VlDg
	a/OFEL3MlIxSfr0H+ATUpgQLKH4sno1aroYhk5PhSmmSrworyhHQhfq9barMVdhUlm6ElhKNDit
	LIPufx/rwi/2j9rgR/HHzqqubWJcGErN4qs1na6a3Ujncdf1bAetSM8k2YuiCdU+qkd7JZcFChb
	a48xsIYkI0F7vf/JL0/e1XHXD80gQDe2KnGXfzFhEAsxhxZz28RpeHogm8GDiGARLk8z6Xd2Orj
	mrJTVE9ZfydCCYZffQM75YH7/4vARsweCkX46iLA8a9uJbN1hH7BKyPn7SEJckVnDlZM3org7F6
	5Ffz/4BWbWdqfW+v34Pcu0QVh8Aexv3VpefBfkeOWBQmzHSrsv+mxSCANpfK3zZXKB00/hcO2jR
	R3OxAMIYpcoVbNv7FYTOjZuIOBaz2wtGVmm8Xk2UzOS0K4qneUPJbDvUC4cAg8TqnSj5DJk+Teh
	CMaeC/kAUGZ6DkiEyxbOSDbDm5P+PeTbO4hdAZWVCl8BeL2bFhV9tOPgKFDSK30YdNu8QgEIOif
	g4Qn9zP1Sf84GpwY2uJhSypFgbjaib7DgFl56WmaO09XPBnS9A==
X-Received: by 2002:a17:906:5189:10b0:bd4:f814:efe8 with SMTP id a640c23a62f3a-bd5177ee44amr131601366b.18.1778840961007;
        Fri, 15 May 2026 03:29:21 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ded99dsm202211766b.30.2026.05.15.03.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:29:20 -0700 (PDT)
Message-ID: <6a06f580.7c7532bd.18b472.cf27@mx.google.com>
Date: Fri, 15 May 2026 03:29:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: Bluetooth: L2CAP: missing length check before __unpack_control() in l2cap_data_rcv()

SGksCgpJIGZvdW5kIGFuIG91dC1vZi1ib3VuZHMgcmVhZCBpbiBsMmNhcF9kYXRhX3JjdigpIGlu
IG5ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jLgoKX191bnBhY2tfY29udHJvbCgpIGF0IGxpbmUg
MTA3MCBpcyBjYWxsZWQgd2l0aG91dCB2ZXJpZnlpbmcgdGhlIHNrYiBjb250YWlucwplbm91Z2gg
Ynl0ZXMuIFRoZSBmdW5jdGlvbiByZWFkcyAyIGJ5dGVzIChlbmhhbmNlZCBjb250cm9sKSBvciA0
IGJ5dGVzCihleHRlbmRlZCBjb250cm9sKSBmcm9tIHNrYi0+ZGF0YSB1bmNvbmRpdGlvbmFsbHk6
CgogICAgX191bnBhY2tfZW5oYW5jZWRfY29udHJvbChnZXRfdW5hbGlnbmVkX2xlMTYoc2tiLT5k
YXRhKSwgLi4uKTsKICAgIF9fdW5wYWNrX2V4dGVuZGVkX2NvbnRyb2woZ2V0X3VuYWxpZ25lZF9s
ZTMyKHNrYi0+ZGF0YSksIC4uLik7CgpUaGUgY2hlY2sgYXQgbDJjYXBfcmVjdl9mcmFtZSgpIGxp
bmUgNjkzNSBkb2VzIG5vdCBwcm90ZWN0IHRoaXMuIFRoYXQgY2hlY2sKaXM6IGlmIChsZW4gIT0g
c2tiLT5sZW4pLiBXaGVuIHRoZSBhdHRhY2tlciBzZW5kcyBhIDAtYnl0ZSBQRFUgYm9keSB3aXRo
CmhlYWRlciBsZW49MCwgYWZ0ZXIgc2tiX3B1bGwoTDJDQVBfSERSX1NJWkUpIGJvdGggbGVuIGFu
ZCBza2ItPmxlbiBhcmUgMC4KVGhlIGNvbXBhcmlzb24gMCAhPSAwIGlzIGZhbHNlIHNvIHRoZSBm
cmFtZSBpcyBub3QgZHJvcHBlZC4KClRoZSByZXN1bHQgaXMgYSAyIG9yIDQgYnl0ZSByZWFkIHBh
c3QgdGhlIGVuZCBvZiB0aGUgc2tiIGRhdGEgcmVnaW9uLgpBZnRlciB0aGUgY2FsbCwgc2tiX3B1
bGwoKSBmb3IgdGhlIGNvbnRyb2wgZmllbGQgc2l6ZSBvbiB0aGUgMC1ieXRlIHNrYgpyZXR1cm5z
IE5VTEwgKGxlbiA+IHNrYi0+bGVuIHNvZnQgY2hlY2sgYXQgc2tiX3B1bGxfaW5saW5lOjI4NTEp
LCBsZWF2aW5nCnNrYi0+bGVuIGF0IDAgYW5kIHRoZSBzdWJzZXF1ZW50IGxlbiA9IHNrYi0+bGVu
IHJlYWQgYWxzbyAwLgoKVHJpZ2dlcjogc2VuZCBhIDAtYnl0ZSBkYXRhIFBEVSBvbiBhbiBlc3Rh
Ymxpc2hlZCBFUlRNIG9yIFNUUkVBTUlORyBjaGFubmVsLgpDbGFzc2ljIEJULCBhZGphY2VudCBy
YWRpbyByYW5nZS4gVW5hdXRoZW50aWNhdGVkIEFDTCBjb25uZWN0aW9uIGlzIGVub3VnaC4KClN1
Z2dlc3RlZCBmaXggYXQgdGhlIHRvcCBvZiBsMmNhcF9kYXRhX3JjdigpOgoKICAgIHUxNiBjdHJs
X3NpemUgPSB0ZXN0X2JpdChGTEFHX0VYVF9DVFJMLCAmY2hhbi0+ZmxhZ3MpID8KICAgICAgICAg
ICAgICAgICAgICBMMkNBUF9FWFRfQ1RSTF9TSVpFIDogTDJDQVBfRU5IX0NUUkxfU0laRTsKICAg
IGlmIChza2ItPmxlbiA8IGN0cmxfc2l6ZSkgewogICAgICAgIGtmcmVlX3NrYihza2IpOwogICAg
ICAgIHJldHVybiAtRUlOVkFMOwogICAgfQoKVGVzdGVkIG9uIGxpbnV4LW5leHQgY29tbWl0IGU5
OGQyMWMxNzBiMCAoMjAyNi0wNS0wOCkuCgpBbGV4YW5kcnUK
