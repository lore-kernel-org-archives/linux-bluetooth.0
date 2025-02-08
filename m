Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E7246351
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Feb 2025 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739020870; cv=none; b=g1G5gR0I/xAM9Ag6rLWp25bDfTSgDsc8ep7K99dCRMCGpfSOgrvISSQwCnmEgqYy2LAUW71k9UnwIbnUxeAF2gDCFT5iYQUj9tLd024EEpFp1diKI0tVx5JM2GX3hd3u5BYO0RPtw+lUzTs15ltXlwU9wONMXHwndnAs2bR7ZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739020870; c=relaxed/simple;
	bh=YJtHh9IuIq+y6hfSGhNqabh2g7dD3reVhbbygDJknWk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QSMT8el8aK/C440QDMBhiuWUxFmAaJntaagwsdOs271KtdqhxhIgCl28P8hPCnFE2XalrxXK9XBLfV243LeQb1Pkl2C/Nq5Z5zQR4aGw/rySORHhsnIwZz6DV8FIoTivWEhKbX6EzOfO4LP/kMEnohY7CajtXXkLKzsllKQRziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+O4cUGr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+O4cUGr"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e436c59113so26866666d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Feb 2025 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739020867; x=1739625667; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3d45dWRBrcIut8ePe95gKK6LCD37beowerKvUiLvpg=;
        b=g+O4cUGrqVj3BKG/irEWsD8ommWsp64Y+uMnZAyjHnJX21Zs0+q+eStQWwRj3QIbwU
         rPXysRIGGZBYcWVH7vtmKRoDfw0GNYDa3PUhnOlU3a53JmZgv8hNqo4+QC4VNBfyixaf
         rMxTaFm7357kkOjMLSs1WpfqPDkh/Ofq3Nw93g2fXt8Xokz0FS5s4nsIzPSV2W21w41v
         rCdxylPDI79PeAYG1fF88FZLtsLh+r5Fk+rXWfOp2wOL9WRCPi0v7LmpYUe5ZvDRnhU/
         WHhfeUviyDyVtg7SMyuJ53t9fAta8zYxmSBXy+hLRQBxazP5BVjxSDYPHctdY7ElqM6b
         SjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739020867; x=1739625667;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3d45dWRBrcIut8ePe95gKK6LCD37beowerKvUiLvpg=;
        b=QSdyLKvbcEnEkcWnnEQdStHRDPxx6HDJ9R6b0xzI/2Bn+YuVZpcULP7+SJCZofj1Mf
         kFUlqNo2rPzuQ0i3JwCzUM60X6eL/P9c01VZUlJtEvqZK4B1pkhsDEcdsMei2tEXVNeq
         kVcDPaPYq8mWKoasx3oNWNFMJJM9jhGah55EteSCV2jkmR8k6VTV1v1mXbK5UeZ5wDIM
         3Qv8pdO5V/e50lveLKKPUsrK23uQIGY7rzvGb/wplPfNnm6KXmG9aDbRpWQ/BIdH+ty0
         ddILrhUC8B+HwmBBAw3eJ/PwUshJOcHYjYGTPowuURho/UZrFofzpc3dQAxG+5Hctmye
         5RSA==
X-Gm-Message-State: AOJu0YyFeWpjzf3anCwNlBXXebaerlurlHk4X6D7nk8jrNXFyPbftS2R
	x+iCzCNvTJFNeyUzNVWEd/kOO5E32VnrBRrQ2HBiUaVLhB942ttadEwPWQ==
X-Gm-Gg: ASbGnctFnm+jcl665tTM8lVaoYQ1MmwQzi9ntm4bqPtqPf9ZLezX6aFxCNQrBHol6gy
	WeSpY8cqqz/gYu+MPSd6K71O9jVP9+sXMG8YZBe7q9hHTUoimYfyq1bHxJCOUfs42uBPsLX6p6n
	4y9AnsETSPFBqEvOZtE3oFDniWYLGSefeE1YOZZpvOsrcZ1ScDgynKQd2rIZuyvdqy1w5uIckZQ
	7m0Ni0NgyP4DfoKCLgju7f4aftERdRuEj5SIelFCuxP7CMkzmT8phlPQl/X+f7eSdoQ13KOruze
	Ob21LXzaqrpAwaZPix4=
X-Google-Smtp-Source: AGHT+IFYf93fNqXvTZzj+myLkXN+PfNXxvEFlBv6e6UsjBiA0zvOVi+WAwRAvHd8F+xpt+GfkeEXDQ==
X-Received: by 2002:a05:6214:cc9:b0:6e1:f40c:b558 with SMTP id 6a1803df08f44-6e445768bd6mr89853066d6.44.1739020866777;
        Sat, 08 Feb 2025 05:21:06 -0800 (PST)
Received: from [172.17.0.2] ([20.42.48.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e451a83cbcsm6455966d6.102.2025.02.08.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 05:21:06 -0800 (PST)
Message-ID: <67a75a42.d40a0220.16e86.1df6@mx.google.com>
Date: Sat, 08 Feb 2025 05:21:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7137391169756841692=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+yang.li.amlogic.com@kernel.org
Subject: RE: [BlueZ,bluez] client: Set the feature when initializing the client
In-Reply-To: <20250208-client_eatt-v1-1-17932786b2cf@amlogic.com>
References: <20250208-client_eatt-v1-1-17932786b2cf@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7137391169756841692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931887

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      1500.00 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      155.66 seconds
CheckValgrind                 PASS      211.75 seconds
CheckSmatch                   PASS      281.19 seconds
bluezmakeextell               PASS      97.08 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      846.86 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7137391169756841692==--
