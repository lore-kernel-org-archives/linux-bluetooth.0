Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E32C6AA
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 22:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566689; cv=none; b=Ho6Qv+n0KUh+uav02HyX5eE4lCyeuJd377S4ikkkiOW4YgiCW2wd51vL53V9Ov+HR6D8WOfw/i6vbop4srSNBg97gXdIv6wn9mh5RlsFGwgZBZJyBBlA/GLGhPz8C0ENUrXKNttV7/btP08ALzbyQb10QxzT9OosThT7f26Vx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566689; c=relaxed/simple;
	bh=WMocSxQTdDlls89WADox/T+fvKxjwbNExdAYvvr+ko8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uHsk3PPkUqplkti99Tk50P9IbaQ3Ug67Fn8cky1P4aB4oBP63w3NDDFuwWhOoUbwVKBkGYrsABVQHKbzhKnTkaYwclipU/v/rvnoI9jZX8Ukx+V+8zZn3+sf4yQwlg9Fqx3ggq6O1shJM2LrT2ZuLO3LmVj6uc1InPveU/OirC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/TBkjZB; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/TBkjZB"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68009cb4669so25911256d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706566687; x=1707171487; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LcC+396Zb1HtEe0BpyShZtqNv249WeJCqx437IYcrVI=;
        b=E/TBkjZBZHpJQf7AalZ2Yfii68WB+DlzLGLGD1LAnb6MU+Oi6i0hMoe2TQmtVJSZLP
         MCRfA9SpKlN5W17UqO+R8ZPC7l0rh3cSI7xtAgrEjVOlQwl9IHPq117MK4Xuyq6aDy06
         uKdB1qlaTM7T20sU6SWL88MJFWO8PmMVNe67WaOyyKLd3tdHa3Ay4Pd2hUkxshVzG4zi
         PSK+2docZM5RxqMR1Y1MGU1ebm59zXGGsi5NSmwsBHbZBrZngZaFRYQLzov53QyuG1lN
         nnzYVx5NK3okh0c5xwTxFBb/37q3UPXF5ErRNICafLFDdYXOPkndTn79ArYEy/qz4k2a
         y8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706566687; x=1707171487;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcC+396Zb1HtEe0BpyShZtqNv249WeJCqx437IYcrVI=;
        b=DdEItw8d7vUrl5QTJEH7WCRtUfsSZVhXbissUJX6f0Ele7wGehH8W5sBqO1xCPbNS0
         Yfiio/Ciwmq6gdSxzyDVH6xLhV0KebVMewgI+IXDlfOm+vD6T/u7GUSd6LyeZYeyg/t/
         0uzF6600Qo19JROw0T7hBtzN34h36az0AEGyOlyceu7xbUH05ZHUs5nu6I0Xi+cPc20V
         Kv9PH3rSpNUFqUqGGBrsA8F7W8xiFGfk2P3pw7qI1eQYinmGWI5Sx+5e/X1WSIBVJEmv
         6gBkR0P85eW0J70ozUAJaAkKeccvA5b632BE/KOqQb6dYHLgoNl02+yIuQjXPG3Ag4Yo
         qBUw==
X-Gm-Message-State: AOJu0YxvHYW0VCeXZWBi+YH4Pizbylq5YQ3BvkGaVSSLlKOaqGl0WazR
	y4WujT5IarN8Jb6bqRwYLAiCsC0YCki28F+cckTk45tMh1bzkXs5JryM3wWW
X-Google-Smtp-Source: AGHT+IGUnWxki3qOs5SGVygQELpTYfKHwGoKaSA8sCcmjjgwKFJCB2fbIr+03mZwDpUgiNwlRYiKwQ==
X-Received: by 2002:a05:6214:f03:b0:686:10eb:eef3 with SMTP id gw3-20020a0562140f0300b0068610ebeef3mr7185645qvb.91.1706566686804;
        Mon, 29 Jan 2024 14:18:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKAH6w2qp2NLY35JbjRxIX9imCfOsbAEB/8GMCTAJb6C3z8YTOyZnZc0SZ71s/50P8aMgtVBRHf8sWx6J199YDo3WQRqSKN13aQxl2YVo=
Received: from [172.17.0.2] ([20.84.127.30])
        by smtp.gmail.com with ESMTPSA id qp7-20020a056214598700b0068c4201f4e6sm2533853qvb.144.2024.01.29.14.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:18:06 -0800 (PST)
Message-ID: <65b8241e.050a0220.37eb2.8f55@mx.google.com>
Date: Mon, 29 Jan 2024 14:18:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2754093629031520772=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, VAnPushkarev@salutedevices.com
Subject: RE: Introduce option to limit A2DP channels
In-Reply-To: <20240129204154.95773-2-VAnPushkarev@salutedevices.com>
References: <20240129204154.95773-2-VAnPushkarev@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2754093629031520772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=821056

---Test result---

Test Summary:
CheckPatch                    FAIL      1.20 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      24.30 seconds
BluezMake                     PASS      744.06 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      164.00 seconds
CheckValgrind                 PASS      227.32 seconds
CheckSmatch                   PASS      333.77 seconds
bluezmakeextell               PASS      109.57 seconds
IncrementalBuild              PASS      1374.21 seconds
ScanBuild                     PASS      955.44 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] main.conf: Introduce option to limit A2DP channels
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#145: FILE: src/main.c:165:
+static const char *a2dp_options[] = {

/github/workspace/src/src/13536361.patch total: 0 errors, 1 warnings, 75 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13536361.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,2/2] a2dp: Reject connection when the channel limit is exceeded
WARNING:LONG_LINE: line length of 90 exceeds 80 columns
#118: FILE: profiles/audio/a2dp.c:2553:
+				queue_length(server->channels) > btd_opts.a2dp.channels) {

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#120: FILE: profiles/audio/a2dp.c:2555:
+		DBG("Reject current connection, A2DP channel limit exceeded: %d",

/github/workspace/src/src/13536360.patch total: 0 errors, 2 warnings, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13536360.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2754093629031520772==--
