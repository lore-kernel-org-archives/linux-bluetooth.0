Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CDB1422D9
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988642; cv=none; b=t8F4CiJ0BsT/2dMuBKqxjvYAQdWIddIp68XVD9avrLN2vRQafGoOn6OmjEF5EJ0Tlbo/g3GnXnoWHUWoU+ZhsIAWFEAnJO0bL8+WqvRw5sTRYN/2oO22IbNulvZgDi6vOBr3ATE+xk4pzSYjxk8LpwH8iEtzV4bp4XONWD6VZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988642; c=relaxed/simple;
	bh=pdtb08AWXvOSDMJtN5nFihyWXYJ+ibN3jb5HRAInDzY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ei5DXlbthu8e6V2G8irCCDvgqj/v0Sg7eVBKmMlYFwIdL0tK8RoP0HYybkTUdBR88Luu/NcrUPUP5b2i5TGFKwz0Wx61oEpem/tR3EjFvcAmzVDERG3YVkoH1mLrWPlV2hC14u1+5q9IyGHWDhzze0pXPX6PAonUxIiECowzvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQkUOPoo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQkUOPoo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78ef9ce897bso146500185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988640; x=1715593440; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BNFn3o4ig3m1wlIQ2tcvvd+Ebk+ma1EouhZcZk52cOU=;
        b=gQkUOPooDgvogwqKpvEBPXz1CtqxOv2nZgNgt8X8we6ucaAtWxAGOnQ8NdzL6P63Fe
         3E5+nxVsS8nF5PSSIa3be4kHhu/5izQmjNGq30OOiPU6dgcfvM5/cnsCa2l799QhCuXU
         AfMu+tY09/QLM13lSQQW0P3GdC7tBnOeImAMDybF9ghWNIKpDK1I/1iZGJ5cPZakKFjX
         NC1UhKrN53WFh3UQ6UhvWI3UE324H+ktpVy8zC+sYr6RCUogvtOUcmWbpvhSfUXOnYev
         YzlIo54qxA7/j0+Nr/Y3LmSntC0IQVruII2X15NXsWhxI0KbkwRUGx8lSptQ6oCE2t8H
         jHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988640; x=1715593440;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNFn3o4ig3m1wlIQ2tcvvd+Ebk+ma1EouhZcZk52cOU=;
        b=VS5RsoRJ3iV6PFUjVVkSbHKUv59IoiJMBPmX52v8eTmChEiWwOw2DDxGcsGjvPw/1S
         EqXj0wcDLAoFTIFcIzaibGxA2Ly1GnvFeST6GVerJiwD4peOR2T1lauppTq+583yApDS
         hO8DfqKIPPAdAPFKJCEqLAxK4rPvHbGHcAk/o2qk0xbTfftqTp8IQ9hEy36IDDTbAI7d
         WnsUxv+2Pm0TnbRPqTKCuHKDzwmfyA3F3EeN3EUhVtS4nRRa3wnp+pvUkS0dpMBU+zDg
         SNVzlind+UI04TMfANZPGRMuPG+y3O2tOsRydkd9gKLRjG1N+M1Nw1J+xPLS+L2o87Of
         0Obw==
X-Gm-Message-State: AOJu0YwZoZabfumZUQe2vjDtPWdstDM+RPjU5G3dK/8bsIq1Cw6dOZHt
	jHxKqon+8pZWh5RXDabadtyNb1zZJG6yf8bMD8rV73Jdha+PttuB1V35hg==
X-Google-Smtp-Source: AGHT+IGvDTAGjcy1do5IU+tvyLBuV+q8kp5RlirDdk1wBlNbNmrmvijwshparq9J7ryBLIV5LDKjww==
X-Received: by 2002:a05:620a:ed1:b0:790:f5a4:4416 with SMTP id x17-20020a05620a0ed100b00790f5a44416mr8660959qkm.64.1714988639597;
        Mon, 06 May 2024 02:43:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.130.206])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b0079297c6be3esm907681qko.66.2024.05.06.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:43:59 -0700 (PDT)
Message-ID: <6638a65f.050a0220.d19ed.21a2@mx.google.com>
Date: Mon, 06 May 2024 02:43:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7720614062698282217=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_nakella@quicinc.com
Subject: RE: [v1] Bluez: unregister-includes option is not working in bluetoothctl
In-Reply-To: <20240506074043.4200-1-quic_nakella@quicinc.com>
References: <20240506074043.4200-1-quic_nakella@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7720614062698282217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=850695

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1695.16 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 PASS      184.12 seconds
CheckValgrind                 PASS      253.21 seconds
CheckSmatch                   PASS      353.00 seconds
bluezmakeextell               PASS      119.61 seconds
IncrementalBuild              PASS      1494.55 seconds
ScanBuild                     PASS      999.77 seconds



---
Regards,
Linux Bluetooth


--===============7720614062698282217==--
