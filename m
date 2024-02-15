Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F06341F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013969; cv=none; b=CYwPTMEL364wBIDYRxsYGCZOCYEMN1SFlmlpYV1tJ3UQoF77jUDukjxK2xRWvBOkhH2dybT9Ple0hmv0GDSKl19XhLSzp96nc21vb6wbTFS8Y6WLMHxygwbKR2915EW7m1TMP3m/zPAgPgJKAPqwp7Te3MXazq5ADq15P793TaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013969; c=relaxed/simple;
	bh=cxkL1BHCFO60tRqQbJTrKfjtnZHv0jH0hftKHAHLD0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ti5Xd+SsZYHqqWxqCc3DfC+JH/X4QXDKdZOUqyMK1TYB7StSDClUiCifxX7/E2iE6ETXoGWunE1Ek0M5yQpY0x+nikWrfj/UOWM0Ntj/90BM4CokUwiG7yJQTY9F9uIlWhSurv4cXLOhhbCp/q58TNQ8EX8GkSG9nKdvc+B4bn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crqd6csV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crqd6csV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d944e8f367so9784365ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708013967; x=1708618767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mSIUnmuLQgsayAdjIS4ErS4PVkdcRcbs5TO1htj84Y4=;
        b=crqd6csVIVxoPe0KGQwZ3+s1m5Rp7X/2YRu3OJ+nTsxhKnueSfitytMpY2Z4Sie3Z7
         dtFncZq/WJgu/zUonaqiFG+U35re4GTByhLseZxnETvYUjJ/hv5g7lm0hX27pwmJbGHJ
         1il7DBtGT0+0A1gh2zAJ8I3GhU5zfr+iExwTCNpln4QyG1fqWOnGDKuFAkqucXI/YXjN
         WSwOr4xfsxnudTp8ozJkRjaWWcngo2IMXO4lXGQQ5LfCjtnC+2/WB8J2aaxglnk5qu1G
         4Jj8sH5CY7qZXbnlS4erz1F/DwV+BPK85XS9CaF3SaeUTSi7NC6IJNKE0bM57GmZRzSM
         o/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708013967; x=1708618767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSIUnmuLQgsayAdjIS4ErS4PVkdcRcbs5TO1htj84Y4=;
        b=Wauf2VM1zb7y6+tKvN933NSmWHT0qtnIgPzZJK/fHOCsA2tfHG6yG16lK8lqZOIbYy
         pmET1t16Ehibd2JU1q/vLA4vm3rC8datsbiVHnoRAud9mB/eNbcQDj9xkA6Djc7v9yvw
         /F+CvctTXqFi7uwzJX5gGlxBnyp8DLirI2PLXmu9ZGr72jzDX22XPda73n/ZpVZR3vyZ
         02OxDnkLNM6+4dlUY1C37+qjszOu8zGrvXktcSLe4Kzsp7bs7m30MGkJOFZLZ1QCjb54
         W29f/xTQFvof95iHEVm/0OOiMzA0x3wCDRr7Zmc+Ul8hX9y+IXRTNLKNqT4sry4NlUCM
         s0kQ==
X-Gm-Message-State: AOJu0YyXZSsEwQ2x6k/7tTDU4gJA3h9qNM0niK2CkPlAho8HA/JIT1zd
	KuuLGZGKzjkPDtOUElOFIB7C6QCQ3dKOz+A2gh2Qv1rwAJ/ScIFS1BdLQNX+
X-Google-Smtp-Source: AGHT+IH91w57R8W+sTKC8BDb8cLbU1OGO2PSE5XC8odvM4jJ5P/8lKdxWmaxWLDQxuS9A7oYegZ8ng==
X-Received: by 2002:a17:903:11c3:b0:1db:7195:5fca with SMTP id q3-20020a17090311c300b001db71955fcamr2473021plh.34.1708013966817;
        Thu, 15 Feb 2024 08:19:26 -0800 (PST)
Received: from [172.17.0.2] ([52.234.26.86])
        by smtp.gmail.com with ESMTPSA id k2-20020a63d842000000b005cd835182c5sm1608155pgj.79.2024.02.15.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:19:26 -0800 (PST)
Message-ID: <65ce398e.630a0220.6c0d6.50fb@mx.google.com>
Date: Thu, 15 Feb 2024 08:19:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0493387988490784756=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] btdev: Fix crash on page_timeout
In-Reply-To: <20240215145227.782554-1-luiz.dentz@gmail.com>
References: <20240215145227.782554-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0493387988490784756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826449

---Test result---

Test Summary:
CheckPatch                    FAIL      0.83 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      24.08 seconds
BluezMake                     PASS      735.14 seconds
MakeCheck                     PASS      11.95 seconds
MakeDistcheck                 PASS      163.00 seconds
CheckValgrind                 PASS      226.46 seconds
CheckSmatch                   WARNING   330.29 seconds
bluezmakeextell               PASS      107.46 seconds
IncrementalBuild              PASS      1373.61 seconds
ScanBuild                     WARNING   949.57 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,2/2] rfcomm-tester: Fix crash on test-basic
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#105: 
    #0 0x7f199c3a01c9 in g_io_channel_unref (/lib64/libglib-2.0.so.0+0x4d1c9)

/github/workspace/src/src/13558579.patch total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13558579.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:422:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1086:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1372:24: warning: Access to field 'link' results in a dereference of a null pointer (loaded from variable 'conn')
        pending_conn_del(dev, conn->link->dev);
                              ^~~~~~~~~~
emulator/btdev.c:1494:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============0493387988490784756==--
