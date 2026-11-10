Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337139;
	b=D18Q3HzrbNkJx+9VvIxOUgfYOn9gSdw027TrJslIM/oaVufNBLyEsPe+yTGwNORmxNy7
	 bs0yb0Q+JXvpgxklc3SYqibpmWwmeiVlGKHZAxYPa2ACMHStOLAFAsluyAQSouWlkGmiO
	 wS2Q1H64tq7VP+UtR1lCD+IvSLrVLExv7HMAPNm3x3UGolYqPlsHojaVWl9BHE+9nVa53
	 oHT/8YL9GwGl7u3J1oJi3Q6btrkwmwUm9IHL0uvk3HQikyXUlhdv3EAwHXAuUcsN9sDw+
	 ZYzX8qt2UQ4cyxKJrRcSkFt/2dtNDMRm4rBeL8Jx/IUYTpAM4ofNDbO4LtqwWIfqXBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=/VZfJTU49CcR8qDkLviN7FOy7BLt3dFRIVegAo5vqro=;
	b=F6M/97fowXeRdr4Yv/lsNwBiNqU7yXdQ6fQyn4vgEY336RMRN5owsddFDaaFYsoG2IOV
	 mNmJzZ+CkIKXdjQfeDl5NspnSH1kIwceN6JN5Vn3iX7NnZ6naknAKL0aLZdR9KDx9bo2q
	 E2Sqt41Q2LFkmfj+xfJk4dvkmaI9pDBwPvoaGWpMFBDLCj1aUDLlkIQNNyXGhqmoNmyWl
	 vHY6xbNmBqMRxZM94oWII1Iwei71M2s+VS5rIZj2UFvml1rjn6xlpAN+Hkl+cBhSfthhS
	 mfji0B9kbx5L21dEYU6NiXdlFn5SKPu7jwu0SrEUGH0zNkF6z/2Lt45yQHIPGHX01+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kETrJVsA;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E63606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 18:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kETrJVsA
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37000e7234bso4447280eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337138; x=1794941938; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/VZfJTU49CcR8qDkLviN7FOy7BLt3dFRIVegAo5vqro=;
        b=kETrJVsAYjdHufZuAK9pa+4X7TpIercz3+t7qiuotXxKWmfADNMPMeJLH8Y/321D/5
         xYhfmoCO3lKnQ6qVk7ovwZxDN0ZEMQkKV7rg6iym2YnWdZ93VNWt1sVojWhDrjfJUABq
         Aw+25TfFmVG0Hn9MWV5LBrvZjCdh49tsww129P+nzpWei9jOjMDd0RLDf19K03K1ESHI
         bHhYyeOWddbs4+ODB0JVmqKb1Y6sjsErqXvHIa/KfVbDFRQA5GRMqeXhFMunj064v2wC
         NBXfFP6YmlQd4KZPhmmMGLi3/o436Q5aLzs+VfyT7GoNYHlV9NPI5qwJ5vKNTxUZjaxX
         7+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337138; x=1794941938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VZfJTU49CcR8qDkLviN7FOy7BLt3dFRIVegAo5vqro=;
        b=s+rruBywC3BA6uPpkmVgQ1m2vbjXfLmjmur/fxVX7gI3HvoZbwZlU6ZhFnIqi1RUCc
         cAQbUY1wO2VUjffQtuGCNPnzawpJK+D8h82ABC3pWd/70Q8sJ8WSsI3n8dt61G7siDoX
         mX6L7StwBrA6MYsrnhPRUP3NuedC1WBrwyTK2OxqxW1VHx62pniu6+f764DZhAZ6iZr3
         +DN069WYGEKGGbqd4FAzdc/s/oWLWKdc3j4AIw+7ickDQVYUvoxMyff8UA6HVM82NdZv
         vUGCe8YJUwM7UShCBF1s0L3WAHMWv4RMcN7+j6AaInF8PIvGMPbvBOBxaNWILSZiR/mI
         E4/g==
