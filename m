Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AD156C41
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 May 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754531; cv=none; b=tnnwjxins6+GSPEy2NM6Fn2iqolAPtHNR01xcgkFwVnnHpDSE4+k/XKxzhvBMZJ6D1F8wSTY4VdI/7f0/OeFLWEnzpRaecL4fTlTPXecEesERUBExmQE5Z43LXNtA7lAtAjbwPxCNsmEteCi6bYv8q/ONH/wNvpEtMn76YUaC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754531; c=relaxed/simple;
	bh=AFE2vvB6MafGpVZFY9uqmB4KiVsNd3YQRsxiMp+puts=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cW9EzNnCZYCgbYfGJ6gDIMU9aN7zv1ffK7E0v+hadhZDg+eG2C8yuqIViCXNiNHQqFIefCY0EwnaYj6ersULIiN0avHd8RivhS3+6DKd4QH/3yBu9FZGRl8WpCTj9AQFRKR8mvVX/AeDep8sNQ9pZG357AGZRAo7/KV+YHk3tIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSXFJvGF; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSXFJvGF"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61e0c2b5cd2so15859087b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2024 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714754529; x=1715359329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok1AAsEwen+7lN6ivIx42peH8e8KnVa0k+GQ3lVxQlg=;
        b=hSXFJvGFGdU6wNqRvlPxcmtEJXBIV2WL4GNBtlrVxl4nSBktPOG7WUxO+41bQ3iexd
         ic3nmkrD/umABRY9qfEqVT+/71A3Ph6ZIWbeqJkDV9mgLVynxnBvJ59rXwoArgM0ONff
         BY9OKD1kvoNiWkdRCZHsCCR8w6mvOhmqWVkzwspKegiY+UpwtyxqXrlQ5YEC14oOZ1AZ
         IE+LHCl4L8mpp0Z7RaC3dXG7r1SW0jh6kJ14K43QmGnWTJ/XM3s2OahMrRXb+NdX7Uu4
         ExEuU6IHUicEtPNawbbVahufeZ2nAq5xftvBteDzNntVzfoH6jNtAHGyXHbVMsA9P0xD
         8MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714754529; x=1715359329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ok1AAsEwen+7lN6ivIx42peH8e8KnVa0k+GQ3lVxQlg=;
        b=U1oQ3w675EMW/4Sf0pq5CeS91tBJMU7eQOf2yqnQwWwITsbuf0+CQrnEYAlBRLLO5X
         apPIQT/qX8lTYH29hb4uOzVGHy1eAJtv36e8+mqgFQP0bA3iRp+paPupmx96rfgGD3On
         3ZGVopZTXGIjiWfj7ppgNnGLhtOnm/3x6SQR3YCjvrEsrM/XfGBfR1Hw5v5H+UWVmQ5X
         47OkZFz0eyKbM6CmI8FVV1qLb0AHsR69gYGG7hY8CjktVUdVRGzJUPllDRL0LjRrRz+7
         GrY4m86geCu/Wyskd+vHGzZzJ59FKHpso0ugv02D5wwq/3HbvJ8oJ8E5GgOeS4HdXEtS
         fj7Q==
X-Gm-Message-State: AOJu0YyL1XWEVhY1mJuaSCTz0S+qtgxXj+WIIWwZJx+zI9Qx5yhvWzMv
	IrRkXwKc/IMSvqPiUySkG4O+J1f3kovSgkDDaOSpTHeD+lCKg3wqhDoOzQ==
X-Google-Smtp-Source: AGHT+IG3HU3EYcyMI37Ps9LmXnxzCYrvHavHs7kDQDrSwI/1ga7syxAITp3HPmf+1oE6X5DUuRbTCA==
X-Received: by 2002:a81:dd05:0:b0:61a:db4d:cc1f with SMTP id e5-20020a81dd05000000b0061adb4dcc1fmr4514328ywn.7.1714754529305;
        Fri, 03 May 2024 09:42:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.69])
        by smtp.gmail.com with ESMTPSA id dg17-20020a05690c0fd100b0061adfb01cc2sm724951ywb.90.2024.05.03.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:42:08 -0700 (PDT)
Message-ID: <663513e0.050a0220.55001.31ce@mx.google.com>
Date: Fri, 03 May 2024 09:42:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6814002929436024139=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] gatt-database: Fix error registering characteristic with Handle 0x0000
In-Reply-To: <20240503145238.3771921-1-luiz.dentz@gmail.com>
References: <20240503145238.3771921-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6814002929436024139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850263

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       FAIL      0.46 seconds
BuildEll                      PASS      24.61 seconds
BluezMake                     PASS      1723.27 seconds
MakeCheck                     PASS      13.51 seconds
MakeDistcheck                 PASS      177.39 seconds
CheckValgrind                 PASS      246.78 seconds
CheckSmatch                   PASS      350.84 seconds
bluezmakeextell               PASS      118.94 seconds
IncrementalBuild              PASS      1495.92 seconds
ScanBuild                     PASS      1007.77 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] gatt-database: Fix error registering characteristic with Handle 0x0000

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,v1] gatt-database: Fix error registering characteristic with Handle 0x0000"


---
Regards,
Linux Bluetooth


--===============6814002929436024139==--
