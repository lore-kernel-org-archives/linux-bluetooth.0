Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648923D9DA0
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047796; cv=none; b=JsG+ptpR/WIqPOonM+eV6ZX1NjvCO+YLnvW+fR0YgM55jMFD08CH8WkroXJlPWTLhmV3qDgXoKdZEiPYQYWvpjmEwXCmUVwQfagrCdQSKMF/5hnt/Yx2zo5X7aMiMNKq4WjKs6X88FVPX5/Anxnl3FeIpTpog9ddvpdslOkJJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047796; c=relaxed/simple;
	bh=++6aWhiqQKh39rO2w/J+KZB9PDiePjEP5Cn6Ay9zPuY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RI0EUQfJElDQsXtSDqVK1+IU8ttKiGXt6sSYjJIWwoctX1D31LeuCObggEUKXC+7+UT5RmqEaigvh3mJZr49MT6FiL3c3CRNbBx2EfOysfVAirsM1hGf0SNLYJIZDxOCAALC1fAAg4CU5ILBcidAR/UyejqFXwh0mlI3Ha6TNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAqA8Gvd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAqA8Gvd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ea8563c693so664030485a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777047793; x=1777652593; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b0anKCXtf/IHKAu6C8n+cn7IpAr2qFI0BcgLxCYmYx4=;
        b=PAqA8GvdmiFfPuvkkamF/pxKpJkI3gPi2hxa2obdOo6mdDEtuO1BP0cA4YPotxN6/6
         a2A4gCxQqNY8pHHChpFCO7V68I+AJpBHUuhIsnmfiMVT4ptFFqYjPn1HBb43gWXoHPdx
         M8Ma/TLzCzx4yUEout2FGR8/vPmPUfzSFqTqVPsLjt4uP1Gz7gALAbdOIcQuXHuhsKHR
         Z479/DWeYZy9W6gU/nskfZrgUQ04spC/AZAs7PpX2MlZ5nZ0p3eKlEs3X6Hjsv2evBUw
         0HmrmslO5jurrT1wAskSZO/8dAYKHz6y3tTciSap04HuaqiKgbpEw36jfamzp0WgLNWN
         2YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047793; x=1777652593;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0anKCXtf/IHKAu6C8n+cn7IpAr2qFI0BcgLxCYmYx4=;
        b=KGZJTGWvPo49NgbDZl5UPTRMDotI7Pl7pXXrnV250REWAkX5Uh/ZVP/83PNGOlrPj5
         kunU0k2ZSEWfQlMtClM9IinAFdXrlcygwojeoMQT+xkQZv1HJFLE20e+hPpEsquKvjSZ
         jxmEKxkzuqf/TzvRCR+99DILflT73kcA/WIEZbNr9kilbdA5EWYgplNRtbWdIoJtrSpw
         FGVyld5izCwhNLr6h93j57B/M4Dnw/bG5f5BC95ljGAVfoP7DZgniHFfvDFlm7MJvl8/
         +QyHer68xqD6yt9eEfDLIyiCQN6jmxTqwIa+QG9qJjJGeYeBntq3AwSRq4KqpvxGd4zb
         GYHg==
X-Gm-Message-State: AOJu0YyHYvvq+JktuxRGSOUwlaGsZuf6UIfRJ3XFqlfEMCoJNJLNlgo5
	feznkYZ3ISjIbDjFai0Ud/JSNTbDwBZkFjaInc34/PEwHSq9adtFPMnkY40r0w==
X-Gm-Gg: AeBDiesQoucSYIcxvdsdgpV3izZ0yYt83fgToMZyTkIfGqkFkNJBLC/1Lmfya+DLECi
	HmlOUeSPPtVTYHFvmfZu0p0FEhtmTS3uDU6d4M8DzF3VGbFGi/UnHxcB3XLbPQTQdvz4yRsODPk
	JFrJrWk5GvDRldi/Y1DEFuzC6w9KbquK5uJJI9PckLXcXMnz3Rt8dxrB8v9/+QSc+HGR4keAMn3
	LQgZE+CGnjxKQomizOCfrS6VZQd4kbb2WGujQfgIjmg9wZl8A/wfkovk7s3gxEYxznskYIquY3L
	nbGV7bWZvPtAy91+6m4T2lEgCyBnases25bYUXzMbiK/YCmZIDKL/dWscE6LWsooOTsPG1lok8Z
	+burorbe/tdYE5lbZg+uMi/wcjHZ6N2aIpb+edUVa1HwYSgRCgzzZQ8dYsV5KLj57mj/hd5F0aJ
	fr260UCbM8eg+qYzHeO7oHw6vni5LbQC2gY6e5JMKhQcM=
