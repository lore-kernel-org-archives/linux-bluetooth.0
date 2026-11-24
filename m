Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553046;
	b=YIXvmOH0GO0YFjbT3GQ/bFR0Olg2/EQWLNjuOmllKGPyF9nIc1ymp6AX6blqJMe/Kd1d
	 Stfdipxfr4A/XNaFg817oeO2Id2nSJSGthXQOZ6GJXpaXEp1airK3N/3IH1I4JG6gEAtM
	 HxQwUOwHuTnt8py1qBC6qOPMs9rw2JLc+l9ij8cCHEMRJxj2U56y/DEuVRqdKTSAWd4cS
	 +Cr0wRuqOEDlMlxmeYUzUJLdsmGT5NYHgs5VwlCr8JCiyfBnvfAP2PzRQRjZbSpA6CWGN
	 V1gnTU1gJb4bCZhiTEFjKNbS+6xGLU+MpDtI5VELKMXWdtV/Nc4cgpvHGd+3KWXRwnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=qRlKywqxjb3NUvqUv/TLe/drvDn2tyutC3Jp5WSrOwI=;
	b=jSkMxbY62b77wzb5EW71aA0Narq7GCP593n+1pea20Nzmlz60zhX/wCc1QoRehyMf+kU
	 xw90+brq978KsOzFUR7fSxRDW2FStNi2jOgSe1e+gKyg7JcXMRJ4chbgDHBYvfFAOZ/wq
	 VmHbDl1tppIaiRp8lh0zNUcTpLqgpxgJwSoHPXeMze/YJl7TFhTNXAzLtAtmW+/rhfpM3
	 pUY9N7Zesq8CtqoYPnq+Rzozf7TnwhNmdERVZd+HqavkBEbFoH5c72pIAkaHVcWiqtazt
	 sD8i+c0H93tEg96AH3lcZ2YdZiGhsd7srRq4eVtjE9e/Ar5avZJWNu8O3GRhOaFu2Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imLTmM12;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A8606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC5A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imLTmM12
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-843cf077f10so6884925a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553045; x=1796157845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qRlKywqxjb3NUvqUv/TLe/drvDn2tyutC3Jp5WSrOwI=;
        b=imLTmM12f+P3aVBXir7Edg6E02KBDP5v7U/gWW54nEWZPoj0gb2rVEkGeI4pghSdjy
         PpNQjmMiqf/UGVyTn2BSjYBARvkz9EXSKkCOkRmAJvTa+hBJ+RsINmPA4ritME/5UZwh
         g93IJCmdjE2v41S1k8gEpWI5GVQet13ueCfMwkm4CFJm+08pwTFpG4wfQu03J/Njo1AB
         e7rMXUZ36JhnEBd9SPjVQy6vU9eGf45MGFktkqe2D+JDpf0gcCX+kqJ923jNdgzu99My
         HdPnhHyu2Kf0rWgOlSB7ENSNN0Zh1EADKZvVc77RTOvTsYLIyfrJlbI1ARiLWsIn/hip
         s1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553045; x=1796157845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qRlKywqxjb3NUvqUv/TLe/drvDn2tyutC3Jp5WSrOwI=;
        b=BYf6qBnhBxim84sIySUvnLpZzFIqu4ZAuuiPkK9vLLMSZNfneJvPJFNY/zsIqKjrWK
         9oMywNWmK9KyNXfwTtsQ730Iyn4EzNm+ODeSjXtJmmB+3gOjgGClXI60WO1e4Z9YB2+J
         Wisiu2S6daS3gBKEPMakXI2YbpDrVNwSDjifu/oT8c8mVJraVYx8RM/TwDHhBTg8mBtO
         vtAQcbqb1QVr2Ek2lcBAaf9zlozcXTbXeFghbxYD4RkWRcO68Q5Ka0OkfYj5mipNiNlY
         w1eHKf5AIVAR2aaDowv3X0TbeyyjmdaY9ngUasDJ/7QvOh0B/vij2GzqvjbtMIeDHpFM
         mpVw==
X-Gm-Message-State: APuU4Z/ssYLlnZMR2NhL4/40UVU6LarCLM1Ej2DeRktXf2n3P24TMly5
	J/9B4SaDw7FTfPi1gu2nUnoXoycZD939dX/oMHb9abvrqFDYhxXnyGdgobDJDw==
X-Gm-Gg: AZFdTZfDWtgojs1dAgKhcE2vB7f+qrqcvr31vKSPCV+L797K+gkqZI17hzZMqUawTyv
	8lPHf2d8qqMQPeB4I3RBHVfXtrm7wv5iLL43lC58NABlxClVvhCA8uyKApbu1Y0vocWWsqkU7q2
	EL/Ftoi+SXUKuTHIY0QLZl/kwz/L7xkjndjXKcZToz5BfWQbQ6QxVECPMOLmJHn0RWCycT/yaFI
	EPqITxFNzxaZ0yFO8f7i+OnGcQPuwlRaa5jzngIauC0kqpasH9ayDb/38BrO90CIQbBToqGSCfv
	mRhQsgPz35mIwFkfeuWYq3ciGqfUOcW9SIlw7gXOjyAZUfK8taZqoN1pg/PULsCh+K2av5DuOoT
	IL5cWRjwEVaOA7wiUc2mX5Rq6Y9gQzXxcivoQZ8vLiuVaNHlw21AkPJezoAkAvuvjIFahZ03c6b
	5E9ZXKUgWvL5cF8GtKewmZVq0M8rtbs9Ra3HZGjj3v6LfV7uGco/pzTCDemxjsca89PN2dmUJZh
	cQl6GsiP9xtOXB3+kRtup7ByLrIScgIYv0g0vb9emnyEEh9TZy1UMnpGCl/Ti0PYzDDTXxRA35u
	7YL5M9P0
X-Received: by 2002:a05:6830:6411:b0:81f:8a6d:7b52 with SMTP id 46e09a7af769-8631593a1cdmr17120752a34.24.1795553044820;
        Tue, 24 Nov 2026 12:44:04 -0800 (PST)
Received: from [172.17.0.2] ([20.64.106.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86316910337sm11166466a34.23.2026.11.24.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:44:04 -0800 (PST)
Message-ID: <6b05f714.98a28ad6.96404.68d7@mx.google.com>
Date: Tue, 24 Nov 2026 12:44:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9183770572490941348=="
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
Subject: RE: Fix GATT over BR/EDR
In-Reply-To: <20261124144642.298366-2-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9183770572490941348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220975/

---Test result---

Test Summary:
CheckPatch                    PASS      2.82 seconds
GitLint                       PASS      1.97 seconds
BuildEll                      PASS      14.31 seconds
BluezMake                     PASS      183.27 seconds
MakeCheck                     PASS      3.22 seconds
MakeDistcheck                 PASS      105.60 seconds
CheckValgrind                 PASS      103.84 seconds
CheckSmatch                   PASS      191.69 seconds
bluezmakeextell               PASS      67.26 seconds
TestFunctional                PASS      938.33 seconds
IncrementalBuild              PASS      223.50 seconds
ScanBuild                     PASS      659.07 seconds



https://github.com/bluez/bluez/pull/2907

---
Regards,
Linux Bluetooth


--===============9183770572490941348==--
