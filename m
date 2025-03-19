Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD7253B4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384207; cv=none; b=tLWQaz3sFo3j4TNzGx0QmALpXgfXkk435dd1bSyk6WfFqkJpMFPpSjh2ajyXljRKafy3QbHO6R1gAnJozi7us9bB8qayoRmd+l7FNQVwkbxMkgC1YXeS6gZ6UecvJlP2zDcdLxQXJe+ChpANtlfjLxRUYLj9qd//ZY7banXfFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384207; c=relaxed/simple;
	bh=YZnhUHzN0cZiYwzwjnYiceUizApQDS6+ZQVAXLUTBlk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=a/6cEug8cpbI0QpN1ti01NVCYSbGg1iF0o4tnArp3+UNpEhZuDiaRx0ZIWTp8nPxPrjGM84kp5jvLr9ETsZRqw8VLhufCLTbRznN42SXrydtwVOO96qt8OzkrGvi9Wpri+sWe4JRy4jvbrB4n7BV+mRn+wDGaXhj+pFtuFmTDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7I0rfHq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7I0rfHq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225477548e1so117949165ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742384205; x=1742989005; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6Jow+4MtyYWM5e/hL5erHWLLe9Iz22RI3j5xUf38SmU=;
        b=K7I0rfHqef3xvuPUZJr8cswsfgZ2jb7+GII7IpTxjKMSiW/HqqGnf+4UBg/oOLkBL6
         tu9heIKqIrD/LDt8IWK16y0a9reIDOpkKiko2HmUPdRSVzyoKd22FsgIWewDrGnJIDNX
         Tr0GgZTOszxLENgH1k+zz4K2eyv4OvXCSeHN5gvoI3qeBL6GF/IBdpdPVcX3SUwjQXgN
         vgZMY7HM7m3IPOvOLVkI8EeN8ZTuPbK0THFPIhoMJT9BwXE3HVfvwF11zvFN9ZpLzfVd
         MnhEQmyOWkwnfLz7ZYqOOsDEVt5qiBShw0SDW8eW4RQy/DPn7lLLOfSXlcGJ/mhdzkU3
         XgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384205; x=1742989005;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Jow+4MtyYWM5e/hL5erHWLLe9Iz22RI3j5xUf38SmU=;
        b=fKApNupVjAe9IR9Xk8IV5NA5B/mVr4fBsyO1MXfxcoC45SCQVTb9s/tVpGl+Nodykj
         w09uxJwnp5RLPsd4QlR270oE5fw1n5XiweAIv+B/6a7tQkBKVgM4GWSBsBWTtbVMO5QU
         VQ4Gk0xBAt53KM+UFgLqdOhj6IwQH/skZkZ8w11ytddCw6E4Pt/WOQBnUNqeCODybfyi
         HBoNKW16CbKnTohXVlJZua7UuCV1sDHIjxbVKZEUyLvZmcG4uGUlU+pJNXFzB7JcwdJR
         PyDFunUrQ/99HeLQLyl4p70LRBMK6gCkxziaUV2+igevODpQcmJcdYJWhXBRDoghKeP1
         95HA==
X-Gm-Message-State: AOJu0YxCSG+x/TNHMrqAhV6Gvaha4YH4/KvMranjWwgTiBZ4g59CQ+zR
	yQTWPtQ5CNgduWonm3UuEFUYHQP7QcRA/yDW5gfBDhsW8o2BBXBnw47tfw==
X-Gm-Gg: ASbGncsMfFYSSfE1TJDHdyonOYSKOMSBV0qDLY/T0D2ojwWHVkoPT8T6qIyjoqPwRc5
	e3/fxxwvuuMskwxHkppPnJ7ExnmBltNbDU88LTo+UjCLfXkmPCr/e/XJhtSy41+ZhpQ3aHjOjc3
	+fn3IEooCVI2mHQXelkWMWSzP6jQ63EQSQJy/hrd+70PyctkLg9fQAxsOg5uGoaLWl7QHdeiCcI
	PjEHSw3a3SaIWCc2HyhHq9m6Te2O97dUWnkUfu3hQ27h7rUlTMJpd+EENVfIMBnHxUutg8C3LgU
	GH/bWZ9ZIILJhcBwrPodQPvN7liRiTuLVyMpWNgSQuegDW5vzSY=
X-Google-Smtp-Source: AGHT+IEOdK7H1bvntIm+z7XqrnmiKJAui2bQpk+2NHtk9jGRjYy7ukmimqNPmR98IIs2cHjaAr1U/g==
X-Received: by 2002:a05:6a00:298d:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-7376d6d1349mr3880148b3a.16.1742384205070;
        Wed, 19 Mar 2025 04:36:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.99.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152b5c7sm11766960b3a.13.2025.03.19.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:36:44 -0700 (PDT)
Message-ID: <67daac4c.050a0220.75983.e4da@mx.google.com>
Date: Wed, 19 Mar 2025 04:36:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5271139070789324572=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,1/5] tools: iso-tester: add inclusion of time.h
In-Reply-To: <20250319103724.10433-1-ceggers@arri.de>
References: <20250319103724.10433-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5271139070789324572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945530

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      1506.66 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      157.32 seconds
CheckValgrind                 PASS      212.85 seconds
CheckSmatch                   WARNING   282.90 seconds
bluezmakeextell               PASS      97.90 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     WARNING   866.83 seconds

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
mesh/mesh-io-mgmt.c:524:67: warning: Variable length array is used.src/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:313:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:

##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
1 warning generated.
tools/gatt-service.c:294:2: warning: 2nd function call argument is an uninitialized value
tools/btgatt-server.c:1212:2: warning: Value stored to 'argv' is never read
        chr_write(chr, value, len);
        argv -= optind;
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
        ^       ~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5271139070789324572==--
