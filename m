Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71427405A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029233; cv=none; b=ibxGKnbhxqbvsK8+OzVz7t0VnFM/qF6ze0DmNY0L3NcmGB8PXVnzIa0Ph5UqKEUtmgH+kT6AbpAGbtuzfhAeVqNf0dLb6/SKddVi0F0V7Uz59k18ON3ZBA0bGzdr6QMZmDNA1sbTxY7fOVSB6O3Q8vNsjgOMIDE4YQufz4MoIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029233; c=relaxed/simple;
	bh=3yKMsl08zspFg2s8VGsAyfHAGgHGtxdVbX53ONbfero=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rCpzOnHExKl582AMk1T4P8/6towN8+o0DFdXK+fhf3txpdSnXg6RlMFwTqs3FIBo533RxpFB8+bLNR6icbgRTQddXVRTiqxrQynX0ED1TqW5AnE80Prlv+U5Z10wBwQ0DaZsTheEnpRi/dVhDuNXFhi76x3SxN0Gpj5pvbKArlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItjSDeTV; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItjSDeTV"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500d08cso822800585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 09:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746029230; x=1746634030; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RkmJfvWvK8LUnCK4gEJIo3ZmNZPa4X6ujZbDGJMQuyc=;
        b=ItjSDeTVQi+JRUs3clbvj1N7pnHNZYJIXFzAUWiSIGnGaJFh704n2t49xJKqNAY72h
         Sj0at4947j61W27dYMP+1TFFSEINcmimwq+eoorBY8gxbFR6HAmKM0N9o+RvK1CoyFRQ
         yVo3Og1PCZ0JGVmllnXkcxs0CyOzvTSBk/ro3BBQOA1z837dJx4VztU1IGj/J5Q0Z6OB
         RC4jstubGwdNSBIIXohXN/fAfflOgXpONEQI7m95wOMELQhfhv61daT9JCewXqCo3ZAa
         LFCge9nunvmsV+kezrRPKugsSc5P0oHSngOJU8mKBPi4S9j2kUIPaE6XVnXi4suQnd8F
         FExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029230; x=1746634030;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkmJfvWvK8LUnCK4gEJIo3ZmNZPa4X6ujZbDGJMQuyc=;
        b=qfcBge3JVV+0wetkLP26qQtAvbgabvvjndi3f3FRH1o1rdKoRBwk2NWpOV6xKJKpDP
         RE5J3Lk5Y1w0BpE0cbnza7U7lSlINKIKzxTFpHsshr0c9YtUtYnv9o1/AhzkVTL1b3yW
         uUSs8UFTW3+o7sFysVkWuTqnyVAjahxvtJiEuWYF0MIXqbVYLZQbxBoN0Vpis6a4Wgeu
         E8dJez3S0V4VDZxEAtESsrhnVoDc7nSo/gQHPBG+IvQgVjcvvWSUpOwy2XRqkToCMxdO
         njYYKHTAmC05T2l2wTaX3h6/m7KpiSbmU2ffI30uWURvihvxprlbJUvIZ/Q5GFhVjvjg
         8yaQ==
X-Gm-Message-State: AOJu0YzfBakuGJuUMS2sGPTptAupRs0r6gjox6Es67l9CXXqb307/m9k
	cvvJsOlXPdcAi9W3oKb5qK6UcZBW0wdJ6xE8+tuN3XIR2PEomW9CSdryQQ==
X-Gm-Gg: ASbGncsgWedR1lINbG0SHu18Zpsmydpr9UnqsNx6XDmLCDM5Hos7NY8Ys4cuO+8PRI2
	u2i0EY6DN5OUzPKWRNUHiDF5NKYVV+8GDvwIxOVNapEjFL0OT3Xb84cPUZyUYJedTbMvL19YtQa
	l57SMrP7zeDiLzOlJ8BXDnUVvr6zRSEWJvsoNnvGyyzD4QKNUXeeHdo0vgSTCgQyqY4ts1jpJjv
	2mny6pFc8QfZPONSJr+Zj04w84qiFoxQjOdKnGXqXylkn6dRITN0sGBsUkPOKjLMqxKpxJ0bZ7B
	OHe7t5Z07CrsS/H8D/8XjdQrS+o3dzzA2nMOleRobHRBl3U=
X-Google-Smtp-Source: AGHT+IGmI0IlURz6H5cGBibZLL1kl0WjN1XTyJPP3NDqVygJYzer2wXJpMODaWRVRjcVZTn/hc7RqQ==
X-Received: by 2002:a05:620a:8089:b0:7c9:35db:8ac3 with SMTP id af79cd13be357-7cac769ccd8mr575545385a.41.1746029230173;
        Wed, 30 Apr 2025 09:07:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d865ddsm869918985a.81.2025.04.30.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:07:09 -0700 (PDT)
Message-ID: <68124aad.e90a0220.1b0b00.d171@mx.google.com>
Date: Wed, 30 Apr 2025 09:07:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7015819668336058189=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] shell: Clarify "mode" variable
In-Reply-To: <20250430144027.2117104-1-hadess@hadess.net>
References: <20250430144027.2117104-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7015819668336058189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958551

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      21.36 seconds
BluezMake                     PASS      2928.53 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      200.83 seconds
CheckValgrind                 PASS      279.43 seconds
CheckSmatch                   WARNING   306.28 seconds
bluezmakeextell               PASS      129.18 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      923.79 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7015819668336058189==--
