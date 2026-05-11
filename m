Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A722E62B7
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520481; cv=none; b=hHZm/SG783jz9Bre5sF+iVl6rKbTo7Mr4WptpLmon13gf9urs8tYfja04DN1IQcOLB4H2XlKpjvqw3eS0fNx1iMxxnlLDUI1YyYzc9HnJlmOn2upQhQJqU03qvFFCRuPVxwdybjK48VqhQrEaCupNgGxrX6V1+N3UvVBiDgVzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520481; c=relaxed/simple;
	bh=AJtTCIZl2BAQj1XMmguyycAaX4kazz4va9L+Q8ZDepk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p4Z54CWUQhVyOD/Z8r+jbbUgeSgLSEG9MApsNUO9lQ9XWdFqinvg9NlCS28b2Iq1LX6ESNqH9/ayRbUSgtAAfrTQf0zdQG9eN6MFOqX7QU5NuZcStcLNcZvUCRU5OEYVYVGUCNDiIQK+qQBooTBmYbmoKMfSO9f379rxlGh3eOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMeF3Nix; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMeF3Nix"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5102582e237so34830101cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520478; x=1779125278; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jZylSBAIj0euqAPCTBUCPVDh+wx81rNWKAc82s4xnHI=;
        b=rMeF3NixjpDNgWuO///tMOeGRSLBnySHmauBdWikwNSROLrIcyV9YSo4kqP1dy0I2r
         mI/7Pn5N1HR/vFDDOn/Tn+ib0BThyqswILTLZ4GKObSF9jThSc7ahj2mY/EWab82gWvG
         pfWXWuDteoXL2kjy8xU+cXi2+60N7Mqfy2TBn7Ab2lCGRT+UZ8RN3BW/FGVBVGDTHndh
         fiwgfSnLe6sWSAlgBNQRglwDkEZr6H8AnP9AY/sNb6B8Kc4MuQnWb+S99Xf0/4afKDpT
         /zbIYIe0gPyvlSZFgLMwO1VF8ylj1Z3v5T7wMu+HMBTI342NhWhfK1/C7NJ/zaaP7tzM
         rn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520478; x=1779125278;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZylSBAIj0euqAPCTBUCPVDh+wx81rNWKAc82s4xnHI=;
        b=Ue1QL9vwvf322ycG9BLwcv6f2ACHvp4ly66e2IdNPWjm3n36QEZkuPi3wbZ5NbKn4U
         iwFGEYRPYmAv/m/YwpSC6tstg1I2nmi4ZIUf3EMmrt0t3N6OoLGMqXRTyHv97+6/avw3
         i6UJ4/XQ3mQrEd3aKFyNrcAUomho94Rq73sswdqPUfb7Bi/DN/6QGq+cc9BxPNaFSQ7h
         UR8FaraT7atYGk8SuOqQDLyX0BPUUV86qyS1kxBXXPFK7kTWrsBjbRnQds6ETrgeYzGO
         YzLh9idmyMxKdQ9WJGcanoacgKcUAZtk7dU7Gj/YHfXTzKvvGMhsqpuaMARMCTk2l6EH
         Unhw==
X-Gm-Message-State: AOJu0YzLNZO8EOh3gw+cBpKNQLulv1hG270BS0BCOXYEQ5Z3hGFSX4dF
	TakMqLBViAvgIYoDdgFKRYaOYSxBRqokMY49QQ9g7u0Ci6GzsKdo3YT7ndLo8A==
