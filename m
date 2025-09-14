Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D061BC58
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757835143; cv=none; b=r9IC0l4HRrq9M4W/fAqF/jM0iYcoQGUmauM29d0IsxZE5AG+djQynRXBisYQm2flOUbxnVrECoOrkfcw3O+rwqll7Gc/pc+uZVsyWQ3oNyrO52/h+xOHKmMMgsntiGUy9o0tTeXDfD6q7E/HBDJEQTNRaOzsM0L9aodCCeRVEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757835143; c=relaxed/simple;
	bh=DCL5HWB19AMGV0SrLIf6zYTrvZNMPWX3uifEAouc+Y8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BDDTZawBrWPPrEXiXpknUkEDVE1GJaTgGddhOX27uJyPSzsvuZjZRcd6PP2zZj3MStag5AMQpNQU5RP02o7ovtt83sGinG7FmLrk+6VgCiWPfml8Ee8HFo1aP0kilhJVp8UJELK51By3fFYp69Aoqt8aaxXOyBn0xZshnRppWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Sm+MCO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Sm+MCO"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5eee40cc0so34557011cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757835140; x=1758439940; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVGIzixByoXngMF8miEQktZz4BIdzZ4nI/EPl89Yixo=;
        b=I2Sm+MCO4pvmwe1CZm20LeU/ga4cSmuLQ98CkSkeXrZXSXM1dcD+9mQveomrZIDG5l
         0tAqS5dDtdx745FgcN5gMEzvaU1T4Ytsif9UfNHxlq/UyTLwV/PSckigdwUsayaWw5fB
         c3tDonj0avmPthuaNjxJtVzSPG8qU4YJAxuO+PrHBssGfz9e9aDVpB/zbzhP6UacNr2j
         e7dZ/7qRzUfgbdMWU/YYbvuL9aM1wBCM76j0mEVDD9CJCdd9BAnhmHYUQRco6/HosXrF
         QJU2PZTDGW6MbWuytwY1l6CSFGmMHh6z8wlmuzKO5pmekub++x4TudUbCDy8uVj1IIa/
         QT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757835140; x=1758439940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVGIzixByoXngMF8miEQktZz4BIdzZ4nI/EPl89Yixo=;
        b=Rwhzku89aHR1HG0X2bbTXDV0jzQmV1zYm88gt24SFfIAz0UFAFccR4U7hBXR8zRTIp
         B3Q6ABy65QfVq6q/E73AfxglUgyY6pnt2Jvbbl4KIuMQjx7P9OKa5GPlVGvx0RlKdtjU
         g/Ior3KCF4ON0HFU8DlSIUz+kDKc7vN023/EIRHTUIjneO6rBnjhNIigxSuBRm21i/vd
         51Ag5HIDIl3T+xA1CrdigMRTKEQM6qg/XAZhmsG9gjXTeEdyzCMh3roN7XrdXbWpyQD9
         IJqbIwNHwdkBq9RFz1nAjTJVcF+UWr5vNolyz1CSu/Pkj+h+bPI6aUP7056sH7rexP2G
         2sHg==
X-Gm-Message-State: AOJu0YwI+URrcBjL4Wwydxtipc+MosSTJg9X0gSroN/UafLIX/OffGj6
	pDrpfC9gx25S6U3Z4IWtcs3PxZcC7qxMNbc4659Okptir3J6ynmHRXDXNPipBw==
X-Gm-Gg: ASbGncvqpfIe26JUv/bkc4hG50H5fIPUSmyfw3nAOrywvKovhiqvj2z+5CMhpQ9fsdR
	Tnj9skxqvtuyysnETMrnwuIJrwsBF9gFQ6W4Z+b4/w4YugqruvW7Vst8wVyzL6i7/vIkrdBCm8i
	1veevZgXOVoxbYX2n8CubvzPSpK3CRXvBN0zE5cfm3m/SCnfOy6O+DIInnjADq52lddjG4V9H9b
	q3iC8dF0P47jNjWep/IIhf+2pIO8WL4wrJ9uW1LFobcjCkKV4bGcuqRHNbuYyd7j0EhWXTegeae
	75Dv3I6BHrzQjOdqCA6w9vIYqiFsYl3EEmYoycu/vG41r/G3bJUEbzftTXvoWpB6lpzkc83F5qI
	oRTNf1fS6gTHqPWDjUcud6dYOZRtmIqdioW5w4g==
X-Google-Smtp-Source: AGHT+IHV178cRbjGtDOVvxAOGEZpLlnRJu8biHNI9UOMtQbbQp88GHva7ssgPyQ+iVKkwo7mIMyrcw==
X-Received: by 2002:ac8:5a09:0:b0:4b5:e35c:4900 with SMTP id d75a77b69052e-4b77d1af74emr95412751cf.80.1757835140159;
        Sun, 14 Sep 2025 00:32:20 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.54.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cef10761sm546210685a.58.2025.09.14.00.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 00:32:19 -0700 (PDT)
Message-ID: <68c66f83.050a0220.1b1f43.486b@mx.google.com>
Date: Sun, 14 Sep 2025 00:32:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5766600438915282610=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, bleach1827@gmail.com
Subject: RE: Bluetooth: hci_bcm: use str_low_high() helper instead of ternary operator
In-Reply-To: <20250914-bluetooth-hci_bcm-string-choice-helper-v1-1-05e05bf0e21f@gmail.com>
References: <20250914-bluetooth-hci_bcm-string-choice-helper-v1-1-05e05bf0e21f@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5766600438915282610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1002134

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      23.86 seconds
CheckAllWarning               PASS      26.46 seconds
CheckSparse                   PASS      29.79 seconds
BuildKernel32                 PASS      23.84 seconds
TestRunnerSetup               PASS      473.81 seconds
TestRunner_l2cap-tester       PASS      24.75 seconds
TestRunner_iso-tester         PASS      41.27 seconds
TestRunner_bnep-tester        PASS      5.95 seconds
TestRunner_mgmt-tester        FAIL      125.43 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      14.56 seconds
TestRunner_ioctl-tester       PASS      9.85 seconds
TestRunner_mesh-tester        FAIL      11.44 seconds
TestRunner_smp-tester         PASS      8.49 seconds
TestRunner_userchan-tester    PASS      6.27 seconds
IncrementalBuild              PENDING   0.60 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.131 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5766600438915282610==--
