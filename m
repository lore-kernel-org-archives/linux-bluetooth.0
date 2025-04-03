Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366C25D214
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Apr 2025 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707032; cv=none; b=qTbWozhQw3ZLW6dzwgoTU/YkP+xPcCvxxMecnzk/B7RdKqUmhYZO6rPpVhaG7zEeZevEHxotPuokJTEKSboCWchJpZp5I++EJeNdgk6S3+j2lqtg8KMQkqSOqnNM6EJL4WaVEwr7NGa06jDGUtZkLDCDcW8v2Ye9Jlarfumo8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707032; c=relaxed/simple;
	bh=fhAGdVm1TatC1PxajdVRrszocqOT0YTWT052Ebow8uY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=grP+DscISc8ihnjOKXryoL2J1ZCNSDlxPqP2FZY7OF0R7lgW0TpdTVIF4/mhCksSV+8mTYPc8P9WMDHu4yGhcLIozNEAA2UpXgO37cd/KNgCMh+YXuMltbOMq74vIbao7BTGdBDNiTGbxJ7TCe1nMPgMnVp29DQkLdxWBQm/Rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZlxfy/0; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZlxfy/0"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b0c68092so1063268b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Apr 2025 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743707029; x=1744311829; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OpCn70GqVuj/LkbsUdnOwz/9AP47WnqFU+GNte9Qg30=;
        b=CZlxfy/0FA/eQbFzz6gN7jDaE0uJ/mD97QbngVHzfRcMa4WyRV9E7STr/ZlPZVxHXK
         RYXMcLbkjWPGEhFoBhbr+DU/otRlxxzQtLdhj7n2zDW8tgnA0nRlwpSxkcsAfQF6jIAY
         WLhZiucmbISRRSW41tOHt+Hc6Ejvks/gEImRZSqR4ZJBSSjQ4gmy6ikCkOni/bRvwNGj
         F+9leUC30+Vnkh26dnB2tz0lvYEeW8fj/RvD5u+lm6AdH5vOJj8+jVj6TLmRA9D/0nmZ
         uClTOvitsFe0cyXLWUDqtbqJiEMnSMRt66gwA8qvqiG5codFTdZzDcppP7UfbqQZgZzn
         mCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743707029; x=1744311829;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpCn70GqVuj/LkbsUdnOwz/9AP47WnqFU+GNte9Qg30=;
        b=hhRag0QO2rh+GleOqu+RzYaSOqKn6iCiFP/SOV+GdIYZUKxZnp74D8ho4bv8rV8CjO
         YtPxZHWaHiYlYJ5RUxFfm9eRVdJhwerW0VceJiL/Fp6eYvIhDKdQkclAJ3+xTV/MKVRx
         cWw46SzczmxmYQFgkzytXv01r2RWHVJl4SBfr83LZWrFZZd4sjgliYeMKZbYyhNFyR0H
         0nvY/KIdFQ7gJFy+bWPjI9Ffq2ptbxCksgX0zYcB6zoequM6/Prb/h15X4V/7UyndeR+
         UfHUP5ND0OpzreJ9qDjgOsYzLsFS2iY0kS4ZjQuGEH06l6vzgmBT+zaRWDtczDVfJ6u0
         GDeg==
X-Gm-Message-State: AOJu0Yyiu+CZHGCUtJajgC4hqWOzDFVQl1NuxPPQk23/agbmvZGOTv1H
	F1rc1EhwGXesDrIOxIoHTd73GOgADe2RgKTwB4MaB3CjUgcsTGY3TEfGPQ==
X-Gm-Gg: ASbGncsi+afa8rpEKd8RVIe8+wRSs6sDqrLSdtSw0WKjuC5wdG8ACeLjMkyl34+qc+J
	fr9/dJyElWZZFxlJXDLGPrhCzGtwTg5E9+wBi+oq3naC57WG6NbpphpGhMGGklJdtOwVWaMWpDQ
	dIPZ8cizfKe8bXoTrkiUbVJr48MTDTi+keWjuGLAsJDR7pvw+Rzyl7Z06z6oBKPL5osahnOMyJW
	PJwlBD8RbpPUkDEB4/Mgj8rh1o1AgumYDvAxsVPtGSfDSXf+Pbg66SOa15EddTpU6kmrU01DADB
	ktjaCYS+4GP72O7/yT8Tt7824PP2ghP3W+YhZNJuLw7my0zILFo=
X-Google-Smtp-Source: AGHT+IFRlxsYzlVQHeGJVlJWGNmWHvB5Fd0mrolfqREv55iAS//aMaS+QkaniL3jdghWoyYOHSllbw==
X-Received: by 2002:aa7:8893:0:b0:736:6ecd:8e32 with SMTP id d2e1a72fcca58-739e4c0e320mr841342b3a.21.1743707029442;
        Thu, 03 Apr 2025 12:03:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b41d4sm1911080b3a.132.2025.04.03.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:03:48 -0700 (PDT)
Message-ID: <67eedb94.050a0220.3c0387.084a@mx.google.com>
Date: Thu, 03 Apr 2025 12:03:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7431829364771737110=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Add an error message if FW dump trigger fails
In-Reply-To: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
References: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7431829364771737110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=949648

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.28 seconds
BuildKernel                   PASS      24.10 seconds
CheckAllWarning               PASS      26.56 seconds
CheckSparse                   PASS      30.02 seconds
BuildKernel32                 PASS      23.80 seconds
TestRunnerSetup               PASS      426.29 seconds
TestRunner_l2cap-tester       PASS      20.77 seconds
TestRunner_iso-tester         PASS      33.05 seconds
TestRunner_bnep-tester        PASS      4.60 seconds
TestRunner_mgmt-tester        PASS      121.22 seconds
TestRunner_rfcomm-tester      PASS      7.78 seconds
TestRunner_sco-tester         PASS      12.35 seconds
TestRunner_ioctl-tester       PASS      8.16 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      4.88 seconds
IncrementalBuild              PENDING   0.90 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7431829364771737110==--
