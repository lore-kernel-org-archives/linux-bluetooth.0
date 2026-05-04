Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E93DE42C
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921040; cv=none; b=PZynhCzkAFDze0YIxDXU1L8ZL/O8E3s+7TxYXN+Fldt2k41eK6QHkbndDey3FBl0lBh1eUlN+CmLl95+RsLyi/bQ6pYGrNMX+rJCizaro6Z1ug8j3I6uG0B8xolHfcZNvkZm2fTS3VG15M0/EI++GZxzPD9SrtEMtqnjJJIdZE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921040; c=relaxed/simple;
	bh=baVVjcPEFFq+EO8lcmNGusRwiS/92x5ij8JavtXLGZU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dXcNX6zd973c27AijDiL2Yzo8PZPz5txtxjxVvv5h9OiCi2of5z5vEjR8jB5fOerjbw9NWQm64Er8bO9VR81UVeIqZOEbnf2VO01mrt1MVnVeANmGx7p8tRQAY18SLzMak9hb8G164X3zD/a5zBvJ3iXLCkRibpqkefUGYSJSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWmj2EgX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWmj2EgX"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8f83efb5729so487189985a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777921038; x=1778525838; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0qA8wDJvQrChQs4xk8kWZiTJY6Tq1r8GcPIDF1nB2cc=;
        b=TWmj2EgXb225lN3qRoKnERfyQqOKXkvaP2ZzsFB4D5eVr8ETjSmMT96LDz1SZONext
         YxjDMr6ZTBTploXqqEoeboQyuj0x3fnMdZzMTj2/9Xzp9hSFCJgnYWUeUJmFVq+CNvXg
         3G3DoLr4FRaZpEe5DSGO3rzbpct3KLgUwg2zoVmYtNB/e0oJdNO6gp2P2SV9i8gwB/Hg
         LKoxWTCgKFXFGw60urNyqDSITmmTeLGcW7cHJ7905rp+X+9MWtgX8y1KUDYWbz7PmDdq
         xZRNnbDyl2KetMq3Tho7AVNwhBy09Vh/7VQjQK52lqwH3L+eEBJBPRBAxsj5pzsUCgoc
         g8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921038; x=1778525838;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qA8wDJvQrChQs4xk8kWZiTJY6Tq1r8GcPIDF1nB2cc=;
        b=HiWFblpuV2VrS8YRefOtTA3LfvJP44+tWNMnPdnu9oLxibVIFqwuwMuomlbm9dYcTv
         7bvFdB+wsyP8691cpHGTo8chrqSKfSNWlkK+yvJMWCFfvWo0mmFERgacVlM2Ct68ayhv
         ppyagXxHCS0sku4hvfrIih7h79VcGVdbBinvScy21Igrn8OJ5JusegCv47LtDstaiCZX
         xJZ0jqtLIADHc1FZ2vySH+UsiURILNi2fxSpuyrFrrRn1OsivMxTXSLebME5Ymb5xwf1
         LCu+qPlK6l06XiaR2Wto5wzDYXdtaw9SnYKtfU9CYOo+UrkZ+vhV/2nx3pe8vH+ZF6jm
         RoMg==
X-Gm-Message-State: AOJu0YyjR1QGX88rI3e51rmOXMSkGcebsE33SwpE+WHQZt4vGGUSPsVP
	+FAXm5HopJzjtw/cfRoi1eHJ7yEthCdsLUSNm5IfD4jgoDwnMzPDFkRcBgkLsQ==
X-Gm-Gg: AeBDieuA0S/0S1v5VkxK2wl4xah015nmZ7nCBWXJSJHSpQEWC9s5YVm7gYIteBB0Z16
	HZ1K/HTKv3h/gVKy/3Xdej5teTPjnG7Vp/yG8iezxciCblOS8ABkUgbjVAk6+bfIpyfnjeYkuGr
	UhpZNYg4DOLyzNxzur8+V0I7Y5ghByzGXTnH/5CY2jPseD0clpByj6EhPvfSDZR6eXtHXwkwIIy
	8Ux0vbwGo+Tto69mbFBA1e7IXBRy2viY4Fx3/BJAlAnrGkIkmiHKKu7a11sZRDJ8cgoLjr1Poc3
	GsMYnrL1CFZct1UVdAHhpsh3jqy3AH/wEDo5oQ/2PfkS3z2AcuSWFCyYwrjb6/Kvq/VzGovv0x0
	wc3gJO7EAgIZBXXyAoJrkJEIBhtDYLWgGOqRPQInSdvwcjWRztW0vfHOP1uUBVN7fbXHN97aSfz
	SdqqKNYoBARQI5m6m4h9EV1rpcKgGjk1A544E/q/Vc6Q==
X-Received: by 2002:a05:620a:708b:b0:8fb:1acb:c907 with SMTP id af79cd13be357-8fd158e398fmr1709645685a.12.1777921038123;
        Mon, 04 May 2026 11:57:18 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm1220545685a.36.2026.05.04.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:57:17 -0700 (PDT)
Message-ID: <69f8ec0d.050a0220.27ffe4.cd44@mx.google.com>
Date: Mon, 04 May 2026 11:57:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6402000213353510394=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, admin@fluentlogic.org
Subject: RE: sdp: fix overflow in sdp_extract_seqtype()
In-Reply-To: <20260504173622.37463-1-admin@fluentlogic.org>
References: <20260504173622.37463-1-admin@fluentlogic.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6402000213353510394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089431

---Test result---

Test Summary:
CheckPatch                    FAIL      0.43 seconds
GitLint                       FAIL      0.30 seconds
BuildEll                      PASS      21.25 seconds
BluezMake                     PASS      669.07 seconds
MakeCheck                     PASS      0.96 seconds
MakeDistcheck                 PASS      255.38 seconds
CheckValgrind                 PASS      228.99 seconds
CheckSmatch                   PASS      360.28 seconds
bluezmakeextell               PASS      188.30 seconds
IncrementalBuild              PASS      663.48 seconds
ScanBuild                     PASS      1086.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
sdp: fix overflow in sdp_extract_seqtype()
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#68: 
covered by commit 31e4fb1498f4 ("monitor: Add decoding support for HIDS 1.1 flags and attributes").

WARNING:LINE_SPACING: Missing a blank line after declarations
#86: FILE: lib/bluetooth/sdp.c:1254:
+			uint32_t val32 = bt_get_be32(buf);
+			if (val32 > INT_MAX) {

/github/workspace/src/patch/14553405.patch total: 0 errors, 2 warnings, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14553405.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
sdp: fix overflow in sdp_extract_seqtype()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (99>80): "covered by commit 31e4fb1498f4 ("monitor: Add decoding support for HIDS 1.1 flags and attributes")."


https://github.com/bluez/bluez/pull/2093

---
Regards,
Linux Bluetooth


--===============6402000213353510394==--
