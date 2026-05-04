Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000738736A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934552; cv=none; b=QWl4sZCHei2tngvhWJjlaOzHBQF9sgUhNeDew+EGqKVyuUkxSmzMpjOtaknRsXWBuwM9J4XTupAl4zQRFNvce+yCF/JgoH9hto4LZ9NceOzsGumtKmptF9cRY+F4VA9opIDWL8sXhrxSp/XUhk7ZrIXXM7saqDTYGxAeR84Hg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934552; c=relaxed/simple;
	bh=nNhoVEXzlkiJMGB8BEambpUPfy8fca8kmPO0jbk6w7A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V+9Zdd71zn8hZB5ykczD1VyONNaIpZgmkcmBeYwHSNS/ZAfGesLva2Bafm47ZGZTEA8dmY2qo03nyVBgwp/60dx1ekj5zDsDsuVw7j3zK1R9hgMIZ5ktUSa6CE/P3cCblrRyRD9PchbBGEApykfYmQs0TKNg0qI+zFb2kR3U+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXjIl6LV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXjIl6LV"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d933da14f0so498126485a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777934549; x=1778539349; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zkK8K6mw7n84IrnWBNW5QQlyK9yyJf8ztrovsbn5EXo=;
        b=GXjIl6LVVhEKIC6gx3XofLLdDdKJwiZeCv6904oVB7rUHpSItyi2tJ5B3uAz8oUdqF
         Z5QVHG7Me2EBviotMBR0SpErJeOyvPG0L6cgunFoAuAjdt+7CU+0gwt7TeId5fU2o3Sb
         voqHj2ZMhJJX8eh6UzKN6GFF9ZagPDUr8lrA71HVgqIBKL1Mo2DiGJZgX2iFMmRI5KJq
         vpbmIuTejKteke8gLzNIq4ROcY+ESp7nRl4rWYMGTYiOE7Ik3PStTELXJW755uIDqs1e
         UHggR7HPQMkKTw5hfaTYGubO4ibIlBtO9d9MvQb8OquvJDWZrSWfeKlOZ1X886qVyuRl
         fhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934549; x=1778539349;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkK8K6mw7n84IrnWBNW5QQlyK9yyJf8ztrovsbn5EXo=;
        b=s7BXnV/wJXmIisoT9BymhUMI/sI1qkGiiwojqsRVYivkK8bd3CZg8xVYtG/edJQ3Hq
         +3ZXGSgLFELyAIZMjhqubcQRYrUF2yQsc78VqpzH8AnatIRdH4RbBGLd620OOxa/BX6q
         zrRhHSthCkofwD1afO/8FJVGyUp3/tvYgT9hnLdt9Jxq/qKAILapD2QnrgPGdLvEJq42
         G7H0gta1TI6cui6emY6THqiaa/PZPmdLdXWxWvfv/ItkAJ79IkTyp+C2yrg1/4JmW7PC
         q/eL6WVRVHb1X4ryV1vNjN/J4W4q1DSW+Uwvp9p1sv667yLg64Rt7CRWXZohJp+Mh7RZ
         EWnw==
X-Gm-Message-State: AOJu0YyPfoR3g17H2UUFuTuwVVycbuf+4JrmuFuXibZ1oNLKNLiPKKzZ
	FuAxLzVO14vq2QJ6PgQJHuF6Z00SMPAXT0Vh9mj79lCJtpdsxaeY/Nf++QeByw==
X-Gm-Gg: AeBDieuCFXexMEhTtCFT6juYjcGVKZRxyZv4DF2Cv+LdvFRgVxUZb/FPTrtEZIyvnsH
	UwOR+aXvQnSI2RDFjNHlkP4UJ1mRdF/ey4duCWBpad7+/XDcHLoUuez01CdhcVofYQ0FAFYqJsi
	Qcijzrs+L8NLgFj8fpYv6ag6eyrxkbA37nrdNuIVvX6YdfLfDGiBfl2aGd4VRdJKTIAYdWsg7az
	T9X5x+0ljI65XeMI8DxEqhJKLowmHq1J4NNAxOhHj6xdMvO5CvVSNgNaPKOoESVPczz6kAQNsZ/
	06nOUQT0qH2RvSg6VrIhL7S6oknXozYGgw9umXW+jN7dNKCXk1Fu0OYfKmdZMlJ2wUh8R/Obk6I
	bLI0EYc3fiS6h2MMIiqlNRIlP//GQ3l3k7AbM1Xk0GDa4RDLjFG27hVgwMkgxSEQSJDX0VhssPt
	VMkMmdF8Y7/J64OGMgZuYKZswBFfqN12ayZs1YfB7FCA==
X-Received: by 2002:a05:622a:305:b0:50f:c36a:3821 with SMTP id d75a77b69052e-5104bef2441mr163307701cf.34.1777934549242;
        Mon, 04 May 2026 15:42:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.153.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b8550esm108846251cf.26.2026.05.04.15.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:42:28 -0700 (PDT)
Message-ID: <69f920d4.c80a0220.e9861.6d51@mx.google.com>
Date: Mon, 04 May 2026 15:42:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7422649164662148027=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] monitor: Add features bits defined in 6.2
In-Reply-To: <20260504211303.1081876-1-luiz.dentz@gmail.com>
References: <20260504211303.1081876-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7422649164662148027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089499

---Test result---

Test Summary:
CheckPatch                    FAIL      1.13 seconds
GitLint                       FAIL      0.70 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      656.66 seconds
MakeCheck                     PASS      0.95 seconds
MakeDistcheck                 PASS      245.58 seconds
CheckValgrind                 PASS      221.87 seconds
CheckSmatch                   WARNING   349.65 seconds
bluezmakeextell               PASS      182.14 seconds
IncrementalBuild              PASS      700.74 seconds
ScanBuild                     PASS      1031.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] monitor: Add features bits defined in 6.2
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#98: 
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed-4ae3-acee-198f-27ead57d86f1

/github/workspace/src/patch/14553784.patch total: 0 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14553784.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,2/2] monitor: Add decoding for Short Connection Interval feature
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#140: FILE: monitor/bt.h:3212:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#154: FILE: monitor/bt.h:3226:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#162: FILE: monitor/bt.h:3234:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#168: FILE: monitor/bt.h:3240:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#186: FILE: monitor/bt.h:4209:
+} __attribute__ ((packed));

/github/workspace/src/patch/14553785.patch total: 0 errors, 5 warnings, 232 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14553785.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] monitor: Add features bits defined in 6.2

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B1 Line exceeds max length (178>80): "https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed-4ae3-acee-198f-27ead57d86f1"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2000:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3909:52: warning: array of flexible structuresmonitor/bt.h:3897:40: warning: array of flexible structuresmonitor/packet.c:2000:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3909:52: warning: array of flexible structuresmonitor/bt.h:3897:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2095

---
Regards,
Linux Bluetooth


--===============7422649164662148027==--
