Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A031FCD09
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737963103; cv=none; b=XnYpZqagLYn1rM9uksgG8sUb5IACMRp4PXwARbXP/j/LF19BBQPM3h38GWItvmd3IinjMr6PLNnfSgEiWYXTtF9xrpPFLV4iDlHPqY3NeQb6AAztvQVk0Dam5jSjVBoqjLwBRzD6mIoGb4+E1sv97/rcxWv9Dj3q2ZVLEKAfUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737963103; c=relaxed/simple;
	bh=70eeGVYmZqrDTDhMzz0OjYHZjjIoyo5aU3ETr6y/Dyg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oSQ+z3pHE8/pGhw20TIXPtOiyKxXe/lT6CaovRfc1UUTVG+WVz99Of311Tv/r0/XuI1pQ8cqI8CKYjRTR4M2CPiqenq9lGqHb5OzszwgiS1lOPi+34txWKu+mnvSdQPNOPkUfTH3+p5YAC2EtE+jesdqQS1A4qgH221OCr6he7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwJEs2gO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwJEs2gO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7bcf32a6582so390383085a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jan 2025 23:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737963099; x=1738567899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=03yrdXXh4t+zhRZgTZ4MedrUWhvEZONAc5wWz+T7Jwg=;
        b=JwJEs2gO0hacExkhKG4uN9pe2RokKUgi5icvonyDlLx1crefjMBjW6gll7hrDXvVNx
         qbiYzmvHd/t8widdVf3HmWdZ1UIbL/lDHxpep4tEdqbZqfQFqZV4CWVBZQvoeix4pBF0
         cRUmyHl1DwbpmRg54CGZKN0yQJQYuIiB8JvOw+pQCE/Drx8XwzGrG50QAAonCs9eP9Vf
         ZdqePJXjmsA2zFFIbC9ioy5CmUeDtaCo8rDwLUpd3nkp8kjf5UpuSl9H2dkh37y02ZDp
         cuXJvrU6RSezlYFDclo6/CbWW0Cp+2DcVXoCNR1qks367ieEQ4p+NDuB/UFVzZN6RlXm
         x2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737963099; x=1738567899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03yrdXXh4t+zhRZgTZ4MedrUWhvEZONAc5wWz+T7Jwg=;
        b=ciJpS2dM1awf6xxGHRrzfFLHNKT3NP4aWQ2SFQ7luEMFGW/DvU2b562MAWBKiVefh0
         R+opUX2NXsHNN1qor4Q0Yq3umTWExrkr7j7J1nBtyFoN5jK+P3syPan4stAnrWEja2LK
         L1xUb/xYcMzXT65TOPeA7Kjn88OIyxCX5ECd7lI0UAAlHPYhsjBzbrRU4bu2RJYBOzd+
         7kY326lFHrHZzk79mHeOLS3Y1TmgMqp71PrGjoBNqpB/RekF/RP/sVwm9ZjHNVw59eWQ
         yGakGo6zXqgXXYeerWQXq1oPfeyqkaKKUIiRztn7qQsv/f21GDjDacxZKI/jzIIj9tMT
         eLvw==
X-Gm-Message-State: AOJu0Yzop6H81KFIrmmp4JT48teVebOEQ8slKwJFnv4IIvauVF700Vb2
	nQlkN5DZmxTw2k1jCM+F2hGWee8oRbW4e9RJR5dZ1nwO5avs54tvFfBR7w==
X-Gm-Gg: ASbGncusmTKwINfBZtea0mHcBCpc+IzX02xom9v+ShNnceJ93cJYXiy5d1Vk5xrgrjS
	InDtRZ8K9cKzmhWR7Z8W7MVLa8IshXNC9znUNa2OE6MyS3rqcn6w9gK1Z1FZT93bybQlEF57VEt
	mO3nO0jPvglR/UpHxbttWtmdFOE2WjOld43QxklOxKbAyzkCh2c9497XI6ASDGQfqEpUGTImSkj
	LtyMvWiFcPXgTGDXSL1QhsIg/V9I78ds0mRjB04oEUPCuqCoSVxrW2/eABFJYOxbTAIilh2J+Tk
	oxMyd6rcog==
X-Google-Smtp-Source: AGHT+IFe6NW5GN0WqBhMptduSHb6zUcXTG9HI4F7kCa9HVD+kxY5Zs1Z5vIfc+R2PbM0f8iMSYuGag==
X-Received: by 2002:a05:620a:439c:b0:7b6:d631:2669 with SMTP id af79cd13be357-7be6321be46mr6418873685a.21.1737963099289;
        Sun, 26 Jan 2025 23:31:39 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af03b3dsm357669085a.90.2025.01.26.23.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 23:31:38 -0800 (PST)
Message-ID: <6797365a.050a0220.27ad89.d38e@mx.google.com>
Date: Sun, 26 Jan 2025 23:31:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7413895598596678007=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_janathot@quicinc.com
Subject: RE: Enable Bluetooth on qcs6490-rb3gen2 board
In-Reply-To: <20250127064940.1360404-2-quic_janathot@quicinc.com>
References: <20250127064940.1360404-2-quic_janathot@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7413895598596678007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=928462

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.18 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      24.33 seconds
CheckAllWarning               PASS      30.85 seconds
CheckSparse                   PASS      30.27 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      431.15 seconds
TestRunner_l2cap-tester       PASS      20.46 seconds
TestRunner_iso-tester         PASS      32.22 seconds
TestRunner_bnep-tester        PASS      4.94 seconds
TestRunner_mgmt-tester        FAIL      122.74 seconds
TestRunner_rfcomm-tester      PASS      7.61 seconds
TestRunner_sco-tester         PASS      9.57 seconds
TestRunner_ioctl-tester       PASS      8.23 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      5.18 seconds
IncrementalBuild              PENDING   0.37 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.202 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7413895598596678007==--
