Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759644;
	b=xWdoaPm22jeqyYT6AaFqRtW/Fbbx8j1XgyzeqMeFmv0ofYAbSV8gWqrB/Bjx5zrlEkI7
	 hgu/Q4rMwh4SVZn31aOQM8kFyoa/5TDbS+Qi1yCZQ9iPK53bdVXd4wdokrK/sZ5457CEh
	 mCqZUdCRE8c9GOrYkN2cin4T5+djaV0RdwbingPhPga1oS1XzgJ7RNGRosTxt6YzbNSB7
	 9ZkMuwuOIPm6MsLaedxKIXPTj1WCK56kqGrn+sM4hz5qcRmSml3EnDG7lePypntPLqIBX
	 HnbD2Xce7SvcyCuY4dhkFH7Pu3+tUV7Z9cEc+niGmlhig1JLkbyu0ByCaEs3C3btZTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ukPSQKIQpl3L2cLAn/s5lssfgBcAwuRwH3+fL78zY/M=;
	b=0Os2CanR/9JgWLuK0K+Mbw6fFPhUUcZd+DFOV4JWUsK+aABtYzxzDncI/RkiVui2GI+w
	 Gqi4fIl72YQsqXRKZRok2/FQSIMyT27MfhWchlbc6H4y/ovsw/wlcfaCM7ucQNxs1+DS5
	 LNWacTdP0Z486ELh63kZiUA2DfdEZsJu1MvzqBWd+4PfF9i/qViq+YzKGbcgTfMrOwubK
	 NJiimvpBH2bE3hvVWLG8ag11M/hVWKZUfq3UDVOZffkmu0OKd89noZ+kkZZQwG5HdSjBj
	 FNyOenQkr/ggy+Pa4aRVYw0apqMJRjY/xDZnJvrWnavxYiAPW0vd9XfskTHcxr7f4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lSLUcxIe;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F6606EEB9
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 02:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA2F6606EEB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lSLUcxIe
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53644b28706so2389371cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 18:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759643; x=1794364443; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ukPSQKIQpl3L2cLAn/s5lssfgBcAwuRwH3+fL78zY/M=;
        b=lSLUcxIekrDOaaWNp+/aBgo4mJUfrIfNmFsEJRHqP07czXzVtML0TKUYqR9Gz+gHBW
         k5LB1bG8Bae4cFrrAtFmoMIN140NbTHvq1Yv3uRFnWixvGpxxnCfVR+T9bd5cuje1WfX
         TWzSK/T4TLe4Iie97/DGdgcz+xvLa82pFJALm4Q+eHVTq/6YN9KIij42RmNQp7AJ7Kfy
         cr7P4d1JWTZ08H8SUDNC6Iz7iwlyfHMfLwbfsSr6tSocqEGDrI/5GfDiCF5IV/8r+hEe
         JaQYNA33XJ9naQQVePtbRdX+VSvDsRzZ4e9PEwPUZKWD5oMCJKDXJl7EEZWe3VV093Q2
         woAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759643; x=1794364443;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ukPSQKIQpl3L2cLAn/s5lssfgBcAwuRwH3+fL78zY/M=;
        b=nz/GIoFofTbfoiA0X3D/BCpx5hoQFXRBkS3S2SDwblY3Y/ZjjSQ00QI0tku2pkxarX
         3dKm/j7VUKlXPPRPeG/rO3sQUR03TZ5oNx8QLvQ/rHcaIQU5MvVsfbIK8lGygxcqD4Dh
         enedOknvt/ujsDLlfNSIgaNj2U9hN4GRsKlpaMGcFQ/gwI+i1zWDTQCsPnPG5WH9w+M7
         bDrFQmsUPC40umjQbCGjZOJsaa819kP3GDjFzE0BhwAit+5of5E68NLxWUpYq+Eey2WP
         9qUGEg6Rs1a8kq58aDxIXwpGgIlouuZGH0ZHdQlIZGWhS/UO7pml1WwweB/giM5kK467
         K18w==
X-Gm-Message-State: APuU4Z+AqnIflrlLNNCrf+62UCs/sPx4AQdcYXJSoilbYcLG3BqVY/zK
	D4spXWvE1H4z/z8Y3aMN67faJZ7V1+wn4VkZGs7BBcS3Tq4zm7s0U0FC3SdHsA==
