Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD8A3B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722832659; cv=none; b=P1UaM5/sxqGurXtWQYQ7ftelctwFcimz024TaB3JGBx6jGVrcsqgBU9Ht4zWCb3RyhpKV85k9MaNpIORgzBgdFAiYwXMC7XXfKPq4VhFC/HgyGsY7Qcm88VQ29UZ1z1UChKwjzFQcQVyiDwpDdYjUd0StM6J5N/I9WRee/gZXIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722832659; c=relaxed/simple;
	bh=DsXb9L1SkEStB/5K342/IrAxQ5nb/D3XhOsRZnMZqfM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hh2ZyGut5KgM69H7at1+wou9Ul51SGNX7QsHcgkVPT1TU0DLmSKFgEUrEg3OpiavYlxvYuGHslE5nwZ3HPy7Kblv5oKDZSepekydqpoDwCnSlKn1gkisoFDl837d04W9WXzA/4OvAWjG4NN0EYtcCcTQP9qTnMyFKnXgKdOkT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loOqE4cd; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loOqE4cd"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db18c4927bso5606964b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Aug 2024 21:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722832656; x=1723437456; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EPViYOml23LC8hwP1Cp7Thwnu5UAQvxIRVeEC2IR7sM=;
        b=loOqE4cddMZBZSyzfQ4PfPxIGpoRSWvrUyYA2YdLr7vafDRXx4LT4utC+6aFaNzhkq
         ekZNEOlnUQSz1MeyMfKoW1Lv5rzliB2XvB+ZvZlOAPSmmT6+x8ptc5ecu5y4rFxWLlbT
         TPfEo5PThPwkZK+NCBCmT4z89MY+Xshq4JdQEsIbBxG098V5hhi0k3zGOpC0ipn81kok
         2idAekseA1safQaXxjAIEjBdCiOF8ACXfYSv0q6YYP3llkeZ6qpTHw+nqhL6+TT3Ah4i
         fggc2YqQExc0ozE3B7teedlWtu1rufNvyxOYw4dUWJQ5hKSRK5lxLA+7JfqhPgbUViy3
         9fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722832656; x=1723437456;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPViYOml23LC8hwP1Cp7Thwnu5UAQvxIRVeEC2IR7sM=;
        b=cH90E3paW+84/ov2NAFHGowPqNx1x+lB7pttTpInKAYBngGhjAGdfAR3ZSHKGSkK8s
         hyyQOWrXA8uwveNwpFKROWic6AG66DX6Q7OiRJe9pyJRiRqKespTZQYuQE4OL7jxjrSI
         dSQv+IpbnTeUbdaALnHVFSmuLcnNZFYbQDkBy0pKfXpTwkxRYYiplw+GpmMUbrIEjpX4
         wn/MrUsjmXiB5pdvulCgLnWDxoHH0kobTKUA7rq43HgONmCl5sRfW1mEUYtwRGhn9bvI
         afxDzPRN2VHIj8sCTJtq5J6caRy+jqU6NwSaVhYilWoQJ+yDcxLxK6np5iDEMuPklqmh
         stPA==
X-Gm-Message-State: AOJu0Yw2bojIKd5Jz5QrlBylduyuYPYfteGuaaMcTSYZBRagqVKT++mS
	bh/bQ27Scb7MoKjtSaz7DYeU7l4uv73xNlgbwExk5czkoYrQ3/J6kt94GQ==
X-Google-Smtp-Source: AGHT+IHseOl+/Czo4YY8O/QqoYfbyyl8vUMt5DQGLN3vX1xj2q9HT0GrNEtUh3uiESTFsXDQHzV49Q==
X-Received: by 2002:a05:6808:16ac:b0:3d9:3463:4444 with SMTP id 5614622812f47-3db557fb795mr12294389b6e.5.1722832656518;
        Sun, 04 Aug 2024 21:37:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.77.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763944181sm4721083a12.44.2024.08.04.21.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 21:37:36 -0700 (PDT)
Message-ID: <66b05710.630a0220.5d4e0.cfd5@mx.google.com>
Date: Sun, 04 Aug 2024 21:37:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3707927121668757127=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, felix@kaechele.ca
Subject: RE: Add support for QCA9379 hw1.0 SDIO WiFi/BT
In-Reply-To: <20240805040131.450412-2-felix@kaechele.ca>
References: <20240805040131.450412-2-felix@kaechele.ca>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3707927121668757127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876576

---Test result---

Test Summary:
CheckPatch                    PASS      2.65 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 FAIL      0.55 seconds
BuildKernel                   PASS      31.01 seconds
CheckAllWarning               PASS      33.17 seconds
CheckSparse                   PASS      39.59 seconds
CheckSmatch                   PASS      105.68 seconds
BuildKernel32                 PASS      29.97 seconds
TestRunnerSetup               PASS      540.58 seconds
TestRunner_l2cap-tester       PASS      20.32 seconds
TestRunner_iso-tester         FAIL      35.90 seconds
TestRunner_bnep-tester        PASS      5.01 seconds
TestRunner_mgmt-tester        PASS      111.73 seconds
TestRunner_rfcomm-tester      PASS      7.54 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      8.02 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.20 seconds
IncrementalBuild              PASS      44.82 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 122, Passed: 117 (95.9%), Failed: 1, Not Run: 4

Failed Test Cases
ISO Connect2 Suspend - Success                       Failed       4.246 seconds


---
Regards,
Linux Bluetooth


--===============3707927121668757127==--
