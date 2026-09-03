Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C517A2FC
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472177; cv=none; b=Clv4HzCZpwcjz1kU+XPQE01gOqjqAc6qhYdrn998BoxXm3OitD38OwnTmqNsCq78USdPxbe05xlhYV0JqiJmypS+Y0w8Ija3FwFDOOV+SUkSAvhkIetwZ2JI+IZR+m2k+qJED+bwaby8JjiZrcvBDwo/TKHf5YbTVqs6H9yHQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472177; c=relaxed/simple;
	bh=SuR5YoZhS0qJsr7jyqmf0eRADMaT1TZ/RDAEhAnJV0A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IdKLO5ScC2nC37AzkRZ3DBOKnTKB+BvxoXAmWwWQmz1EVWvNOTjnJ/MG15CTw+LqnDEQDy7M8u5A3dtIH/upX1M5zZmwepRBhUDbxVQ/Xd02f4A7BBzUPx08R5kVbcmTslHafmQNc/tusrpnCTHd1UACcz/VU/s8d70JCDz6bTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qcf7EGdb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qcf7EGdb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf452def93so14447805ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 14:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472176; x=1789076976; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VLMl18om9dONfVtx7yfhL09QdNhcgX5+9Ne7gGEbIFA=;
        b=Qcf7EGdbXtae9sBDvgizXZqMgtC1lH2ALGgqE/WnMrDMWf8vjajE4TOB/5Wu0tHegn
         3Wx9OGNhNScEtaV94C8qPzPvQ5sTGpwICuK6d3ZcyEx/ixJqntqRsxz2vIx3CVoFPKhV
         xT8Nt9ZMYmfXUBURSdqR3v6fI+ZwX9DNdvU+nHhEbLXJpEPOuZpvEZwNB33iDKSigz4s
         D07Ss6wQ6+ZbjhmAwaj3oZU2Pwxen27Vfzf0BIc52kyrGI/4OXyyrvjGiKr9VPhV0AYh
         Jk44fSbLA2Gu5GQdsffBDNB3bivlZAEFv54Z8MHbUHWEt8o7lz2MmQLURLIa5lwkblxg
         kBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472176; x=1789076976;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VLMl18om9dONfVtx7yfhL09QdNhcgX5+9Ne7gGEbIFA=;
        b=EwDO9LgpCFjdW+7d0U6Iy88skDulrmEPNpfANS9yg8ibQK5SXFoLgKfjCv7WECAM7G
         IlrMUN4Ag20QLcCm2UMMKdX8RWVQ+C0EQYOQf6kCRQ7Eh2MENZL28eK2KQ1HiSyxNmV6
         9uUH3U1lo8u4q7TehQWz3oe9g+WeXiA7zvvCyMkNQzAl8QK2MztLA6COax30JFomcNGd
         2DBu/trz5YMSSTwrhhUs3GexJZEB9Rn0zVHkT3/hPh0hIH81RJLp4qklLfNgOcYNxHNG
         jDMKIc1QKv5TMFESbkxYAzkbEkmmrtmpDpKL6XDJanteRJMshduet6SKaQrmB9toz9A2
         3M4g==
X-Gm-Message-State: AFuF++kFrGO82h6GJ3JZSXkny2h5VdDdwOwbIdJZ2BTF9TcHJrfJuJng
	LsahUaSo0S5DPcPemX/zMh50TlQe23ZZG64mdTEkfBbHUg2mkRuxqghwKmPHzw==
X-Gm-Gg: AYBFou3jj+DhxM50hNyVj8WLCg67reg+N6sNyMzuA1a1cX+MtglS6MQ1zKE+WOS6zIR
	/kE+yRVfEAWkLpMZKq3J0tq/1O16eaaQeLNlfuGruLpyF4a+CipZPBg42E80qytWglzBesHFXdM
	bgM1f0KUg1hyDOpdS29mPQPjAT0vCO3Wni3RXA/PcaDEmdovZlAW1EK6jZHo0Q+mLUeXTPS4g4I
	b3pgZn2+WXjYIObfZJy8Pms5yu5uc3fRkADfXCdhcgkJqoUafPT6aITIK9LXhw1r5FCy8VcF59Z
	GOsBjyn3moCsai4OJ3tgLE5uf4sbLl49/BBLlKMcAuAJXuIIz19AX5iR6gCWgqY0yiDJM1A46R0
	HvvtWYw/EREwIPF9oqQjf5zTQAg9dX6Bq9L4txp0IXrFCRU0Tm3z5w9f/TAAJE9L6bjU4IWBkiF
	r7Tc5EebIcEVWvITBeU3h/kVfi0i1ncBoMBSxAkg7IIjiPUb9zR9yFLFi035Gjmh99Z8Qn
X-Received: by 2002:a17:90b:1e41:b0:398:9beb:a2b9 with SMTP id 98e67ed59e1d1-39b087f4d0emr9389935a91.27.1788472175868;
        Thu, 03 Sep 2026 14:49:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.226.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa31b24sm1553481eec.13.2026.09.03.14.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:49:35 -0700 (PDT)
Message-ID: <6a99eb6f.3865fcc3.16a676.e9ca@mx.google.com>
Date: Thu, 03 Sep 2026 14:49:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4438155360951108014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aaron@embeddedts.com
Subject: RE: btattach: Update for glibc 2.42 compatability
In-Reply-To: <20260903182709.473976-2-aaron@embeddedts.com>
References: <20260903182709.473976-2-aaron@embeddedts.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4438155360951108014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157334

---Test result---

Test Summary:
CheckPatch                    FAIL      0.30 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      20.51 seconds
BluezMake                     PASS      607.12 seconds
CheckSmatch                   PASS      313.35 seconds
bluezmakeextell               PASS      102.40 seconds
IncrementalBuild              PASS      605.31 seconds
ScanBuild                     PASS      984.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/1] btattach: Update for glibc 2.42 compatability
WARNING:TYPO_SPELLING: 'compatability' may be misspelled - perhaps 'compatibility'?
#85: 
Subject: [PATCH BlueZ 1/1] btattach: Update for glibc 2.42 compatability
                                                           ^^^^^^^^^^^^^

/github/workspace/src/patch/14788391.patch total: 0 errors, 1 warnings, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14788391.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2487

---
Regards,
Linux Bluetooth


--===============4438155360951108014==--