X-Received: by 2002:a05:622a:2519:b0:50f:ade2:2d3 with SMTP id d75a77b69052e-50fade20b11mr290215301cf.42.1777047792812;
        Fri, 24 Apr 2026 09:23:12 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.209.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fc91de051sm57040281cf.2.2026.04.24.09.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:23:12 -0700 (PDT)
Message-ID: <69eb98f0.c80a0220.355adb.1e37@mx.google.com>
Date: Fri, 24 Apr 2026 09:23:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3418171728763589185=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: client: Add public broadcast advertising support
In-Reply-To: <20260424141831.9172-2-raghavendra.rao@collabora.com>
References: <20260424141831.9172-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3418171728763589185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085227

---Test result---

Test Summary:
CheckPatch                    FAIL      1.30 seconds
GitLint                       PASS      0.67 seconds
BuildEll                      PASS      19.93 seconds
BluezMake                     PASS      604.72 seconds
CheckSmatch                   PASS      318.76 seconds
bluezmakeextell               PASS      162.72 seconds
IncrementalBuild              PASS      597.91 seconds
ScanBuild                     PASS      910.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/2] client: add public-broadcast advertising command
WARNING:LEADING_SPACE: please, no spaces at the start of a line
#106: FILE: client/advertising.c:1014:
+    return uuid && !bt_uuid_strcmp(uuid, AD_PUBLIC_BROADCAST_UUID);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#111: FILE: client/advertising.c:1019:
+    if (!ad_is_public_broadcast_uuid(ad.service[AD_TYPE_AD].uuid))$

ERROR:CODE_INDENT: code indent should use tabs where possible
#112: FILE: client/advertising.c:1020:
+        return NULL;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#112: FILE: client/advertising.c:1020:
+        return NULL;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#114: FILE: client/advertising.c:1022:
+    if (ad.service[AD_TYPE_AD].data.len != 2)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#115: FILE: client/advertising.c:1023:
+        return NULL;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#115: FILE: client/advertising.c:1023:
+        return NULL;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#117: FILE: client/advertising.c:1025:
+    if (ad.service[AD_TYPE_AD].data.data[0] == 0x02 &&$

ERROR:CODE_INDENT: code indent should use tabs where possible
#118: FILE: client/advertising.c:1026:
+        ad.service[AD_TYPE_AD].data.data[1] == 0x00)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#118: FILE: client/advertising.c:1026:
+        ad.service[AD_TYPE_AD].data.data[1] == 0x00)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#119: FILE: client/advertising.c:1027:
+        return "sq";$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#119: FILE: client/advertising.c:1027:
+        return "sq";$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#121: FILE: client/advertising.c:1029:
+    if (ad.service[AD_TYPE_AD].data.data[0] == 0x04 &&$

ERROR:CODE_INDENT: code indent should use tabs where possible
#122: FILE: client/advertising.c:1030:
+        ad.service[AD_TYPE_AD].data.data[1] == 0x00)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#122: FILE: client/advertising.c:1030:
+        ad.service[AD_TYPE_AD].data.data[1] == 0x00)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#123: FILE: client/advertising.c:1031:
+        return "hq";$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#123: FILE: client/advertising.c:1031:
+        return "hq";$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#125: FILE: client/advertising.c:1033:
+    return NULL;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#130: FILE: client/advertising.c:1038:
+    struct ad_data data = {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#131: FILE: client/advertising.c:1039:
+        .data = { 0x00, 0x00 },$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#131: FILE: client/advertising.c:1039:
+        .data = { 0x00, 0x00 },$

ERROR:CODE_INDENT: code indent should use tabs where possible
#132: FILE: client/advertising.c:1040:
+        .len = 2,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#132: FILE: client/advertising.c:1040:
+        .len = 2,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#133: FILE: client/advertising.c:1041:
+    };$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#134: FILE: client/advertising.c:1042:
+    const char *state;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#136: FILE: client/advertising.c:1044:
+    if (argc < 2) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#137: FILE: client/advertising.c:1045:
+        state = ad_public_broadcast_state();$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#137: FILE: client/advertising.c:1045:
+        state = ad_public_broadcast_state();$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 12)
#138: FILE: client/advertising.c:1046:
+		if (state)
+            bt_shell_printf("Public Broadcast: %s\n", state);

