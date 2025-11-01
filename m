Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35C79F2
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001185; cv=none; b=bPFW/OqMRdryDghstz/AQQ5z42EVUUvbJC31Gh/64UQB9BmJwZpPfQx8DEeXrqUIv20awmT4Wjva7dC/ZzCiL59PDwWPTv8Im00QhV1GWNGhuFVbutPLQwFpXaeUY2UiCFDuIdbQGpzB09pqZLJJ4Bojsd7u1oPtTDsjlbzPmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001185; c=relaxed/simple;
	bh=F3lNHqtbBA9Y3RzgukttnYTjKLhla0YcClxXy3K5ApU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ow0jE/ILXF82sRPJBr/Jy4vjyZcBD0Eha9N7wpjrkSLOSalEZSq79nm8/gk0q1jrgqK3kdO7rClHjH8E0tDD1MWjQ9ddPClCI32+o6eWglIEE2T7Z4nXIMU1mxf5zqG93m0uqBchjdW9Rck/ZtDcv5WWvFL92m/ifEJdgGtbjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edtQaNFw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edtQaNFw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed0c162789so38497991cf.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762001182; x=1762605982; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T59QL4Kflr+lAl7TjIknxKtEug0AHro0G4wmoE1OjH4=;
        b=edtQaNFwbt54cJtEWQ0H6DhpCzkT6HNR8aY3T5Bxif9KSBYxXups6M6S6YG7M6lDDB
         552y0TABb4lt5Fl/liJsC6cuUDJ1rmsHZ5WB4M1m7FcpLy9kqXTt1x6H3PkzYLrAv1uZ
         IRmUdsxG8NNqcqombDISxmHQ7YpEobdvtULo3P2KW6w0BODvVCJ61yVrL9K1hblF81o1
         RJ312P0ab0TGpxt3kfaS0EPHnuEAHXkW4MUkopGt31yGeXYEVc4rXOQZ3FajktjxgFZm
         B6n47L6xeOor0f1BbKd1iVxGxNLZ02fH4seRwm5OFFe30u7OxyJqOy3Tl4Ji9S/O2MhG
         bE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762001182; x=1762605982;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T59QL4Kflr+lAl7TjIknxKtEug0AHro0G4wmoE1OjH4=;
        b=IFiTM4t4OG6a4hlwxf+LRrcPmiBEfayuAnHHFsTd1mfpcuyxxkW86moVARJNcqcbNF
         zXKXplfvjML7tBgX9Tv0yEY752Kl2CnLAxZu+d3d6B2l0yOlKz1owrj7vs3bzNRQ8jit
         0nxAYp7tIz9b4vxwe4IuEpcPy0iDMdx4nyxFfWQNzVG0HwzhB6oywhwTVySn1TRPgrEP
         7rYd+KHKtzgTJAGWruL0cz6OWqjI9LMUMqAFxVfm7wKnKNghtcLta9fZCzKYFERF/7v2
         mFqyOOD7vklJZ/Zy8+3WJcbuBu1RvzscOBH9ppfVunZezDkV0TLlRxUS5fLYvZXrnZMS
         g1kA==
X-Gm-Message-State: AOJu0YyqQkmb7POBAByFiTUIZuGx4xWa+JJ6SkQgwmc0NFpvOs3Q91UY
	UB4UY0UwTE4juS9P5V9ainhpZclboWU8BM35tbwW35IPia+me8+hrxtaJnBSIA==
X-Gm-Gg: ASbGncuyRJJ4yCoQvnAFxaEOF+VCALvymKeqLE8n75GfSyVn+ozaXQcWR2rrN82liya
	EQsQjw2HMB6uC8GdcEdGKSJtA69F4KUdbJDlEiv3Im+WSaV/w3Ak9PDMKkGeJ++G0tGcM1rC0Po
	u6aMemi+sNzDXX02k9UGaUza0W63cfWgmJ70in42IY39MnGTqJnaD+FxB+cFN+Hhh5XMwwOBJh/
	UY0/Xt3SiSxCcgpvL+RqHI202uIThNcVNpd94nuXvM9CSKXhlw8f+x1ssiVICFjxMQyvlNapruc
	FXKZEV/AmAbuwPkEEcYJtbjUbCxYIagNcmAx9z2cdPqWUcWSrRBn4/uxR5oRUqeeG5Zei+fSrI4
	QT+1U53wFSEfQQm/qd7vG7vrgXgfpt1GriGXNTX01FY6YRUQ4XCJTz3Gddd04fhxPc5H0DL8v+Y
	iCNlr+QLvu1yawLOeD
X-Google-Smtp-Source: AGHT+IFldiprk7sNqAnBZ8B+CKzpcsAQ6ZAlItm5KhAsAfdy7r2206MlpBUz1CoJiE9PonDthe2Jug==
X-Received: by 2002:a05:622a:8291:b0:4ed:4325:d9b7 with SMTP id d75a77b69052e-4ed4325e0f8mr13648461cf.4.1762001181980;
        Sat, 01 Nov 2025 05:46:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.92.212])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac02f89facsm292234385a.34.2025.11.01.05.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:46:21 -0700 (PDT)
Message-ID: <6906011d.050a0220.24d63d.7864@mx.google.com>
Date: Sat, 01 Nov 2025 05:46:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6058957200199739265=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/4] Bluetooth: 6lowpan: reset link-local header on ipv6 recv path
In-Reply-To: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6058957200199739265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018490

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.23 seconds
SubjectPrefix                 PASS      0.46 seconds
BuildKernel                   PASS      25.08 seconds
CheckAllWarning               PASS      27.26 seconds
CheckSparse                   PASS      31.31 seconds
BuildKernel32                 PASS      24.64 seconds
TestRunnerSetup               PASS      498.30 seconds
TestRunner_l2cap-tester       PASS      23.71 seconds
TestRunner_iso-tester         PASS      70.16 seconds
TestRunner_bnep-tester        PASS      6.22 seconds
TestRunner_mgmt-tester        FAIL      113.56 seconds
TestRunner_rfcomm-tester      PASS      9.20 seconds
TestRunner_sco-tester         PASS      14.40 seconds
TestRunner_ioctl-tester       PASS      9.83 seconds
TestRunner_mesh-tester        FAIL      11.55 seconds
TestRunner_smp-tester         PASS      8.46 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PENDING   0.69 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.107 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.187 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.056 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6058957200199739265==--
