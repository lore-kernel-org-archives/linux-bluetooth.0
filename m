Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AE22083
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588118; cv=none; b=AyjjEddKQLM0CBB32iNDy769CX56oxWCEvzcHd8YUrSBaM+wegqrL5Cy/w9jd+7ZrPkpNwgyJZlCbxVFXhaYLD8hT/eT7or76y/bMcSc8tNlIilNKqaWGaHihQzrz/gn/Ov+zhDb9v2XaKeYOZuZHDUA59zDNh+aAo5rj3kB8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588118; c=relaxed/simple;
	bh=T3fmbUsoxTEqgHGPEt/+oVhAu63jcuB+bKm75xi6L90=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tHv9MADcmPHGcoXZCRUeCxCXrHHDf2vl5yCuuQzGlhTAlKhB+7QubBw2QM3kM9oE1AUTvFNshTxpmqoHuHJT2z+DSUG0XSkmh6ZEk+ozORXaD1zHq5MKRiINDij+R41bJpZWd45e1NpI8xz/qT49rV4tngadd973Qq82n1LYpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl8RBXMO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl8RBXMO"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5fcf464ecso2829688b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588115; x=1730192915; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tYLbEE0UwbHtyu1W++7DJKsryBKxX1ftL+hnqFquV4M=;
        b=cl8RBXMO9BFGMNGn9WdgqWF7p0j+ijdGeADftEtYxxnauOo3F2yJYnXSE4WUXfWcFZ
         AXqoaNYRdtYu7YjGG2uOe1i/npyUGOOuHx7JCwDiemzUAyVHUbBXTIHxZNO5gdXSpnw6
         RLz0oh1257PULlpqoTZshcPx9IohU6dUEgXxOsrwpbvvFQ3wicAyVTx+HOoNPW4gOewV
         I+2/MecswTqZZxFoh0SYg1MvxEmEFxCiKg8kykG4nth7VwEG8BOdn4/A2lgFz+gaNWQ9
         YTMwE2D9OhCn4bqHk7AxgojqzlzsfEP2XId5f5WqlWxNcT0O/d/Vsagf0bhhdTnZXF0s
         /1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588115; x=1730192915;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYLbEE0UwbHtyu1W++7DJKsryBKxX1ftL+hnqFquV4M=;
        b=U/sQoKVPrRqhjmtdj7VkAplI5XIoPJcoyPCx2uROHPHZBjHkXnlljvQCqsvgt/e0fj
         xB+mSLyhThXNx6PH5OSv605mpEYDHU+Anggv6LkCUQH2Ff+LrRTLNjI2tDrEPqSW84sZ
         39Bw+8mNqYgQ7ug9Rk0a27upZAa/CwHxoCdcNWjASwLJWoNZOIT2sLGGuFJXPbb0P6Io
         /npD+3QpHUDgGet5AyBN9ckA3Bo31tk49OKlorylRYeTQZFb+i7TFMsmzAJuP6qNuGv+
         COCWymHCKGAom4X8B4tVNoBQ1AVfiPc7p20taoFueG/io8tANEzyG/I3n7BRBZJrDv4a
         sL7w==
X-Gm-Message-State: AOJu0Yyi8MEKrS+Fm9judL7gyqnwC793NEKuLVWpIphirZA2dPoxnPOP
	eiSTAYIjv7SkOZb79GdTn5UnRTpBwfBsnW6PX/E7MYUZHTyCyf+C2h1lBA==
X-Google-Smtp-Source: AGHT+IGeOEwyT4pUCYRPSgefMsb1vxWktOjBa6j3zfVWzu4YT5V4Bum/JmZGgktsSDPxhZNAn+KHWg==
X-Received: by 2002:a05:6808:192a:b0:3e3:e713:b293 with SMTP id 5614622812f47-3e602c882a4mr12370903b6e.16.1729588115235;
        Tue, 22 Oct 2024 02:08:35 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.68.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb9e6fsm4515622a12.66.2024.10.22.02.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:08:34 -0700 (PDT)
Message-ID: <67176b92.630a0220.62a0.d6a2@mx.google.com>
Date: Tue, 22 Oct 2024 02:08:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6206246032408472002=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Resolve SRM issue for PTS testcases
In-Reply-To: <20241022072423.4080043-1-quic_amisjain@quicinc.com>
References: <20241022072423.4080043-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6206246032408472002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=901706

---Test result---

Test Summary:
CheckPatch                    FAIL      0.55 seconds
GitLint                       FAIL      0.45 seconds
BuildEll                      PASS      24.59 seconds
BluezMake                     PASS      1718.68 seconds
MakeCheck                     PASS      13.73 seconds
MakeDistcheck                 PASS      180.60 seconds
CheckValgrind                 PASS      256.27 seconds
CheckSmatch                   PASS      358.60 seconds
bluezmakeextell               PASS      121.28 seconds
IncrementalBuild              PASS      1516.97 seconds
ScanBuild                     PASS      1026.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] obex: Resolve SRM issue for PTS testcases
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#102: 
value in the PUT/GET request and carries on with the PUT/GET operation with SRM disabled.

WARNING:TYPO_SPELLING: 'recieving' may be misspelled - perhaps 'receiving'?
#105: 
though recieving the unknown SRM value.
       ^^^^^^^^^

ERROR:GERRIT_CHANGE_ID: Remove Gerrit Change-Id's before submitting upstream
#110: 
Change-Id: I399b1daacdcfa118137dc9798529514d36fd78ed

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#123: FILE: gobex/gobex.c:320:
+	if(srm != G_OBEX_SRM_DISABLE && srm != G_OBEX_SRM_ENABLE && srm != G_OBEX_SRM_INDICATE)

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 14)
#123: FILE: gobex/gobex.c:320:
+	if(srm != G_OBEX_SRM_DISABLE && srm != G_OBEX_SRM_ENABLE && srm != G_OBEX_SRM_INDICATE)
+	      return; //unknown srm value

ERROR:SPACING: space required before the open parenthesis '('
#123: FILE: gobex/gobex.c:320:
+	if(srm != G_OBEX_SRM_DISABLE && srm != G_OBEX_SRM_ENABLE && srm != G_OBEX_SRM_INDICATE)

WARNING:TABSTOP: Statements should start on a tabstop
#124: FILE: gobex/gobex.c:321:
+	      return; //unknown srm value

/github/workspace/src/src/13845233.patch total: 2 errors, 5 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13845233.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] obex: Resolve SRM issue for PTS testcases

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B1 Line exceeds max length (89>80): "value in the PUT/GET request and carries on with the PUT/GET operation with SRM disabled."


---
Regards,
Linux Bluetooth


--===============6206246032408472002==--
