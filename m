Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6C2107
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916236; cv=none; b=MlOIPHPRUMabGdH5fzkQ3VsWiL+fRuLlNLnwMhYAs/uivJQjgXemzMzQhy/XBfqVwWbbNsgrs0DTDfPH0qhdC8Buu+NtfKlQ7JQI7gteAyqyzmIGmfgCC1sIv7osPgshg0IIDHf/CQpqhmLqXpSxcAwZTyp678BK0s4gQbFBrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916236; c=relaxed/simple;
	bh=PJiH8JtR3ZGDB1LC1123cMBjVwDuCSzfS3F1lOaHPIE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EYDWSZLAtlC8FpmMvOqUjMO28b7FBY+p1cdIR0JqMZwgTr5MXO2ws4np9bpi89QhwPUmXhZ4E1tE+4aYQ0hT9TVSXlhonDZnGLa4GgM/2O5CKtdbyf529pc0ruBOpOGnVPVZVzR431dmnyA/DV84xge+3szxvxRVOSvCUzFws1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhmvRehb; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhmvRehb"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c1a2f7e1d2so577385b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709916233; x=1710521033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EoMg1WBri1Dfnel8N1t5/duP08N3bnfoqxF25/+4QgQ=;
        b=RhmvRehbvD1rDusxdLYnp+Zm+GuLpZvzpA7u0PCrJPZIE/IOlpw9qS+OYELenWcJNB
         2FwiKs9+gsOUNBt+HrYHsKlMo7qQ73tyCygU9LOuzTIEqBoIWTFiySDM2PZcqabk9B2a
         buaqkeSicA2lBjNL26GFyzzV3VdHewOGmlhNsSvbNMhoPB02qzoKx5sEuVSKNOXlMBe+
         VzEF6VKEE6YvOhhmVN7f0/A6KbrL07/5/3jKR4lkkzc5LPGqycxbNmr28VogsgOaZx1O
         PN2+f/igbjqrNHCeFhDGL+fIlRJdP17n3eAxM0NWS6KmJCmozn3PYFUr9LY34Y8WQ+i9
         iSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916233; x=1710521033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoMg1WBri1Dfnel8N1t5/duP08N3bnfoqxF25/+4QgQ=;
        b=w092Gl8rfcYKs0OKeNHE0GYArafIxxdNfRWBskBSUsvzXpwBNG5yCsbozH2MJ6e1GC
         vMDCLTlbZtBvEVr7K5pxN/sbUdIAJ2kVHrgKycCc+1eSNaCxRdu2QrgecKxGc8ryXqEb
         h17jw3ENhxLb6CLeCXE6KbUEYNOn0dI8XMCuPtMOcN2z19EVNEB6kbSFGylHVgrs/qS/
         GW1LNUzLUXIkYtXAqkq6ZMvWR5cTzhZsrzTr+hdRhYKf1/DAy1pO3q3FNLzu4SjhYPji
         QCFJLNcrT9o+RzwAejrEn4bEFZaR8vc0XGRePASSRMSqHUdfEnkGzpCSr2yhP3Vju86h
         Qu0A==
X-Gm-Message-State: AOJu0YxPJz2WqlRu+ax+RiYOj86FGWlPUUoogvlCRvBsqT50Op5Y34jI
	RSY5rVvnTIEBcSewG/yCGTKhYMWxEZt8nGSE8a9C867u50CLW3ivWY4A8aIY
X-Google-Smtp-Source: AGHT+IEabGpZcB+eXpulZWoFXV0ToyZCPV3aK/fUDg83MHZY7ftLrGVEskzEYosymOwdiIpQFX5KoA==
X-Received: by 2002:a05:6808:150:b0:3c2:c82:904f with SMTP id h16-20020a056808015000b003c20c82904fmr10523023oie.58.1709916233464;
        Fri, 08 Mar 2024 08:43:53 -0800 (PST)
Received: from [172.17.0.2] ([172.183.147.198])
        by smtp.gmail.com with ESMTPSA id t10-20020a05622a148a00b0042ef6645bfesm4864772qtx.44.2024.03.08.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 08:43:53 -0800 (PST)
Message-ID: <65eb4049.050a0220.b0e71.849d@mx.google.com>
Date: Fri, 08 Mar 2024 08:43:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1636219298653015242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ayaanmirza.788@gmail.com
Subject: RE: Bluetooth: bfusb: Updated code to follow style guide
In-Reply-To: <20240308162037.100226-1-ayaanmirza.788@gmail.com>
References: <20240308162037.100226-1-ayaanmirza.788@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1636219298653015242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833841

---Test result---

Test Summary:
CheckPatch                    FAIL      0.89 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.03 seconds
CheckAllWarning               PASS      29.71 seconds
CheckSparse                   PASS      34.77 seconds
CheckSmatch                   PASS      96.15 seconds
BuildKernel32                 PASS      26.14 seconds
TestRunnerSetup               PASS      492.94 seconds
TestRunner_l2cap-tester       PASS      17.63 seconds
TestRunner_iso-tester         PASS      29.65 seconds
TestRunner_bnep-tester        PASS      4.62 seconds
TestRunner_mgmt-tester        PASS      105.66 seconds
TestRunner_rfcomm-tester      PASS      7.06 seconds
TestRunner_sco-tester         PASS      14.70 seconds
TestRunner_ioctl-tester       PASS      7.52 seconds
TestRunner_mesh-tester        PASS      5.61 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      4.76 seconds
IncrementalBuild              PASS      25.17 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: bfusb: Updated code to follow style guide
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#93: 
Added indendations, removed trailing spaces, added empty lines after declaration.

total: 0 errors, 1 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13587034.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: bfusb: Updated code to follow style guide

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B1 Line exceeds max length (81>80): "Added indendations, removed trailing spaces, added empty lines after declaration."


---
Regards,
Linux Bluetooth


--===============1636219298653015242==--
