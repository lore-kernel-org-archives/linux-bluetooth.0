Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF31FB3
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856833; cv=none; b=eA6aNxa9Mpu/ewSr7PdPUN2NXfGKkF3T5bAxTdlWGoPAzgbCPkohv1f5IgM8GDyriryiBPeLaKhRUnmHwlcalOMe12uTUhstLioF4FQE3spoQ+0S93fgn4lfQo/Nu7bdgd2v2QBZPfXw93uD4b6IIXKRTyL++CLjboINEwjAnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856833; c=relaxed/simple;
	bh=h9hLPUCxxPsI3Utd8fvnXSHTEpSQ+QN6NtC+FVrgunc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V5yXh2I2Awv7VdMRCJxQZBLmrCS24aSbIkPGa3GMr0EfpsWbpuado/+CTRZerhNGvqQuuwyPIwmRDL5EcJeydXjIytHTg3cK7gVgZWs0amEQRMLYe1U+MaKek2fvoSLNRVOPT+O1+ZMcwDWESmtykkY/y3iY7pwOJ01DJNh1Vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu6SfbKP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu6SfbKP"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-81999b1e9ccso318496885a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Sep 2025 06:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856831; x=1758461631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=28nXbKkifUv0CkC+2FiP5Kl2udpBmuzYOZVMQ4kwlEg=;
        b=Mu6SfbKPg52V9CThB/mLTFm0ZQQMtP1ZCrj4Plns7QC5FwRKGgLy1pVYLNXbladluJ
         0QsLqIYQXwXxkjR2ENvowi7jIq7Viq5ZZKSDLg3CtWOIROO6AdC0ghgDG486ukxNlSPY
         WQ6kukxaTeTP8OD1/1ZZeVnVFi3MKgV6xSILGPPS6Vu1h4EyfKyc09CIMgdKa5T7VW8Z
         x5Wt6e7GLpXNnD4a6h6TYN8ug7kwmz0Dvz4iiSrrIPH+HU8ubSu0uPlnuuzH8s34Dbns
         bzfVxuNZTSt0bYI7h4KcNIyVR47ygam9BpIJ9+CO3d2biv8SRcQCKAahZyBaZzIz8SRt
         IL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856831; x=1758461631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28nXbKkifUv0CkC+2FiP5Kl2udpBmuzYOZVMQ4kwlEg=;
        b=NgoFxZDprBHr3BDC1iCLltqbC2sDNjBqmxl4cBiD0BLE+BMRGVmhM1ftQtxSiYqZXw
         Xw93UbrAgoMeq5ReNVCPeb+1hGHYmQUt7EwbJakJb3UjBUjWH0fO71A39A6mFA1lLuNg
         VGQYcqYtOtyiTIBEAEF106ZOizXX7vvjuL4CjhrwfaONMBKxhYTBLUh6Qe5QPF6eWs5Q
         vFjjXPgBk0Bq7GtdD8LIgmGxWUDxMyGn2/PAZIyUdaVSQpXgJCV94dHAm6tBAzkPFZm9
         /jg0qPVHVaVoGG/wi9+vRPqz2YjyVYZ8TQIkyrVA4eOXAEtgUKG74rmsP1CJl3aOfbJN
         9fiQ==
X-Gm-Message-State: AOJu0YzWjQkhg3peqmbUmcom6V8skSntDIWIq6kPcAVmU3TkaTjBN2xb
	ENuSPWCvM1lGpOU1Fy4kDOtxeiECJzUjCywGnuj1WErCkyWh5TUaBQ7IFJmmBQ==
X-Gm-Gg: ASbGncvJxLyPbdyiuLu4iMzstCakZAC/eRsKJq4VNYjd0pZ9Ks2DCRjVXnnmrwdRl2H
	uhBRwBTXYkWrel3RBwTi4EAAMX26AHuWRSVoJYPc/B3kAmesFF+WehuYZQV9IXUvhGJCBGMqqmI
	l1xy3OLlenl4aRWyDHoI49EUiScCKJInERI3HRatyqSSn6UWc9k33/bUMVhwsKRMTTY6ipoFGlU
	x7MOlE7QdktMT6U3RTUZ+ZOUNFIWDQj7mhFBVWj6BmDzrauOiG0MrcvmgBlP1WpgASWV1gOn+NX
	EK46CWrgYkSQfFlGB0LixNoNE+5BasgmurQ/LgjaEVW3KTtGBQ1vAsQDqjymDkQY47uy5n2mkrV
	IKOlocTMlODy7c/+wFpCvyG9bi6rK
X-Google-Smtp-Source: AGHT+IG/iqdg1/MVjCTUxnIS9PYaoMhgPVMt2AEoNoyEIzHq+LbhhDUn3eKqAGfumKCQYWm93HUc0w==
X-Received: by 2002:a05:6214:2522:b0:72b:1221:fdc8 with SMTP id 6a1803df08f44-767c3a546dbmr102100056d6.46.1757856830752;
        Sun, 14 Sep 2025 06:33:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.223.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76e576ee0fcsm35260156d6.69.2025.09.14.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:33:48 -0700 (PDT)
Message-ID: <68c6c43c.050a0220.edd74.e40f@mx.google.com>
Date: Sun, 14 Sep 2025 06:33:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7171084935102919832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared/io: add helper for asynchronous shutdown() with SO_LINGER
In-Reply-To: <467c9a64b1ed7e311728f07f4065de92c33622eb.1757851523.git.pav@iki.fi>
References: <467c9a64b1ed7e311728f07f4065de92c33622eb.1757851523.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7171084935102919832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1002158

---Test result---

Test Summary:
CheckPatch                    PENDING   0.23 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      2567.36 seconds
MakeCheck                     PASS      20.18 seconds
MakeDistcheck                 PASS      183.89 seconds
CheckValgrind                 PASS      234.42 seconds
CheckSmatch                   PASS      305.43 seconds
bluezmakeextell               PASS      128.41 seconds
IncrementalBuild              PENDING   0.57 seconds
ScanBuild                     PASS      906.97 seconds

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


--===============7171084935102919832==--
