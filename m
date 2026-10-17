Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0684F5E0
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195959; cv=none; b=LOE4ztOwLche1f3GaEaszjDrwRpr6t8FxCTA3E/gvFasS+8bHffT+2bcqR8Nvj+zebOvLIjrwYzKOVJHiBApoxaa64S0q4umEABMdPlZ/IhwUeDikXSH30+ZsO04vJmmxVGLM8b4wI85sEKWW7LXry0JSEf6RBJ4ZrKEJj321Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195959; c=relaxed/simple;
	bh=++QPVHPKVuoIfCePxaq+Eqa6ThPB7+arg4nxasTU0Gs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RA03O1Tc1fmn4Lig1jtnZhQXdP8Zev6nhJs9BpL2f3/7eWErVKsM8nELmOtbawLTbOBb0DCaRGMj8ADO72gQCAmkEgG9hfk+SgdXYB/0ixf8F6fk5c4svBDWv/wydOf5hL/cSlE/m01nnBI3S29F0HKckffupza88dBgZQiprLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdRiyR8F; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdRiyR8F"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35f036b17easo1279363eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195957; x=1792800757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pmhgBsbQZJBmWZMjSQsWnGx7Rko7wcdgl0ODfL17L/E=;
        b=kdRiyR8F2eD/HT3jqqi4vw2QWLwBzlhrdxdPLWPvnGimGWCHV4MzJt93xkHaWlWL4p
         Kf4cvX0UsXUOjo4EWjmWarhAmkzytM3YHk4bKnkVC6i+yLMOcBgm/bSkfRnJiW0Gj5/i
         90zXXKwk+x/gqS1NRsIYngIZhTfSP89g4eEKuNBM+NgwuHmcZ+dEEZCdefZnPzSAyGQp
         zRdmw3/6Lfmfl1iiSU0fUY4ULxpFUMggAo0GmwIPl0tNbC+0IUHtS62OR1vjx1Yt12qn
         caik1l6ixB7VOeb1BOUmEgO/jMzirTRq13IywkenUNQcU+ZFViYTjQp0371vyVqle1Av
         qSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195957; x=1792800757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pmhgBsbQZJBmWZMjSQsWnGx7Rko7wcdgl0ODfL17L/E=;
        b=DzTDplwy86ARp73DhC4qsW2ejDZ6CX24LJryLfKWu/IMoELSDBpmQ7gWVxL1RoNNFW
         BiBJIMvd2k22zvpqgSbVFwCTed5mWLOwH25AzFGzliZBG1CDoyExC9AyBu+Ed3rfA+hi
         6dLGNocn/LLqNnLXyRRbOJGr59jsErAeLmhrS4h8e+lF2o11sHQhNn2Uht/hMljf7fFA
         JC566l0jNSCb10B2TS6tUWBAzS8ZxUNdzunGKfOvaRUwRXh/C2I88c7de1d8OBQAaY7Y
         w8aKN1RREuMK6C6vEfefIsldyvShtZA0CRc+vY1VQ+CBMQR+kGcdxXLWNGhTMwYtpBtj
         6zNQ==
X-Gm-Message-State: AFq9FYI+aOyqMyfJlVLLBTdeqqYOv8aAlMWDmdFw87CrFdF62NRY7OEk
	h7W1q2KQnG/eJmj0ACC1XSnV7AR3W8aQZPlcXBW9RpHt33X/uZZh53xWDtpWdA==
X-Gm-Gg: AYBFou0Wc91m7n+AQPlpJWXUVcFUZry8Z6hV/qimkDl/uVNbqnlh088HUmBagROx5io
	rGTclTyvrrADDP76LyF0bubCQMlMJExG3ra52aLHHNGpLQWw3jBnALm8tfQPNH1WAqF+FCyg6cW
	JKHZj8Rx/L5NMHGONvluvqwdNAPdH1InMyAR2zz0AI18etKGvWYW6hvDdO07eleZeyeMC816Uy6
	jM+Rer/mdA7rknpH9tY0vYYSxJ7LZ1RiiihHXx4fTWWiXV4lMTIivU/XIbqRHQpI+lQsItkbg3e
	f5PmDOcZLQOvQfLMnVCGhPwWV+rawADLwTPEEOJaHbkZSP2pqEuQs6r35werjkLHEqiAbjE2BAV
	X1T33mbeAMgblXRgt92W7JZjqv7xtgDYPDVZueDs59yig0DNjpGfdwpxqOU9rxdns47WhP3zGTZ
	kyU1Yjd7/fDqC4d5P28A/dbGkyX1+ha9tHAyLkdUnyxFUUR3bNxTZTzqcgl6RgXHfCcp9XxY9EK
	alE4g==
X-Received: by 2002:a05:701b:2418:b0:143:26cf:8617 with SMTP id a92af1059eb24-18512f1d03fmr3088701c88.25.1792195957070;
        Fri, 16 Oct 2026 17:12:37 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.244.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314b16f57sm9232495c88.2.2026.10.16.17.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:12:36 -0700 (PDT)
Message-ID: <6ad2bd74.fa539071.1bcf6c.a958@mx.google.com>
Date: Fri, 16 Oct 2026 17:12:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6206047819136075505=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: RE: HID: hidraw: Encapsulate struct hidraw and make hidraw.h private
In-Reply-To: <20261016-test-hidraw-base-v2-1-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-1-153f67a20cad@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6206047819136075505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1187695/

---Test result---

Test Summary:
CheckPatch                    FAIL      6.85 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      1.18 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      29.11 seconds
CheckAllWarning               PASS      33.58 seconds
CheckSparse                   PASS      38.76 seconds
BuildKernel32                 PASS      31.58 seconds
CheckKernelLLVM               PASS      37.06 seconds
TestRunnerSetup               PASS      721.38 seconds
TestRunner_l2cap-tester       PASS      12.57 seconds
TestRunner_iso-tester         PASS      10.81 seconds
TestRunner_bnep-tester        PASS      3.06 seconds
TestRunner_mgmt-tester        PASS      87.08 seconds
TestRunner_rfcomm-tester      PASS      4.41 seconds
TestRunner_sco-tester         PASS      5.88 seconds
TestRunner_ioctl-tester       PASS      4.58 seconds
TestRunner_mesh-tester        PASS      5.45 seconds
TestRunner_smp-tester         PASS      4.26 seconds
TestRunner_userchan-tester    PASS      3.10 seconds
TestRunner_6lowpan-tester     PASS      4.36 seconds
IncrementalBuild              PASS      36.80 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/5] HID: core: Move internal declarations and drop unused exports
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#156: 
new file mode 100644

total: 0 errors, 1 warnings, 106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14896150.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,5/5] HID: hidraw: Make hidraw.h private to HID subsystem
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#123: 
 {include/linux => drivers/hid}/hidraw.h | 29 +----------------------------

total: 0 errors, 1 warnings, 146 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14896154.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/959

---
Regards,
Linux Bluetooth


--===============6206047819136075505==--
