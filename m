Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070B308F15
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509454; cv=none; b=A+Foz2JOmRyik1umQ5+Ik3aYRJMkn/ueDHURADE28nfwyh10IN0Df0LCYgLXBnu5bGvZTlnccZQ04mH6QSrdOd8tSPZN/kOLFA3I2zJlXRAbqKzI07u6z5Bs0v56iHCyuj7Md5K3Takm7rXHmRn5ToDK/B/1RFSxjhTElNJwn+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509454; c=relaxed/simple;
	bh=jFPBpH/Nyh8LidQtfz+5ryE+suDe9RqLWvDl404JmLU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cUDVnwbf0DIU+Wb0GTM/uV00Rtz3XKVM9NVrNUwEdGZMCi7LCwptL63LozBB68Rkirj2H4J8Ld5mThHpEOb69t2cnBlElBnsa9sZ9B+tuE8OwZk9ongo7Z+tZwfHieEUGAISIa26Ein1krGDO4qT0rsqzKLK72P+R0mSuVeg7PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faS4MWTp; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faS4MWTp"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f7020a928eso5995077eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509452; x=1779114252; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LJX2ErVvrwU5Fws4WwHfKqHZ1objt+26cTfS2lZE5Ow=;
        b=faS4MWTp4hsq0ITjPPiqg2FPGhooLDp29i0tzr3MLuNjU+KUFkQmcZx951vx8A2InC
         gB2qSU3KsM/JMRgFJAXRuD+HjBdmBWAdyvQXougAq4nLK3NzfLCe6DQchINVKVyPkaFz
         jo6crYf98baWLsravpyQGqnTT5qn3TaNWkLyqkTrYbe8qt5wNjeJyt/OP2U17/PUYqNU
         jRjpJwpnPJ5WI2OQRtwlPDGshPC036wGN2OB3Zmwd3yJjxwcd/UbKQptfXDIES4o39TQ
         tqfg67ZaMPZFXLWEWV4+YntW4bK/W+2pzdenGuxuEgDgkIvZASk5xWtNX6oWqxOwL0nw
         KB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509452; x=1779114252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJX2ErVvrwU5Fws4WwHfKqHZ1objt+26cTfS2lZE5Ow=;
        b=LbYjKbkAFqBjwH2W54s2gfIS9dhSISLgJcAgeqkidQo3jiDjaHTvO06IrUow/pyyoE
         WqEmvnXIUG8XhwlXxKEvwiYR69b4hh+pnuqY3L0/dKSGmMHHzHFWp9vHGC2ADgu2VR1o
         Oy6vi6QG5XijlnNlnPZWZfWiBLAeg99q+VrQAJ3b3352CUuGeXbXHP0j7hIdzofVXkNJ
         iJoW30MWiDuKvCR6dznnFPKnOVmOjUSh0g5laY2pLai0f3QxZ236wVjLZwHmhewQDZcq
         m3cFxBZ1jyX7SglEjOxWdwYwA24SBSuupFwG2dSaOoVjBIvW+DbVPloNe6wkQTH4T49M
         eHsg==
X-Gm-Message-State: AOJu0Yx7W4ZJ77etacAGY+cO5GLC6UgDvrIdsHMC0AoC9rIcF6f6vPbc
	JBb7HNBa+vyY+umgUhYmrNN+Igs5Tlm5Bu9cuDAe8dCWEM3L0rhyqjnkbDqdCA==
X-Gm-Gg: Acq92OGlxJm3UDr8GjG1KKocbArw+SNxQuL2X7R8b8tRkYB96973bLWeG7ohmE7xGmz
	sq4yTcEYTCh60EjAak+gFDHEJ9Ok6pYQQaIB1Usqu/ndPJyoY26NdLbE5+CrocBdKn6EzHXq/gL
	l0DNu6TL0NP1TZV3WD3kDEs6pI2M9sY4YEJTtj43/ONDnxC/uavkqEZ6oMTGpoHWh72cNCnnwrO
	ErzYeYYzGUntSnof5/Z2wHWQZvQRx1/WHEu5LARaTA1ijVBL1WqZaKYZ5quGtbc6CS68zKyfUBz
	y8S4Xb4ktb2R6OCz89R6UzharP1DfZcNy+YAYPyJFY/OedygInjZ/mJVWbTIPjgOck2E3HyXCFa
	Ozw6dU4aWcuCLJNxxVuAw1sAypSzHxNA4+sFYOyP79EHF/AhgqBPxySSsQEWUfxaqUtltTm5AsK
	RiaD7mUY/e4FxLkMlENRDu4ZX1MQbiHeZC
X-Received: by 2002:a05:7300:ac82:b0:2ed:e14:7f5f with SMTP id 5a478bee46e88-2f54b89a1a3mr11684225eec.35.1778509451429;
        Mon, 11 May 2026 07:24:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.195.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752ccsm13249105eec.17.2026.05.11.07.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:24:10 -0700 (PDT)
Message-ID: <6a01e68a.050a0220.22ece4.8b51@mx.google.com>
Date: Mon, 11 May 2026 07:24:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6341163311188242926=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, michael.bommarito@gmail.com
Subject: RE: Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
In-Reply-To: <20260511122641.437434-1-michael.bommarito@gmail.com>
References: <20260511122641.437434-1-michael.bommarito@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6341163311188242926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092764

---Test result---

Test Summary:
CheckPatch                    FAIL      0.59 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.17 seconds
CheckAllWarning               PASS      27.71 seconds
CheckSparse                   PASS      26.40 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      525.11 seconds
TestRunner_l2cap-tester       PASS      378.39 seconds
IncrementalBuild              PASS      24.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#104: 
Commit 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14565486.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/165

---
Regards,
Linux Bluetooth


--===============6341163311188242926==--
