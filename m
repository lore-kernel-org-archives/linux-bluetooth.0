Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795388170;
	b=Y7Zdbu7Cu2SSyDse4SnLlr/gKBevTDni8mjD1U16SMz/OzurIqDL2j1/U/wib0gl8NJT
	 evIquB3yyza+cMcIdTLutRCffBRMZrIcAd4lOx79hjUXUGqkk6m6G6Qm9DTUODRN1y6Fp
	 VrSXgCvJJOhtV19HbNDFRvR5n0uXDiGkeQtw/qmIV1VERkrEKoyoK5js1v/gPTiacFSf3
	 S5NQ2OntEKEk6Xwnirt3LS71La98ELm2MGfkGhnzWn1RPv4QDlq10WrtmOponwR7H778I
	 hQNf8tqGSJh5C/exwNLLREM8LfKipsbPhwkGHbkvXQrlW3Ainx+GnkjESZA1lYe859g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795388170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=lN+ZWTQzjaD7jmCPDskCFgWkrC1q+eJRG7uOSbSiMPs=;
	b=hf9R7iJ7aoS5IyP5U5Pc0umpt9oPMH9LKnXXo/tX7oDO2QfXb8ywZd2hCeQIIxy3ee0Q
	 eSCQBTaviW55vtpkI5Ked5+WGf+mBLgTXYJIJpWP2hmX5fM8ybddnFh7t9GlcVx/OJIoO
	 PRpGItLS3Lsr41RD02fpzwkjnmHvRNwZV1ODMjKor1X4HtZnE/d+LbAmUBg3uYKdiJTb5
	 3t4foo5ufY2QkPWkaXzT545H6B1LB3O9W2CY7S7RSGxaq5pumjlzSh0hM4u3sHpHNXjmw
	 /fluj13WXoW1h2hwtdskfcvi7BuwyDRSGOGMhKfzEjvG53l9Pqg8n3jgA+fRrLH0FCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dHx38BZ;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AA606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D17AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0dHx38BZ
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so2266807c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795388169; x=1795992969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lN+ZWTQzjaD7jmCPDskCFgWkrC1q+eJRG7uOSbSiMPs=;
        b=0dHx38BZCVK3GCmCE3vA6FFAR9vVCN5NZP7zo/CrHxYjkNXJh8ClbdF/C4hJ8ERjs3
         LiE0+dinpnvBRunfkNRWu+oCVdr/luiS1EmeRbN93IlwjBdLvKwKlnMEX6iKPA8sIFmN
         yW75yq/1mmW5GLx4s9XHhQMEOJbTPs9Cw12DKkeGT+RVGSr/TFwHjjRJcPqt7Gv7M8Jn
         UJQj/hADKWW/Ai1ZDyelbb9RddF5CwiyIMnVkYMaaqGFkMwvHIC3TVc/ek7tu42pLH01
         5zczK65Sz5iYwuOyc2pem1zxZAUf6YaI3oPbvHfS8RxhaTzvW4752cI/auB8v5w20y5P
         ZMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795388169; x=1795992969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lN+ZWTQzjaD7jmCPDskCFgWkrC1q+eJRG7uOSbSiMPs=;
        b=tU+fXGoR+E4cqoxyJMlTLdw7UvgMoJaYHRJosB4ocSiW+XSmNK37pyFGgSYXMFZNIM
         VHjWMMdnkApuUGD4t58jFtND784r7sh1nLebu0yfhdrO8h0ZikvlX5+B+PvWfxrnuli2
         I2VEtcF89n8dKCjInQfRlgGVE7eBBpgHuAyu3x0aWp4IFHUq0bdeRz+o375hnFXwVAJ/
         uP6YVncSJRUZfNJztUSAeYxvS7xwMTM1o5X6RoOlcch//r35JvMr6AFOoFEIzUf7lY3c
         9Ixmwqq5dhGmoaFilgTRYs8kqO8nuMrKBXA+6m9yuEd8cPyJ8bCiDLRmZfnidcGHLKlf
         y0TA==
X-Gm-Message-State: APuU4Z9EMtkamHdHoPFxYeEu7GyQp4WdyJtC/pHdpYIlH4f46HNlfAEW
	Hl+QB6WGNs4C1vIotic/woP5e8NGIVsD8CCZsB0Jc6ux3vVTVYwJdIar+1dMlaVc
X-Gm-Gg: AZFdTZc4bCWyKTeBv2+2DsaNrZf1UYupTRMPlfAOljpHfNb9s/m4XJPD+8oU4zGau2+
	E8H3wnB/4hi5WRFYGXvUS1Kps3MFxOCHCynINtZx8EYQMjYLxkxwO9KfecAXrLus6bF0xAozV7f
	RC8i7IWmXaDrz8TeAPxt8XrW2x8+bgWue9IFg15ycgFVYF3Nc6+F2+3GpvppIj4RwAc36oypkZe
	/Sqm0K3e6VOiKAtFmiym1yv6DBYadxayX8deZAyhKSc3xg7mA4JdI81vV3RCTs9oKTwLZ9hErSt
	D+92RX7r7BfwRuroBBdj63xooItIikgrNjxSgmkVe4yLyMFw5zxH0qCE0Tfi1jgFghd3tYTDDre
	+yjRigGI2FjtsOUoXf/SKMDe934gpaNkRM6HZStLvwu37SM/YdjwTUF/HJd2LPBzBfznM8KSubx
	kjlh2Fo8byVagJI+MnHczof/OXXKx2FtQnFn3Pr6enwqNANXXvE2dfvIisPaMM2EIBOPJ0GiVUZ
	/qPeZsL6TsJZWMFeP22vZDX/8vhDAUNXC1fSEA8aZT5vwxGDqeRIydPUIXjueI=
X-Received: by 2002:a05:7022:f8c:b0:1b3:a89c:c456 with SMTP id a92af1059eb24-1b55689eab5mr12591559c88.6.1795388168889;
        Sun, 22 Nov 2026 14:56:08 -0800 (PST)
Received: from [172.17.0.2] ([68.220.59.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm23255522c88.1.2026.11.22.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:56:08 -0800 (PST)
Message-ID: <6b037308.54e42a5c.2bfb27.db9d@mx.google.com>
Date: Sun, 22 Nov 2026 14:56:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3749500398040779242=="
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
Subject: RE: Bluetooth: hci_sync: Don't make a periodic advertising set connectable
In-Reply-To: <20261122201412.2856420-1-simon.mikuda@streamunlimited.com>
References: <20261122201412.2856420-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3749500398040779242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218953/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.56 seconds
CheckAllWarning               PASS      34.87 seconds
CheckSparse                   PASS      38.23 seconds
BuildKernel32                 PASS      30.81 seconds
CheckKernelLLVM               PASS      32.52 seconds
TestRunnerSetup               PASS      746.53 seconds
TestRunner_l2cap-tester       PASS      14.78 seconds
TestRunner_iso-tester         PASS      13.14 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      89.14 seconds
TestRunner_rfcomm-tester      PASS      4.44 seconds
TestRunner_sco-tester         PASS      5.58 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        PASS      4.50 seconds
TestRunner_smp-tester         PASS      4.34 seconds
TestRunner_userchan-tester    PASS      3.19 seconds
TestRunner_6lowpan-tester     PASS      4.41 seconds
IncrementalBuild              PASS      28.29 seconds



https://github.com/bluez/bluetooth-next/pull/1198

---
Regards,
Linux Bluetooth


--===============3749500398040779242==--