X-Gm-Gg: Acq92OFihLvOL3A7Ld/nYc/hyMxw0NCwYtsKE+m/jSlNcP/yTnf87G1mrIjHW2TdgHS
	MHbavm6t6W6K3eakp9oUA4NLrivXgSmz6AGdjR1wcbysyzsFIdZjArd+awiRwS1LzaL6ZZheH59
	IBH5V0EWI7DTwG4RdWx67t4k1HBB3lE3A5oEeJdY9A9lRl0y+rOP3YjgCjX4DwRac9GQKg7lWW0
	qdNcBGskIM3MrTC0xMFcoufO1vnjCi1AnAzUfMD9MMX/hY1FnygK29yxoM0iv2gJNeYvErGbe7U
	RI2pyJxt69YlNncdwP6xG5zF+3sLIxw2ihNEjJUXWpWa+oQr0uXFmM0CVC8mggrUPd82ud7ZRbs
	BUHerdblTv/VFnGmRAI9L6x0/10uooZO2suKvyyoLXovKPKq6OS/6jt8epyEFCjFqlDuTLouz8a
	G6A9jyrnXeiDLxJk67OsSbTczJsi90hx0=
X-Received: by 2002:a05:622a:4d46:b0:50f:9c32:509d with SMTP id d75a77b69052e-514621f7de2mr351336961cf.60.1778520478405;
        Mon, 11 May 2026 10:27:58 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf34asm100012051cf.14.2026.05.11.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:27:58 -0700 (PDT)
Message-ID: <6a02119e.050a0220.271c94.d4cc@mx.google.com>
Date: Mon, 11 May 2026 10:27:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4959854932914016979=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: Add helper for "cleanup" variable attribute
In-Reply-To: <20260511132131.1283892-2-hadess@hadess.net>
References: <20260511132131.1283892-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4959854932914016979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092801

---Test result---

Test Summary:
CheckPatch                    FAIL      2.71 seconds
GitLint                       PASS      1.76 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      666.47 seconds
MakeCheck                     PASS      18.72 seconds
MakeDistcheck                 PASS      245.36 seconds
CheckValgrind                 PASS      291.26 seconds
CheckSmatch                   WARNING   351.83 seconds
bluezmakeextell               PASS      186.73 seconds
IncrementalBuild              PASS      1330.28 seconds
ScanBuild                     PASS      1038.55 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/6] shared/util: Add helper for "cleanup" variable attribute
ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar"
#106: FILE: src/shared/util.h:103:
+static inline void * _steal_(void *p)

WARNING:LONG_LINE: line length of 104 exceeds 80 columns
#132: FILE: src/shared/util.h:129:
+#define CLEANUP_FREEFUNC(type, func) static inline void cleanup_##type (type **_ptr) { (func) (*_ptr); }

WARNING:SPACING: space prohibited between function name and open parenthesis '('
#132: FILE: src/shared/util.h:129:
+#define CLEANUP_FREEFUNC(type, func) static inline void cleanup_##type (type **_ptr) { (func) (*_ptr); }

ERROR:SPACING: need consistent spacing around '*' (ctx:WxO)
#132: FILE: src/shared/util.h:129:
+#define CLEANUP_FREEFUNC(type, func) static inline void cleanup_##type (type **_ptr) { (func) (*_ptr); }
                                                                              ^

WARNING:LINE_SPACING: Missing a blank line after declarations
#184: FILE: unit/test-util.c:46:
+		_cleanup_free_ uint8_t *data = NULL;
+		data = malloc0(128 * 2);

/github/workspace/src/patch/14565706.patch total: 2 errors, 3 warnings, 140 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14565706.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,4/6] main: Use _cleanup_() to simplify configuration parsing
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#84: FILE: src/main.c:258:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#108: FILE: src/main.c:440:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#204: FILE: src/main.c:888:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#409: FILE: src/main.c:1207:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#501: FILE: src/main.c:1570:
+	_cleanup_type_(GError) GError *err = NULL;
 	                              ^

/github/workspace/src/patch/14565665.patch total: 5 errors, 0 warnings, 413 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14565665.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/shared/gatt-server.c:271:25: warning: Variable length array is used.src/shared/gatt-server.c:614:25: warning: Variable length array is used.src/shared/gatt-server.c:712:25: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2118

---
Regards,
Linux Bluetooth


--===============4959854932914016979==--