X-Gm-Message-State: APuU4Z8SZQ26pJnpfSYOncobsPmwI/MUdVvRrhDs4Pl44QIUVzwKXqap
	6ImVXFbcRerQ64fl1B+4A6yZ1l6P/DjaM/ETyQ9P1kRFwgk9yVZ3ZWZ/BQwNpA==
X-Gm-Gg: AYBFou3/dG6ZXIXdqzY3PeWIBhIsQXOJfnDS034IjQOp+xpXaQz5L0zAg24Zg/QKn/M
	NWXNBiHNiD5TQD0CeKBHYfqmqQqDDTFcC8zEJ6VoHQAfmzFmM3tRH7QYc7XnNk46dWQxoOCbLRH
	n56JmUtrqUBnABwBIB967c8fQDVG5LsZa2W9GI1k7ECDxhPFMZ7roCWCQcWlVsFOW9oxDnVxtXO
	Wf1e6Weyd4lWyUMJPw/+5EltW/MkKWQOuoDjZ4R/0t5xV8JMsoTrPZDE8gd1TjAAx9xh6EB53v2
	Y5U180IHOD//x4HqJm6fu3QVJNncrVwi1iklLEdq/k1moKC+NyA1y5nG7mnNy4DevpSxIUiI8aK
	YkhaxR4lOYye3vAtaw+zFF+ACm50Ar+xZY0ZvzUoxosaPxUIbZGINQhBGHGhe0fV27y21LVbowW
	IL4UM4pJniOW2irC37RaV7AAO5Gzlr7yLDkVwKtQtPDD3tArjNg5l7HfNgg5a7laiGXABvDO8FV
	NtAvzRgWr6PQVNtKePT7RumPD8Yxiy3kkY+z5sjJJ3VM/R7AIMirLRmgRJSz20F
X-Received: by 2002:a05:7301:da17:b0:369:f97f:72c1 with SMTP id 5a478bee46e88-3768721429dmr208586eec.36.1794337138209;
        Tue, 10 Nov 2026 10:58:58 -0800 (PST)
Received: from [172.17.0.2] ([20.184.150.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm18055614eec.23.2026.11.10.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:58:57 -0800 (PST)
Message-ID: <6af36971.67914289.fe7ab.83dd@mx.google.com>
Date: Tue, 10 Nov 2026 10:58:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0057520598764835627=="
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
To: linux-bluetooth@vger.kernel.org, linusw@kernel.org
Subject: RE: Use platform Bluetooth addresses on Broadcom UART controllers
In-Reply-To: <20261110-brcm-bcmbt-mac-v1-1-c68003a06f64@kernel.org>
References: <20261110-brcm-bcmbt-mac-v1-1-c68003a06f64@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0057520598764835627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1207142/

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 FAIL      0.15 seconds
BuildKernel                   PASS      22.73 seconds
CheckAllWarning               PASS      26.09 seconds
CheckSparse                   PASS      28.37 seconds
BuildKernel32                 PASS      23.25 seconds
CheckKernelLLVM               PASS      23.84 seconds
TestRunnerSetup               PASS      546.25 seconds
TestRunner_l2cap-tester       PASS      13.20 seconds
TestRunner_iso-tester         PASS      11.57 seconds
TestRunner_bnep-tester        PASS      2.86 seconds
TestRunner_mgmt-tester        PASS      83.99 seconds
TestRunner_rfcomm-tester      PASS      4.08 seconds
TestRunner_sco-tester         PASS      5.13 seconds
TestRunner_ioctl-tester       PASS      4.24 seconds
TestRunner_mesh-tester        PASS      5.14 seconds
TestRunner_smp-tester         PASS      4.00 seconds
TestRunner_userchan-tester    PASS      2.91 seconds
TestRunner_6lowpan-tester     PASS      4.05 seconds
IncrementalBuild              PASS      23.08 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1104

---
Regards,
Linux Bluetooth


--===============0057520598764835627==--
