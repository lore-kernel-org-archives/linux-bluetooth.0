Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B3F215057
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927138; cv=none; b=E3vDm37MPPvz3eXILOfOKa4uKY48gF5rGtpA5ASV1AvQE3aEFcVdIB4s+M5WOWduMSGjDvBuPGsuHqeOZC64e2/hHhK/7qwG7b7ob5LOS3xjpv0DVGnspCM2dSPBwVG3tp8N88hLmyGxyjclUchMdGW3geXx5GwiB7HkJ3wCoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927138; c=relaxed/simple;
	bh=WPmlDWQb7YTreEOal6m8OuDYULvC0JPxoLoT7o2ruFY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g7wo4A70MhGMRsHgiofIAoA9fCYBIZxkvrh4YRpLclIxzYIWky5rfk4xY+6byJtSQtla0H0x+5apFG1fU2QB+OBIn0YVtcS2ymyPWwrM3fhxoBaLAFOYFRMlyD1ulCBulxiM8jbm+i6zWPjNubeMjvlu+r+VyJe5dhdXqhAs+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CylJS/5p; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CylJS/5p"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47692b9d059so16375461cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Apr 2025 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744927135; x=1745531935; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HyrZ/DJJwgR/PegzayMtly2deuqEnV7z/3MUaz/Idtw=;
        b=CylJS/5pQBQkaI+V8iagXvAMGxawv+cBE/n1xO3rQSeX4M57p3uYz08KgNtLcLfcBj
         0HemS4NttsmXc+PG71dareV4U8b4Se40LFQLJNrEMXTFdogqV2cYEy1Vy1tRZid+E1mr
         wB55pYBXLZSvyQph0xtriZ8m14orjKIOgOyY3TFZeS6m6bpw5UQDwPAoQDKSzsAAfL0a
         3SdeoOY2MPMyoQFrBhHbZ3iKe2HcuIx6MtHp23qS+mQdw+KPC15j4s+JqMOiZbS3nvpI
         /B72qMcR/1HsbZplK3QYeCxBhSSwdU4/oCKE6AhIs0idbWAh0Qrvi+5HGhIZn7ph7NK6
         ThwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744927135; x=1745531935;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyrZ/DJJwgR/PegzayMtly2deuqEnV7z/3MUaz/Idtw=;
        b=DhJ6/Dv9XJxloVwtJJcWmxHcU9be1zRWZ+JXLKsk79VptaI95tkOXHG723c215Xcgb
         QDMmEj+e7nLaPkzO5tSoqMgeHHfyn10hXRCciuzOFusUl5wGWkDM1xVRUPTtu1jeiDkw
         gsBGVxMLmfi+oHwgnEBFnIHslH/LrSB1uob3E1oXTJntMtpB0SJjZtmnGwKfHsiBi+My
         fcqW7NFPr+Fo7dJGAqNXkzgoiSlAdckVCrgCapXCirGnUfizt3sHQhfcplvfOLgnFfaj
         M/PpEuCTrjTJuTZP/TG9LqhRBDGnsQsrg5yqmMlXCns9micOJH8CA2LtdwCJ1jxeNT7P
         qUBw==
X-Gm-Message-State: AOJu0YzDTVEgbMzm8JzNKuYcFVHTw4KoGssZ+M9JJCjjH6r6CUx4EZi4
	0FyR7WeFvuvB492Ac0r3qkhkchKk9A631b4Y1kP2v6LvNKayaZhgiiPirw==
X-Gm-Gg: ASbGnctmIQ8Ys/VLrD4Pj3uSNUbPLvkc1iD/UHDJU+x4nC+78wLQyGR8vDYAhvDhERV
	nTQg6WwiUC6gz/mlooYVfTnsFVCSEVcQr486cPhHBHktsAAFlRj+eU7ED9r5MRmRVCARvbPpeI2
	afsWuObx2SCpjOAZPbgtmaKoq44cpKeCmPjtjcK8kTHv+/gjnNtmSlSHD2WDCbEa/CZW12n2j5Q
	+m5lYNlgoYPp9uVmBbhbAY9DS8qsWu1qmRonRbdbDjdecnOnzh9s3FY8qDM1vwgiTUm52YBbQej
	KSYaFNnSMXVh9YvhTdgVijH5++JeBjB6xo8k42n2mN0C+eI=
X-Google-Smtp-Source: AGHT+IGVdivDrxPYcWFHohHDKMmz+4SETqoKneNSV6rpR2tvV8s+y3f3Ju8UNQGO0uhAEdrmikBlPQ==
X-Received: by 2002:a05:622a:14e:b0:477:e2d:2ec7 with SMTP id d75a77b69052e-47aec4b4defmr8512271cf.33.1744927134837;
        Thu, 17 Apr 2025 14:58:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf7357sm3520411cf.66.2025.04.17.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:58:54 -0700 (PDT)
Message-ID: <6801799e.c80a0220.3a5ae2.227c@mx.google.com>
Date: Thu, 17 Apr 2025 14:58:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4027340928794041796=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/shell: Fix build errors in fc42
In-Reply-To: <20250417202113.80496-1-luiz.dentz@gmail.com>
References: <20250417202113.80496-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4027340928794041796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=954640

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.19 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2654.11 seconds
MakeCheck                     PASS      39.22 seconds
MakeDistcheck                 PASS      198.23 seconds
CheckValgrind                 PASS      280.23 seconds
CheckSmatch                   WARNING   301.86 seconds
bluezmakeextell               PASS      159.08 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      900.12 seconds

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
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4027340928794041796==--
