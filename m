Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D105C1F4706
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903749; cv=none; b=Axf66HSsLygWUsw46ShND1ho8wa7RWyGtU/hUtNmiElCx2szuTCsG3twHxY3vA3jXbvKnth18ffD0Fy1fbptpPrgCe5foy/gJFm40Ft/DaB/iNC519e25DIJZngDpXWmWUDP/dQcQKhPJUI+6E28rqhAJPhAczhz9XJbAMgOjA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903749; c=relaxed/simple;
	bh=gUHKK4EKt/0cZIg0XIExCeB2eFJMz2oHJ5bGZ06yK6A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rbPN1xA17noIB1/UN3W/JLYQj5U9yPSL8lysOMKxKel/+VJA/4ozlt4s2iQEro87OYPGVvhBGLDJaTQPCEfYQKFz/Y/KxghYguPx57fwVC4mx6ZF6B9TNMHkJUZg8lwbDJiW9Rz37PmsG6StbZynAibK+F6gCx4eY0zYCxIQPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoCNhYc7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoCNhYc7"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ffa00555so13033386d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Mar 2025 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741903746; x=1742508546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TIdn8YtmtsMogUMyHmvQReiVP//Th7WeapUahLOQ3c8=;
        b=GoCNhYc7F1lAJNNVmK9H3VQV0IyVhG+mh4aGUu7RrqCrGZw3iwtYsZYMIbsM1f6RSc
         oiWXrrUEBKKEKXktpNP6JOw07CWE0Vtw4v5a/pGYGk49fU5TLkaq2j4wY9iwrY+lSsq7
         0/waGWYEtJ8r1xO66fR7doDeubloEhRii39Csdl3PbGa5mNrO6EeQyoq5FPsRTmr4a18
         BzUgK45AzysHScwKjt7OcrlYzDoWKPNBywYGva1CCNJ4+NvLV+tgF0je4fYvNXyjX1NX
         sN8k2/CgDwwYxQWovI4VjTa2mUCFKh4eqzsrHSyFUNCNbkAeMQ62feu0u4Cf3EDCAK3N
         y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741903746; x=1742508546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIdn8YtmtsMogUMyHmvQReiVP//Th7WeapUahLOQ3c8=;
        b=IoodlEyCeZhImoSb0o7CUBNGaLKp9EKdGGGeGccOuWIzoWXZILLT2OEdWHt1w8JnnP
         fXyAxIuhvpv1Z2JYv3LGVDofOVJejEPLOQn4o6ziW+c4x5EDFmBILkVq+04GCNrfbXGh
         BCjiUQOn1AbydfXopH3DYCk82pjJD/2lASKQVYePkx3h2QefisJpnxBiDsBZaXsBYH2Z
         z/q9fQwTzBqP34FJ3griiYn7GSdPI+rtS6iMsjHW1h2WbY9lkz81ZohH5iYCtF4LeGZL
         tQ46qYvdbzlgXVkcUAt11f3JzGLfFNb6K+LWVJ7Zdlq6U46BPgjyiMZx4O1rGjCzPIY/
         GlKg==
X-Gm-Message-State: AOJu0YxL8MttpvwTIg3BOzrc04bgxoemY73zQT/Ky8f8i2PhJW7hnCuL
	5NTKjQYMw3csF42qNOOj4qrTBRv21CjCdiaYVSXFbcDdOVgf+7g7uyPZHg==
X-Gm-Gg: ASbGncsq+x2avH1esisz8Zc982Py3iqAYivVkFb23TDlqzizAIQ5aXMPbXnpEU62XL3
	Y6HhW2mO1NyXnSbbBoR3xsHQ0Pvp3+bdYgso+MvwZgSltrhRoh7PrD7L7G/XJ36R66DV7YXUEM5
	a6+BZaJex49e9LWbXF7cRLdd3q38WwPzs3Xn89kSO9aXGDpTZa9Y/dH+R8TuX9jBHv6ZNaNVN5z
	CQAF9LTVla+R57KjVEfBvvyTwi6vf90kBq1G6joK8y2xYvrQRf+E6ZfrFWxS1tCbELESOPN7YEt
	mMeg7rMc7boZXW4V6eHCVoTzF4iAgAtk1wykd2fYJEH5EHDpPQ==
X-Google-Smtp-Source: AGHT+IErq4/Pr9IZs3U71vuWOPG923eXw65QR49Qt5WKDi4S+a8Awt89PGlVyAB3wBFcHpbIS2yRPw==
X-Received: by 2002:ad4:5b83:0:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6eaeaa8a17dmr1210376d6.25.1741903746593;
        Thu, 13 Mar 2025 15:09:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.54.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade3343b8sm14441026d6.69.2025.03.13.15.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:09:05 -0700 (PDT)
Message-ID: <67d35781.050a0220.161188.5f0b@mx.google.com>
Date: Thu, 13 Mar 2025 15:09:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4941790580368916111=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] gatt-client: Fix Handle property of descriptors
In-Reply-To: <20250313205404.534383-1-luiz.dentz@gmail.com>
References: <20250313205404.534383-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4941790580368916111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=943694

---Test result---

Test Summary:
CheckPatch                    PENDING   0.16 seconds
GitLint                       PENDING   0.16 seconds
BuildEll                      PASS      21.12 seconds
BluezMake                     PASS      1474.58 seconds
MakeCheck                     PASS      12.72 seconds
MakeDistcheck                 PASS      159.38 seconds
CheckValgrind                 PASS      215.52 seconds
CheckSmatch                   PASS      285.85 seconds
bluezmakeextell               PASS      98.75 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      871.10 seconds

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


--===============4941790580368916111==--
