Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368777;
	b=5BPkQOUEFzfJoPFlEEPUAprPhkn4gXyu6BcWD7pHkAMUd5L2w5twvZwtarSbpUZIZ9Pz
	 ZJE+7734RGkQKsoLTIOgpZblbsVQeRDfhqGmK5tynuCNIuFm5KN5vU307Hamjn98gF1rS
	 mdkDm/cHHTWP+M8OzvOO1nyNO+x7llF1XMtEZ1s0U9K4+14DXX4jhPlVpaNqpOWKFav92
	 Uf0xvOoxiEKgdKtDzwIkt2QtQFr8Me35YoZX68h7DXtj6zwQ1YjCNDkGpl49iQ4o4qfRd
	 YZK4lpr9x1o8jUr9DlKc0ex0EIxdi/pUTZyKt28ZhiTgOf5a4dMg17P/qQcmClMVoeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=YKn+NaT0E7ijv51TAK4tWA9cCLkWvxrn5F+RqgNiszg=;
	b=il8851S51AHMtnD/yiANwdS99NEssk/k1sbtDlwhqGu35s95DC2xrvjZ2tfqQaUR9D2B
	 p9sbEMB912GfXXMWXp4R5Q/64booXKav3KqduooCnyvfdJiHktq9D9fsYf1q4CLG0PzzB
	 H+w5afAbXFwS7LvDyZAa+foeVs0wvXQ4Z+v88Ngw1izhBQIZygAQcipj7l4ottXuL9Gcp
	 007KjjZ7QlW/zSXGa0klJPbnWiPOJHQWffEjL6p/81KnIsvpTb9h/T+DdjEkP/ZzpY2EB
	 6zyKBaUIh3ek9gTZqkF7k0v0eN31M+Oqsh8Hw8bqRXxRnM3jO2JNYcF0nMoRM3shg4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvPrPH96;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA9E606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EA9E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvPrPH96
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9495e8ae23aso231516085a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368776; x=1795973576; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YKn+NaT0E7ijv51TAK4tWA9cCLkWvxrn5F+RqgNiszg=;
        b=dvPrPH96KlGzfnSwnzAHDS8bzqT9xqfR76wSmLaTdvNmyzRVd7DQlW1mxKotvHJT85
         GOJz0zBQMVutSuVvxidzdoGGu147LJGanVfwp5oqoCS0MJcEcbtkvRGMPN7S3s1emF4+
         2RxH02KPJUSwj3EGLv7ayozRfJwulvH3/U9NQqVCxMuxSD6TFAhjQHWt3GavUVAhJGXO
         iMrXUcwLgyd5YsOTvnJLsd/0M5KQY9NKkJFD1H/r4L7ozLUbobnbxn57BQkim25eIqwA
         X7Wb8LASf1gg5/iDz2T/DyMMAnxCEuu0U61m+e3Ce3yivZ6POfCS1Bd9cX4OyFXtgAlc
         etmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368776; x=1795973576;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKn+NaT0E7ijv51TAK4tWA9cCLkWvxrn5F+RqgNiszg=;
        b=zHOUjKIRK9Bu03+8zKm5KwjS9ttU84Mn1BDF1hXevZ9NHmnO9CzqmnpFOXX8ziuXRx
         anb8aGfCLZKE/T/MZRwjZWN4caB0cLq3BtjAfh5N3LpzOM6R/hQtYUmxASFIbSzcsRZt
         ayKsbw1oPISLAdWGWlqXVh2ka11jWWIflpqdAyn2gUGuEvrnqQjPjrQb1AF0cb3guCw7
         1nqT+bxycJUkrqN3H2kziJRYCITOyydSW9oZ2cd7WXkdLSOB/JyVdnoaVs38t/kDb7gK
         fb0kSsOoN3KbZNJT+ymI9Ow3p3leatWUczHyy3tUrkk2bTW2U5Xxpg+mxsbidYw0yDUn
         gVzA==
X-Gm-Message-State: APuU4Z/mjogNg+kcF0X2EC8WERE0odOWfq6somI+5fTgODpyHgxcpsgU
	s8d2UzeAZgyj4nKlpGhcYvS6zxmJ25SgyU0yNNZJ7crWYWma0K365vqI4alnehkC
X-Gm-Gg: AZFdTZd30GPWYG9H8pp4AKcOOlxdyuc1wfOQ685trOx+p/jz+cXjpdO7tXU2ckR7QEQ
	QlLoOliBDuoZhBSOJ51cSE2i5W6OBxeQ1aJ5lr0tRrV1QzSHtTtlWjc/o6tLqbqD0IB4RV2TA9k
	bgM01QsbKkmHpC5MTFCSotcvMDE/+tqv85W4rOqJFgyehc7l5qZzAekJyDLcKkGv/WNAGM2FlHT
	qje1ViK5Q6vp0e1lnkfJRyEY8RIPrixLa1UH8YeXGIlsJ3saA9nu9M4Xn9FYELx65QQQy5N8y2X
	hFgqkyFejhDPuHjBTpL5UYf9DY/MMGwFs8rJWCHbUaUKy75+yNvwX2X8ceD39hCtTXGbIxK73/8
	VBF/3UGCdgRfRxXK9X5rfBZbcwYAY5xR6EXXoLx2TwcoDyzgdBwdXs24Ug5F+q6EPKXcYwUF678
	WcezPXy+vHvj7UVlpmLGF5fB2cMhkR1Gv1C/Jsf9e+9hY3H5CCrVKOp7v/wSfJx9C9N7ROggLq/
	JgzjGSAKdxWU+yIvYsIjhMjXDbYX6cXWvsV70/gvfrJM6NJvJfWFNG2K46P0cJw
X-Received: by 2002:a05:620a:454f:b0:949:b9db:f736 with SMTP id af79cd13be357-949ba9c69e0mr1541565285a.25.1795368776292;
        Sun, 22 Nov 2026 09:32:56 -0800 (PST)
Received: from [172.17.0.2] ([172.208.13.53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ad6dsm642470785a.12.2026.11.22.09.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:32:55 -0800 (PST)
Message-ID: <6b032747.ced8aaa0.14d436.a4b9@mx.google.com>
Date: Sun, 22 Nov 2026 09:32:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9010952468848355906=="
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
Subject: RE: Bluetooth: hci_h4: Ignore the RFU bits of the ISO data load length
In-Reply-To: <20261122155208.1549223-1-simon.mikuda@streamunlimited.com>
References: <20261122155208.1549223-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9010952468848355906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218723/

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.53 seconds
CheckAllWarning               PASS      35.83 seconds
CheckSparse                   PASS      37.94 seconds
BuildKernel32                 PASS      31.18 seconds
CheckKernelLLVM               PASS      33.31 seconds
TestRunnerSetup               PASS      743.84 seconds
TestRunner_l2cap-tester       PASS      14.73 seconds
TestRunner_iso-tester         PASS      15.14 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      88.93 seconds
TestRunner_rfcomm-tester      PASS      4.52 seconds
TestRunner_sco-tester         PASS      5.64 seconds
TestRunner_ioctl-tester       PASS      4.73 seconds
TestRunner_mesh-tester        PASS      4.55 seconds
TestRunner_smp-tester         PASS      4.38 seconds
TestRunner_userchan-tester    PASS      3.26 seconds
TestRunner_6lowpan-tester     PASS      4.45 seconds
IncrementalBuild              PASS      28.59 seconds



https://github.com/bluez/bluetooth-next/pull/1186

---
Regards,
Linux Bluetooth


--===============9010952468848355906==--
