Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0949E129
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121852; cv=none; b=h1CIPMQtJZ4wOVaN6qnMu12Jvg5xL2EwOjtqvwB8w2kQ/PeEmHlta4AFK3EyaNQEE4lXs/khDwkaiLg3lBfvQhQpxbUDKKNYg/MPbJDPs7U/uinIbuVbCRn5Mc+ObJOZW96StstUG0MLhjsR9Oewl8KlFS3FppPa2ZL4Fa4Z08E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121852; c=relaxed/simple;
	bh=vxGdw4RpqCbxbUT2P46tZgZWvO9ULvrMuhsJMt1jtT8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jgeni61yQelNy17K8kE3IyY0eBdPqt5oPKPsAuPfDStAdRlPsj9S/cQSsmLJOtEceO4ERUjpg2q3jyYUQlzvKcuXtaAVoczM6dNajD9uOhDebGFjtpDMVjTE1cm/CNjX6eYHOLFkyMD1fG7hlwAW+VNnJA4jpeDtMxn0sr7p4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irPk3bgG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irPk3bgG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cc372d6b2so8355976d6.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789121850; x=1789726650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YsrCwouCjtTxysbXhgdzINif0mpm3l4Q+APZU0gh9jY=;
        b=irPk3bgGkBVDGlvs/gTta2SvjSc8tvxeAUHmwbZyBzVLfwTDX6IREG5outRCHNdcob
         rJ3x5P7/jKffhIzqnwrjP2Szs9U7hYudlv9IrOFif4rxV3wmirq6XnNLoOgOJfzHcthS
         uNXpMdmKQrLXdTASLofkvhHCpWrtGc/Z6pvbOBarRA0QQ1MtgH0d60Pb8QdwV/XqX572
         JP9FWEn0h7w6x8OuzmMKBl9qHPmHxOsZLqY4gJw+MYp7sQdvZKoAg3f3J8Kpm8xFQPIq
         U6Qjpt+h5c5U5xUYoZRjzwtJaX242A5XiS9HJRFJ5xL+QhbNJRjyDTjuVx07fivHag8A
         40Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789121850; x=1789726650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YsrCwouCjtTxysbXhgdzINif0mpm3l4Q+APZU0gh9jY=;
        b=HqIgVD10FDXo8Lk4Ue2g0WIR3BJJ6MW6Ria9wxjHiwLXwEwIYqEwxwLYqY34wVgpLB
         yWpvFbbQciJKWyMGn0kIj/qp9M2uiWRDjHyozqfLJ0NjfLTkaLM81m3XZLHnPekeus/l
         nQEjNXXbELcf9gxoeh4cvf52Sc/azwO3ctB9eoW6YdDmgxq1dS3/6s5pkpzo4L3vYkL2
         eaj9c4Y7Xk1bDzdz+qFY38tWMCeM6dY/ysocuFOxfnD+ux/dhZ7jtSYXSvjQr1erolj7
         PzMEJjF8CPx963vPSiakUNao7O9jd3P9Xrlf0YCsqSa0fZ2dhgrKoJxd3ikFDBm2R0Hm
         eBTQ==
X-Gm-Message-State: AFuF++mneve1nswksNQLpH8HPhlfnKtoBtmKGWJpTsWxIhZ84wYtyC8u
	7WND/LFv6ii4IhOMEyej+4WRMKT1YNP6aP1TJoVLmLGrwnTRWU/wnQwMx4faIA==
X-Gm-Gg: AYBFou37MEVl85M42ky2alw+WiN1PO8f+C42OiZcU18/5AjBEx8AbYO1Pday3X26VGq
	Y2E4aEYtjpG5bZGzZsG1I+q/zgJEvOwU3qAwsMRJxtXaB59n4VbQGMaBznDrpMSiW9Bq2bp792K
	P7/OsO0T5bwAAwT4BNrIw2sBtt9jiYDOz4uMvsHo+c3Ww1aPNJ/fmi6lPK11CZ74As18Vky4FT7
	1iskS0na6XR+DVXz/sL0WADMHj5Qe4fzspHxL+BhmTdyF8GpVV6xb3xK40m/MklwaPjpgU0jDVu
	RKDsQs60HHHPzyWl2lrXAcWSpsDRH0bKNBfnciEV+0R26tSNkyjss5cF5Q72YE/aplXT/Gwpf0j
	GSK8WG5ojZ1WTCKnpx+cJEOLwJeBo62apo0FOmVn1U97mAwZ1Ixt3CvpQFtBtVtKgRSkL3Lefuq
	Do1YtP5BkJSOL4GXt1KN15omvdumfzx69crMPOXLvEyyN0P9A06kH/QlPV21S6whHV4xk/S+PYJ
	81UhYeeon9YnNs=
