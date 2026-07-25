Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849B351C10
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014349; cv=none; b=RMKjvATkvXxiDgXkTzT5C+ZVTOjbqkVwunr7mOXSKy3GzW6KPHSAl6vCVt1AFTVn5Y2KoPNFwT4/ByxSYcNcQ54zSXwKgUKkium56op7tQYBd+8sL/lzlsQg6psrJ1j1mrN79G183W1cBSrVaJ6XmztN2pNH1NPcSMhESsmNdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014349; c=relaxed/simple;
	bh=OltIPIemJgEWSQJChww3sHBM1lrMKYS/bh7f1dKqasM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JNoLgh6w02EnilhxVSXDBds2ZVYiV0auQ0zgvh9su6uh9nz7HKwFwJR9IluAcFZ/8FdESNnNuwwMkXjgaAHAC2RRsC4yH/mtIQm9cWT0dzTGdiCN9ETTbjMVeJz+lojzG57gGtZqL7NFHaf9I4tk1sQMKvbE8eREwFBoRlXTPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Hr2vHu; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Hr2vHu"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a40bcc8d69so975856b6e.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785014347; x=1785619147; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=edyMga2RrtZ227Vyd9JQ3z0TZsBR4CiEzk0r7eQWzu8=;
        b=O2Hr2vHueWi89eA58SvfMH+TVqm5vE0T/hjF8Rj7lndPk4enTctEhqaRJT3nJLd93Z
         Hu1F0M5nVpKYVUhDwFR35jM8+0IOCMb/R+IMfOue5V0LPi8qT0Ho3PIeub3paZLKZys9
         PpjnKAbn8ypIYmsp/c029SQHWOHxUEkDjR1QhIkdsSdS3LXZaiFKnG8UkklifWbxXs1Q
         sk0UXl9hj/ItYtMzMDjeMZzZptXYlgC0kPUWNJnQcyEBEWX/Gd5OkV4yugryvkqm0q9Q
         tIHv37FILA7NBJI+AJY8aMfS29tbVWMIOze/JdfwSS9cEvi53Iy+xlYC0fIVcPOXDIaF
         vtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785014347; x=1785619147;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=edyMga2RrtZ227Vyd9JQ3z0TZsBR4CiEzk0r7eQWzu8=;
        b=N5sKZYeuOyibj9yxseVbpBzSt4hY2iXGqnV3G41oqolyQlTuGaF5Z1184dCxTGl0ck
         0MpwBpOCNXXt0e/w5I2snw5dKEBEQqpX725sxPbofcW+61BPA0yVHpTrVbjCg0kKruCw
         zBKDRORUKRk8lhaja1cCra4ZTIWeodq5H7iBQEkYEVsdGXidHE4csFYEuMJkx2C1rMWV
         95KXMyEsbfx8Rw1AImwAkwLbYVYAb6RwgoMPWPIv82cQtdZ09KSMvxx4oVDFsK5gnHPA
         LXsdyRe3INysROvDVL7skGR+1gzMw5bUeNQPhPhAOMLr2OahM/CSKFb+jrTZbGkocFfx
         FnzA==
X-Gm-Message-State: AOJu0Yx1TAL3y9XSOc7GePuG2SUUfAFmAs6vL1zu2uXE3Vy4b2x964ek
	LJQFUMckam3rY0HCSaFEFM+XKxZEIktBXcSSk5HezCEybw1SrW2sPAqdgKjSFQ==
X-Gm-Gg: AR+sD12Bt742cEy6CQ3EyKAb6MmIVts57H0yQCwE95gU1zQU4suifBQMXeWQyp0rAth
	96dN1NpnTTc62F6g8pYs0xQdRpOtM//znJHJOqkgRMzpRkcVJlNfQlclmETEtprHUEuc/0Ab+K3
	IyReecoR+haYVGahZMXE8Y594xBcArwAmUSrDXLFDlE8vpR8D+klTtcX/u5+ALBegjwhbHq2F5+
	1iMUfa2dv6ykyzL9DAvpjcXefC+BwnvPaAHSGy5HywfP/989AzxsejvqZ8KvtyV95Km3rmzgFsj
	6Yx8ZtAUivSxozs1sYawJ4/kXiA6wgGrylrPSnCJvYyYtkurTW9M1OFWeX9otc+Jau9+E48/eqf
	gzg2Yth7x152Ve6silyEwsjE5QLViWoZxRRdm509jNiDszGyW70+uJWvrx40mEueELmrU2yGqYm
	4wJNKRXRY=
X-Received: by 2002:a05:6808:514c:b0:4a4:a06:43b3 with SMTP id 5614622812f47-4ab6a1d162emr3089629b6e.38.1785014346891;
        Sat, 25 Jul 2026 14:19:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.21.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45804f6d51bsm1635995fac.8.2026.07.25.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 14:19:06 -0700 (PDT)
Message-ID: <6a65284a.8ecdf604.caa0a.f7f9@mx.google.com>
Date: Sat, 25 Jul 2026 14:19:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2852469058685149409=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, matthew.schwartz@linux.dev
Subject: RE: Hide WakeAllowed when the adapter cannot wake the host
In-Reply-To: <20260725201856.2142333-2-matthew.schwartz@linux.dev>
References: <20260725201856.2142333-2-matthew.schwartz@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2852469058685149409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1134469

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
GitLint                       PASS      0.77 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      519.73 seconds
MakeCheck                     PASS      19.28 seconds
MakeDistcheck                 PASS      152.18 seconds
CheckValgrind                 PASS      217.44 seconds
CheckSmatch                   PASS      291.38 seconds
bluezmakeextell               PASS      93.72 seconds
IncrementalBuild              PASS      522.92 seconds
ScanBuild                     PASS      854.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/3] adapter: Add btd_adapter_may_wake()
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#87: 
Assisted-by: Claude:claude-fable-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-fable-5'
#87: 
Assisted-by: Claude:claude-fable-5

/github/workspace/src/patch/14710584.patch total: 1 errors, 1 warnings, 83 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14710584.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/3] device: Hide WakeAllowed when adapter cannot wake
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#77: 
Assisted-by: Claude:claude-fable-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-fable-5'
#77: 
Assisted-by: Claude:claude-fable-5

/github/workspace/src/patch/14710585.patch total: 1 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14710585.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2349

---
Regards,
Linux Bluetooth


--===============2852469058685149409==--