X-Gm-Gg: AYBFou13kGFPsQjY5ObYbBNz1fyQm8ke0wffyyDXORAZmsrx4ksMa7hoJ4fXLCam8dH
	AqQi7bbKjaBWm6Lpuc74sva04jqN37ShBNkHFR3vvecWgfAxYoneoh3XVdTnqF68FzPDTMTddER
	wOBIjF//aXH5pOm4m7ikyIe+e4eJQA/NzPDETVdq1cl5KH6C1pCJzCuZFJmFtDKcpJaMrvFkY93
	1GLZOrSHL4Stx4HKuOAxkniQytuE/2Qv5CLX0pKaWdWqjvsEEXBq4r/nhnXn4D3BqNQ/YkU6cqw
	TC7dca0gA6QcQdzsBgpU0MD1HAk4DRfqmlqEGh10V1Kcurh42fwj8DP6+Bsm3gLJElXJspYUZJ8
	GLqOTgTT7/HQmF8UjoXOwjlDOa0q0SMDJZsjpbt2ZbweohiCPF3AJdan2rzPcTs2uCDyxqE2nHJ
	av0Efni++60R5QX+/l0KjluXzELmxNJdMGHBxsSvj4JXuO7oU8ey2RcsZj5JkXwAfaQ5woaFPaU
	d5dcjwVYI5usm9pamdPTAh5jY30E40iiOFYrV4EJNdQ5pYTevZjycuuqKU8VKQ=
X-Received: by 2002:ac8:5d8d:0:b0:535:a5f7:d589 with SMTP id d75a77b69052e-542b7ef72bbmr260272221cf.67.1793759642505;
        Tue, 03 Nov 2026 18:34:02 -0800 (PST)
Received: from [172.17.0.2] ([172.174.191.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7b1e92sm6462086d6.45.2026.11.03.18.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:34:01 -0800 (PST)
Message-ID: <6aea9999.8b0b0488.416aa.9d09@mx.google.com>
Date: Tue, 03 Nov 2026 18:34:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2123786697767441103=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add support for HDT and EKS
In-Reply-To: <20261103221944.4072041-2-luiz.dentz@gmail.com>
References: <20261103221944.4072041-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2123786697767441103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1200958/

---Test result---

Test Summary:
CheckPatch                    FAIL      7.31 seconds
GitLint                       PASS      3.27 seconds
BuildEll                      PASS      16.30 seconds
BluezMake                     PASS      233.73 seconds
MakeCheck                     PASS      15.58 seconds
MakeDistcheck                 PASS      118.58 seconds
CheckValgrind                 PASS      188.91 seconds
CheckSmatch                   WARNING   230.71 seconds
bluezmakeextell               PASS      75.18 seconds
TestFunctional                PASS      987.86 seconds
IncrementalBuild              PASS      447.01 seconds
ScanBuild                     PASS      845.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,2/9] monitor: Add HCI decoding for HDT
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#162: FILE: monitor/bt.h:260:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#167: FILE: monitor/bt.h:265:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#172: FILE: monitor/bt.h:270:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#180: FILE: monitor/bt.h:278:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#188: FILE: monitor/bt.h:286:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#198: FILE: monitor/bt.h:296:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#206: FILE: monitor/bt.h:304:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#213: FILE: monitor/bt.h:311:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#220: FILE: monitor/bt.h:318:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#225: FILE: monitor/bt.h:323:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#253: FILE: monitor/bt.h:351:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#269: FILE: monitor/bt.h:3354:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#275: FILE: monitor/bt.h:3360:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#281: FILE: monitor/bt.h:3366:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#292: FILE: monitor/bt.h:3377:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#298: FILE: monitor/bt.h:3383:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#309: FILE: monitor/bt.h:3394:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#318: FILE: monitor/bt.h:3403:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#323: FILE: monitor/bt.h:3408:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#341: FILE: monitor/bt.h:3426:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#354: FILE: monitor/bt.h:3439:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#361: FILE: monitor/bt.h:3446:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#384: FILE: monitor/bt.h:3469:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#398: FILE: monitor/bt.h:3483:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#416: FILE: monitor/bt.h:3501:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#423: FILE: monitor/bt.h:3508:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#446: FILE: monitor/bt.h:3531:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#453: FILE: monitor/bt.h:3538:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#461: FILE: monitor/bt.h:3546:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#471: FILE: monitor/bt.h:3556:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#476: FILE: monitor/bt.h:3561:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#483: FILE: monitor/bt.h:3568:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#489: FILE: monitor/bt.h:3574:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#508: FILE: monitor/bt.h:4563:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#518: FILE: monitor/bt.h:4573:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#529: FILE: monitor/bt.h:4584:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#562: FILE: monitor/bt.h:4617:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#583: FILE: monitor/bt.h:4638:
+} __attribute__ ((packed));

