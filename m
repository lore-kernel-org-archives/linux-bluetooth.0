Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CE28E17
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ98H+BB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78106c385a1so95138985a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 02:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704450599; x=1705055399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KY0wKoyOLu61s8qF3yICkHeG77XYoNXfxW2/tpZ5uDk=;
        b=eZ98H+BB2SxHrsG+yQOtxgSEFjrL+qvtYjs2f9lSHFBQRAcXxlbYR1kr1pH8fSVXQw
         LSRwyHK5wF6Z3+2J9gd1eiNessNd7drQKjP3njpEGve+7oBExxF5iA4qux2YmbriX1iv
         5S/RqMulqty0i4jZC7nosE6tNHboeZ/AREK4S+xad/vR+LnnK23xYcCie3DVhLlNxhpn
         xS6tpAY5Yi1wN/laIoVMZHmOc6+wEYZfjmhkB5YGKfJZx/R72MfrjOqNAAyV4aGjlzB8
         Qp+2mYcRTwgJ7pXsaeAb974YKGl4anUITEwTXQ11M5vJ/F8nw3mdEhNgJBBTiu5veadA
         QfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450599; x=1705055399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY0wKoyOLu61s8qF3yICkHeG77XYoNXfxW2/tpZ5uDk=;
        b=hvBzW6qcqpYZjWdRiqI2mjD8S3dyxNwwFD9XbbxFMdgJjkS7GCjUH4zGJwUgETOarl
         a8yRTtbRy2AYrXw247g8/AxLdFe0OXJ60b6WZlArQ358j5Q5T7pBEKmn+lGMFYdB2M8s
         YFtwQUsrajXPIxjJS2KP+2j/BYZs2GpROjvXMb/K6WJgXv8/c1vpCnJKN+SjCP4EHACR
         JuIfP3gLe16fazmJgEqJuCzaCdEYg0w8EQ1Hba5shohrsiU7jyfS7TsaE78WwS2mIiy3
         Rmznww/pR0mFlvXvDGyG9ARJYjTvQ9estwy6f6n9CmTuoUzzOihIcrWsJopYLK8fqiok
         ZgeQ==
X-Gm-Message-State: AOJu0YzB+UIoCtyBJ9nka0pQvtAWogtbtvRgeBqbH93wcOEL+LsHazDc
	s6J92sep1hJHiVvLwRA1RSGjVq/5tP8=
X-Google-Smtp-Source: AGHT+IEpsyX7r0+mfvMIN1mSepH29Ik7MGuK3YaQyrWGQl8RSvMQXC8SsDMoPqGovp7Kn9HLshqtvQ==
X-Received: by 2002:a05:620a:c06:b0:781:16b1:86b1 with SMTP id l6-20020a05620a0c0600b0078116b186b1mr1763226qki.34.1704450598971;
        Fri, 05 Jan 2024 02:29:58 -0800 (PST)
Received: from [172.17.0.2] ([20.97.191.242])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a13ee00b00781991b04e7sm473390qkl.110.2024.01.05.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:29:58 -0800 (PST)
Message-ID: <6597da26.050a0220.bbb3c.1434@mx.google.com>
Date: Fri, 05 Jan 2024 02:29:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8916406390701777692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] shared/gatt-db: Fix munmap_chunk invalid pointer
In-Reply-To: <20240105091742.146342-1-frederic.danis@collabora.com>
References: <20240105091742.146342-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8916406390701777692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814595

---Test result---

Test Summary:
CheckPatch                    FAIL      0.83 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.16 seconds
BluezMake                     PASS      697.41 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      160.25 seconds
CheckValgrind                 PASS      222.11 seconds
CheckSmatch                   PASS      326.66 seconds
bluezmakeextell               PASS      106.59 seconds
IncrementalBuild              PASS      663.30 seconds
ScanBuild                     PASS      935.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2] shared/gatt-db: Fix munmap_chunk invalid pointer
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#105: FILE: src/shared/gatt-db.c:366:
+	bt_crypto_gatt_hash(db->crypto, hash.iov, db->last_handle + 1, db->hash);

WARNING:LONG_LINE_COMMENT: line length of 89 exceeds 80 columns
#218: FILE: unit/test-gatt.c:2413:
+	/* test that gatt_db_get_hash is able to manage unordered db and doesn't crash */

/github/workspace/src/src/13511878.patch total: 0 errors, 2 warnings, 163 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13511878.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8916406390701777692==--
