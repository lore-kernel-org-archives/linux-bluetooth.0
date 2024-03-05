Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991636127
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650683; cv=none; b=RUqpFd9B+eFOWdzRan/otifiztaahvPBjH0VPLmcT9VFCFgywaJPYHi+t33ufmagBJGvHVSORyAjd3WgNf1BfJx/LsKISY8IrhZRqYFMuS+Zp5jjUoZ34BKkiWXG6B5fV+RReh2jmaeCqNT6/EAcNUV8wjszwENna4vTPkFbKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650683; c=relaxed/simple;
	bh=U0UUO7ZFAp3Eyqz0xpH3U0jn6gxYqFzm7PQnfLjraZM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I3QvbHiWFHt5cxY6aASOHga34ap1qZVXNkGDJpv/a8iCnCP6TKHsWQBtXyKa7MXdOf5IsXMExPtLjXRhGQAteVJ33aojp461fcBv3EG4lf2SJ5GRlhWufR+cD6BK37J4mAGJ+byHU6UsCeEVjzMvCujqJy+dazswpD6HWl9DXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL2H+TeT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL2H+TeT"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78822c7c77dso111969085a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2024 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709650680; x=1710255480; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yQPj10eb86LGXRMLkHyvndt9Wab8msxh+HkFXpuILnc=;
        b=NL2H+TeTFQ91qhyopqr2keTnDubWCTzdcezEcRYFEMrZz/0MiOqgPycyTjoyxalaky
         g7rNzGNUYYMt4uI0BsMct2VM+FJ+McH89WLFmy1NgSMlymKrHRqTOf6HE/03VwTtTwSx
         qKZgu3G+5enrvluSLZ9PnpiGG0ZIcwjffgmdXIGkBbxxjJIcQPj/wmny5yOyN8OlAJLh
         vEsRlTXTsOts2eETNEBQj08YDRbY6ZNzO2TxJLBrSw0UKm4SY3PaSG40VPYHkCP4DlAv
         kB1R3LIxqN2K6cG7/z3BSeDDCjIwf14TfJesXJ93jAK0pdyR3mqhOBGlE+Ib7x5Zdkek
         +a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709650680; x=1710255480;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQPj10eb86LGXRMLkHyvndt9Wab8msxh+HkFXpuILnc=;
        b=QPq5w9uRuPd9CuAr3eIv5neuAcev+/uHZMNtTETxZC4FAQ3kpb3Gj5yWTUrQrFvjz1
         9rxnapXEd5FKyd+UdPS4Q7rjQF0pBw1JMdc/59nE1WF/pKfOJsD7ilV+NDN5UtoXhDrc
         FaGqHxUFlG+BV5JQOF+2OWasn3pqstli1sZHQTfUy/oKVr5iuQIlaqaSk8z2HimKKpW7
         +c7HGoUyjo6Ho5xkrdAngI2LGeI7TI87XOQfjX5OGWXoV1gwjPoVxFNyTe3K0vrGMB83
         O+2s+IQ9nCCNbnuU31Fw+P7GwEI7IO1hGtbPvQH5OVuySTzcielUp60GBScz7KGtoY4U
         vmmw==
X-Gm-Message-State: AOJu0Yx6Gchj88njxkLYIYNzDkFc69+6bnvkuPR+4mSKFQJniC2/+Z2B
	xrhtmPOXFwpipUk7DF2aKoetDXT7l5I9QTdGQ4W7ufbK+uxIkITVaqIkxmCE
X-Google-Smtp-Source: AGHT+IEp8AIcTZncLgD/4nh53xykoC6B42FU7f7PV77hm/HLw4M/ZMBlJYTybDSFSb787Qlo1JBm6Q==
X-Received: by 2002:a05:622a:1494:b0:42e:f445:ad6d with SMTP id t20-20020a05622a149400b0042ef445ad6dmr2419463qtx.36.1709650680279;
        Tue, 05 Mar 2024 06:58:00 -0800 (PST)
Received: from [172.17.0.2] ([20.81.159.25])
        by smtp.gmail.com with ESMTPSA id e5-20020a05622a110500b0042ef7ad5b4dsm1403270qty.53.2024.03.05.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 06:57:59 -0800 (PST)
Message-ID: <65e732f7.050a0220.e79a.7510@mx.google.com>
Date: Tue, 05 Mar 2024 06:57:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0746700128887892215=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: btintel: Define macros for image types
In-Reply-To: <20240305144459.119564-1-kiran.k@intel.com>
References: <20240305144459.119564-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0746700128887892215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832561

---Test result---

Test Summary:
CheckPatch                    FAIL      1.91 seconds
GitLint                       FAIL      0.85 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      27.66 seconds
CheckAllWarning               PASS      30.39 seconds
CheckSparse                   PASS      35.88 seconds
CheckSmatch                   PASS      98.13 seconds
BuildKernel32                 PASS      26.83 seconds
TestRunnerSetup               PASS      495.42 seconds
TestRunner_l2cap-tester       PASS      19.98 seconds
TestRunner_iso-tester         PASS      30.26 seconds
TestRunner_bnep-tester        PASS      4.80 seconds
TestRunner_mgmt-tester        PASS      113.15 seconds
TestRunner_rfcomm-tester      PASS      7.34 seconds
TestRunner_sco-tester         PASS      14.98 seconds
TestRunner_ioctl-tester       PASS      7.76 seconds
TestRunner_mesh-tester        PASS      5.85 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      32.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,2/2] Bluetooth: btintel: Add support for downloading intermediate loader
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#80: 
Intermediate bootloader (IML) image. IML gives flexibility to fix issues as its

total: 0 errors, 1 warnings, 69 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13582504.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,2/2] Bluetooth: btintel: Add support for downloading intermediate loader

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
24: B1 Line exceeds max length (81>80): "[13.458075] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590"


---
Regards,
Linux Bluetooth


--===============0746700128887892215==--
