Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232D8289C
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488006; cv=none; b=rjnPS6BuqXanbYnFpkL5aFdec2Pr9yXJuCwtPkGzKm2zy8hqvjRb3wmTbpHiEDdA1tvIqFHxZdzs33qcAoKthXY5lQkwTZ9NADDVO65f2up7SeM/04MjfU0JZMD4xAQ+JL+yvADdjwLdM84B4hzD1Y3lERax4PBVRP0/E7u2Ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488006; c=relaxed/simple;
	bh=X/GyQU5pNc3bkBJ4jKCzJLLgk/v3kbkFZyzhs2LIOMY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=krOJt97pUPWSAxpo2qZ+easExs3YLL4Yqsm4Ji5oxFKcFEtOcj1pxUuhyUCuiwzDfJpOC+Z+3HwW+zyDtGF8Ek+WRX985qVEB2LDifmkKbevyydoHveKxkSvx2MJQClJJfhlkWdkeagHYbOSlTr1MYl9pirQTeAnJoCJI1RAmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h29pISu0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h29pISu0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bd9000dc87so1738557a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716488004; x=1717092804; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n4yUdsszGXxBW9B3pKgvS0ddbSOKmJDZry/TIwQSSzc=;
        b=h29pISu0WpI7MBWOkcuDsQ2ia2ZxBljK2MM95So5NoCl/ghVGV0qiNFPhGjFLhnhex
         igQHQwAm0gGsTI0nJzYf9rMHwmV+2ZaJ8TyfOPLx/hqNKnOEQUzsPQ87fLejToxUCUNN
         bSz142NpsnCyo2+qKs28F1+G0UfWmrEZVZniwT+0cSznp/PbOq92QSkfe1FbyHNSeWAU
         VIs6atN9U4DnlL8zhKf9xwhH7XCPr7pgM7WRqO4Ni7rGQEjN1SaQMFTarmM9Mz3glvlq
         sk4JaWeWSDZs4qCxkyVfq0m8GmMRGiNTarN550P0S48yGSP4N63EBpBxIarOfGavvChD
         gQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488004; x=1717092804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4yUdsszGXxBW9B3pKgvS0ddbSOKmJDZry/TIwQSSzc=;
        b=pIbSVSLOlthn1hGagQHqoJcdgsEKsz1EGPA21FVOcIA3v6ztmLvoST3OZvtoLxcw0S
         87XC/lxAEd1FcBBxaJxP06gHpCJQQfeY5XirKis/DQ6Y3+v/GfwYnsqhkPYgdlGMLsDh
         3q3nzATgMrO+LyNJaa0SeM2cYbsIDHJa8w0750V6mzJRITu79qx3a+sIwFfdV1tqssXq
         QEa5B3hXZ3KfaZrr1eeAkTv0h8mtOtzbPG9Gp03rb8JmVk3z6pmwfiCeD9Qgk6kVsEP5
         V8CDaiF1uyaFGSp2SjFQwQQ2zBvxnPsfWb1HyFQ8fWn4hAmbBVDKKF9sXmwAAC+WiarP
         tb0A==
X-Gm-Message-State: AOJu0Yz34XNb7jfaIjZ/Lvw+QcAw6TH6G/AO2n4rYugLN/Eg45UvgmzL
	/hY7BQ4Rgp9NwukEPeRVOS4Plx0rnCmQ+3Cj3Bx7yCFkjrt83sneyPj35Q==
X-Google-Smtp-Source: AGHT+IF6bGGNPaMMAaeVULwM5C8/4Q8+YEG5Mnj4YM5eysAaWeqNcbHaYDEGu3ePAq5TFWuIs0MA9g==
X-Received: by 2002:a17:90a:55cd:b0:2bd:9255:91b6 with SMTP id 98e67ed59e1d1-2bddce5c5b1mr4163706a91.4.1716488003950;
        Thu, 23 May 2024 11:13:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.25.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ed90c6sm1892200a91.8.2024.05.23.11.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:13:23 -0700 (PDT)
Message-ID: <664f8743.170a0220.5a96.6099@mx.google.com>
Date: Thu, 23 May 2024 11:13:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1443775800085825897=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Update BAP Broadcast Source state machine
In-Reply-To: <20240523154754.39451-2-silviu.barbulescu@nxp.com>
References: <20240523154754.39451-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1443775800085825897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=855404

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.42 seconds
BuildEll                      PASS      25.15 seconds
BluezMake                     PASS      1754.84 seconds
MakeCheck                     PASS      13.45 seconds
MakeDistcheck                 PASS      179.68 seconds
CheckValgrind                 PASS      252.81 seconds
CheckSmatch                   WARNING   355.65 seconds
bluezmakeextell               PASS      121.64 seconds
IncrementalBuild              PASS      3100.81 seconds
ScanBuild                     PASS      1019.41 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1443775800085825897==--
