Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602F1A9B4C
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347028; cv=none; b=JwlQH+wS7VGrsf6Z1IKIYrc1Yr00LA1r8rWh+o8OzA8BKCkF5dvtyS2mxj/VdQoHDh28B7WM6LvTpSodnmu05Lge1Ix7alhMVjIPv+v1nx80MI9Df6A2URv/d78l/tfKV/LnA2NOtKl41yBaFQN9QqSDvEZWcBvMcDkQMwTOwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347028; c=relaxed/simple;
	bh=0OQlzpAB4O730UqHvuNY1w8wlKHd2OcuyXI1l5dRoqU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ffkEPOiRLVTL/FiMTGW2IoH7AF5UjgnXc+rIlyb41EAX+3s4ucCYlLnRNQE3UGaKFUxMgnYtbLnK9ceJgTkdWB1jnEi+bcrqYaT9yo4Us/vvVXpK+eU7DJ0/P1wcQC/dwMtLIPX/ho31iRB1CLNRZ21ynVHBuuOBm0c4tjO8gks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkJbhUE7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkJbhUE7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so2736809a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Mar 2025 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741347026; x=1741951826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YUZR5vRAVqH8Cmt48DLz1hcMmgWsVVUq/+d8ejF2la4=;
        b=gkJbhUE7QeGh18no5vWopmn482Uek9PDXW9BaOPgW6VGnYeNuVoSPK2MK1W2JZCq24
         vstaLsCmrz9N6KLkhLJhQ1O3MQnQ94cQFw9H9eSuj0e7G1iS/6K/14zt3yrt25iKshZw
         ybJ4ensoAbwKA3VoKsZXL/DhJgpHcCZxokHoYEjtZ3vuzpPQsSdLB2w9UW0XSSZ8sfEJ
         TSjqJgXCS8lib8iCQpUkgqn3X0cs0zV6Maag1JES6nQU9QLYChg9hucnt1zVTa4Dw8t8
         vJ0e5dAoDMU3nInQyVQDOW8OlOrlPxJCpWUk2l4Id/rxqWwIlI3omgC4MOMBDDIqIm9o
         bCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347026; x=1741951826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUZR5vRAVqH8Cmt48DLz1hcMmgWsVVUq/+d8ejF2la4=;
        b=vfLaNTBCAifIFwkDYF9Cs+a4+SJ2Kv5g57Gpl9w3b35wWk0mA7tSwfFRymeNz0hUfC
         kxD3x5hpN/bqDfrz8IhxKdSqWVeoAXDaetPAtOcG1ClzUqWgDBijD/3Ok8jRP5S0EPGU
         SuRBJ1D+YPuXw69eDPKzE/JJFOZlaXQadJjMXj4DglOjr4NYUfIkHxzbLvchwj1VBsY/
         qV0Q0WRkkcz+/oLIJb6u/9PkWm9WZ6aq1NIMo7+J+ZKLzeqPu8NOzXx8dk+3rMV5QOu6
         xSwc7xJWrnT0l+ki/vNiatgHGu6gE2y8dQK1LlXs7kb2SDTuD8cT6ATuqKG7fq/AuaIX
         71Tw==
X-Gm-Message-State: AOJu0YzK7TbGTRrvtq4QKLEQgUfwBc+KbrmJBYX1/4qg9xuOtkcsS1eo
	3+2fvCC/ARe1ygn650QDigh4uEDgHLTNLoeXwaGmn63DNmFrbCMvdjmPtg==
X-Gm-Gg: ASbGnctj6WExEPHGcslB8+bdtVPsk+dWaE5GtpTZQE5orK69O+DEUZEpQV2OZQjO0Iu
	KuiAD/6vhtu7VHfOIyV4EpziHXiD6+2qy2yMTugB06XwHZswmLtAMFakR2EKrNWIHvdW7PiTPiG
	zV8W2ZjL1bruPQPKUoM6z5oaFE4dgM8LQZVCeunyqon9BqOqpJfb7OeS1JIjwWqTArGdMi0yogH
	kXPLr+KVWrUsN+Dxbw+Qrl2v7Pp72yQO2SrXiWS0M464fnSCOKUmX+RefRRKg1+NxnieerlFMk0
	Or5T9VaK4CyRw6uwmTniMHiBB1Biexg4KEt27aFjm8j0QeL2tS8=
X-Google-Smtp-Source: AGHT+IFngM4y2hC8a6rLW/yF7dTwkBqZVL+0qqEY5ErXMIwXp/PCUo3EtqwWHotYFSIAqrz/yrwdRA==
X-Received: by 2002:a17:90b:2883:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-2ff7cf31b55mr3842290a91.34.1741347025978;
        Fri, 07 Mar 2025 03:30:25 -0800 (PST)
Received: from [172.17.0.2] ([52.234.38.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6933b029sm2807372a91.6.2025.03.07.03.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:30:25 -0800 (PST)
Message-ID: <67cad8d1.170a0220.1a3964.77e4@mx.google.com>
Date: Fri, 07 Mar 2025 03:30:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5138249318532122037=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vijay.satija@intel.com
Subject: RE: [v2] Bluetooth: btintel: Add support to configure TX power
In-Reply-To: <20250307110011.1960049-1-vijay.satija@intel.com>
References: <20250307110011.1960049-1-vijay.satija@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5138249318532122037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941465

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      24.84 seconds
CheckAllWarning               PASS      27.36 seconds
CheckSparse                   PASS      32.02 seconds
BuildKernel32                 PASS      24.56 seconds
TestRunnerSetup               PASS      429.89 seconds
TestRunner_l2cap-tester       PASS      26.94 seconds
TestRunner_iso-tester         PASS      32.93 seconds
TestRunner_bnep-tester        PASS      4.76 seconds
TestRunner_mgmt-tester        PASS      120.97 seconds
TestRunner_rfcomm-tester      PASS      7.82 seconds
TestRunner_sco-tester         PASS      11.71 seconds
TestRunner_ioctl-tester       PASS      8.33 seconds
TestRunner_mesh-tester        PASS      6.05 seconds
TestRunner_smp-tester         PASS      7.29 seconds
TestRunner_userchan-tester    PASS      5.11 seconds
IncrementalBuild              PENDING   0.94 seconds

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


--===============5138249318532122037==--
