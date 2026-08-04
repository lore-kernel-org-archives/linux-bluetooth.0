Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196804756AD
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860873; cv=none; b=eH1o9BKn1kQCa1tmc8s+Ofzi67kwBEy3m5CHNd4SbixLMkfU9OUT0NivbwWPaZFDd2+Y7J0pq6/lyVcCLV96EDJ3/9ailgveDFkHORO0NVwZkFpSOWgTbTXpLGgslQvRV5SCw7zgpBJ96HMMQmKREVN0iPmXjk+oDt0PFPyA6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860873; c=relaxed/simple;
	bh=aTImSHP7FekK5SUlrQYRPGOPtPxDGkj4ZAOHv+yI8c0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kcjjceiiYu9fnZGMljFZ+WEL1C4OhTW6IbEwsaDRRgB8rS83r2x2JkOD6IFO1X722mvFDMrGV/TEPlROjyDLihhGsYWDTu3fv0JC4mwXK1kBAYd+vd87kPe4NPfzrOWp6eMwylHo4oziei9hWya2VX45b7eZCNvi9mw2ykNHV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqW2iHYF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqW2iHYF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so4518302a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785860871; x=1786465671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W7OcmZ+uUn/sc8Y+rjB3MiLi9wygdZUIhtgvbsAiS7k=;
        b=kqW2iHYFsGgxMdKujaT+7x9qXnmBkQiiaPiYuY8Shu3hwHx3P6PJ/Ls3jXIEOIpTV8
         oc2BPKuVJk0hHxuQyY3Z79ewSsrKwQ2dzU7DJlLlkkp/YMzMAXcTPsmtwAN4axbAZGje
         Q/KNO4wJgHVbdLnION1zpMl/SBel22ramkLvSB3YIi4/Z47KToHIgWMW2iqNl0DJijs8
         YSm+hC6zo7X2pam3Vybv7IOwyEa7MMz26prWHOv7Hd9PLW2WeMZAvmVh3Lt51iovjpmY
         Cv7tfo/yof9pIh1qI1SnntmLTONyXR+2Dwi1Np580zBg/xn046fIDqVVaRi2L7nx6pJF
         6cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785860871; x=1786465671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W7OcmZ+uUn/sc8Y+rjB3MiLi9wygdZUIhtgvbsAiS7k=;
        b=sQ6rzcXdVnCyZCtjjSr/jE991v8GDd66YTTUL25XDsdnSPzvAmHcbs1Fa6Z+NO6/QZ
         ePAHHVkZeafyqPS9G3v86SAsh9zsPqyiPgSllNLC1HSv5AuP0InwQbwUvNzDNy5x7nPf
         a5ek7DZAKj8toD0mxp7fQz6J4cjtfu4JToq3tPUJlpyBlewosRBbjPddUBN8bqNkufz2
         QQEnF8oqqQqr1rm/IT3g2+pglMrpwIODHnXy20C+cBE0/h4Y17Lc827MNl9JJbD6itN9
         bqX84jXoJvObO4lz5TEsufFIJZS4HM4dhpSg4HaCo6fkruxlh7S4Ig6uRNKpO7o9PbxO
         ciPg==
X-Gm-Message-State: AOJu0Yw4fyglZF2EQpyGr7TURW30io7nwFCYSh0XdogopiOSnLXqR24q
	YYamOQ02zD7Lxk9vjSX/zI03G3VGZJlb9c4US+zR25dlcMGDfIkXNU+kV9NSnmAk
