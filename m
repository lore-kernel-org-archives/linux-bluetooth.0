Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199753D1CA7
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650965; cv=none; b=kohmkyjYYF0SL7QbBnHntnUppNvBLEI7pX0ZKrSb4gO941N7V6ZphayG9A0lroSlvWsAqLl3jnu8zef2Ugz1lh8av0kitinBPbVsLJ9xPOzGLyq9/0Wgdj11QKKDsLwztb7xZBdmOKUHRVOL83qPKNUFtJ83IiZ5GSoNZ5L9mMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650965; c=relaxed/simple;
	bh=amNstM9UB5dhKWcy9bm4QRGX+aZPFKEwqrksteBpgyw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ojO6x57zIqUZn44uNN34mkpeRBwROe+4S6l9bwMaM9IFVXQpVJuNvScMweQQvLvGg4VpnUSjDCAKLWvVdUHCfUtmAH35pc8LDURPK94V8TwhNYGbRmPr+M9a7oNhVw7orw4rYwOIrDVoYbZPBeyEwT+l/uHnkzMLabcvKcDMEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNCX1K4p; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNCX1K4p"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso18510276d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 May 2026 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777650963; x=1778255763; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ2Q/gm3W0atf6HRbWZDtnwRlk76tVScYyC8O/yhUvw=;
        b=iNCX1K4pAJKvvKAut4pF1ShJQ7YaPLxR4bwn7nmH9CNTWXjb6mO+7cicnRwUu+Hy8R
         xt56EM7mYv736iQKvTvBgkajQnwXoZIaJYX9lc8LufyDZWvWG3SwN0rGtHE8N3Vn8Yub
         QoxnT9okmfgdxddJpRckvITYqDAteai0vs08v+AWsbtVJwmtD016kFkL3CKUuPzGTUMt
         l2KEjyfwNN13spELxukumbA+wIFGe164Cet3XfJOn886ifTuTcetro5PmpFiiJHGhjvE
         F/4/8xEaLUrIKJfXrTcumC99ctyugOvcpbs/R/IZaR3z8sEKwuuXg6X+8KQXyrtlkRt0
         aAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777650963; x=1778255763;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ2Q/gm3W0atf6HRbWZDtnwRlk76tVScYyC8O/yhUvw=;
        b=h08F9kfO0VySL7FQvZilNuYKfxZiqkJbq+fkj+pG1bVRezBtAfBzfgVflBJsnJ0ib8
         2RCraq2I1+0yRZi9eieoZQn0N9158YBPlyM8g3IOOAxr4g8ncRx7av4AXTVM7oFp98oQ
         sW5l4j/le5zJPZrlQ3drASOBA4Wx4BlsTnMyAg7y4fJNcSeeCmIJQpZiJWoQrZz/JE09
         wa+LTIjy4C09A85cyGWcU00I5klifkOQS1vdB4XUOZdh8FeOIKOI9HJX+qh39v4ch91J
         BKcLrOAvA7RDc2TqXB7UiBykB8Dwi15zOtwk+AcYiwP+4U0WVsgHu581ZWBx/CReKyXG
         S34A==
X-Gm-Message-State: AOJu0YwDKYx2+wWl/KFEgo7O+5TN/o+obohJPHaK0CwdJPGxEnHG1+nb
	a5eb8lU3k/O+5dx2I39cb9cJi3EtvnPBqwYdCB3RJM4oDXrvz1j/Y6LWIzmLSA==
X-Gm-Gg: AeBDiesuf6LADnOmnGZzqj2X530KlKNqa1gCnLJyM9L28b4qk6xgeFwiHDI40w07xWY
	Oh2gebojO1CYMIONFzk7N1NEbaz5umrGLN8hcMSl/j5s7ayfc6yq6gXYHOI9JuNzalm9s/YBejE
	eT5+2WCAwOxTWbk4OI5442iivvxPhLQs1ZzibIoZso8XGNeA4IkLsR8rM/SqzKYYsnYP9jcPxKQ
	3S/GU04SjLk47kk4BjhPnjJaa0lUDPBIWhrdwhhxvGjIp9K50EG0RhnuRgrevww7VXWQKAhBmyK
	gt4l2Yx9pZPaKhqwCffUoOD4dzYoGEXnMVfiH6hA7ezEtHeZ9aO7b/cvbWMOOq5omQdYzU4+dME
	j0Htf2N4+Pa1ahUw8Af2ejRcTTvwDKOwTUVBiXFhGploFvK47/4Q+KJQXE2ae35Ra6O8kilCuMv
	D7k8QAfgkKFXt8AfTjyxv04c16iqHyy4DY1uCOGv5q+ChZdVl82FE=
X-Received: by 2002:a05:6214:3381:b0:899:f092:9da with SMTP id 6a1803df08f44-8b6684453demr752746d6.28.1777650961895;
        Fri, 01 May 2026 08:56:01 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.160.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5394d1894sm27990866d6.15.2026.05.01.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:56:01 -0700 (PDT)
Message-ID: <69f4cd11.0c0a0220.77eab.f075@mx.google.com>
Date: Fri, 01 May 2026 08:56:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6060190715606906294=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] shared/hci: Add BPF filter for registered events
In-Reply-To: <20260501143847.724150-1-luiz.dentz@gmail.com>
References: <20260501143847.724150-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6060190715606906294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1088547

---Test result---

Test Summary:
CheckPatch                    FAIL      1.94 seconds
GitLint                       PASS      1.17 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      654.89 seconds
CheckSmatch                   PASS      350.12 seconds
bluezmakeextell               PASS      182.29 seconds
IncrementalBuild              PASS      707.45 seconds
ScanBuild                     PASS      1006.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/4] shared/hci: Add BPF filter for registered events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#105: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#105: 
Assisted-by: Claude:claude-opus-4.6

/github/workspace/src/patch/14550825.patch total: 1 errors, 1 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14550825.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,2/4] shared/hci: Add bt_hci_register_subevent for LE Meta events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#111: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#111: 
Assisted-by: Claude:claude-opus-4.6

/github/workspace/src/patch/14550827.patch total: 1 errors, 1 warnings, 317 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14550827.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,3/4] ranging/rap_hci: Use bt_hci_register_subevent for LE CS events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#109: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#109: 
Assisted-by: Claude:claude-opus-4.6

/github/workspace/src/patch/14550828.patch total: 1 errors, 1 warnings, 269 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14550828.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v1,4/4] hci-tester: Use bt_hci_register_subevent for LE Meta events
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#107: 
Assisted-by: Claude:claude-opus-4.6

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-opus-4.6'
#107: 
Assisted-by: Claude:claude-opus-4.6

/github/workspace/src/patch/14550826.patch total: 1 errors, 1 warnings, 116 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14550826.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2091

---
Regards,
Linux Bluetooth


--===============6060190715606906294==--
