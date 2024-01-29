Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3106F073
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549257; cv=none; b=YT5nu7COpPLcdLnRpf0TUuP8Es58Eqci2Hn/pNSPnfsRPlY2kYE69cyO6PIYole4fg2/m2xXhwawa0SFYfHM7IPyZt0lIqayl/IEDSQzuuV8gbLJnI+exD4ygv4Dhr6rNqzbm9mYXZsMR4ji4/W/VsUqPWt55PbYpAsoiwuYGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549257; c=relaxed/simple;
	bh=BA4sduNidfn0zFGkUKN1zNgrQIZ2xuOPkbuZAaOohnk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LzwuuT/hLBO93W5kMTfcfk/t4ivmtteUZW4Mt2/ToR7mItJPIuxEWetAt5hc9iUjVHm7ARFwX4Zx1ULHePgWuzeQP1u2oW0bcXR1ByZPRM9iTh+b/kRmghe/dIc52AObpD01fVCTL5F11DyNzQgGdzZcXUBjHqyM1+1Sju44hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtaxTcID; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtaxTcID"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783da8920e5so250684285a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706549254; x=1707154054; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hjnjIYN5jpccytVUX1EjU2VGAANzOuK1PXpOrJvwRuo=;
        b=CtaxTcIDmBWwEwtgt1e+HZ0yph2lwXTn6Ur8V7li8ip7fX9xRWA1DnlRRo0t4k2hJE
         Kj1CIyR0NA9HbUNaIA0yw837m3hy1c1O3F9mEJiBd3nsH9Hi28H2WlCG4sihrkDJNnMv
         aI2leCkRBDNDPpCtuljSTojIWmZXO9f2wB/msvKy5sx08Z4+IEq/G7SLd2SvkQ3vc2vF
         c7rVYMEIiT22cKM0jVB15ZZsLdMDTYhhZ6sQYHlS76/1jWPUM2JY8lEYcrd67hZaX/uj
         1AAhHDWGZSvQRa1DEgcNqytHsLtc5ls71QLw5YQodTGyR/7AblGER/LyWshrH0tFAjef
         jIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549254; x=1707154054;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjnjIYN5jpccytVUX1EjU2VGAANzOuK1PXpOrJvwRuo=;
        b=MrMETvOJqCfp48pOQZ1UQmCXf2bha9vk9jike0/KzuhtBeReioIEYhdvPewbOcDPHy
         12uz3BACOB+ACeZWdp6pMt1mnFfyYv0snBwoViLkBtWgtJEY0RDRAHP5egV8OMt0lPnq
         XIpYKuEio4YXT/IdNlYytGsC3NMOvVKn9rXqMC5YYY9QWIPrqGzb/pqTcjOi50oMC4ie
         S7AnxCstebowLntgL9eeAQBH7dfsf2f3GiO8yCUjNw8d8z63tJa8RzlUPCfaDc3cjSFI
         9b9V1iuuBDZjxeCPoqTH5zGuOM6n/8Ozf9qvp1yIfT5kPCeziqK+jXPvqCPrWbyFId0O
         tlmQ==
X-Gm-Message-State: AOJu0Yy2jIpI2u69qFLUoZqfnGQGCLtR2ux48LH4cQhk+HPV3eP9uZNS
	ibXXF5VOicT/QcZk9m7aJVpLwd3pxcfw6u2zv5uPksOnDaQHjfgZnC+Swkes
X-Google-Smtp-Source: AGHT+IHf/PsihUhiJF0m12lbxQvSEoYfrgstXP3T90aeSaKnX47DMQoBc8pkT458kLDJ3KofD5Mlfw==
X-Received: by 2002:ae9:f441:0:b0:783:ebb7:fd64 with SMTP id z1-20020ae9f441000000b00783ebb7fd64mr4491358qkl.38.1706549254482;
        Mon, 29 Jan 2024 09:27:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUj3HErNrNkUi3o41sqvkZXMJOYyKsZ0VM94g/Jok6oqYALuFRbRUiX+r97onCpzE5qa2SbgDo6GYcglW62w2KYk1NZntkbHeWrZB9oQSu40y85m8zfUvZilIj9
Received: from [172.17.0.2] ([172.183.121.85])
        by smtp.gmail.com with ESMTPSA id os28-20020a05620a811c00b0078350718a63sm3310067qkn.67.2024.01.29.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:27:34 -0800 (PST)
Message-ID: <65b7e006.050a0220.daa84.c904@mx.google.com>
Date: Mon, 29 Jan 2024 09:27:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6201593272732295382=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+emil.l.velikov.gmail.com@kernel.org
Subject: RE: Remove support for external plugins
In-Reply-To: <20240129-rm-ext-plugins-v4-1-bfd1e08c7f99@gmail.com>
References: <20240129-rm-ext-plugins-v4-1-bfd1e08c7f99@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6201593272732295382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=820935

---Test result---

Test Summary:
CheckPatch                    FAIL      3.64 seconds
GitLint                       PASS      2.33 seconds
BuildEll                      PASS      24.08 seconds
BluezMake                     PASS      732.29 seconds
MakeCheck                     PASS      13.76 seconds
MakeDistcheck                 PASS      164.26 seconds
CheckValgrind                 PASS      226.32 seconds
CheckSmatch                   PASS      329.54 seconds
bluezmakeextell               PASS      107.29 seconds
IncrementalBuild              PASS      5502.72 seconds
ScanBuild                     PASS      928.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,2/8] obexd: factor out external plugin support
WARNING:IS_ENABLED_CONFIG: IS_ENABLED(x) is normally used as IS_ENABLED(CONFIG_x)
#127: FILE: obexd/src/plugin.c:37:
+#define IS_ENABLED(x) (x)

WARNING:IS_ENABLED_CONFIG: IS_ENABLED(EXTERNAL_PLUGINS) is normally used as IS_ENABLED(CONFIG_EXTERNAL_PLUGINS)
#253: FILE: obexd/src/plugin.c:200:
+	if IS_ENABLED(EXTERNAL_PLUGINS)

/github/workspace/src/src/13535810.patch total: 0 errors, 2 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13535810.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,5/8] bluetoothd: factor out external plugin support
WARNING:IS_ENABLED_CONFIG: IS_ENABLED(x) is normally used as IS_ENABLED(CONFIG_x)
#127: FILE: src/plugin.c:29:
+#define IS_ENABLED(x) (x)

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#239: FILE: src/plugin.c:186:
+	 * plugins are loaded. */

WARNING:IS_ENABLED_CONFIG: IS_ENABLED(EXTERNAL_PLUGINS) is normally used as IS_ENABLED(CONFIG_EXTERNAL_PLUGINS)
#258: FILE: src/plugin.c:205:
+	if IS_ENABLED(EXTERNAL_PLUGINS)

/github/workspace/src/src/13535813.patch total: 0 errors, 3 warnings, 178 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13535813.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,7/8] bluetoothd: change plugin loading alike obexd
WARNING:ENOSYS: ENOSYS means 'invalid syscall nr' and nothing else
#108: FILE: src/plugin.c:52:
+		if (err == -ENOSYS || err == -ENOTSUP)

/github/workspace/src/src/13535815.patch total: 0 errors, 1 warnings, 106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13535815.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6201593272732295382==--
