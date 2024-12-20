Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F502A1D1
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665501; cv=none; b=mhsJ1CZK9pHm8bQDkqET+J2YgJYPGoL1KrehzhC3aAhz2K7M2fuOg0VTQhlok7snVG5f2qjqNUQCmJkwv7E8oSSG3G9oAriLqogDwIPZmmLC7SXNGycCgmxQQ4p13fdIxkvQf4CSq2M/ZY2BgelFwJgN01Kza+fHCZKju8rcxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665501; c=relaxed/simple;
	bh=7CHSeNhYV1xr24/TWiVl8LMIfH7I6Ce3mrPFueAEvu4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q8ZXzcd3LPLy2rnfN2bIb5I1h9BzsiMqYB1lqOVTW12qMigAuk61EfN1fv5VCSO+yG3HA+FhV6tbTeN5AmYNN7NLAdwQEozcAb7K7nrK5SWjlcVGPph7ogHM4B+Ma0wUtp8jeAi9VDY3/3EXmJTw+eBGztLQmrlIUxJdCk2QcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoElYNVH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoElYNVH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dccccd429eso11761016d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 19:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734665498; x=1735270298; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gaXq5ZCQ5kCTjPjwBphtv19IigM/hcc+0D/ydYV2vdQ=;
        b=SoElYNVHMiHR20BJv2espJBND9I9aZZGWYVJsulesU3PiT10V8qlOsZ+FFSWH3bVzo
         MktLlgZSwYIUVdC7Stc2ZyMyBcWJusFl5R8hMElQga3i2RD/ViXbBdqSExTnNgrNAJ7c
         nb/0NMZVx9CKzmYLLnmYuPQMFq/BjBXjydBIGxXEcZsE+Ci44cDPxQTdCbw85H3vqXP0
         Aq3SbpZs0a6qhF4LHoJccqdyd21i1tMxyMud3AZyyEzn7xvhXsY8gYZFpF5g/S3njkqG
         m//rJFwoDPzVtTffUEYbStlPf6wp1knF0pThr03hY0RNzu+eHrDSzaAkJ19+8v6+9Vfc
         QZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734665498; x=1735270298;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaXq5ZCQ5kCTjPjwBphtv19IigM/hcc+0D/ydYV2vdQ=;
        b=PLlQKae/ITc/WmiOWEBqQTLVXKCSE+uI7zJjviYLbuUMgQi0GM1hestISSd1Glanxz
         TIi1dSNdh04Xk0iFhd++kIZ3DXQUWxhNzwp1vpQQGyIYYxK71Bd9SoY7w1LMzI6/VhN6
         gLR93ReSUgjHqTdaeNQN9XMotJ1wz3W58gHzbUdihylefPaSJzx4KM6Xdy03AA/8/aCT
         Fw5eydhaXcdzrFPafM2FbH5joHQrQedyNn4AlAOKcES6S+EhjzYE3D+vFteucDgJr99g
         1cGmbEADRoCJw3+bKpFy7WzZLrDIZFPLY/yRWMD5ymzUdmN4GuKHDXj4g6KODnoZkk0G
         h5ng==
X-Gm-Message-State: AOJu0YyKBvpQB77KbYwYnxR6Le1rTqywXTlwXu2HBGDWaMBhvbZZGSZ6
	lQ9JYzudk7l6r1VZHhg+NiP+D7UDPnamABEBCEKHzl8PqS7o+Pq3mTIH6g==
X-Gm-Gg: ASbGncuIHw9GqJae4TETMc+yZdM799evN3NhT/BOS6RSstSodwvwZg+e1EzOTvZyT5F
	X+svGZaA0eXyyjiIKP1nDdkVxzlqLp8+Wp8BBG5Lyqx4GT0ZIFof41eg5yr/TMD4IycLFNlfEQE
	NhpDNFZellrKAzaUUIYsYQ73uBXATRLwJWXa1+roiCV2RmB6d518N3+z4W9ihkkwcYIZh6DqdAT
	filIXRPWUV63Nmh7CwrbbXo7wAA3EOY5KKeKQpbzBbP+Ub6MQC4Du1zDkaKHQ==
X-Google-Smtp-Source: AGHT+IHROMasiauiyUzGz2NG1evESzpxsAm9ldF8/wuSmEhO9TXe4dgLiEKwOtWEGV7BD/0UuKgzew==
X-Received: by 2002:ad4:5ba5:0:b0:6d8:a84b:b50d with SMTP id 6a1803df08f44-6dd2339ff8cmr21729896d6.33.1734665498316;
        Thu, 19 Dec 2024 19:31:38 -0800 (PST)
Received: from [172.17.0.2] ([20.161.78.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d53ecsm12672316d6.114.2024.12.19.19.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 19:31:37 -0800 (PST)
Message-ID: <6764e519.0c0a0220.1817a7.4fbf@mx.google.com>
Date: Thu, 19 Dec 2024 19:31:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4155734946613082019=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kieran.r.geary@gmail.com
Subject: RE: [BlueZ,v2] Set `SDP_LARGE_MTU` flag for DS4 Rev. 2 product code
In-Reply-To: <20241220020818.478090-1-kieran.r.geary@gmail.com>
References: <20241220020818.478090-1-kieran.r.geary@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4155734946613082019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919714

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.67 seconds
BluezMake                     PASS      1587.12 seconds
MakeCheck                     PASS      13.29 seconds
MakeDistcheck                 PASS      159.70 seconds
CheckValgrind                 PASS      215.45 seconds
CheckSmatch                   PASS      274.95 seconds
bluezmakeextell               PASS      99.81 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      848.94 seconds

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


--===============4155734946613082019==--
