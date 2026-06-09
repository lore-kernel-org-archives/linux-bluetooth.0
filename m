Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22D4963C8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026220; cv=none; b=FwRPO9v5fx40pKmOl9C88okQSl1DrsoKm3iq2mcj/GHoSMYvEiq+rbx1r/3LL3EpXu3jNEKF/Ly95aiExbG4hpEpLG0GNQR33Ze5qM2qgHOOZrv/32u+1v4NMU2b5mHChYXpt8xl8dj2AYaWyBYDCg0AGbXiq0NNoBKY5WKkXMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026220; c=relaxed/simple;
	bh=fxVL6aV1pC+U2nRjWie5wQsvScOicRiuVgXKs6iDaWU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OwsHDjBYD3/MjHgui90SnHmaJ+VVbXi/I1IJvmBrTfjn6/sBQ0oJVHXJidmWM2U37/qwtxZfS/bU6Npna+MrkFP6kHSl5h8ZvGe8p53zpJRVXEHwjSZX83Fw2fB8mEolQkgy4m7teX5EwYr91oUyAoY2jojiYV6me3UBYEdNnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQTvGdp9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQTvGdp9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso59224096d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781026218; x=1781631018; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8bCJUgGjhSkUiUGUg6T1PeL81mI3SYM4NyHX0Vqv2Ws=;
        b=IQTvGdp9iM0jDYT3gmPgOKPVezLpVixFVKd/xIX2Dsv+YSO+E89/5QIdkRFqHUM22H
         UA3WiXJxxDdluY4lxbEBMAnuN8gMAoxB0hSFDCuWg64KkoGvPan2Cr7sosgukbyyWxLa
         +isEMrqfgr/iakOtV+VrGBHwx5wY7laC9kj4f4kUMFQYngEE5g+mXRdRLefZhsx+lzHM
         oEA+Q39QZpf37Ys1fNCUctcLqN23HZsy5B7Gey0FBoAZmVCiyc1m5glvKc1nQWnX9kql
         we6iLA6C9KhlR+IO173gqG6YLrmZB1t0BadMGYg6/MTfy77ZBNQPTQQEIyaf5hXYXcNu
         AIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781026218; x=1781631018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bCJUgGjhSkUiUGUg6T1PeL81mI3SYM4NyHX0Vqv2Ws=;
        b=EjXJ2oxVxrwI85tBPKcxjKGqw7U2EPaGmuRIepe5pD7x7yuHKlVHJsYAyZ6J0zDjqy
         A9a2qHr7Krs23qcj5hwx0baDRdMWwuXZcIdAJYXNzLOtHqhj3vkvFi6WixfcD8uWJ6XA
         Uf+raT1fJBJ1Wq1XFaKu8uU4r5IzNHu1DhQuomBrAKBbNyWH9t1tF95EWQVEqbGNHh8g
         hU3BcybNlMiLbHZ0WLjY13aMILql5+zS+VK6/4eBgWUR7h6956754bPS7XdQdvXi3FsU
         dKzw73zvPhmzK5KbLx0u/b2t8YTOsezEAAj2aQwSuQWJyhyERCgn5qoXVB2dvnUGamjH
         aOiA==
X-Gm-Message-State: AOJu0Yyq6uz6oF0aMf+34EEUuxhLQoLvY94MwUqXjflguxMLHm4KSHlf
	EQ1OZIedjz5RfbWdZYpHcjtMu9qCefJOfTXvnD11WSLS6kkBbGf63KBa2ItxQw==
X-Gm-Gg: Acq92OFipaAkaWCI3eh06yRYGhELGWyluSnowv0qQ+/9Q8YyYpG3p/YQ4dMukVJKEdr
	JTWfCbQBTJ6CpeoXBHK7t6IIUCHNPpCCphvRfo/Jnce1D4W2zEMJRihKqAaBRb/YXGc9oIUIPQi
	zZp9Kv+7CqSvwYhqWlfWOpknO/JDClqY+0hC7UQBu8Da5hRbJ3wWCzCl7RfXWQ1rkwkP3m0MGr3
	2pfJ+evd6cvSqAZYuTCmOXHcTJg3HTDzz3S3Hgxsd5QOalK9YpKD9hQ2qFNi53bqfTmiu/xLJrf
	873Z+L0TEuc1yNi32uFKF+meEF0gkeZfud7tyZZAIP5r1mQxsZc8CWSwGDiCEWQVTGEq8IzNwge
	/9JgDrzuyINh+GTjIiqNvkd4ixNS32yu7R2m8+ImQEFX3QORxzy4soqR/u+jKPtE4awN2eLRTOQ
	xD9K0gwjUWymNsfP+db2pyVHNc1/eVZ4DflZ1zjqIN
X-Received: by 2002:a05:620a:4013:b0:915:7f9f:8d94 with SMTP id af79cd13be357-915e831d309mr580080885a.47.1781026217362;
        Tue, 09 Jun 2026 10:30:17 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.71.20])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fda2sm213377866d6.2.2026.06.09.10.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:30:16 -0700 (PDT)
Message-ID: <6a284da8.7dd3efdf.a331b.6852@mx.google.com>
Date: Tue, 09 Jun 2026 10:30:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8512854605531524807=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: "cleanup" variable attribute follow-up
In-Reply-To: <20260609135837.476561-2-hadess@hadess.net>
References: <20260609135837.476561-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8512854605531524807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108616

---Test result---

Test Summary:
CheckPatch                    FAIL      2.51 seconds
GitLint                       PASS      1.73 seconds
BuildEll                      PASS      16.19 seconds
BluezMake                     PASS      498.81 seconds
MakeCheck                     PASS      18.30 seconds
MakeDistcheck                 PASS      189.35 seconds
CheckValgrind                 PASS      217.95 seconds
CheckSmatch                   WARNING   253.71 seconds
bluezmakeextell               PASS      131.42 seconds
IncrementalBuild              PASS      985.31 seconds
ScanBuild                     PASS      733.50 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/6] shared/util: Fix warnings when cleaning up NULL pointers
WARNING:LONG_LINE: line length of 94 exceeds 80 columns
#74: FILE: src/shared/util.h:130:
+	static inline void cleanup_##type (type **_ptr) { if (*_ptr != NULL) (func) (*_ptr); }

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#74: FILE: src/shared/util.h:130:
+	static inline void cleanup_##type (type **_ptr) { if (*_ptr != NULL) (func) (*_ptr); }

ERROR:SPACING: need consistent spacing around '*' (ctx:WxO)
#74: FILE: src/shared/util.h:130:
+	static inline void cleanup_##type (type **_ptr) { if (*_ptr != NULL) (func) (*_ptr); }
 	                                        ^

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line
#74: FILE: src/shared/util.h:130:
+	static inline void cleanup_##type (type **_ptr) { if (*_ptr != NULL) (func) (*_ptr); }

/github/workspace/src/patch/14619750.patch total: 2 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14619750.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,4/6] main: Use _cleanup_() to simplify configuration parsing
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#90: FILE: src/main.c:265:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#114: FILE: src/main.c:447:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#210: FILE: src/main.c:895:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#415: FILE: src/main.c:1214:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#507: FILE: src/main.c:1577:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

/github/workspace/src/patch/14619699.patch total: 5 errors, 0 warnings, 420 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14619699.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2201

---
Regards,
Linux Bluetooth


--===============8512854605531524807==--
