Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A6284682
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653605; cv=none; b=Aq8HhganA3NJ2mMECdEopbOBgsZ5ME4AgUpJ4VQlvpu9ZK6Xuw22mFrrEKKjruWsNDmE4VObQCsogPayuaV4nXPH7hZhmGV5wOGKU9J+63AUTAM/bTzE3jpQlhCxvcxiPNpXhcPB3+1ba06IRljuluHSeNHzg0EJq6M4ULJGtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653605; c=relaxed/simple;
	bh=EvS7LDIKhdFaKuxNOjbBS73rKH7B/JgnTxJ+muvZmvQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gwdc/6iVZ0d0j5wofWdS1p2IMOoAlIqk1hSx3lTDuTKs6Vzx3vjlkwACtiCq7aQ6va1B+vdB/DefOUXiK+38NSQnJ79xSbGVKeP5Dzt+XlwrJcf1GsGMjjOA1QgboMl1MxmYE7y8TIP66An00WNJ7BMLc/S7xexFo8wZYYjdXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8Op3hlf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8Op3hlf"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736a72220edso4816245b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744653603; x=1745258403; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UPLHvphErqh5tsRSFXgooq7dkHhKuAAP/pWpA2bHISU=;
        b=L8Op3hlfycnZJzh9PbfT05BEGUOMCj+egexTxDDZQ8qYcx/joh5aq4DtmYQCswQcSE
         D0svnRLphSjjc79RA/KPIl73TCjUUIpSWjT3KitxOBQV+vyVTIEIzSSWu2hM4ZjWNw8B
         LSvi+B2TPe68wNhMNfP4fC6DKPEjETUctBUg1INnrmjEhzob6xxEShwPdXMdnEPJxYMi
         76vVoi4cGa7qruaCOpwoXplqPzj+ZV49P4CSEOBWDbR+F2cZHVJPuwLwGavXVn9qQLPV
         WurV0L6QLIG569PUYzOWB//txRs6keQz29KYz8q3D6n/4qDy8bjN/Rs7iOqni/gOe1+l
         p0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744653603; x=1745258403;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPLHvphErqh5tsRSFXgooq7dkHhKuAAP/pWpA2bHISU=;
        b=Ii9TryMkOzq4TJLQXLSugBGNAi68FBbNqQDlRg7ofGtLKOwFqLhFi7E9BEBG8i6Xkm
         jF+eMQoPmzHP7zgdjaFKxct9GJlECkk1Vr7WYhPD+3XVV4MmeN7oJOU4r4VG/k93pem0
         kpFWZGCO0m0UwuB4TFvob7svNln2d3PZysjKqXkiuuoEAunW6xLLDyOTIHItxLoHClwr
         K7jqF2o8uDIMi+iMsPplsl7Tdtv4F9Ow8J3oNsyhMcLt1Dx3zHJC+0qzyhkARCZ1K1yi
         KRVLmA2EmSNOnzmxbHX1V0GyuLJcahhSHkUm2SjASdC28eOVSApVxtTyKzwAKlEW04nY
         wwaA==
X-Gm-Message-State: AOJu0YzET4f0NNFzABFvSeJ0S9N86TaccBNuy7qpkOFwgL3xf4gbPhkM
	0gExIEhL6icKw45pwMCjG+FcEJbWdYnChMnlehmgo0ioTWNS8wtPTs2+Zg==
X-Gm-Gg: ASbGnctMbxyfdUDRnK66tRJHCZjyWzwe3v9nCYjHph/3rqwOgWSctmXcNFwgBvMnann
	TMeN8TFyu4eahJzyasMVDnBddXLVy25J7A2f+VZdkPm3MjTFEgHLQ/AwJAWoYSbx0Gvy1b3K+2x
	ZSViGMFIcs2sgyeyZpMxq5pLR46M5iASTZUt1JqSEWz7GrKbdmgjXE14oQvOX9TqOpP84H/Wibj
	hFCuub+p7zxfb++SJyAnhOM6dd0jdxJpgFL0ZkiyCeGb8TNSM+uWJQRGEOsUNwlia3WlCWZSCRD
	69IBIlGyXBTfUZtMWFuGYQMWIbSZW9DGX4uEa8VF5wUT4aU=
X-Google-Smtp-Source: AGHT+IH8tAmuX1LCCIdf6u7ehr2Rh+kPUoj/Iq7XpEzoRP+hPMruniOP8weWc/OdAbm69rd7kaaOOg==
X-Received: by 2002:a05:6a00:1799:b0:736:a8db:93b8 with SMTP id d2e1a72fcca58-73bd117fd59mr22035402b3a.3.1744653602397;
        Mon, 14 Apr 2025 11:00:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.43.247.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e355sm7094623b3a.139.2025.04.14.11.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:00:01 -0700 (PDT)
Message-ID: <67fd4d21.050a0220.1ebb61.5979@mx.google.com>
Date: Mon, 14 Apr 2025 11:00:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2024654829394805383=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2,1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
In-Reply-To: <20250414172200.401437-1-neeraj.sanjaykale@nxp.com>
References: <20250414172200.401437-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2024654829394805383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953190

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 FAIL      0.50 seconds
BuildKernel                   PASS      24.81 seconds
CheckAllWarning               PASS      27.97 seconds
CheckSparse                   PASS      30.45 seconds
BuildKernel32                 PASS      24.39 seconds
TestRunnerSetup               PASS      464.99 seconds
TestRunner_l2cap-tester       PASS      21.97 seconds
TestRunner_iso-tester         PASS      34.90 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      120.91 seconds
TestRunner_rfcomm-tester      PASS      7.86 seconds
TestRunner_sco-tester         PASS      12.55 seconds
TestRunner_ioctl-tester       PASS      8.37 seconds
TestRunner_mesh-tester        PASS      8.52 seconds
TestRunner_smp-tester         PASS      7.26 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PENDING   0.78 seconds

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
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2024654829394805383==--
