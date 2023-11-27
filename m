Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT/58SPd"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023721B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 13:20:58 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d6f853ba0so375480285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 13:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701120057; x=1701724857; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cFEoDoEz4azVRn0GsMXJBxFNj+D4713UjbvKqCGPc4U=;
        b=TT/58SPdCNOmuhCBiql5pUzvkYpjBdZnhJOlYmL0zM6BJLHRWlVw1GDXnHmT5yQG5m
         dhN2oFRva5kQ6jehxlrZS6R5CFqHK/rDSKjyruBqjidQGmZX71VYtV5LVSTzLaf31ZxU
         hnDPLe/W/aE/t3+gVg+8SLy/jjCYi3fNXfUWbphJC/witHMG7BZxCUUhKr3HI4fyFOx/
         dT88mFqlMWoEKVAjhF/85Yru/YO7LBz24CD/Ggi0cf/jdFRm2hfszrwqInsuxeg69HAu
         d1tEvR0bDaVnieDGAgcvhz8ZFHR/XEUjXUyB7qCkdXLZ1ws7zYtxEf3o1mzp574Zi/zW
         qcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701120057; x=1701724857;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFEoDoEz4azVRn0GsMXJBxFNj+D4713UjbvKqCGPc4U=;
        b=DRtRMTMm6lA5bASIFeyKpOuwnZWTrBJjO8hIgrDzNaUPFKIslQPPjsDrkOOJ8yLvZ+
         oRni/w5Yy04fkhABLHp3vZH1GQ/SMGnuqalk9dK21xf4iL3telTcLF7zr7SLZ3t6W7sE
         lzNgHJHHGSTBs4U3B9+baaUa4z6uZYKKNBqEycrXTSuxUWrMPyN+sIiessZq4OI3Y5mM
         tzK6Wm65DFf89/PClhggFVQ4/ZDDlpGQB5HsJetNpz7M5QDr4amAL06dWTkhPyUiwvMa
         ySqHcaYmwdnnQ6/6BhiIO1u6DYFnRRhhiCF1AT3k5DCB+pFjAHjvXFpU03XaDiGJH2Km
         8/3Q==
X-Gm-Message-State: AOJu0YxpNzbodKloUUNYL2OD4ELdm/SA6KuEzcIyzHmL7SIaBtCR6km2
	gVAbxAiyA6VYURc8745cwZurcWTvlTQ=
X-Google-Smtp-Source: AGHT+IFTnmbSxWyx7xBXU63bmwMu4ndY1W9UiDuglJ1WMqSBcD3wmcaOPO77Sq3n6YzJRxMgT+Zc7A==
X-Received: by 2002:a05:620a:278a:b0:77a:5247:730a with SMTP id g10-20020a05620a278a00b0077a5247730amr18770524qkp.20.1701120056736;
        Mon, 27 Nov 2023 13:20:56 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.134])
        by smtp.gmail.com with ESMTPSA id m16-20020ae9e710000000b00767d6ec578csm3994547qka.20.2023.11.27.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:20:56 -0800 (PST)
Message-ID: <65650838.e90a0220.3a85b.e824@mx.google.com>
Date: Mon, 27 Nov 2023 13:20:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7161989604790302220=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sebastian.david.forslund@gmail.com
Subject: RE: [BlueZ,1/1] Pattern match on service- and manufacturer data
In-Reply-To: <20231127195632.445-1-sebastif@axis.com>
References: <20231127195632.445-1-sebastif@axis.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7161989604790302220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804640

---Test result---

Test Summary:
CheckPatch                    FAIL      0.67 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.12 seconds
BluezMake                     PASS      551.41 seconds
MakeCheck                     PASS      10.52 seconds
MakeDistcheck                 PASS      150.82 seconds
CheckValgrind                 PASS      210.28 seconds
CheckSmatch                   PASS      315.47 seconds
bluezmakeextell               PASS      96.19 seconds
IncrementalBuild              PASS      510.76 seconds
ScanBuild                     PASS      906.21 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] Pattern match on service- and manufacturer data
ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#93: FILE: src/shared/ad.c:1327:
+static void pattern_manufacturer_data_match(void *data, void *user_data) {

ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#123: FILE: src/shared/ad.c:1357:
+static void pattern_service_data_match(void *data, void *user_data) {

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#124: FILE: src/shared/ad.c:1358:
+  struct bt_ad_service_data *service_data = data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#125: FILE: src/shared/ad.c:1359:
+  struct pattern_match_info *info = user_data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#126: FILE: src/shared/ad.c:1360:
+  struct bt_ad_pattern *pattern;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#128: FILE: src/shared/ad.c:1362:
+  if (!service_data || !info)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#128: FILE: src/shared/ad.c:1362:
+  if (!service_data || !info)
+    return;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#129: FILE: src/shared/ad.c:1363:
+    return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#131: FILE: src/shared/ad.c:1365:
+  if (info->matched_pattern)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#131: FILE: src/shared/ad.c:1365:
+  if (info->matched_pattern)
+    return;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#132: FILE: src/shared/ad.c:1366:
+    return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#134: FILE: src/shared/ad.c:1368:
+  pattern = info->current_pattern;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#136: FILE: src/shared/ad.c:1370:
+  if (!pattern)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#136: FILE: src/shared/ad.c:1370:
+  if (!pattern)
+    return;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#137: FILE: src/shared/ad.c:1371:
+    return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#139: FILE: src/shared/ad.c:1373:
+  switch (pattern->type) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#140: FILE: src/shared/ad.c:1374:
+  case BT_AD_SERVICE_DATA16:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#141: FILE: src/shared/ad.c:1375:
+  case BT_AD_SERVICE_DATA32:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#142: FILE: src/shared/ad.c:1376:
+  case BT_AD_SERVICE_DATA128:$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#143: FILE: src/shared/ad.c:1377:
+    break;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#145: FILE: src/shared/ad.c:1379:
+    return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#146: FILE: src/shared/ad.c:1380:
+  }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#148: FILE: src/shared/ad.c:1382:
+  if (service_data->len < pattern->offset + pattern->len)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#148: FILE: src/shared/ad.c:1382:
+  if (service_data->len < pattern->offset + pattern->len)
+    return;

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#149: FILE: src/shared/ad.c:1383:
+    return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#151: FILE: src/shared/ad.c:1385:
+  if (!memcmp(service_data->data + pattern->offset, pattern->data,$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (2, 4)
#151: FILE: src/shared/ad.c:1385:
+  if (!memcmp(service_data->data + pattern->offset, pattern->data,
[...]
+    info->matched_pattern = pattern;

ERROR:CODE_INDENT: code indent should use tabs where possible
#152: FILE: src/shared/ad.c:1386:
+              pattern->len)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#152: FILE: src/shared/ad.c:1386:
+              pattern->len)) {$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#153: FILE: src/shared/ad.c:1387:
+    info->matched_pattern = pattern;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#154: FILE: src/shared/ad.c:1388:
+  }$

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#167: FILE: src/shared/ad.c:1432:
+		queue_foreach(info->ad->manufacturer_data, pattern_manufacturer_data_match, info);

WARNING:LONG_LINE: line length of 88 exceeds 80 columns
#172: FILE: src/shared/ad.c:1437:
+		queue_foreach(info->ad->service_data, pattern_service_data_match, info);

/github/workspace/src/src/13470254.patch total: 3 errors, 30 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13470254.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7161989604790302220==--
