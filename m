Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904D373C1A
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446800; cv=none; b=HEl4hwYlmBwAem1s751dTgrYS4Tiax+Z8ZtEAGOI2cYbKoMiZ1Sdt9rwp23LClRGsSIHHX/2dyMY/yEw5E3axyj4JgO/xvOVZtKVl6gjsfe+y4VBFjtLzl33QGVRIn50zniODUJvUVfQ0WzKpwJRcc+3g6CuOe2AJRiMgKfZzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446800; c=relaxed/simple;
	bh=DZOyGj03+IBDFhaN2E01mvx3fCwcMGIpj5ZgskvadVc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rIndkNixsZYKXR0Hu9LdfixrVs+bYT7uErAawY8ciQkrlf6bjgo3Lf8UBA2Sjvrh0nFV13CUmp3gzWrGpxuQQ9MH7ccGO5r2/wAg2ZneEYAMxRwFyzXgKC294UJw5H0/Z/patWZrGaITkJeuxjJ4PYxug8rw8VZjnaFJKC29MJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaPksLwH; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaPksLwH"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-535853983f0so9394151cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446798; x=1792051598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EjEPpmZCx6ZM1s6Xsq/g2HMdVbg13ycgxPIxyzQEH0Q=;
        b=IaPksLwHr5ikSKjrzRlkbA661PmpqDEBbQsLmJ/YVu/c3WEegqfagomddzb81l/Dr2
         9cLnE70mj3h56CmL/35+dguDhxPDrBlKo0/FBvFRewsBhOoUq6pc6hsTYQO4OcRinf0x
         ifUvrdcZTjoe6hXZpt7pan1hdoDmGYdqO9QFvy9XsLLPDmifj1NRc+DIt+ntwEb19HLR
         nGIbRqw8E5SjcoTDKOkNGsV7xst3+jAY/BtaucFZ9SMiiqtFwUJUMi/nOulXUGEpMWCm
         dQ3ajjMHX7l8Flw8id3YLIeMmVTWdRsxLgZfpOZtYWVtXxihN/HJCOw80bo/r3ylgoxc
         G68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446798; x=1792051598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjEPpmZCx6ZM1s6Xsq/g2HMdVbg13ycgxPIxyzQEH0Q=;
        b=ycAlQD+x7xhKv+9G4tqkn5Y/JUkAwwAy+kXWTFbF/otomU7591hqkUCbrRdlFWEtNT
         8hRCaeKW5tTWfvp/BzXtBFSpeJmoVlYNcHCy7NXPQCMRmJXHd1zHEqTVL2YOrWuuC0MW
         0NRq4VAExSkNSbS486KY6PnhymIKifTSl5odKuSsHCuKImdjNARpygPb4SEcFz4XKuY2
         HnyOYZrHwY26MQqYrFIA4p+kHOTsVcsXHQ69WK2d/xrl52dWJ3LckH/CZSWm5sYcNOnp
         /nepHW8JU1F3pghUT6G7o7x15VpKAroeXqV+DngVIIfxJZ0Usu8GrOyu6qwvh3EhZ1Y3
         nmvg==
X-Gm-Message-State: AFuF++koRrKDxrtZqoueqiB02k1hDEQEF0AzIutFT0WbDXWqHCDzkpb1
	GonIbLIMmwo5hYJMEp8Fa3yQbA44eVnUaC4BAX5/9IJLTi3EB4x7Z4o7RHn+4w==
X-Gm-Gg: AYBFou1bkV8ZgmTvQ8E0LwzEFL+43c5qmdiOhokVqObMJ1N2MCUApr29LJFH9ssff54
	60x+7HaM+iCb8MwN02BxqzbuhKv21mKQJnotRWuE7mc2/GfQax+Ipj/DYqw88tMtrm96RPXDLTo
	A41am1UEfBvonr64ui3k2q2QYgQDbQ40xXpNJcEXsTrYucHd6Udij5VB/95nPM4HMKYHzWOWGvB
	Q0REjbIZozRKUOSQ4KTj7N0iRR9W0xlPGJmdlVY2yvL3HwHofpeHuwSkhLa+3kiBCjbOMi4YMgi
	LiADhiJRKd5MXjZ/ugxq9+Vc9OWiDhpHfE375kyeQZxbtBIutwfD8rjbcEA0vVYcxcYFH0yBnXR
	3c7T2UA3qDMpyeq+YXM3y99PRThxOsOjD7ypiedWN6om4UuWEil4RkHjtN5k3fHSPggeZdfeCxf
	Zb0GKASw2j5kYlzvkPpDZxRjk3mUOOa34s/pMutCmpHqDshtWGOrAw127aS/fcRNXeeBIkP6opd
	8Ya
X-Received: by 2002:ac8:570d:0:b0:535:2e3b:6885 with SMTP id d75a77b69052e-5357560d7eamr86553811cf.48.1791446797654;
        Thu, 08 Oct 2026 01:06:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.38.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53571f18656sm39132381cf.4.2026.10.08.01.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:06:37 -0700 (PDT)
Message-ID: <6ac74f0d.3c73b1f2.8bbc5.db34@mx.google.com>
Date: Thu, 08 Oct 2026 01:06:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5003254649641551364=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: L2CAP: Hold the listener while notifying child teardown
In-Reply-To: <pm-bluetooth-objects-candidate-0072-v4-c08f7303b91238d86930@gmail.com>
References: <pm-bluetooth-objects-candidate-0072-v4-c08f7303b91238d86930@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5003254649641551364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181247/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
VerifyFixes                   PASS      0.42 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      30.34 seconds
CheckAllWarning               PASS      34.30 seconds
CheckSparse                   PASS      36.86 seconds
BuildKernel32                 PASS      30.29 seconds
CheckKernelLLVM               PASS      36.83 seconds
TestRunnerSetup               PASS      796.05 seconds
TestRunner_l2cap-tester       PASS      12.60 seconds
IncrementalBuild              PASS      29.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Hold the listener while notifying child teardown
WARNING: The commit message has 'Call Trace:', perhaps it also needs a 'Fixes:' tag?

total: 0 errors, 1 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14873379.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/880

---
Regards,
Linux Bluetooth


--===============5003254649641551364==--
