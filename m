Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B054EE877
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780952; cv=none; b=YDEjEPcZEJjImwWi/WPjisK5Emgo860iTnc964vhhYtQgW4Z/DvyRGLOanIFo/0rleUQTPYxhFqE2oiC405Yg7iO9bcPxhv66XBYximrNURsog6jVu8WEuwue66Y/qy65DJAg/fzFDdhqCJjNpkxgh1bbDA+OPlXp53D/NgaKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780952; c=relaxed/simple;
	bh=/xpEN9/TA6ihinA/XNHlI8Qsq+Cz4iJ8uitIS0n93/I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HStiNfYZ1Sh0rmlnfGStcM98DGLokVf6oJgFKaaDLnSecra9oJw3DJyux4a2RNb1McXnfjn46hPchlrEt0vPLAd/52afHNohMINGAkewUIduqzjZ6LL8muTf19RyazdhV30t1wjMn8n16eUAQJLiAcnydiXo5TRBQPDA+al4v0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYKsJ1jy; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYKsJ1jy"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so3967742a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780939; x=1791385739; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0uQJV9XYOtS+qf+yzd6ZoPNPp3n8IQQAUuQwhseym/s=;
        b=hYKsJ1jy56Lf7bYO4fBUMkM45MbZvwqZgV+CI455ZEc1PovWQIokkUrEgUz2x6khwK
         UN3X3EvXMZ4GtxxBnRC/46ftXvXVU9ldiVik0i7icHbufk/aaVc5iJdVdfRn2pZCSNtC
         co1NBhJ3AA2yUdPySYwPMxTXTSZLNfmP5UMzyR/J5w3NyfBHXy5xwko51lUnguxTuEkB
         fk6mRSMnN5Ht2U4TGWiu0BJmbZeYFnmvQeyfynwoLJAeiQTkCTvMhyI7MupP2IExgd0b
         JIS1qn3BxXnlOWLPAPZ+ABDx8dW+sL/sBKkn/j3ZYmImENln0Dw59kcAS0P+Ssl/TZBV
         z5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780939; x=1791385739;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0uQJV9XYOtS+qf+yzd6ZoPNPp3n8IQQAUuQwhseym/s=;
        b=cvu2Y3S383Wh7zrQ+WIjgyDzS7wuUH4HbSHLO/QKgBTxT+nq68a8/5VYl0p3QlrwWR
         sl6+Uv6+U+Ocb32ogx97naoGTLSHzht+15N6krXQozdOqAtBEi6Q+Bqj5Xe7ARc1fD57
         +w0RDkR4rzYCzHwELXx02G4r/RW6wfIe+55a474+kpy32QhHBEnzMlDan2pAQEEOpcY9
         YmsmOSi2z+mdAK9BQAUG+ZL2fTIJICAdpfpkt3IKTVCgLdyJowGknUmORspzOhZ+ePHX
         /CmqRCQ/VfBOahi5uCU1M3mK8KzcucBHsHw8oNgE3NiuZ0g8JngKjlhLJXBF8mNJUkk9
         XKBw==
X-Gm-Message-State: AFq9FYL2Cx0AxWVkZQb1NKrrNYQFC9hSwyq7p5LzcnSsqdBdvWgw7ZPy
	9bG4HxaQt8PQLwUCHLPtQ4p6zz+UQyeCmQl3qQIgw4LGgYCh3X7I3KLXVztZIg==
X-Gm-Gg: AYBFou1Df4ZvoOaqtu8OF28gUThKdad7d/j2kcaCvN6UfhGyWk9nGAXm3+1cI8sGcO0
	+qMjO4aj9ENpOnU2irB9XiaOu7yJaOJKIx5aHhdSE12DmZzjgZpIiMa+fQHaoymGkpkXUUXBM8h
	N9bWUv8r4aRLDRjurNO2YDzvzJK3EQaLxOs7OB8TabwgdnwHNHtsFuY/dOfNPWU78RVE/JHru9/
	36kNaPGWg+L+U0/0tdJjYlji0l3gShBw5oPL1KEF06mRCIWOIDX+PRhfiyLkoxNVjJKz3fBG63b
	Y54Trh8m5k09ZTXrn40YzOAHVVnYVAUxdHZb4TWjgPe30mH7s0febDMwHHDVD4MzF+xSa7+ulpf
	hYEmb8B716fTFBv3SchSA/nvy98FEyTYbICPp0QmXrnmG42F9daw3TyCmbEtWnfgHWD2qQv9Un9
	3QYkOQYhPCbxULJyn7MNrZQGeYH2bQlEyn7pl2DIDsa8SdhgvXI6iS9nIKsu2mlIwaz+CqiOJqw
	2cqYw==
X-Received: by 2002:a17:90b:3c4b:b0:39e:6c6a:4b77 with SMTP id 98e67ed59e1d1-3a4d1ddb4c7mr1316095a91.65.1790780939315;
        Wed, 30 Sep 2026 08:08:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.46.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4e697008asm667878a91.3.2026.09.30.08.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:08:58 -0700 (PDT)
Message-ID: <6abd260a.5d525de0.2aad6.a2f3@mx.google.com>
Date: Wed, 30 Sep 2026 08:08:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3562806450943332129=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] obexd: Fix FILE* leak in phonebook-dummy
In-Reply-To: <20260930073953.266930-1-jinwang.li@oss.qualcomm.com>
References: <20260930073953.266930-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3562806450943332129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1176647/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.36 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      19.90 seconds
BluezMake                     PASS      386.30 seconds
CheckSmatch                   PASS      295.83 seconds
bluezmakeextell               PASS      95.06 seconds
TestFunctional                PASS      1128.28 seconds
IncrementalBuild              PASS      403.49 seconds
ScanBuild                     PASS      1123.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] obexd: Fix FILE* leak in phonebook-dummy
WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#129: FILE: obexd/plugins/phonebook-dummy.c:169:
+			error("fdopen(%s): %s(%d)", filename, strerror(err), err);

/home/runner/work/bluez/bluez/src/patch/14857371.patch total: 0 errors, 1 warnings, 21 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14857371.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2611

---
Regards,
Linux Bluetooth


--===============3562806450943332129==--
