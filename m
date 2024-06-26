Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240ADEEDD
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423599; cv=none; b=JIeTtM7ODvZMyb0NRg3OF1tQ4/K3n/LoCUmjUoVbWTbP1wswwlc1+DUcKu6XTK1ZCTcoGv2nl/Jijg0sNqN3494ftw3O+/H85qoPW/Zrkk2HUb1fd2Z5HtanWQt0mC1hjKD7y5ovt+6ZL6ObkezxvuvFindVDEABpA3hFrJrF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423599; c=relaxed/simple;
	bh=FYDgye+JFuwnKUd7iiFcBrYH5dMVpbp72Fx+LR02VlA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sRpEkzq6JXpYVdpkXUJddjhnfFGFOe8IqiJ2sL7SLtggsphK0LCK1M3JbdEcg8F/iz6+9K982kvnzp1sTFVKyfwRzQJsAiRry/DSSfvC9tn7FZsDIILqUQb/Tx/jsVfQoxUGrsJtjixlXbsN8lMS01D4S1FleOMcp7QOe4ext8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OerW65RC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OerW65RC"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-718354c17e4so3611874a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719423597; x=1720028397; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kfL7yHMjylzXCHJQXtF7G1hJv+RBBGK5bbVe1G5ci44=;
        b=OerW65RCot3r1K+t6Bxa4+jDBIuLQk/K7itV13NN9lJRQlhb3FuyAjaRywV6PBnjCV
         jZL62HGiscBYHVsCxR6/NPXPspcdvBMvm0VFcvLqye9Hl3m9HD4ZI6yqE7NS4T3mlw+e
         7KBVfIRu9+N0/bYVZqm39Z+42SaNLtgIg63q2l5pxVVEMfCjzsLl6jTtTE2GElZJfxHV
         DwhG9OZW3gbNjM79rb71h5F3FbS1/i/mNn8JO4gAZt58kCp3UQ6kYiB5s1WZ08D9uVvF
         rmkRLk8G1teWfeMY/DO5QzocvS0HTjBl9M1iL5RhBzIU7N9seTdWBqHVkaoZ4dcITGW8
         LKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423597; x=1720028397;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfL7yHMjylzXCHJQXtF7G1hJv+RBBGK5bbVe1G5ci44=;
        b=ACH8qplcS5S5Q0rAAs1bP+sG6MmggAs0MNBbnjkjWMkw/mt29ZqF4rVDB4SvCtz5Vp
         xbtdpfAjy6LrhBtKc7W5YbwVc/wdvK/0Lse4X5pobBGFLLemRjtymOhKaUP6E6wbi6Dz
         9rZw1gwzA0dqfwdwL/Mb3y9AwXqN+7AWzMwnwckxyMYrPVbzyp+xk325hUf6tUzYYBF5
         JFbQWSRtQNkCT81jU4sfvPWKC+n2GU1O7OVquox56845ZfdeobQyrQ1PJyXEmKlMgqoh
         RVW6BsZNXQKxvN7PbOAFCV1K/UNu0X9qJfiBhzIWH86plJWQheETsAdGgWURoDgicbfN
         nLaw==
X-Gm-Message-State: AOJu0YxtQpmM5hct9WPBVMA8utlsMeGn/Z/B7R7bO3Dd+y0huiCvrKru
	oqbrenav/5m4PJciD8JN16DprpvV0HEiY64YpTNX7PXTTxM6fNSdj+UGnA==
X-Google-Smtp-Source: AGHT+IG+MwLxOWxnbrTGHRiUcIru0AOkFFHZJe8I2/xexRP1GoMdCbvPUIXOdoW7GU0adT1hpTwMiQ==
X-Received: by 2002:a05:6a20:1aa1:b0:1be:c0c9:d003 with SMTP id adf61e73a8af0-1bec0c9d3d0mr1787956637.14.1719423597083;
        Wed, 26 Jun 2024 10:39:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.40.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651254c67sm10577138b3a.97.2024.06.26.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:39:56 -0700 (PDT)
Message-ID: <667c526c.050a0220.4fb2a.e22a@mx.google.com>
Date: Wed, 26 Jun 2024 10:39:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5353670492295602453=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] l2cap-tester: Add tests for multiple data packets
In-Reply-To: <20240626150229.103047-1-luiz.dentz@gmail.com>
References: <20240626150229.103047-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5353670492295602453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=865811

---Test result---

Test Summary:
CheckPatch                    FAIL      9.80 seconds
GitLint                       PASS      0.60 seconds
BuildEll                      PASS      24.62 seconds
BluezMake                     PASS      1809.27 seconds
MakeCheck                     PASS      13.20 seconds
MakeDistcheck                 PASS      184.30 seconds
CheckValgrind                 PASS      256.07 seconds
CheckSmatch                   WARNING   358.51 seconds
bluezmakeextell               PASS      122.75 seconds
IncrementalBuild              PASS      4778.15 seconds
ScanBuild                     PASS      1033.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/3] l2cap-tester: Add tests for multiple data packets
WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 25)
#351: FILE: tools/l2cap-tester.c:1285:
+		if (getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, &data->l2o,
[...]
 			 tester_warn("getsockopt(L2CAP_OPTIONS): %s (%d)",

/github/workspace/src/src/13713119.patch total: 0 errors, 1 warnings, 431 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13713119.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:613:28: warning: Variable length array is used.emulator/bthost.c:787:28: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============5353670492295602453==--