X-Gm-Gg: AR+sD10fSWzEMJH7C0SjFbpkfawPDYLjFEYICqEwb4Q4O5IDHAplI0G0fP6veDvuKyR
	eieQaV/OSnWTt3XP10EwPjnu4IsEDabe8EHrhdg0shHqTy6vYsLlK2DtTFX60hqZCw5BPzKEfYD
	6Eor9xxX/L4h55peuiuJbItMfdfGcfOPMQ8u0UtrR8hX4K4n111yalOZTSGHZN6N5hTUlHfLL+1
	BTW980qBqKSVzbcsMX9Dp689JLnALCP29eWR9ixCadc43vw/R2zPii7h6PIGyVn4gS2DIAqsBC6
	JSS3RLkEHPrb1N3V21aphrv23EiJNAEZYXA5J17Xt2evwGaoUBamBgDo9m5iYC7vUKJsPSdhHz0
	2mxipap/EaBZ+56fSoU9Fr60eYaPCkaGFTK5k5pEfCo/cDpkzFJallqbyo2pQAAAty9zB4sY5ZV
	2xl02T466GfnQSuibgxbgM7fExC9N8qw6CwGtkqrm8lVyFReQvZHC3AsdfGjmeUxnOY83d
X-Received: by 2002:a17:90b:2b48:b0:380:534f:58c2 with SMTP id 98e67ed59e1d1-3903c6902b5mr228399a91.30.1785860871292;
        Tue, 04 Aug 2026 09:27:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.136.167])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca92ada6sm4818046c88.15.2026.08.04.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:27:50 -0700 (PDT)
Message-ID: <6a721306.7d702ed2.a25d9.fb60@mx.google.com>
Date: Tue, 04 Aug 2026 09:27:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1597135115988266335=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
In-Reply-To: <20260804142419.2274153-2-hadess@hadess.net>
References: <20260804142419.2274153-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1597135115988266335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1140181

---Test result---

Test Summary:
CheckPatch                    FAIL      1.01 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      21.33 seconds
BluezMake                     PASS      551.90 seconds
MakeCheck                     PASS      19.02 seconds
MakeDistcheck                 PASS      159.31 seconds
CheckValgrind                 PASS      227.71 seconds
CheckSmatch                   PASS      309.84 seconds
bluezmakeextell               PASS      98.23 seconds
IncrementalBuild              PASS      563.59 seconds
ScanBuild                     PASS      945.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/3] unit: Adapt poc_*_oob.c test into a new test
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-authored-by:
#56: 
Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#118: FILE: unit/test-avrcp-sec.c:30:
+	 * Actual packet length (len) = 14 bytes */

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#125: FILE: unit/test-avrcp-sec.c:37:
+	/* Launching the PoC. We transmit a 14-byte packet, but namesize=1000... */

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#126: FILE: unit/test-avrcp-sec.c:38:
+	ret = parse_media_element_name(malicious_packet, sizeof(malicious_packet),

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#140: FILE: unit/test-avrcp-sec.c:52:
+	 * Actual packet length (len) = 14 bytes */

WARNING:LONG_LINE_COMMENT: line length of 83 exceeds 80 columns
#147: FILE: unit/test-avrcp-sec.c:59:
+	/* Launching the PoC. We transmit a 14-byte packet, but namesize=1000... */

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#148: FILE: unit/test-avrcp-sec.c:60:
+	ret = parse_media_folder_name(malicious_packet, sizeof(malicious_packet),

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#160: FILE: unit/test-avrcp-sec.c:72:
+	tester_add("/avrcp-element-name-oob", NULL, NULL, avrcp_element_name_oob, NULL);

WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#161: FILE: unit/test-avrcp-sec.c:73:
+	tester_add("/avrcp-folder-name-oob", NULL, NULL, avrcp_folder_name_oob, NULL);

/github/workspace/src/patch/14730317.patch total: 0 errors, 9 warnings, 91 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14730317.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/3] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
WARNING:BAD_SIGN_OFF: Non-standard signature: Co-Authored-by:
#57: 
Co-Authored-by: Bastien Nocera <hadess@hadess.net>

WARNING:BAD_SIGN_OFF: 'Co-authored-by:' is the preferred signature form
#57: 
Co-Authored-by: Bastien Nocera <hadess@hadess.net>

/github/workspace/src/patch/14730318.patch total: 0 errors, 2 warnings, 22 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14730318.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2376

---
Regards,
Linux Bluetooth


--===============1597135115988266335==--
