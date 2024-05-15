Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100341A88
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715816891; cv=none; b=X2kplvMU2Iw/LiW9kx24gZkw2f2idDqAs2T9+hrmcR9xkfgEN+RvuRTMgzaV04xGtBFj0tmpHdaHk6Bjs9L/W2viHMFu2uSLpb0YyGlUkTVS3ZZswFYXH1vjVif3TeCSYGfVzZGt7S/E0ygmsA1Ez/5PJZIkCyHOB26gUe5rfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715816891; c=relaxed/simple;
	bh=zUKp08+bBx8grL4bDUGiEk0DWYXvfov0ryS9RtdUILE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VzT4FcQ/+YbGWwqphJ/e58IBbwbAQj2hW7I65rnf9e5aL5fsDHPaPtNkkKagbHy4/8be+S8HLnSfhLNI9RPYduTE79bxyLgahGs+bEt7nMUWPM5NIQlKYOhsZsJ2cavYgvjc25/VSJQAAPl2xhYEYO3od8d7iGFXbyXZaIp+6AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydm71sWw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydm71sWw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso54148865ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715816888; x=1716421688; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qQagz+QEdfxudDfPoW3Zj96aGje2ntIP78I1mX8Rc6o=;
        b=Ydm71sWwfINBtE6vJoDDb68lRa6h6vbGU9JEjJ9Cmv4ViELIxJAh+Yaj24tihPbqoi
         19A2VReyVpvm2WpIEkqUi913OwryEw4Tnn2qBTIlW/KaQXdOsSoIWXFp+mpEys4lIGan
         oi3MZNRDE+2ebqlUkE2S5ViWsCKQu/V6GduzdRPlr7BaQt650pRwIv7OA/X2SI8DL1sS
         eseahN3G2WsZ28QPNW0McOZFYGXyhfMQLFuILaqOMXxW6D1Mu6/Do7v8RdE9cJayfjM2
         bcFHolUOGW6yeBis6Stil0793citnSW+12Vz4iDelCrG9+fiSIa8dPKIWsJ95aG8XOFM
         AKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715816888; x=1716421688;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQagz+QEdfxudDfPoW3Zj96aGje2ntIP78I1mX8Rc6o=;
        b=FMj9yBbPnpqvG08aXM/r4of44ZTZtFo37BsElgGfuMFvI9QoQFyfOkiQlXYSo7Q41T
         UHGdXKzwIeYjy4Xe5YcyLYA3QKPTgMfA/59htIsGHFNIcb+HzsG8ebr96LUWPBCdV8CM
         lnVB64HALT99f2NgeQvChc8WkKMj0M6khZPDX9c4OIMeu5HxnoWWj/TrAUNMTVTOjPlG
         x9si9wx3gwVuo/XwpfQNfAKhbtRYLMxZC/q+JFgEI4uj0DqwYDS60h/hyEygh+1cswQm
         mS9hl5qEQbnMAa4CfAZU6ZZ/YOH4150q/souZ6YWiy1qRvdNZSgL6KWnS7YyfxSgMZ4t
         CAmQ==
X-Gm-Message-State: AOJu0YxKfjXtslOzJlhM5djZr0/fCQ/IE1cACz8SthSiH8wwFaYZtm3S
	eCu4UzERsW8xTsb7mIhIhQ2PY2Kx9b9YqdTSQ0sdOtEy6QTSJ++it5CaBw==
X-Google-Smtp-Source: AGHT+IFE3B3FxxPAyhsomV8gY4Lr/LVJO0eVtHalsMpfxAS0a5/LfysYfJU6eQSqEK/P3OdNZ3nk9Q==
X-Received: by 2002:a17:902:f791:b0:1e5:5be8:15af with SMTP id d9443c01a7336-1ef43d2972fmr225294165ad.17.1715816888447;
        Wed, 15 May 2024 16:48:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.17.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef2ee602d6sm115493245ad.26.2024.05.15.16.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:48:08 -0700 (PDT)
Message-ID: <664549b8.170a0220.8216e.eadc@mx.google.com>
Date: Wed, 15 May 2024 16:48:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2579329769128384875=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Subject: RE: ASHA plugin
In-Reply-To: <20240515201552.1831618-2-arun@asymptotic.io>
References: <20240515201552.1831618-2-arun@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2579329769128384875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853506

---Test result---

Test Summary:
CheckPatch                    FAIL      2.36 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      24.44 seconds
BluezMake                     PASS      1666.53 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      178.56 seconds
CheckValgrind                 PASS      248.43 seconds
CheckSmatch                   PASS      354.05 seconds
bluezmakeextell               PASS      119.54 seconds
IncrementalBuild              PASS      7792.07 seconds
ScanBuild                     WARNING   1012.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,3/5] test: Add a script to test ASHA
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#103: FILE: test/simple-asha

/github/workspace/src/src/13665531.patch total: 1 errors, 0 warnings, 158 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13665531.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1048:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb) {
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2579329769128384875==--
