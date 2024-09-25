Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C8414B07E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259106; cv=none; b=UHDGnt3VG7ek9YS22XApURWGpKkSpLEaGm7hp+HMAEuNKKhxzZuO/+m4SLbIK44gEFMzPp0N5F7oetTc2X+2oIZSu8vwr5FkpAvPMze1tbWJyI8f0tZmKDVXIxPHnPCKoa+DWDdTRT0AlwcRr479h33E/hxoVagArHOvLFnhGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259106; c=relaxed/simple;
	bh=77R0QdkP3JlcxS/K/vc8eV3t9fPMWRlVj7zrs7ijmnQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k1qsDk0GvqefyaZ8LxJkC0YK+zBhz2aYi/dGYbNlyWlEj20MgcSUobDj1KuKmYSem0zel3tF5Q+gPZavr8UWH2xPWav2yvL72tFPNfGI5cFoxu6DAp4zTBrHdBjUc3lI0dSv8DMPEW2bLvLJUPcgQqhjFoZsesGzYbyC0Bfc/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km8hX0mi; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km8hX0mi"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1d2cf4cbf1so5919534276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Sep 2024 03:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259103; x=1727863903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sNsneTvTMamXybV8EXl6ZUn9Z7beMPsweAJmMvCqW0Q=;
        b=km8hX0miPHbUruwK64lS8A8fabqx4uBBwoTvPpM7+dcc1P2SnwJS+QM0HOeg5L4Lbg
         /KQH8I6B+zwyVxehIz6QD0XtHYv4j1IO+RNrCGC22uQBcjJmCgXVFnilJ8kVcCtf3XU8
         bD/ELa6YkAjHQnjInfLnejTxUN00anpKHz4Sb7YfWBeyopz1haqwlSNd7sSlv1CTtGoY
         PooclKq19XGGGO0X3xZzOi1gqwuRKi8LFu25f4NQt2VekiRlVzWRJPbFcLSZ/pRVx9dS
         eL1N1Lzoun4uxWUMfKWmzL9tT12ygctNXMjR58fY0UFPD9QCGOxdzwF1NGCYAax/E4KR
         6Ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259103; x=1727863903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNsneTvTMamXybV8EXl6ZUn9Z7beMPsweAJmMvCqW0Q=;
        b=fOMiyrVDbIh4SuN7PjUZ5BWmmjK8CIjscQE5Qw+kplAIDRL094SLcIUGdHOniCwCEo
         E/6P8zDKvOVpm/Q/1K7RbVLO20GpnxTIbZLxJ6Q6bssHdcmumTd0ChF3WopfOWGTAe2P
         Nxr6NWpobkp4IlVDu6UrxI8sliEnMMfnBFwT3p90D0PbfZGNwtdeEsbDOgujS5lcSnf2
         zkLgV11EZDCLF8gm5gZ5D9UUyHfpDZSDghON18UGuNKJb+t7hIXCSHuGrH6R2zOzNfot
         NKraTm6Ly2wz5tEEWAabz9OikIRRswLNQ6Q3/EzTox2z6JP1m2w6NOoM7xN1iXUcR9kV
         Illg==
X-Gm-Message-State: AOJu0YzVkDaNdsP7/IWjOD1SM0fIBQ1v/2s1H6PRlPYWnjup8N8IEv/V
	QejthzV1fcgrQ73GK31KSWGD3yJ/1wiKOPgHXt9ncfm64BYhGFyqfsuilA==
X-Google-Smtp-Source: AGHT+IHDcboMf3o62kGEUtXVY71xLeu3vEEQTk0/Z7Mp9/5ryVjSqRmI58Z2QrqOg+S6yXq3o8k7aA==
X-Received: by 2002:a05:6902:2684:b0:e20:2b46:7682 with SMTP id 3f1490d57ef6-e24d7824507mr1236455276.1.1727259103264;
        Wed, 25 Sep 2024 03:11:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b52572710sm14743831cf.22.2024.09.25.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:11:42 -0700 (PDT)
Message-ID: <66f3e1de.c80a0220.da2b4.687c@mx.google.com>
Date: Wed, 25 Sep 2024 03:11:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1412340711006623206=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v2] device: Remove device after all bearers are disconnected
In-Reply-To: <20240925082750.1516282-1-quic_chejiang@quicinc.com>
References: <20240925082750.1516282-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1412340711006623206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=892705

---Test result---

Test Summary:
CheckPatch                    FAIL      0.66 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.80 seconds
BluezMake                     PASS      1673.81 seconds
MakeCheck                     PASS      13.45 seconds
MakeDistcheck                 PASS      178.92 seconds
CheckValgrind                 PASS      249.18 seconds
CheckSmatch                   PASS      350.04 seconds
bluezmakeextell               PASS      118.20 seconds
IncrementalBuild              PASS      1504.34 seconds
ScanBuild                     PASS      1044.85 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2] device: Remove device after all bearers are disconnected
WARNING:BLOCK_COMMENT_STYLE: Block comments should align the * on each line
#115: FILE: src/device.c:3501:
+			 * be handled after all bearers are disconnects.
+			*/

/github/workspace/src/src/13811785.patch total: 0 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13811785.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1412340711006623206==--
