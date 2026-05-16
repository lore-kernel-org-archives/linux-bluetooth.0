Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F06113E41A
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778964434; cv=none; b=LoUatWkn+aFZckEgZNym362jw/3oCtxX0T3xJ+aWLgDtQPj6+Slre2LK8PCvWh/XWWmNdC9YuVg7VNLUmy2y1wYqC0dR4OChPGVl3eP2qcVvLEnQe0Us08wuiTPGinG3HDmNBvZtr1QEbwQZDBj79kc2w4MHVqpQgMCGoVBXPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778964434; c=relaxed/simple;
	bh=e13zyU+aEfDljiYNXgUFqZG3P5UcsE/1QIhj1bzGCT0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e/AzPEurHR0TmS6FaXX3gq1DvYlKuqIrR4ZGx3K/y+2p942tINvu47WnGnbPOhZI5/ikac2JskTsSiX0LRIzBCjAZSS8Fj/88AM/bZTqnLo1f8gGNoGnKCGhlnyUbW9juBBHrRpx3PP6AKZM5k0K/nopJNdqyOa1o8MzBFo9sBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr00WBNC; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr00WBNC"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso4457722eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778964432; x=1779569232; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dLOUxplm4SmvY/58AnPbr68BacE7paFRElp/FHmHzRE=;
        b=Pr00WBNC06XEfva/YZay/MeOVqxWlS7r0//amMb90x4SHAeEoJEIxfBj+IuKKmLM/Y
         alalUndvKBiomOJwYCHEdtRAaatR6l7fYertKysj6mBskZm2b8dz54pnVPAt0O1+/109
         kVK9H3l2oEdnat1+tbXr8mMM5i8J9xKQKRwju4rYF8lXUW1lAvRX8ppJhAbqrrTO7QvX
         eDtfSlTLzdfxNdA9jgAa49LtjGjV0J7toK16VUaAWVYbQT3XUkkTeIJ8BgPAPsizTmSg
         zwqeiH/yKfEtY/eYtLPgZqwtkaGlFbHd8/O+eY1QRD4M6+oKz27JxmzjexgrtdWOErEz
         7rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778964432; x=1779569232;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLOUxplm4SmvY/58AnPbr68BacE7paFRElp/FHmHzRE=;
        b=AkXpYOx0e/F3JYYbQ1hcZaB2Z8zICw+1vxv2W3tW/VWONpoSZwQR/+uARkE8vmlFLI
         6zmI5HnPx9bKkTs7rilhxCgvbz8smBf1HrnEIUKN7+EothQaEs/QUYWxSrMrEYEWHeIH
         sNRfL5T/JHDy/MrahhOQATu9m81jXoKmeULNES3zLKQaU1oFVbG3kIQvOmcoHpCGKWds
         jUFkcvQOMdIKRLLtCUCxxigzng3luynmTOSLOEz7cgdMXcLIWESVfK7LqXU21yve9gDS
         piUiQzBcamAboEMSSmrl/2hB4Ej5s5TrO2I7Fvn5fre6mx79+volNHP+CiNfwF8cD3dl
         pf8Q==
X-Gm-Message-State: AOJu0Yy5BkUneNOlZD0t3NkZn+LuixZZf9flkhxSNldJT4bacGnjzhXE
	UH7d+pG6bYkMyoBbaRNXO8kAv67ky1o9Xnu+gmEDrzDjUn//W0cVyzHv7ID5nA==
X-Gm-Gg: Acq92OEymNcljGVYXCrGbLqYExNLInb3ur//QnSEG9DDkpRuECL3hfIpB1BYdmrO5Ff
	8ekzxdOjPdCv2Ku+nvE1u9CO0Frwkue4WrLEveH0/MGrLsEVvibZg4R/87GGNb4Dh3r3I4wL9VL
	zd+gaaThQx1u8i5XHv57KmAmQN+qzd9+yaj6RQWC56lEx/mm3eCD8bixnnjKhw4bUkkyy/Nz3K3
	iwepB/22KQ90RCLzjCKMqktt5Ht4OqSJr1KP7u+CWH+Ctdv8xpMEet8oQrsjVKqiyBXfKnxhh6Y
	xN7TJKkbWLjg5nvM/yFt4qmR+7r2O1+VtyhqYBZtjiFQbzlbHzFRag4rTsRIcnk5YqasZdloSyJ
	myUgFPTmeiHXE+mTsrVEM/JeX3qhFLN89H1FymSrH9b66mIBVEbuLkUpv9qwYkDCwnVlMh5Etl1
	VYGBh3IKbEwlNDeoxyiHC3kUdWO44=
X-Received: by 2002:a05:7300:ac90:b0:2ff:9d6b:4f31 with SMTP id 5a478bee46e88-3039812b389mr3874490eec.6.1778964431973;
        Sat, 16 May 2026 13:47:11 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.6.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm10166801eec.20.2026.05.16.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 13:47:11 -0700 (PDT)
Message-ID: <6a08d7cf.257a352c.2fdb48.b647@mx.google.com>
Date: Sat, 16 May 2026 13:47:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0561625991316583087=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, safa.karakus@secunnix.com
Subject: RE: [v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
In-Reply-To: <20260516181504.3076260-1-safa.karakus@secunnix.com>
References: <20260516181504.3076260-1-safa.karakus@secunnix.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0561625991316583087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1095877

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      23.87 seconds
CheckAllWarning               PASS      26.65 seconds
CheckSparse                   PASS      25.16 seconds
BuildKernel32                 PASS      23.25 seconds
TestRunnerSetup               PASS      518.74 seconds
TestRunner_l2cap-tester       PASS      375.73 seconds
TestRunner_iso-tester         PASS      596.04 seconds
TestRunner_bnep-tester        PASS      18.18 seconds
TestRunner_mgmt-tester        PASS      2021.60 seconds
TestRunner_rfcomm-tester      PASS      62.71 seconds
TestRunner_sco-tester         PASS      140.77 seconds
TestRunner_ioctl-tester       PASS      133.16 seconds
TestRunner_mesh-tester        PASS      59.48 seconds
TestRunner_smp-tester         PASS      17.61 seconds
TestRunner_userchan-tester    PASS      18.69 seconds
TestRunner_6lowpan-tester     PASS      50.66 seconds
IncrementalBuild              PASS      22.44 seconds



https://github.com/bluez/bluetooth-next/pull/203

---
Regards,
Linux Bluetooth


--===============0561625991316583087==--
