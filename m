Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8692936DA04
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785612170; cv=none; b=bBU2KDf+ZYRllK099xa08guLuhBvAZpOR8nHJT8D5DIlHVbfVf/3cVB7Qpw9DibACDSSd4csqs2tx0LnoFedH0rtoq/JTjvJDkMLTVEldO+0xPrqGvCnwSc8vz1CCq1jr7eXouYvc564+Y2buJdTJ8D3bGegnsptZKLZHpqfgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785612170; c=relaxed/simple;
	bh=VmHkPPfPoWd/Nt+z6slexZs5nndKiM5XNrgQ+UU1b1k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PBSMcH2/f9unHf6ZNKkF9k5wCY5hXPUqG/QUG/9EWL7RjX8MTHXNZ48eRx6nofffW02VL0JTRNWUCsy2P/Fa+4vHLAh1mQIyHyofEp8Ra5PLI0RfbvrjAQe0efDY4rBLbMhRi73gvW9tkFgWuIOQnZdYuTR2GX8aYx9hFzPjhUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0gFPKyz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0gFPKyz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2375802b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 12:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785612165; x=1786216965; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kcHBVNrpXOv7NyVp34XNNu08z8tATh7eJqrOWCz7xwI=;
        b=c0gFPKyzopM4crSj/e/nlA2otClyLV/zYK/+bx3ZMyoIObT4gidvNMArG73Sq8tcYv
         ps5xuNRZbBSKkV0sttkjYQ19VDugX7qNrtZQ/5BChJZSnXXCTUoLIKuBOE3H9NqS0Alo
         U5hbfErGK2AYoWa4WXDVsXo5vqTc6Wj+gyqXx/mXH2JKSXFUD09oeXNDWYL4E24yNB9V
         HV/GOoCyK19U4/vjBy3HTn908kUORTszU1eR1t3aJJt/BlEUUElX5M1PbPso/XCAbmBn
         qXUVqZo6aVJd/jAktbpRO+zYor0zIKNsjnfCQCnQYp2Cwb7Ay2ucbohEfwaD8n1N/2Ks
         2ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785612165; x=1786216965;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kcHBVNrpXOv7NyVp34XNNu08z8tATh7eJqrOWCz7xwI=;
        b=Cghdv57GWcQpFGwIuKdVfKNmyEcDGM6YFumLzAzwzKMENiFRIUKOl+mOHUIs56dYJT
         1fAKOmE+7PFrwxZ9eIb2fhTYE36iGFq4VueLzaJ0cYGvzkmcXnp+7mZd1ZIZnJiyrJui
         xHv5vSEltzSepRnXnqvTfy71Kd1szf81m/CO49gCoglf19KeTdATwgILySlnuFGP8FZm
         u74RKPxG7e574psT6EVtUXt0LO5lCnvwQkNiAvIPjuhjlxyNJof2JPa17/s7vYCMIBbN
         mvNDgb/eS0eNNw03FT0EYSxRkHFn9usRuPYx3SknUZ1XqoLR+qV1ZkJmR2pppAnuCp9e
         CtTA==
X-Gm-Message-State: AOJu0Yzhtba0WcZlJJ9bF6gb0ChwKnzWWNbrUhmRI6Jkum0oA3kjnt20
	oJx7ctM3ybBiKknwDvAdd/g1Uv9Wl+g9Aw79MULNPznJga4fRaMB/gZgP7NaSw==
X-Gm-Gg: AR+sD13/RgtvYElHG6aTZB6/gQcC4JrPkAu/ZH0QRfh786jcYnwIs+sY947XGWafKi1
	QU5awuLjvRGe6qLAaIGoNPyNt4RixQaBEJ26Le3q2ZmN0nt9W07hRGhJrdCxB8rccGhEPlWPB57
	f5LXoc0+id8QztbBjsFYI4hr13SFGjOVtv5B9PNdf6ZjbUU2ZOSsM9A4/pmhc1A2snV4PfyPsYn
	v2nPOZTNc90DA/+wMW4TLzLUX8kC22A4XSIPksPoVtK7mriZ9WbvZ8omTMNYeLgqqUaHeuuYlVc
	v6OTIrrqsJMl0SecUxjrHOSusOjjh14F0vRgJqhKNaDRQ91sXvoJKaSjNJvfkB0PVfblOvghzVC
	lbVtn4TGs5JsiXEnkPLkem2J3H4+oDXOPtawPKYxqta3AbA6zAEHLflNAbgKUD7lehX/G6OfG7W
	a5OViS8Q8XCr4yEE3F1oRVS3Er5Ss9nRMRxLBRUcvxDXWB5RuM/+ui4jOv4BmdK5x7MVY=
X-Received: by 2002:a05:6a00:bd88:b0:847:8dec:141f with SMTP id d2e1a72fcca58-84ee493f671mr3680629b3a.51.1785612164981;
        Sat, 01 Aug 2026 12:22:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.73.144])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4f83c3sm12863908c88.14.2026.08.01.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 12:22:44 -0700 (PDT)
Message-ID: <6a6e4784.dbb26164.6cab3.b1e1@mx.google.com>
Date: Sat, 01 Aug 2026 12:22:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2253312645652727857=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [1/2] Bluetooth: L2CAP: use proto_lock for l2cap_data to fix l2cap_disconn_ind
In-Reply-To: <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
References: <a672a4ee3d24c93156c51ef84ca4dc3364a18109.1785609341.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2253312645652727857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1138701

---Test result---

Test Summary:
CheckPatch                    PASS      2.03 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      24.87 seconds
CheckAllWarning               PASS      27.09 seconds
CheckSparse                   PASS      25.93 seconds
BuildKernel32                 PASS      23.94 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      453.23 seconds
TestRunner_l2cap-tester       PASS      63.44 seconds
TestRunner_iso-tester         PASS      78.00 seconds
TestRunner_bnep-tester        PASS      18.54 seconds
TestRunner_mgmt-tester        FAIL      224.32 seconds
TestRunner_rfcomm-tester      PASS      25.16 seconds
TestRunner_sco-tester         PASS      31.61 seconds
TestRunner_ioctl-tester       PASS      26.40 seconds
TestRunner_mesh-tester        FAIL      25.86 seconds
TestRunner_smp-tester         PASS      23.10 seconds
TestRunner_userchan-tester    PASS      24.23 seconds
TestRunner_6lowpan-tester     PASS      22.52 seconds
IncrementalBuild              PASS      39.03 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.258 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.415 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/526

---
Regards,
Linux Bluetooth


--===============2253312645652727857==--
