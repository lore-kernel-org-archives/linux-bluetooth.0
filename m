Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2C3BC67D
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865752; cv=none; b=cEKGtQ9s9xx43ZLMRY0tXnc5FlbHhbVX+zDjzNpYIQzJ1gU2JHnf/lMzBYUNnX2i973hixs1zZyC+Yo+TAqj0Mr1x1we2I0UrozOhPW6K3W486urCegjdrhGpo+/lqn0X9/ssRoh+8saU6LddiEkGRSPdjgEouwIfEH/svdrUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865752; c=relaxed/simple;
	bh=7LB75pCYGO2jWrEE+0Vxw0dNZGh4CVkOEh0aZ6W9cUs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AFcdmnFkHWjFjIcWZe7NfUJpAgXVtNYTa+O/atIzxZBR+Lmpw0LIzSzWcGuLXLkz/jZmceMWN89QlV/0zM8o1BCfjlwso+rWMBv1C+7V0d8cSqVsPFcmm9KwT3Otwzg/l+kTCm4cwlN8dklzMAzbm9/CyKqbdaykvJ4OIgy5Bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBfCEPpl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBfCEPpl"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfc137464dso576887285a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774865750; x=1775470550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W+LV1+nidcyGiYodxdKx871kOI73rAn0V6Pz/3Q8cxg=;
        b=pBfCEPplpld6xbmTYAn+ZHvxjwbBDmpEtaPQv/HncQGjazJuL30Tf7jQ6KB7yDIiMP
         32TiXINAoFApc2rCTJWQoss6/BGlSW1ZV227PjooaMfv1bPhBNM3ECDa8OqAdehhnIiG
         6WyHcVMCMSu1nqLbacdZSIHTWaCl+HoR65KXz/5bbL0GbYUC/kPjQI4syPAFIsTiGgY2
         AKjzrbMKxsDC2r5oh+2SLN6IdbzNh8uNmCErlLlj8Qe1iOyKPunZsSaW+M2nLtjhIh5J
         WSW5qpPofh3xK3S1O/4W1ckschmgS5V59FEkZyHTlK/iJKBP5oIu1XzryUmBknNnueD3
         SACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865750; x=1775470550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+LV1+nidcyGiYodxdKx871kOI73rAn0V6Pz/3Q8cxg=;
        b=ZQ7P+fMSHGeH5trKDLMnYVwTeg5NHLz5CgtuA4Pqe8Bd1LWx4JQsKJWJatceQaqmph
         jOGQNfSvUWQ8QckN1FzkZr+Cygph1mBQaAICDdEMuhFTv9+XJpi4xRC+ydM+8a/qInT/
         3X7qt+2mwgY47gJSZ91P5CGx47xixsWJHUNK1Y4jRff8csk0cpX3bq+d3nXrkQ2BdmBi
         AvMUwFHJ1B7+uJOvcRDxJh1CdAKScVEBjwTUezheEBvkNhgCYH5grS1cZ7TNYU7gtlId
         6CkgJft5Z+K+YviTTeGuL+ROwMaYS1GlCmMBkDt2qHmZpUwaYKrhDWbrtrLf/EYDEyqw
         npwg==
X-Gm-Message-State: AOJu0Yx+EEPPk+FNeI8Hqt58lE9NR+hCsMcnNwNnDYA2CJJpXRNyON21
	nxfdemKbzhlal1CNwXnoRHzsM5iBC+3DDedmGYlNKlKCD3p+AOKWcN2Q4ox62A==
X-Gm-Gg: ATEYQzw4qx63kvVoDzcTwVl6Wzjgn343yowdoVPw/X3nwObKGPxRzHoN/3P06UpHgD/
	dBB2qZ07JU2lHFKvBTYzgbODG827gggzY4ct24XM2xcsxTl5FjM9F69XCAQFBPGhzqq1zneC+6D
	bo3WoEe1VGVVduKQ7RK2dfEyZzVVG+hs4i+g6+muwOeLWwuTR2l32wzPU/uSUY+bPekYCP1YOrB
	+5qEdj7SHM8v2wmFdLjip9vwbYmkGx1gmtuElToKhwFrIPj10mHtFWrePtTaCCGVe4E6KPYBsis
	EKrFAR00wcOHxrwnCHb0aRjGVST5RempfE5rVTzylMMfOTsGSYK/QzU5RSSUJqLERklnpiQOTx3
	lo4SC7mC7aC1tctwjWfVw5uwu/ftDPv76Xw8iTFdpCibnHUgotv5GCXoqIg9aqBcnYcqp5ro5Bn
	BCK3UKErOKjZD11iDZLa4yoIEJiZKl8vA2HMim5voZPQ==
X-Received: by 2002:a05:620a:4555:b0:8ca:305b:748e with SMTP id af79cd13be357-8d01c816e99mr1599748085a.57.1774865750156;
        Mon, 30 Mar 2026 03:15:50 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02803f26fsm580498185a.27.2026.03.30.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:15:49 -0700 (PDT)
Message-ID: <69ca4d55.e90a0220.2d8719.11a6@mx.google.com>
Date: Mon, 30 Mar 2026 03:15:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4043092113178110604=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, johan@kernel.org
Subject: RE: Bluetooth: btusb: fix wakeup irq devres lifetime
In-Reply-To: <20260330093311.1621965-1-johan@kernel.org>
References: <20260330093311.1621965-1-johan@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4043092113178110604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074460

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.94 seconds
CheckAllWarning               PASS      28.37 seconds
CheckSparse                   PASS      27.33 seconds
BuildKernel32                 PASS      25.09 seconds
TestRunnerSetup               PASS      559.52 seconds
TestRunner_l2cap-tester       PASS      27.49 seconds
TestRunner_iso-tester         PASS      42.70 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      111.57 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         FAIL      14.17 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.51 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.60 seconds
IncrementalBuild              PENDING   1.09 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.124 seconds
Adv. non-connectable & connected (central) - Success Failed       0.122 seconds
Ext Adv. connectable & connected (central)           Failed       0.174 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.179 seconds
Read Exp Feature - Success                           Failed       0.109 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.792 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4043092113178110604==--