ERROR:CODE_INDENT: code indent should use tabs where possible
#139: FILE: client/advertising.c:1047:
+            bt_shell_printf("Public Broadcast: %s\n", state);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#139: FILE: client/advertising.c:1047:
+            bt_shell_printf("Public Broadcast: %s\n", state);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#140: FILE: client/advertising.c:1048:
+        else$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#140: FILE: client/advertising.c:1048:
+        else$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (8, 12)
#140: FILE: client/advertising.c:1048:
+        else
+            bt_shell_printf("Public Broadcast not set\n");

ERROR:CODE_INDENT: code indent should use tabs where possible
#141: FILE: client/advertising.c:1049:
+            bt_shell_printf("Public Broadcast not set\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#141: FILE: client/advertising.c:1049:
+            bt_shell_printf("Public Broadcast not set\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#144: FILE: client/advertising.c:1052:
+    }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#146: FILE: client/advertising.c:1054:
+    if (!strlen(argv[1])) {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#147: FILE: client/advertising.c:1055:
+        bt_shell_printf("Public broadcast value cannot be empty\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#147: FILE: client/advertising.c:1055:
+        bt_shell_printf("Public broadcast value cannot be empty\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#148: FILE: client/advertising.c:1056:
+        return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#148: FILE: client/advertising.c:1056:
+        return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#149: FILE: client/advertising.c:1057:
+    }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#151: FILE: client/advertising.c:1059:
+    if (!strcasecmp(argv[1], "sq"))$

ERROR:CODE_INDENT: code indent should use tabs where possible
#152: FILE: client/advertising.c:1060:
+        data.data[0] = 0x02;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#152: FILE: client/advertising.c:1060:
+        data.data[0] = 0x02;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#153: FILE: client/advertising.c:1061:
+    else if (!strcasecmp(argv[1], "hq"))$

ERROR:CODE_INDENT: code indent should use tabs where possible
#154: FILE: client/advertising.c:1062:
+        data.data[0] = 0x04;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#154: FILE: client/advertising.c:1062:
+        data.data[0] = 0x04;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#155: FILE: client/advertising.c:1063:
+    else {$

ERROR:CODE_INDENT: code indent should use tabs where possible
#156: FILE: client/advertising.c:1064:
+        bt_shell_printf("Invalid argument: accepted values are sq or hq\n");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#156: FILE: client/advertising.c:1064:
+        bt_shell_printf("Invalid argument: accepted values are sq or hq\n");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#157: FILE: client/advertising.c:1065:
+        return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#157: FILE: client/advertising.c:1065:
+        return bt_shell_noninteractive_quit(EXIT_FAILURE);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#158: FILE: client/advertising.c:1066:
+    }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#160: FILE: client/advertising.c:1068:
+    ad_clear_service(AD_TYPE_AD);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#162: FILE: client/advertising.c:1070:
+    ad.service[AD_TYPE_AD].uuid = g_strdup(AD_PUBLIC_BROADCAST_UUID);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#163: FILE: client/advertising.c:1071:
+    ad.service[AD_TYPE_AD].data = data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#165: FILE: client/advertising.c:1073:
+    g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#166: FILE: client/advertising.c:1074:
+        prop_names.service[AD_TYPE_AD]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#166: FILE: client/advertising.c:1074:
+        prop_names.service[AD_TYPE_AD]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#168: FILE: client/advertising.c:1076:
+    return bt_shell_noninteractive_quit(EXIT_SUCCESS);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#183: FILE: client/advertising.h:38:
+                                char *argv[]);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#183: FILE: client/advertising.h:38:
+                                char *argv[]);$

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#195: FILE: client/main.c:2923:
+static const char *public_broadcast_arguments[] = {

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#196: FILE: client/main.c:2924:
+    "sq",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#197: FILE: client/main.c:2925:
+    "hq",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#198: FILE: client/main.c:2926:
+    NULL$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#203: FILE: client/main.c:2931:
+    return argument_generator(text, state, public_broadcast_arguments);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#215: FILE: client/main.c:2986:
+    ad_advertise_public_broadcast(dbus_conn, argc, argv);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#226: FILE: client/main.c:3673:
+            "Set/Get BLE Audio Public Broadcast Announcement",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#226: FILE: client/main.c:3673:
+            "Set/Get BLE Audio Public Broadcast Announcement",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#227: FILE: client/main.c:3674:
+            public_broadcast_generator },$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#227: FILE: client/main.c:3674:
+            public_broadcast_generator },$

/github/workspace/src/patch/14537907.patch total: 22 errors, 52 warnings, 134 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/patch/14537907.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2069

---
Regards,
Linux Bluetooth


--===============3418171728763589185==--
