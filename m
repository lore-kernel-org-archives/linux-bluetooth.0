Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C972223316
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707142; cv=none; b=pvvTr1oHJRj+VcWegv7EOp01A6XJvZCrAWExYODLragr4/aRKScZX1zY2REkuzUJQYdEvuGNJnw4yp2yyVAJOvdTW4iKOB+WIG4MHIoqexX7nKm4HvRSTcg4IrOmfT0odhg1rlVaxqXU3FrYDH1N0/fkDS8HJGMVz4pLWvQ2kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707142; c=relaxed/simple;
	bh=r+DglhfiDM/5yklwjhC+HbaVxNGQiwoYi5NOIVpxBsQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MEV+BEyf8++eH78s8Q9fcJ22MEoHBBsxb2QupICAo8pT7yga1ZUPLHjC1GUzLXbOHS1KOm6dggGxDuEyJc93J8qA/jdchFC5DNDXwSMnAOSpa5oHxHCD7qms21JzzlH81CcOy20EJx6J3kiJb+eYqj0YkqhJIyfEwo4UETtibPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkrBr1ap; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkrBr1ap"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so2116505b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757707140; x=1758311940; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8vddY7wVWGzuMgWIRC6Zl+0WgQKyIe2w75urQ3QQ+0w=;
        b=MkrBr1apLI4pYG+S1wNmWZ/W7PYVtRrOo9pXlZnY81XZGEP394hZgBIHBuJ0EkLTLa
         V3AAxqgfUWva1Y8osb6Fwnv1ba01VRTHm9lE9eqBNWXSiJI092I8t7J+/ts0IkF4rjIX
         Tegozja1zx+cN52V7LZnmge0tvID+KKZ+xbJShu6AlUmb4N8HzGLIETXsP9bq3NCHJeC
         UL36dSQJUIuworhXSfZLCdIpaPiw3it5N8ryV6vidcTcUYDN7jp2IEJiWU6E/Qs+cwtA
         ukKbadKw/mbOGnh+8TcMTdXoV1mssYN08FX9+Kmo304O5ckFVCF8RBclGF8Rs3qseFjo
         NSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757707140; x=1758311940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vddY7wVWGzuMgWIRC6Zl+0WgQKyIe2w75urQ3QQ+0w=;
        b=JeaCML0ym9kUw98MfAdmT43pOzrUAbvlc4WI10lumH4348NXsdDAWAlbQBNzQp55X3
         BeC+MmZv3ps94QOH8e/snTL+CYaXegqL9zxpTRoudOh9qQ9C62rSfNvsYi8QPD8MDBUU
         FwtcupRTgjZ4BCU4qk+vo5RQbUqLhJNEkYD+8XVD9TfXe8VVClrWCsTuQ9/6mds7KX8F
         bfzDClTQAZk+DkCm/7bBDzF4voCJICnqZg0Oj4zh1TXnd8dhethetuQKNVOfipXiLVUw
         3Se/xSxTn4UADGoR3Om73MQgDaorrtGqy30PtrRvtEKxsn+n9ipQknGG2Ld2bUWfx8LX
         8IRw==
X-Gm-Message-State: AOJu0YyuddHG4NGb/s7rlTb7J1fC02WjzM4ofFvAHAjd+fNvzwALFClE
	LCCpAvi50nEJZxOW9qizD9a/frM5DEdcYb4OHmDXDrMIRaZp01bhU/trg8WL+g==
X-Gm-Gg: ASbGnctaDrUjfNqTEZ5GRHFzISLe4DKsUeJYoLO6oYmrqreGf7kIV0Jjc17wls7gTIL
	BeCniki12Py+c927sAa19AABWkmmLguvFdZbLHH6MwWMCqDY/HBA2iMYEGibFCealn8EavEwHRq
	1ygH8CmwTDH6QfKrzNTm2AohUv7GeE6pePt9y7jA+9BhOtuCylwQSZ11F9sLgcUGeEL4VwJmJEX
	ZtAtex/0F9SjlFzy+Tz0mkhBQCFSmT7vOtO6zSYZvHHdK0tTHl7UOVQtg7DsbJOZrwY4bW7Nken
	FGfNBlEfHqSjRosLmHdt2F5q5yms3Ov54x33kvnoF6sBtGdXtoY+9wDJJ7Yk+tD6//fEXFHiYGK
	pSRtd4TorlpfB7UA/qtDMFdqO1rM=
X-Google-Smtp-Source: AGHT+IGta/Gitut0MISYJVNy7vDv7qEzO2xCFmJdsspPOFleffzSqFMiFGdj24b1nXlyLoIAWIunqA==
X-Received: by 2002:a05:6a00:2e1f:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-7761218f11emr4807540b3a.19.1757707140263;
        Fri, 12 Sep 2025 12:59:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.233.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7762c225d2asm10291b3a.65.2025.09.12.12.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:58:59 -0700 (PDT)
Message-ID: <68c47b83.050a0220.1514cc.00f0@mx.google.com>
Date: Fri, 12 Sep 2025 12:58:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6691432807123988056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alex@studer.dev
Subject: RE: [BlueZ] profiles/audio/a2dp: Clear suspend timer on A2DP stream free
In-Reply-To: <20250912182033.1260032-2-alex@studer.dev>
References: <20250912182033.1260032-2-alex@studer.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6691432807123988056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001921

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      2528.19 seconds
MakeCheck                     PASS      23.40 seconds
MakeDistcheck                 PASS      184.26 seconds
CheckValgrind                 PASS      235.56 seconds
CheckSmatch                   PASS      307.41 seconds
bluezmakeextell               PASS      127.93 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      917.66 seconds

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


--===============6691432807123988056==--
