Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C117770F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724783914; cv=none; b=sIi0K40YcXkIjkXzkvW72Tke9MLt92L8z/p4NP6NyAqqMvGDod8dPP6HnrkcAI7es9yOSGjuvSvWE9AexfHHNBf+0bzX+w0UBwfkBp0jtLSYRT8EL8PVsvEUCibdshCsMBW4VYLtIE+gGZawMQ1FaKVWuonzFGxTmOaXJjLLRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724783914; c=relaxed/simple;
	bh=7vcQnxTs1f4p5xv+EDu2CAK+6NU7+j69290TQQTLf0w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qkE/9WNVnzCc+l5rxnlGxb8e8cQZsSB6qOTfeHu93KD8kGliSPNVS4q5puBFp2HfC6LnrUMn/gC0JPj+M6F+gHxL2w41w+VdkqFmtzZ1NuJvuHoFqMYwAxJolpaDNIqUWthUKRgrvvzhckh48FX7m14t34wvzE6QHWG2dnSmpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0Gg45ct; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Gg45ct"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1e1f6a924so380294285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Aug 2024 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724783911; x=1725388711; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P+Uc2PkNg2CvXMgOk01b+dnwFpufe5519cgiLPbFQvQ=;
        b=Y0Gg45ctDKKdBgoAbLrHUClp0CVYu2gdxJV2N6mSCiBQGFUWM5d4HS6ObrW/7+dfyT
         hAccKIsJKY++NLm25SXpXedHKbrUoDFme5lQwGP4ZJjjWJghZmb5C/jH0kMBffC3BUkP
         ADwLSkWyUJ7NSxNVlPTJhjHNj47RVIzEPNRQUWuPkdl8Mffykpv3utT69Cd1y+zmFgFz
         GAGDmMcmHZh7hZoqZhcE5vCE10M111FYbkqis0ZOEgxIWvYIdi4MzS91Em+GTG570Xt2
         wTPHRe2/Fb4wZvZ0xR9VrfwUk9WofFgYyZq2h1/4qHMh1CfkgQtzSL+sWWb/pGLitQ0R
         lpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724783911; x=1725388711;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+Uc2PkNg2CvXMgOk01b+dnwFpufe5519cgiLPbFQvQ=;
        b=WVuvuhVwJ4uwFZW/JPAioGFbddoonddfq/tlwWsjAZ1AihUqP4pSbOwRDFmPjRk1rx
         fTwWMwmNgL4hy7glWWxwvVBTnNiwTCoqFJPfUuATjIfYj4QiF9UUKUixQiJRcwGLoyhq
         tLQ8QOnWuXTk5UQwVkb0q5MbgrT+kHAQMQri1Tsco/lTuowQ9PEWR2vIXE49HX9ub6XV
         MwRNr9IqDE8JKPAkJCL15b1syXaNNAHRqh2+eXCwiUDJuPNUuuh/UcWEKFuYFx7/zIIs
         bPaChOWlX3gNswlHCgfE3QNkTBT5Td4RRBPViPzKXoZ3Bd0ppixZjFyB80fplD5jkwoX
         2EBA==
X-Gm-Message-State: AOJu0Yw8q41SEUMzW5mENPRIxbAlMZf36kgay/sgJx6b/T3D0AVVmFeN
	EUbIOMHPO12u+ecqGEYWVH4Ps9vAuMjeVHGKRP0cMtW7X0fSW0i6/M0dLA==
X-Google-Smtp-Source: AGHT+IH9/+PRoliZrEST3i+T/3oz/KTcraKKDsLnMQ1A+OQanod0BP1XEvcvS8HCFyuhKI2ORDhR0g==
X-Received: by 2002:a05:620a:450d:b0:79f:11a5:149b with SMTP id af79cd13be357-7a6897ac8f1mr1599279285a.47.1724783911140;
        Tue, 27 Aug 2024 11:38:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f31922csm574571585a.10.2024.08.27.11.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:38:30 -0700 (PDT)
Message-ID: <66ce1d26.050a0220.104256.68f4@mx.google.com>
Date: Tue, 27 Aug 2024 11:38:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7880587527197056464=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raj.khem@gmail.com
Subject: RE: [v3,BlueZ] Provide GNU basename compatible implementation
In-Reply-To: <20240827164948.3030478-1-raj.khem@gmail.com>
References: <20240827164948.3030478-1-raj.khem@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7880587527197056464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883905

---Test result---

Test Summary:
CheckPatch                    FAIL      0.65 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.82 seconds
BluezMake                     PASS      1678.47 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      179.77 seconds
CheckValgrind                 PASS      252.46 seconds
CheckSmatch                   WARNING   358.74 seconds
bluezmakeextell               PASS      121.27 seconds
IncrementalBuild              PASS      1416.61 seconds
ScanBuild                     PASS      1016.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,BlueZ] Provide GNU basename compatible implementation
ERROR:POINTER_LOCATION: "foo* bar" should be "foo *bar"
#152: FILE: mesh/mesh-config-json.c:2699:
+	const char* node_name;

/github/workspace/src/src/13779813.patch total: 1 errors, 0 warnings, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13779813.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/hex2hcd.c:136:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7880587527197056464==--
