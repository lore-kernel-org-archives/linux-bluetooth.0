Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689502571BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406774; cv=none; b=X35oRs2jf+COWO9kEb+4LOJEx3ygtBNbOVZe90Nn/A5BKA/gKSWnZxoJTxFc5C5jpjK2fYIXSN5byp1bvvqKDmdjvbZV2VJ0Dkg8Adiy0k0wTr1zQUiVEDB7ktMGmWELAuU5+c6Dq/dBk6ICm3k4P5O97qRJSP3sv3gBJHB7ZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406774; c=relaxed/simple;
	bh=zHQrBNey8K7zQQUb17jFhqFnMQNta9D8gBOSb99j3TQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bwBGZuac8DKudEUwgh7gPJewrn/DDRapXwZwMKKa2dtDrxi/s2HUEkDpKi0+C2GT4QayjyIXNTojrwMEMJMOfJaB5V1q5Ta2oTqWIWd4JrLhf49rQcS7QhXqGodcywSoh/4qB4nkYp79A8jBFeQmT9KEyGQNuf5fKZqOzN8eaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW0sOiKM; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW0sOiKM"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-87640a9e237so311334139f.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751406772; x=1752011572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GZGb0dBVyE5hvt7kzJjUqiuq5tybUXv+XEg+S042e9I=;
        b=LW0sOiKMY7Mdjvs+yDDdMLfXj+hstI9UilU1RPKPYkJphHZ1FJ5hZWNz3vOztoUccb
         a0EJIcX/Lg7JUrzQ9Fru2qWDiNOxRpZHS17pe173pHhGEsexlE+LPdWb+493IBieiKYS
         qTk6d1MJaNntI8RUHxVkSMCGf3q7wNeTT3xzvVMYLdWW1t7kESAlLMruBPFck3dH6d3N
         HmEdno/6i4vkxAXTsIm63/Lx8Fx7USzzlpwfUUQ5IQv9dseXN2+K/BAVxx6HQx/uHKn9
         1oHnXdJ/uZKb7h15ejmEosYI6R0bxSW53PXromu9nM+VXqeg+Gd82JadcL800D2GqUKN
         6qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751406772; x=1752011572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZGb0dBVyE5hvt7kzJjUqiuq5tybUXv+XEg+S042e9I=;
        b=FY9i/451ZBfFc4Ymea7RgSP6q2mJjvhDIx+oUnDFgTmyLJcr67OXnqn5htoWj8+4KQ
         oR5MkXCpn+yw0fMnBa2UbiJWRKECOQcaQvntFOSZqHmf1wmcWYYLaro1WWC0PWOmawfs
         Xb6EJ62C/xInnxNLn3qiEgmAjkc3/TrDaikmk2HHTI3N9NrxZAlkzVd/efuEGV/DPaa9
         DCXhYAr01DF97XtZ6VmuEwNwK/0RFnjEiOpiPNDnvDl451chlgDWB1YUKVW+wZV4Bw59
         GY9h17XPcrFLvcClh6SthH5Kzz3aWkZaZwH8VSpOfX+2M4JxxAbxZ02mnHbq0l+YQrsD
         0FDw==
X-Gm-Message-State: AOJu0Yy1PMOGCvdLLL9Bid25HLRksrb43Vz+B3chS2C7Usx1NIRDy/YP
	faztCBxlg5RMhZUFIZ7t9qEfcKT7iTI9ex1rQLEIHMk1JNYygjL8B4/ljLKBtZGT
X-Gm-Gg: ASbGncv2y5rYepPBlp88+QOhjGVHyls1LATlPNPS66MmEoyDpkrBasSF3YNZIcBS5Yy
	uvjeixJTAoQls6gfrJ/HZJCsY4HNl+ZQb9f7Q/P5YqWJNhNb1G0pjRtXXYmJY6zkBaPA6tbR5vD
	ocljqZeJdmAZe1Y3ysD+9iDv/DyTkXRqKZDCiLkJ6dx8YEhA1OEMtDmo671Aes19WVXZDgFSRE4
	UcuCoQKIDDbGGkRAwWZYBOU5xYxAj1c740mmpE1AMFqfSlQY+J5cPe6R1FMCytBJ9E8eFQmXJKQ
	gZNZ6bdn3PQZ9lVfSoCMsWyjMEO1ZZALg0uMIjNzZkKyTaE+CzFnXCaQ11ZUN5yB0j4=
X-Google-Smtp-Source: AGHT+IEb2AyDHOOY7OXjxAIWmIcTIHN/3Yz8eRfihfW1x5rQiwtEbTEBirJYIU9RM7FvUl+1ZcTG+w==
X-Received: by 2002:a05:6e02:32ca:b0:3df:4c9b:683c with SMTP id e9e14a558f8ab-3e054b2c79fmr7269905ab.17.1751406772229;
        Tue, 01 Jul 2025 14:52:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.45.152])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df4a00dda4sm30856885ab.31.2025.07.01.14.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:52:51 -0700 (PDT)
Message-ID: <686458b3.920a0220.1cead5.79da@mx.google.com>
Date: Tue, 01 Jul 2025 14:52:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0563187521031515401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] error: Add dedicated error domain for BREDR
In-Reply-To: <20250701203446.1227837-1-luiz.dentz@gmail.com>
References: <20250701203446.1227837-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0563187521031515401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=977912

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      2603.04 seconds
MakeCheck                     PASS      20.39 seconds
MakeDistcheck                 PASS      199.86 seconds
CheckValgrind                 PASS      279.46 seconds
CheckSmatch                   PASS      304.30 seconds
bluezmakeextell               PASS      128.34 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      919.21 seconds

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


--===============0563187521031515401==--
