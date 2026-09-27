Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCDF2673B0
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551670; cv=none; b=ZmXEsenrBFPQTZ140+QyQI8/7n0iSpixNdLIy6dTfpi6XVPyEnqjx9IyZrKjaVklx35NvFVlOz9ZcUK9ypifcBKJ3Zs5OrTnzafFyGs5CCJYManN7UMzGtzpcpp1OhiLQ7q8On+xoKBqBCMNYJ1veuNHsTBOxqYyOJfOegckF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551670; c=relaxed/simple;
	bh=Ct8eXiU1TbTxzxREUrCMwtt0jGCF/kdtzjXyEjEJSLY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VF0c7rVErtg1gueWB3mr5Rd539odBCe1AUerVr0xHwd3VaaUhfwuzwzFHzROndOrpsg+vPh9ehk9nZzNI03mz6uIBQXqroIWASceG4yC5qIlRL3TiDyOEDkr8d4u5OCEV0e7wm6MCxXJS/x/pgoazai4wWKkDl1K+Ygjq9GUtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrjfj+1E; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrjfj+1E"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so3030617eec.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790551668; x=1791156468; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LbAB9mFqMeAr65t1fDkXMmvfYRfoyj25v8g7QLPJrYE=;
        b=Yrjfj+1EhKr7C9x2wPML2zJcaNT74e1rsvC6MOHQu2waKr4Gbq2G+wtjYlzqmvCTWn
         OneeqW0m+7ARNXQiSFcV1Y7AglR5kkSS3f3wwGdHEFI3fxmuvptAY5MPmxtC9TDv1ctm
         eVZMMbyEY4hzaLBAUR8B7sm867Npd2JRqUJ1nDsfGwa3E3+gwILYQVbiLzBmCZAiTkXY
         GA3rDBg7ALvsoIRum1si0Ev4TXMsl47DZNrgJFpVccDgUNOd35A9oTaznZe4UfigcPJu
         Ozhim1iV4d610QOLJvPf0PHQQCeaZ9Gp6QCuAFwfFMi0sliB7+QVA4jTfAHQMU17+pqo
         IDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790551668; x=1791156468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LbAB9mFqMeAr65t1fDkXMmvfYRfoyj25v8g7QLPJrYE=;
        b=F/Uu9C4a5lrXLegaMO/Y8f9B1fz+YF8psictWwQRO4pA+NSjOGd9ukNfuyzxmhT+Vw
         PTfSUYyxUuAQlJCdh71s6uNrXx420hLmv5daRDhnTVHSk4gauQdUCGFcdnl8LyNPIt+o
         dznE5Ek4/UUUVBMW1SC7SLtu3R0ovsWLEYJ4T97bbFwL7dbVgwc9JujnYqPAyxkJntcY
         yTg0tPVszTQIySt/s5KWfYwyYPG6PmTLhkOYdGFBzO82jiG9mPYKpKqNXoDj73F92+C3
         1yP7QGBKGyB78WsTAFXeRPJje53Q+PAFHIoo5c2SmX3UALsUlKCULofsBZ7DpGn3Xd0A
         Idhg==
X-Gm-Message-State: AFq9FYLhjQggKibU90OTCuvLxFlFePhqB8RIOu9YiapuZpd556cQq+x9
	yyKCOOlHkN1yjxfEWxA59px05PesE1RuezL2B5mw/+ZXMTqCPZBkwZ9LdYlipg==
X-Gm-Gg: AYBFou0Pewbz9DBLMCoCDv9SXcVj9uqrvsiaNkHxOWWd2Z3gHZYAMaS+gXApH9j0OzM
	QfX93+QHLJHK5KApqpmv/x4KgHNHiwT7WHPfwC1KcHFHRBuTwhval3rGhnQpXx9nqeaHfRSP/BE
	ZS11LXY8wM8YG1F5stTGld5tIPc7TW+ZPqpYEC9AP72yXTHs/x6qfKGvojop27VXwC+MqiZXH2t
	BmAbtNNMHgUwZ52KpXP/18e9CDRdX+ZpvMnIj0pjfuzfqJnnUJ1sRfKiJ5dShnlYYCnCN6vBoML
	H0f3Ici1dJQ5bFAfmRh/ISfI0r6UOvuyqAFlopybC7O5fedso+sjVwz2J3bv2Pv7Rxc3+T2WYgp
	wDaATABTYnTehilztE0FVdfFMP/xtIjqN0FPoaGA5eUlymAr88sDabLT0VaD1sbc2EHpxY5wFhR
	BesRpluqYQUN2+u5HPdS6sF1aMtDjV/OBP7pYi9QtgmrFcVGRj5Msh4L+F9rup8k1B/UBQG0qWj
	0tqLx5UrjVKNbyUFrQ=
X-Received: by 2002:a05:7300:c8cc:b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-3426fbbe36fmr7777406eec.8.1790551668230;
        Sun, 27 Sep 2026 16:27:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.150.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm23765600eec.17.2026.09.27.16.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 16:27:47 -0700 (PDT)
Message-ID: <6ab9a673.17b2f02a.51de4.be66@mx.google.com>
Date: Sun, 27 Sep 2026 16:27:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7375957953693537203=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix inquiry cache use-after-free
In-Reply-To: <20260926172831.2415074-1-nicoyip.dev@gmail.com>
References: <20260926172831.2415074-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7375957953693537203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1174571/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.39 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      30.31 seconds
CheckAllWarning               PASS      33.89 seconds
CheckSparse                   PASS      36.41 seconds
BuildKernel32                 PASS      29.52 seconds
CheckKernelLLVM               PASS      36.09 seconds
TestRunnerSetup               PASS      833.38 seconds
TestRunner_l2cap-tester       PASS      16.59 seconds
TestRunner_iso-tester         PASS      41.01 seconds
TestRunner_bnep-tester        PASS      3.06 seconds
TestRunner_mgmt-tester        PASS      61.38 seconds
TestRunner_rfcomm-tester      PASS      4.43 seconds
TestRunner_sco-tester         PASS      7.60 seconds
TestRunner_ioctl-tester       PASS      4.61 seconds
TestRunner_mesh-tester        FAIL      7.77 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      9.43 seconds
TestRunner_6lowpan-tester     PASS      4.57 seconds
IncrementalBuild              PASS      27.60 seconds

Details
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.408 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds


https://github.com/bluez/bluetooth-next/pull/825

---
Regards,
Linux Bluetooth


--===============7375957953693537203==--
