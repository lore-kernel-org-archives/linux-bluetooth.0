Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD017B425
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879839; cv=none; b=hOisbgNefPtRQdJ5M/vvCLhll24tk+EExZKNUfb7l6Sqv9UqABz3gAcLze9QPWpi7ocTQclGt4M0zR/rEJhuajpR2ofFj88xB0HoTdVRc/k+yU92habRQL8OeyAwIZN7aEa5TtUuR4JlO6ItvMH6b1cIoOPZNjCJ+26gtATqXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879839; c=relaxed/simple;
	bh=ML0/EWEHP4Lzz24R/wgFg4ix/V3m4mHHP+wBMcknKso=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M+hjIyW3LdLzLCI4gF5QZhCvFuBFQtPj9wPiM+5y9PJXbOLkIw56/gmyX29voMF1NaLpwH89jTxUnhv+xaOA21QeHlc2sq1uPWP99tKG2vn1ZP65M0245VxAHybYEhV8S3oWV4lLcNbcZD9/weExg6bgQ1ypwzBI+P3PndvRFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYvWwlaI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYvWwlaI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-936e393176fso27389285a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787879837; x=1788484637; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KTfTETWen6rEnnp+r35Sz9ti9L7iCh36ibo8yPaJXZg=;
        b=gYvWwlaICVWKnMC+FsFlc/cgzv7cddkeHdVZ0k8DIiVQb8TivqVfvzO4Q1uZ90srfL
         KuOmfY54wVteQ86pad2MAXvy3UEkHQFSlGuy+JYXdy9l5I0O7EfY65hZuPTzBacKrQK6
         tvmnEGCNh4ImLxrwtt8wYgjEaSP76uAAQ6HKIcETBf81yBtDRSb5oxWEHBjd7ESex7YX
         nTn9ksgSjbuHGwHL5XUGLQSEcc7l4VvdeAsRW2m1jqhEBVUBdK9TDU6Hrue18JHx6k9M
         vfSDgZOQHDJHmnLt5COobCmI1hS7KRbXrt2QT189qDO1IQqFWjBw/U0bzfY+xHmz6A6O
         XY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787879837; x=1788484637;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KTfTETWen6rEnnp+r35Sz9ti9L7iCh36ibo8yPaJXZg=;
        b=Ni8ZLkNEk8VQES3aJgvC7cf9YA5grkFyaEbVea7OZFv9yxODptx2KbJKQpJuhiJfxX
         d7GcelZwrmp6ImswLUnEygXAetqRdPRvLaFam9rlDbZu+zXInx6UTglC8V1/kWjJVT48
         As+sDRCT5e9a2Y/sOKvaeKsY1k56/v5x7+1Qk3AY7m3FQKBDZ9gjcCetWtIA3dgaJtLH
         AN06vqy3Fk69zT4nV6FhA/wk+alRqm/nWfcI5NsKTkCaFJzMnd2MJB0PDrYsXekGlWTs
         6aL3Hx96VL9EElMWbW3Euhxadg9d1w/2TvHiNPEZGeV7CJOAG4LgCmijesiLKYQRwS7r
         bdKw==
X-Gm-Message-State: AFuF++liw+uY5fUU5W6a2+oZ+nPRR2fsqh6to6hsCw9RChEYiXdiTU5z
	NiGVWmFRjM5en8RAu3Ym6B3L8C5ZL5tKsAM10zLz+s+PNoVVzNEarAAf9jIK+A==
X-Gm-Gg: AR+sD101OG9QJVQBAutZT1/C42t2A1tKTxlgXcmoCol76Z5HVu9TzK0Zmnurfhyvr4u
	cT3IJs31mMjBF9XE+StzATavOg0wEb4WDiBsaq3ykRbRKRowLVU1EgfRBuDNtYSJe7NcnOjEg3t
	VFS0CxnFWPOu8Dnmbz3uGj/x5k3xZ+5hXLFNPbBFAhUYvbsDBE+QieUu2F7hPCJuPVqX5RBa9eN
	syYJHeBE+ZkLfcDJ5pWU3CKnI+Qk9gDcZJcpmjbmTppnqpbcsgijnkc7SYENRYckmK5hiKp24h1
	YzRuyvx7J2t2TJY9t1lG9nJeKni8BJj5o9VgjDd+5t8Pl4YX0GybV89F5HrwuTZptZc8+SFQ4dh
	Uf/AF1q287mpqhBSRFu2+cvHlLnxxx95ub6RndJp2lA3PEOArUmECXVP1ykicj/i3oxOg+pE4PY
	f+JD/op+AejzXdX95ZbfJZV5fkA6rapBSYVtXRsejXuDrvPLp6Wx8bj6zBTA+54BZjaQ==
X-Received: by 2002:a05:620a:29c4:b0:939:710:536c with SMTP id af79cd13be357-939139b2e13mr343235785a.43.1787879836723;
        Thu, 27 Aug 2026 18:17:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.87.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939170142fesm36572985a.7.2026.08.27.18.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:17:16 -0700 (PDT)
Message-ID: <6a90e19c.bd0b6004.9a6f6.28e6@mx.google.com>
Date: Thu, 27 Aug 2026 18:17:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1843546078301026839=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,vRFC,1/4] test-runner: Add support for PCIe passthrough
In-Reply-To: <20260827165326.350079-1-luiz.dentz@gmail.com>
References: <20260827165326.350079-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1843546078301026839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152755

---Test result---

Test Summary:
CheckPatch                    FAIL      2.19 seconds
GitLint                       PASS      1.31 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      541.80 seconds
MakeCheck                     PASS      19.49 seconds
MakeDistcheck                 PASS      152.15 seconds
CheckValgrind                 PASS      220.65 seconds
CheckSmatch                   WARNING   294.22 seconds
bluezmakeextell               PASS      95.10 seconds
IncrementalBuild              PASS      590.14 seconds
ScanBuild                     PASS      866.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,vRFC,1/4] test-runner: Add support for PCIe passthrough
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#130: 
Assisted-by: Claude:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-5'
#130: 
Assisted-by: Claude:claude-opus-5

/github/workspace/src/patch/14771785.patch total: 1 errors, 1 warnings, 431 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14771785.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,vRFC,2/4] monitor: Add latency standard deviation
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#119: 
Assisted-by: opencode:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'opencode:claude-opus-5'
#119: 
Assisted-by: opencode:claude-opus-5

/github/workspace/src/patch/14771786.patch total: 1 errors, 1 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14771786.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,vRFC,3/4] monitor: Add ISO packet loss counters
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#119: 
Assisted-by: opencode:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'opencode:claude-opus-5'
#119: 
Assisted-by: opencode:claude-opus-5

/github/workspace/src/patch/14771787.patch total: 1 errors, 1 warnings, 192 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14771787.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,vRFC,4/4] doc/btmon: Document the deviation and loss counters
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#110: 
Assisted-by: opencode:claude-opus-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'opencode:claude-opus-5'
#110: 
Assisted-by: opencode:claude-opus-5

/github/workspace/src/patch/14771788.patch total: 1 errors, 1 warnings, 66 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14771788.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2003:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresmonitor/packet.c:2003:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2444

---
Regards,
Linux Bluetooth


--===============1843546078301026839==--