X-Received: by 2002:a05:622a:1341:b0:530:dae4:81d with SMTP id d75a77b69052e-530dae4376amr8445441cf.27.1789121849465;
        Fri, 11 Sep 2026 03:17:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.199.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca4b9c54sm16120281cf.20.2026.09.11.03.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:17:29 -0700 (PDT)
Message-ID: <6aa3d539.a52e8b4c.3b0378.9b60@mx.google.com>
Date: Fri, 11 Sep 2026 03:17:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0622025560658290119=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Support Qualcomm multi-subsystem QCC2072
In-Reply-To: <20260911-btusb_qcc2072-v5-1-422754f4e938@oss.qualcomm.com>
References: <20260911-btusb_qcc2072-v5-1-422754f4e938@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0622025560658290119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162689/

---Test result---

Test Summary:
CheckPatch                    FAIL      6.79 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      1.21 seconds
SubjectPrefix                 PASS      9.73 seconds
BuildKernel                   PASS      22.86 seconds
CheckAllWarning               PASS      26.27 seconds
CheckSparse                   PASS      28.56 seconds
BuildKernel32                 PASS      23.28 seconds
CheckKernelLLVM               FAIL      22.05 seconds
TestRunnerSetup               PASS      584.99 seconds
TestRunner_l2cap-tester       PASS      34.85 seconds
TestRunner_iso-tester         PASS      81.12 seconds
TestRunner_bnep-tester        PASS      9.69 seconds
TestRunner_mgmt-tester        FAIL      118.27 seconds
TestRunner_rfcomm-tester      PASS      12.93 seconds
TestRunner_sco-tester         PASS      18.08 seconds
TestRunner_ioctl-tester       PASS      13.81 seconds
TestRunner_mesh-tester        FAIL      15.99 seconds
TestRunner_smp-tester         PASS      12.08 seconds
TestRunner_userchan-tester    PASS      10.04 seconds
TestRunner_6lowpan-tester     PASS      12.35 seconds
IncrementalBuild              PASS      44.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v5,3/4] Bluetooth: btusb: Build the driver from multiple source files
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#167: 
 drivers/bluetooth/{btusb.c => btusb_main.c} | 0

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14807477.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v5,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#522: 
new file mode 100644

total: 0 errors, 1 warnings, 4929 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14807478.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5,4/4] Bluetooth: btusb: Add support for Qualcomm multi-subsystem QCC2072

8: B3 Line contains hard tab characters (\t): "       USB I/F	|	   internal link	|"
9: B3 Line contains hard tab characters (\t): "BTHOST --------	|---- PERI -------------- BT	|"
10: B3 Line contains hard tab characters (\t): "		|_______________________________|"
##############################
Test: CheckKernelLLVM - FAIL
Desc: Build kernel with LLVM + context analysis
Output:

drivers/bluetooth/btusb_qcom.c:4269:6: error: mutex 'btusb_qcom_xport_data(hdev).tx_mutex' is not held on every path through here [-Werror,-Wthread-safety-analysis]
 4269 |         if (is_vendor)
      |             ^
drivers/bluetooth/btusb_qcom.c:4267:3: note: mutex acquired here
 4267 |                 mutex_lock(&xport_data->tx_mutex);
      |                 ^
drivers/bluetooth/btusb_qcom.c:4275:3: error: releasing mutex 'btusb_qcom_xport_data(hdev).tx_mutex' that was not held [-Werror,-Wthread-safety-analysis]
 4275 |                 mutex_unlock(&xport_data->tx_mutex);
      |                 ^
2 errors generated.
make[4]: *** [scripts/Makefile.build:289: drivers/bluetooth/btusb_qcom.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:549: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:549: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/github/workspace/src/src/Makefile:2187: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 496 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.103 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.363 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds


https://github.com/bluez/bluetooth-next/pull/752

---
Regards,
Linux Bluetooth


--===============0622025560658290119==--
