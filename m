Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0942D76C
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100783; cv=none; b=d9hOYJP+0e6jz4CX+2kjuQr+2IB+yYmfmp0nt/nh8e88lCYqhTh0o/ckY6kgm/liNudnXfsK7TKbmvIiTd9trJKOtg3ZqHxDWDx0EuUF+zEJAPIr88DBoyTXS5dMkyqX+5/tPQSfLtjsjpVu3ez8EVNXSLG8lxt2REbEyvlutXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100783; c=relaxed/simple;
	bh=7FTuWz5u/UgITIbGxLADPOmrz3hbrYB6WL7swwZsJM4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FhlLwMKl8zIPH+Fc21d8Vlr4rqFv8SjLwor/xAqPRWR1lPZcfdhfatoHuEFq5w/ecgjWsmXEhGlgNBD9BefnZqwtoF9qWaM0/ZQncy0pD9B9x1EwlTAoGqh1P4IxaWnLl2UiAXZ6SZGFIsMRXFs4lknbtC+0GlQsX6VXN27jzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgN4zDl7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgN4zDl7"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-821106b5b64so38708857b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786100781; x=1786705581; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6sbQG6YdZRUgELblm8+2SmJut16rEoGVvxEC/6JOWIE=;
        b=GgN4zDl7RL3zBvnaJfGlSl9qP8TY+ycvlFpRJQoZMhe11ewNqUZeGHvprh5v60ZvEx
         ZhN8MAkei4HJ9GXScZ0xQsiPHdFANM4dRcVpi8HVgPt8xd81VVAL6wLD3botyJ23d+z4
         M5C00OuJvR5upDoVGCGSA7AFdZhKdwBgZPvUiud+q9r8NwYRZx/GeQv0uvbBPIzWP2fA
         MTPmqF7XAYPoIamIMRK8p38NbS+D4RoCAX8mi2YtNoIstwaVRcDsHLwtaudBZ/cRKUlT
         oZX85qAdsE1rKsFlzdjDzAM849CR1Oy5AUekVtnp9tG9v4vkAQEzLUo8gF6oZNQMemIu
         wxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786100781; x=1786705581;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6sbQG6YdZRUgELblm8+2SmJut16rEoGVvxEC/6JOWIE=;
        b=F4SW+ynwVXogofZIvQ+UxJkTlxtW6fWhrA5R35rp5j0aKqm0qkDOcjoThhIqVG/xff
         TErnBJAMiHIOCDcHbhGeoSqjfcKHDC1hrkCCD4Gxb44znkXE9GihyzbYMzlOamZYTCwU
         3cRWCiNDHRdPyRL7Gpknh+N8GD/gcBmyFXhOGtZ0nkBYx9YG0dqeQFskXFb8Rlt4/DU0
         17d8r26VrxCUmooKNkwK8Oqk4v8au7FqlBqkPLmqKw3xJ6C6H+yeecdzMkaeZIALmvpk
         D7/lhk1LIuP1O70Ge3f/MbObqcJlnLZzy/irXs0D/ZrBC85ZKJp6QsPPmjapgBrH6QMS
         /ioA==
X-Gm-Message-State: AOJu0YxSPWs6291125BQOs/ZskCTOi3khTyYJyKwq+bJoIdShGQaaxbB
	6ZvRBX0z582i8uIpXu5rqcfoFZRmWY/hoOnbvnFwahBBokcr7jiLuEIm4c8uqh8y
X-Gm-Gg: AR+sD11WqgEK05uRi7G9to/kgvF/0nrXPMhJi/V1NMHBT50TqloKZScvVmUJ84SzpEU
	giFsk0yMGm2qQq5HVtpJUBh4Fp7ZS8bLvTxCmtixOM0FgVvNJKTt2xNWPyr34V5DJAhi91MFNYQ
	DavhUG0xI0WDT8fzTBQnzs7mXuG7enU+IyUmT4lQ3M8Q0nrlLsMlVl2qgW3+FSMtXRQNDw6a+al
	NlJDBG8HX+kwo6mImPpzuhnN/iBklv+EVSOk9o9/6uLvoK5FeAIgOO+Mcpmy0OYSjCenLQZH55+
	7CECxuabQvsisW8CLg0o0ZvUH8D20ik4WYFkvaR+le8bt1UTJPkMqwHxgNM8MWYZeAy9fEn3Mse
	H1x/Crqo6z9hrs1L3jXpZYK9d/zJjCbZcdIxAKVAOpHIEeNQL7UjbGTEC/3USsCbPfeUmjbemCQ
	HOtlfzSG3+1AjcE2e/JlMKGJU3Zihqj00R3C+8rhPLC89bj5AbW+lpf8vPgPDuvIB2gFLs
X-Received: by 2002:a05:690c:b11:b0:812:9e6d:d47c with SMTP id 00721157ae682-8213b69ea1dmr68482267b3.10.1786100780988;
        Fri, 07 Aug 2026 04:06:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.156.86])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f577c5acsm7578777b3.32.2026.08.07.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:06:20 -0700 (PDT)
Message-ID: <6a75bc2c.77321ceb.36abf0.bade@mx.google.com>
Date: Fri, 07 Aug 2026 04:06:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1756443394584571296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [v1] avdtp: Fix use-after-free in connection_lost
In-Reply-To: <20260807095809.2584501-1-jinwang.li@oss.qualcomm.com>
References: <20260807095809.2584501-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1756443394584571296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142087

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      16.04 seconds
BluezMake                     PASS      446.70 seconds
MakeCheck                     PASS      3.53 seconds
MakeDistcheck                 PASS      122.19 seconds
CheckValgrind                 PASS      120.72 seconds
CheckSmatch                   PASS      228.31 seconds
bluezmakeextell               PASS      74.06 seconds
IncrementalBuild              PASS      464.74 seconds
ScanBuild                     PASS      681.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] avdtp: Fix use-after-free in connection_lost
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#122: 
Assisted-by: Claude:claude-sonnet-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-sonnet-5'
#122: 
Assisted-by: Claude:claude-sonnet-5

/github/workspace/src/patch/14736692.patch total: 1 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14736692.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2386

---
Regards,
Linux Bluetooth


--===============1756443394584571296==--
