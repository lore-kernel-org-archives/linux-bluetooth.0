Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181169;
	b=UzdL3hSqDHTeM0IFs3C++7G3hMbvcp1+aX/rlwVbBWGO0570wX/niqxy4pXC9mVINF4U
	 kMHl3r0pvRcIyCdSCCyHHkPxmBYRBRQUi7jqjlxnlTs/g+VXzIq2lm+HXR5pPqpK3eKHr
	 QqOrNXv5tB3s1BT8TB/fcvu0ZeDgDl1gGq7zsJ1hyyoeW0+NMBn/eFmPARDoPKvb1rSLq
	 wbQXMYbuYctvHIVljW/wCL/HDxhmA24pEK0LANEUKoJwZgN10elGhubr5TASV/k6cUmlf
	 6dqI8F/O4Oi2OZPwOPb96AZaFbBSTGmjnRS5xE4ov1o0T0i/xSDbBhZPBWnMTKRS5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+eLnZqZ1AW6M+nXFzLOOjymbD8lMySHuWmiSkbCitJQ=;
	b=UgZoIenCYdYJ/kNUlzGQkCQ2cDFtZzZWk8FdtJGW1XfUDEfbciN8mntWiqImq2T1d9R1
	 vL3Xx5pjx8lg0Wq5los8cDqJ9iAUMgpkzNGC8/KDSPsk/XU7K2WgeApxt3xbAAWJp3jPN
	 bPVPaw4DXZuiIREwcNfp67iRgQ6uZ/BvCI3Ctmm8hqM+9P0IRtTtguwB0Pa515Cowb4vq
	 7wr+3ebLBCqhYdcDVTQNGncsYScEABomc6QM5JAY0f6uizUvz5iLgTYb0akKh77WqHgH7
	 LYLRHFwA1NLQxZDrjrf5RDzR8tiy0+HY/yqGVIRf1dR8Q6cP2ng5AoTM8vzYcBuy4eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+gxknQO;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C986606A33E
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 13:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C986606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u+gxknQO
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-921365696d9so6080716d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795181168; x=1795785968; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+eLnZqZ1AW6M+nXFzLOOjymbD8lMySHuWmiSkbCitJQ=;
        b=u+gxknQOasW33mvuF4MRBRSX5SPxlbtHjupQnmpX0LHOI9QQfJGwSiPm5hsf3EhASo
         n7wB++oB01PibbIz8OM7mRAqTFdRSRwlr7XDxGbhgvPQ1WuUW7WU/rMMt9z40AcZ0QFa
         m3fOVxD2HF3Cqzb7WFuv0+Ryfvb/8fzBrOEkZp0mpoQ3b59D03Qfe/k5QH1VtWeFnyB/
         68F1qwjsa1d36/Bp153vHiHcrJG0vYs+Ir2mnVZGtk5ZvYx52gG/cnCj+mEScbk9Ao5+
         8Kn382BFjEXYD52J3zCi//MRgkOA1Jc2PNRtzOWFjw8y6DxKObgRSS8ZlmePt2r3sxUJ
         mKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795181168; x=1795785968;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+eLnZqZ1AW6M+nXFzLOOjymbD8lMySHuWmiSkbCitJQ=;
        b=2czYbCQGsfmg0p2JFtFhatdIhBa+7wrkvk7AnyPwKZrA5PRrCiC/3/iacI26Kqt0cw
         Lgc1JuyAomIIdXzz7j4eOh5jQAw5E5Lz8995QAaNDSnItoCwoXJ7IjC43RqTS1fy8lHY
         3PqmOPEejGd/Jcrx7v1lSrGcoLyezq56zHxVaUeoY1phiUrxAVBuhE4WY7nB4a9NXf3L
         XsGEIc7DK4eQ4kiwcMxWVt7cV6yglNCCBR3uk0fNHlEb5THqDlMZSTGgzlDacg3wEvdt
         LYB4wlhGc6jI0zFzPGaxUqDN7IFHq5sF4YmTJrFplePOjun2oPpUL7V0ZgeG+jir/hPv
         ZWCA==
X-Gm-Message-State: APuU4Z+7og04Fh/BCEI5PTrmKiMgzd+T/2vTpGDRYv+NFh/Gq8UOcLdF
	yW+jcST3og04wR4UWqfu4FuRgNvA0HcHXoKROMo5+2Dq3qfht7Vz17tGpqNfTg==
X-Gm-Gg: AZFdTZfxXO/siG1ZqDfJvJaU8vkRc+VbsTCJ7+KFZ2bl4IWp6wvR+wnA79Mh/OpBFpP
	c+rkx7z1nb7idVHRweeC7hzAmk3yzmQVILLUVhT2jcbDkf36ZzKmmZ9iVZLy6cEX2YRYObw0ww/
	LxELdSfuATRihWSJ1EtzqCU0XzGwat5bR1eVVNnLTrRv4sElkDKLXSZv7uOrjrz5SB1Pb52MUkU
	s01L6urfzfH2wMC8XPuxJulvjOuwDl6qKbMs76k8f9V04ZEfO/Csl+JupvWKPNwTPkabBTEZYot
	ibHccSlC8jV/+XGanDDio1C3rfQRc5rKREXJBY9h1cWkD8gK1SlSVR/cT1W6LbK6dSYeVTVAHge
	5E0yLNWNR3sqOr2WcrwWDj8PXs6z5XSXF1FDtS3z/sPKTgPA71XHt30zXypGbfwmA/2jPp/opbm
	IIDK9CFAAXy/bwHYYQ5mTUz2uj/MxJMBiVQZDKpIL800N3Kq74MkpRd3EMt6p0ui5DDaqYQVA/P
	cOpm6Crjcu6rFm9IH6+IEQivweXa02ahu3JQMXbLPum+8yL2ABGqC1PIMu9ENy/nyQe6TBPfvVm
	yxWu0sP0
X-Received: by 2002:ad4:5762:0:b0:921:26ee:3f4a with SMTP id 6a1803df08f44-9213476de21mr50621646d6.0.1795181167980;
        Fri, 20 Nov 2026 05:26:07 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.154])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm25629926d6.17.2026.11.20.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:26:07 -0800 (PST)
Message-ID: <6b004a6f.8a6417be.d678f.59f4@mx.google.com>
Date: Fri, 20 Nov 2026 05:26:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3897011310477381462=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btrtl: Add firmware format v3 support and RTL8922D
In-Reply-To: <20261120082636.3834168-2-hildawu@realtek.com>
References: <20261120082636.3834168-2-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3897011310477381462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217068/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.77 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.65 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      23.75 seconds
CheckAllWarning               PASS      26.96 seconds
CheckSparse                   PASS      29.90 seconds
BuildKernel32                 PASS      23.81 seconds
CheckKernelLLVM               PASS      25.68 seconds
TestRunnerSetup               PASS      551.85 seconds
IncrementalBuild              PASS      25.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v10,1/2] Bluetooth: btrtl: Add firmware format v3 support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#926: 
new file mode 100644

total: 0 errors, 1 warnings, 1416 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/15004719.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v10,1/2] Bluetooth: btrtl: Add firmware format v3 support

29: B1 Line exceeds max length (87>80): "[  174.019929] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config.bin not found, ignored"
33: B1 Line exceeds max length (96>80): "[  174.019956] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config_f000.bin not found, use default"
36: B1 Line exceeds max length (96>80): "[  174.019991] Bluetooth: hci0: RTL: cfg rtl_bt/rtl8922du_config_f001.bin not found, use default"


https://github.com/bluez/bluetooth-next/pull/1166

---
Regards,
Linux Bluetooth


--===============3897011310477381462==--
