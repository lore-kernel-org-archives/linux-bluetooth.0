Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E33655C2
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561485; cv=none; b=PI97U/seU1YO0YI9FusuJ54sJh5cPmj168wQ4MIaisWE+nuRsgDgjsa1h6XuKbNyscrB2X2tOWUG1dUMyYZQMthgeUG+p9D7s+/XshtDdi5evLkSklRRJi2YnFI5AGOIgVlVx7BEFTDIz8OfRIJ4axq0toY4x/553ljI7L9x418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561485; c=relaxed/simple;
	bh=TcfYrHE8NAp3uuUSVGjH5VXuXzs27X7CRNA4F+QngDM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Z224At2T0q/+qWQkF5LhZ6x5NhR7Tk4yFhQpgSDqfYmFbaT5PELndYBdIOfY3ivcnfqfPTzkvfhY5oqomHH7xzqL8/ZOarx+NGToBZmqDxRXOyiaiHjjyuHBCxGLyx4BJlOTd5t5ph8uONPZBZiToGePie9ViLyjGq0hAV7aCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBtqruYc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBtqruYc"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93d92abf38dso380865785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561483; x=1792166283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ksQWl+xxdbdKv2LNBSFo0m7o++69/XW3QBjnLC/R0gU=;
        b=tBtqruYcsTeW+sthZONXbdOpRw8nlh1odUdP0GMVmbjElVp6nPMmcR29MI73NPx8pi
         NqkqZOf0lZYHpbQ2I5rjQtn5XnraTkyfkCUiJEQUXszlviXPb8kEyRA3IJNE8Fk+EFYW
         +6u3ZYCs02XP+1gzINEYPjxpjfVbWdkEUqyUCNMyn0AkE8+Za2lsUk0qZtxkWYOzYBg9
         Wb9Jr5qVn2lZX2E45pQnc/EBM9fwz2GRri/TBXVek3pFS34pboRGZAvHTG6AOIWw+Kdb
         l/19lniq5YNFG0fvV6Agrxo9xGr4u3Y2nyqsrW7PIqytlrAoicCVMnt/FvWpCMtT7I5Z
         4NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561483; x=1792166283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ksQWl+xxdbdKv2LNBSFo0m7o++69/XW3QBjnLC/R0gU=;
        b=PeGHQm/DZvxzNpgbux0ElnMFL/4x9RQi2SdMiQyNL5ijLwkR3YbwfIclXQG6xMn33U
         ExfL/SapU76PvZTf2KABIxAn4WA64W/JgUAC+nlb5rL1sd9aK0h9nJFEFK7tHxUndQMG
         U0V+l1xwf1ilEBJqPO4sHAyLr321ZaF/mIwKMfY8zpgzRC1T3P6WAaJ0tnqN2oqtAlnw
         4Y6E2yP65RN1phNioKVvMh8LLqQjc20OEHJy1nO9o9d9CrOsr/9YvTLvafeGL8DzGMbI
         xUgJcKAoJeBan1Dsh9s/cP4+jF75KvdAV5oQQq1r6sXalKevuYmEzI7rjA3V4ECaZxGr
         jiEQ==
X-Gm-Message-State: AFuF++nGidof6vJnUuuVZYu/XulrTdFSigFqjDvtjYSaYvFiNfF0/Xn6
	Dao2QKAj/DB6AQPjXIiISiagFLlCDk090c2+Yg0L5olooL5KNi6vV1bYixT1lg==
X-Gm-Gg: AYBFou2E5o6CAgMBbQ8u9483Jh3k06fDIt1qKvoNMCbzVV80p0BPZbxr0JSQsZkevnh
	SveKBFgezq2P8pGkehgRA8Q8nTwgiuOrxenbR1c1ey5GjWXkxai6sH8KIR/JHxfZbuuRQwfwIEp
	DWOR9xp2guNKxSy+9fpp5uJ0Jtn5c7AXiA4gqb/qk9Q3vwqdGuagG0sp2mnpIu9f+qIsx7WQ7N0
	fDJaTiojgDvZTTGFI1p8TQYtUMR0KvAdkcSh2pB3j5aDcaSbTGVqNpwb8gmIjXiFQBh0Ez4UYGK
	8kBIYa/6M7aL82kHKRHC7meogp8Iv3myQNPdz6u0JFFm2n3SUJi0j7sqRPy/2CrGYgNZePbinJa
	r4PBmmutvrkTL1YJminuiEOxFPssKiT5a5Eaez/33jqaRO/XBUWAhEDs8QYf/gN9fSQhfGqWXex
	YefbAWEB+JBznrHuKV5Z0NhP7urkmk0AYq/YaIGNU0pSfmv8rCnEgrMHK6O5anLAGaUmtXP9dPt
	UR2pw==
X-Received: by 2002:a05:620a:6508:b0:93e:512c:e7f4 with SMTP id af79cd13be357-93ebd28c788mr330885985a.62.1791561483341;
        Fri, 09 Oct 2026 08:58:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.247.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9846a5fsm215839085a.15.2026.10.09.08.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:58:02 -0700 (PDT)
Message-ID: <6ac90f0a.cf847633.837a3.0ef2@mx.google.com>
Date: Fri, 09 Oct 2026 08:58:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6352752706427635566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: [BlueZ] Add cover art support
In-Reply-To: <20261009134924.122040-2-jan.brummer@tabos.org>
References: <20261009134924.122040-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6352752706427635566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1182479/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.36 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      19.89 seconds
BluezMake                     PASS      404.47 seconds
MakeCheck                     PASS      14.50 seconds
MakeDistcheck                 PASS      143.94 seconds
CheckValgrind                 PASS      235.10 seconds
CheckSmatch                   PASS      298.53 seconds
bluezmakeextell               PASS      95.45 seconds
TestFunctional                PASS      1183.23 seconds
IncrementalBuild              PASS      403.92 seconds
ScanBuild                     PASS      1155.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] Add cover art support
WARNING:STRNCPY: Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90
#296: FILE: obexd/plugins/bip-avrcp.c:173:
+	strncpy(entry->handle, handle, sizeof(entry->handle) - 1);

/home/runner/work/bluez/bluez/src/patch/14877179.patch total: 0 errors, 1 warnings, 1042 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14877179.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2644

---
Regards,
Linux Bluetooth


--===============6352752706427635566==--