WARNING:LINE_SPACING: Missing a blank line after declarations
#1192: FILE: monitor/packet.c:10541:
+		uint16_t mask = print_bitfield(2, rates, fields);
+		if (mask)

WARNING:SPACING: Unnecessary space before function pointer arguments
#1512: FILE: monitor/packet.c:10861:
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);

WARNING:SPACING: Unnecessary space before function pointer arguments
#1515: FILE: monitor/packet.c:10864:
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#1636: FILE: monitor/packet.c:10985:
+				enhanced_accept_sync_conn_request_cmd, 63, true },

/home/runner/work/bluez/bluez/src/patch/14942033.patch total: 0 errors, 42 warnings, 1890 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942033.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,3/9] monitor: Add LL decoding for HDT
WARNING:LINE_SPACING: Missing a blank line after declarations
#184: FILE: monitor/ll.c:801:
+		uint16_t mask = print_bitfield(2, rates, fields);
+		if (mask)

/home/runner/work/bluez/bluez/src/patch/14942032.patch total: 0 errors, 1 warnings, 355 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942032.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,4/9] emulator: Add HDT support to btdev
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#802: FILE: emulator/btdev.c:8419:
+	} __attribute__ ((packed)) rsp;

/home/runner/work/bluez/bluez/src/patch/14942034.patch total: 0 errors, 1 warnings, 1140 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942034.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,6/9] shared/gatt: Add MIC length permission checks
WARNING:LONG_LINE: line length of 85 exceeds 80 columns
#548: FILE: unit/test-gatt.c:4735:
+	define_test_server("/robustness/mic-len/read-multiple-variable", test_server,

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#569: FILE: unit/test-gatt.c:4756:
+	define_test_server("/robustness/mic-len/read-by-group-type", test_server,

/home/runner/work/bluez/bluez/src/patch/14942036.patch total: 0 errors, 2 warnings, 356 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942036.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,7/9] main.conf: Add HDT configuration
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#213: FILE: src/main.c:193:
+static const char *hdt_options[] = {

/home/runner/work/bluez/bluez/src/patch/14942037.patch total: 0 errors, 1 warnings, 152 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942037.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,8/9] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
WARNING:MACRO_ARG_UNUSED: Argument 'name' is not used in function-like macro
#362: FILE: tools/iso-tester.c:909:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'setup' is not used in function-like macro
#362: FILE: tools/iso-tester.c:909:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:MACRO_ARG_UNUSED: Argument 'func' is not used in function-like macro
#362: FILE: tools/iso-tester.c:909:
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#2819: FILE: tools/mgmt-tester.c:14370:
+	} __attribute__((packed)) *cmd = param;

/home/runner/work/bluez/bluez/src/patch/14942039.patch total: 0 errors, 4 warnings, 2685 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942039.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,9/9] l2test: Add HDT options
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#204: FILE: tools/l2test.c:127:
+static int mic_len = 0;

/home/runner/work/bluez/bluez/src/patch/14942038.patch total: 1 errors, 0 warnings, 285 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14942038.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2290:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:4251:52: warning: array of flexible structuresmonitor/bt.h:4239:40: warning: array of flexible structuresemulator/bthost.c:707:28: warning: Variable length array is used.emulator/bthost.c:708:32: warning: Variable length array is used.emulator/bthost.c:961:28: warning: Variable length array is used.emulator/bthost.c:995:28: warning: Variable length array is used.emulator/bthost.c:996:32: warning: Variable length array is used.src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2756

---
Regards,
Linux Bluetooth


--===============2123786697767441103==--
