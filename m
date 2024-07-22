Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553316C87C
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642385; cv=none; b=qIGF49zpMG4t7qjTmwm/T068n6tz6H2TfCeLmoyI3hJzUM6IbdVD08c/XajqQJak1hpv3Vlyv2gazyzKzyOwuFrncwetm0d1xBoZnYIsAiVXAtPp1WVpUC5vbNPzIweg5AYjE662H1Ea/QjYHB0YuyXjCylCB0kj9I2CNvh6owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642385; c=relaxed/simple;
	bh=G4plLrLUOQcttZwDhRPPDJ/yxOtxwOjQnKyrwc7npTA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CqYa7jILkMx0niNbwE8krf4Gh8TMTCcjFpYMhJNHVHdNoQvPIDl6pgorIFrREpGrDkXFw0EIy0GhemPCHpcCqTNgsoMsMWS54BWKlazyW7evWrZyEMz0ZnAQ0bLnIqpX6bWBlMQZ1qKjcb2o9B5d8zE0F1epmnNeIXKe5+Xzav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5lyf9ps; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5lyf9ps"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso3712131276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jul 2024 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721642382; x=1722247182; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C7J6l9hYl4AU+h709PJQ0hkFW91mrjgkxPA8+Y3Eed4=;
        b=Q5lyf9psi4KXu/JgEhYxNhtZWKBGPbuM59RLooz/pqCK877TcWxTc4YUXwk/RQ28kM
         6rNYQ39uG0cJgKhLAsDgWqDvkpfW6u3xPK/3GXUlfBHAUU3pNFHiHY4S5LxMK2JCzt2r
         cUgpioEvOXaemM8awHHpOFAF3JZX59o/cTVYbIZTDqkQojAsoGK93ANTaf3WZrEFzydD
         yuLhoW4JFpwuTjl9wYmPSOzO8oYF5Vtq8gRR44f9ewfZT5K4rKeqZgjzcp7Gmz67xvVP
         X9YVsIU9t7w7fsWVr8sFYoqi/5OnhztoxSA7XyIQzwov/1WPq/Xfw/EvoLEH9z1F+kYB
         GDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642382; x=1722247182;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7J6l9hYl4AU+h709PJQ0hkFW91mrjgkxPA8+Y3Eed4=;
        b=lGR059ytGgZ8JbQdlajqJMS/AQ2Kqr0NaCinUSNC8O/odOEoRjN8dK+CXc6PJ3Xo3p
         RXpQwQF1wsmg3Txeh1vHbkCsiRcPAPCwM8Srk0Fv01DvtEHUisUQI+1IHxSHJvk1Ftnm
         K5Pbc19UlCKmzbm04op42DW0bM4YWz3yyCYy7G6VVvVLBZzBMdEnySAu7gIYO/q6xp7g
         TKKzVRo7GeamxC52cdxoKsHAo7Rjxm3V5Z1IkRQBo0BrktoZEMqD96wpSQs3KUHTMLy4
         kCWo/Wt1kZpaHAceZ3asKulxtcu2WhSjl3xojhinop+UWAe+e/xuMznLLdzhxcuZHLmm
         jBsA==
X-Gm-Message-State: AOJu0YwOKaOkPnmWbDNwgYyrXJ+YLTYXculBEuOTDSSIvEApXs3m0rhW
	nHKIE7AULzo+/u0pL38WnsugUtgltVS7rI/rL9Sv+2y5sB0a6+24pbzDCA==
X-Google-Smtp-Source: AGHT+IGPJBaG9we2u6NIupR747BUMXTLxltEQOrgLQtqkewq/QBJ5UQeS36kl/JjoKfC0amgJdKfaA==
X-Received: by 2002:a05:6902:20c1:b0:dfb:6ff:403e with SMTP id 3f1490d57ef6-e08700657f6mr7066361276.13.1721642382530;
        Mon, 22 Jul 2024 02:59:42 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.28.184])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3def52sm3650109a12.18.2024.07.22.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:59:42 -0700 (PDT)
Message-ID: <669e2d8e.650a0220.9422d.8ccb@mx.google.com>
Date: Mon, 22 Jul 2024 02:59:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1348145668710421512=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arnd@kernel.org
Subject: RE: [1/2] Bluetooth: btmtk: Fix btmtk.c undefined reference build error harder
In-Reply-To: <20240722092735.1109925-1-arnd@kernel.org>
References: <20240722092735.1109925-1-arnd@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1348145668710421512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=872895

---Test result---

Test Summary:
CheckPatch                    FAIL      1.37 seconds
GitLint                       FAIL      0.69 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.64 seconds
CheckAllWarning               PASS      31.93 seconds
CheckSparse                   PASS      37.56 seconds
CheckSmatch                   PASS      101.74 seconds
BuildKernel32                 PASS      28.62 seconds
TestRunnerSetup               PASS      524.61 seconds
TestRunner_l2cap-tester       PASS      23.89 seconds
TestRunner_iso-tester         PASS      29.11 seconds
TestRunner_bnep-tester        PASS      4.84 seconds
TestRunner_mgmt-tester        PASS      108.95 seconds
TestRunner_rfcomm-tester      PASS      7.44 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      7.88 seconds
TestRunner_mesh-tester        PASS      5.97 seconds
TestRunner_smp-tester         PASS      6.89 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      33.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/2] Bluetooth: btmtk: remove #ifdef around declarations
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#81: 
 2720 |                 urb = alloc_mtk_intr_urb(hdev, skb, btusb_tx_complete);

total: 0 errors, 1 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13738574.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[2/2] Bluetooth: btmtk: remove #ifdef around declarations

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (133>80): "drivers/bluetooth/btusb.c:2705:15: error: implicit declaration of function 'btmtk_usb_subsys_reset' [-Wimplicit-function-declaration]"
14: B1 Line exceeds max length (129>80): "drivers/bluetooth/btusb.c:2720:23: error: implicit declaration of function 'alloc_mtk_intr_urb' [-Wimplicit-function-declaration]"
17: B1 Line exceeds max length (142>80): "drivers/bluetooth/btusb.c:2720:21: error: assignment to 'struct urb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]"


---
Regards,
Linux Bluetooth


--===============1348145668710421512==--
