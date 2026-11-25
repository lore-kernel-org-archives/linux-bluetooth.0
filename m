Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650473;
	b=nldW6p7yU0jQNixfw8q1GuvINXunUKgCAGbT+knWsT/Hb08uS/Kq766TYGaTKNRqe5f7
	 SJs8wctLaVePKnonQ3ZqxKvz13b5D/kOryLyRFV6vXScc8CknXOEC74sH4BxF9vQARkH2
	 wU5w74NExJo5W0ZxsW5PQjSeWDITrnmgeL8pZa6jtuTdfouGEr2ocGCG9gDIUkPZDVS6J
	 HFK9YrGCFCmqlDCtu7hNPyjXXY2QXIVNUZYKmeqvAVyj+nY6mDkBcxJYesQL60qEE0dBx
	 Ve5XIZycZ936VSClG+tPUAFsYmVZGtu+U9jylPX0+S0txzVeFAMWfzVm6fm/7dz+gbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=JyfmAUOmuquMjMHGRKVDjyzEZ7QyXvkNmgE0TfwMHkc=;
	b=JU60dGZGCx55eNSSCsH11iNEcxP/ZJglGz4V5l2s0JZQVCsWZJTWxQmNuP1td7tgbRmp
	 ifKqWRO/yWQP7QtXH3q4iYZzmqXI9RGhutEWY5ezxc3FNovkTfjW4hvrKA/r3nh9YldWH
	 itRU4Oq4TQvMiGNDQWmcNbRs57oyKLW9yU40DwCTQyHaGCKcirv992XPwU/y3mo7t+wBn
	 8VLcDrY24rSySRdOae8mrw9bcaoq7oFsYZhVwg+kKgx8SEo+i2P5lwBUDmwdhuz54ZP5f
	 po85mrb35IGmx6cXITRcI/bwRP42IuKlYR8FB/mlEqBkz+QCrV1zbf4q6pA0aAjfLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riKhtPNT;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0FF606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA0FF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riKhtPNT
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3866a784546so8705594eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650472; x=1796255272; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JyfmAUOmuquMjMHGRKVDjyzEZ7QyXvkNmgE0TfwMHkc=;
        b=riKhtPNT+BWCxBH9ScZBEqg2xTGVQGtuWVEdRWo2/SbPbOuT+uDIxSfV2i0ULQlHoj
         +Fy5DZUmQM4BN4ILGIllQEwhMpF8nmNoPqiVVRQNq3F1WgPCKNNvmJhMEmaTVVjb8lJl
         JxMlBFKrxdJIDjwDoyJ8v95xLEAXnip0YGlz6pd8V3IqJR33CJhnjbG2SQPAadVw8W3E
         Z43F/NgSoX9zTgnkubouEpRj1dgq2ltIGDT3cLvkLZQEIybiZQnishd7xuj/47s0ZKXp
         EpW/jg/cARog9LXYFEIll2hQ5CNTA430Yz7izIq2nZJeBImBckliMCHw4XnmR+3Fimvi
         qTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650472; x=1796255272;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JyfmAUOmuquMjMHGRKVDjyzEZ7QyXvkNmgE0TfwMHkc=;
        b=ogmVQohOXVi+/eXN2MmX9jb4VFN7MWOL/MP1zPtgrmcHXyYZBRlV0+vOhaD2piAxK2
         hwq4feihzaOKCYFx2aJrfKDZfR1HwOPukm+Ma8xhFNKtXLGYCYN8yrNLt5vcTR3tH8Oi
         jJQxifDtmQEsY5rUU9WFN0ZGgyBJzz7NnPGmOuIxDVwmPLa7WqZZY2hG1Wak+tZrDm60
         o6weza3UNSA8yM+YT99c5k5lB6uCLpVJP0ze+fqdsXDEan2xpciYDGfA6R0Rc7T0suiB
         ZLeuZIjGmGLlHa+s6W8T8p63xiZ4g/ZaEVc/uzpxmIRrpbghW6387xdnaYy3p1gl/jc6
         qv0A==
X-Gm-Message-State: APuU4Z9f5i3zaeOGfmWQ5iKOiRpoI759wbsPt7k1j96u6C6juKZ+RqI8
	2r+QvCaJoVXrJ/FIL1YkwA/3cGXLtSsihJbPGx9mJD4BaLDCfg9J4/R3LGq7lA==
X-Gm-Gg: AZFdTZdb9sBX2RKyIcZJncaZsD6MSn5AXGdE0jRhdOHlNxuecZyixPWrmQUzdEjgUUP
	lOApUQz4FFRkcfd+p3IMYJO/1ddVDcEfNHELb/Sq+SqEHcUXaS62dq5O463emmK+3Riz04s+mi5
	/mu8LetaAMAROryxftK+9W8GCvIEq/7Eza0j/6IC1RVlINr+YMS/sSRO20gYGD3eF+eqlM+AA+x
	gWpQJrnoX5ttVZqnrSFuMQl4UJMujptCyztlNQc+g4UQeAatHikMzpzCQxf44uBPPB03KgkQ1FV
	yxD92p+dn9L/ZVJm9elh1xYDMwpc9qMMUxg3+VFiaM6lTJqwQ5RRXpUEYqwTuMZ95WdYvxhzX3j
	YPfBOSK/vL4Pb0XMRj6cAa2zfrJ6IhR0QGv9BrM+EZmBt35Snn/TZhAcPRgcNF7Z+paYjcNG6J/
	uddG0FWkBqTziJH1MzfeBCE8rzDxd46o/kKfj7PbKU5uAFisFFiYc5I+KfDM6+TH6UEsuk3HjHx
	onsTgs8ydEFv84gcq4JGSA537utc3geuckFK3XSK7GNqXEXx/lWmwytDedW
X-Received: by 2002:a05:7300:50fa:b0:384:6487:b155 with SMTP id 5a478bee46e88-38570c359d3mr21987475eec.29.1795650471758;
        Wed, 25 Nov 2026 15:47:51 -0800 (PST)
Received: from [172.17.0.2] ([20.171.55.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm69961208eec.11.2026.11.25.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:47:51 -0800 (PST)
Message-ID: <6b0773a7.4e434f19.685a.2df6@mx.google.com>
Date: Wed, 25 Nov 2026 15:47:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7318437501140316982=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v3,1/2] device: Run reverse service discovery on the bonded bearer
In-Reply-To: <20261125165857.1645242-1-simon.mikuda@streamunlimited.com>
References: <20261125165857.1645242-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7318437501140316982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222362/

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.49 seconds
BuildEll                      PASS      20.74 seconds
BluezMake                     PASS      312.85 seconds
CheckSmatch                   WARNING   318.03 seconds
bluezmakeextell               PASS      100.47 seconds
TestFunctional                PASS      1231.79 seconds
IncrementalBuild              PASS      344.07 seconds
ScanBuild                     PASS      1212.94 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2922

---
Regards,
Linux Bluetooth


--===============7318437501140316982==--
