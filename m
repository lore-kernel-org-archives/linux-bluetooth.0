Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B91200C2
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760213317; cv=none; b=fDte5dBcJ3r9ZuoxO704nd4NFV+2Zu5NV5kxWo6tDhkt0lDmaCZQMjIRmxptg0KSHPgvlivawomc5eYaFxrjdzTK3oQ2iNF0z8FdofHT1p4OAT5QovDxDeWrjrT1O4ip0LAeMkWszg/ClzZXwa7kMFTc40x3dXHCcQ9fzL1cKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760213317; c=relaxed/simple;
	bh=ETrjDlOL8XK0aZyeEEw6+aLTbXvvqIp00fhJ9DoLB9A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o7ZKHLR+G71nXJea+Zni3Cn11W9yf3jgtvRwDVvC4Qd9aqXRghip8Y18CZzeLPMwvV9cCKdujlu+CF60WngYiO4ICFsGWgnu/l7WxflVZHXjB++O/muOT9tS8TPn8I9NBS6iBDrlGNAhfE/ODwDRYDRlIx/oOKbfZpbN1nkjBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFhSGBsh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFhSGBsh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eec33b737so46726945ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Oct 2025 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760213315; x=1760818115; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l+bPSfRHOJeSnzWiDSS27EnDjKJ4L6fIJpBa9mrTAeA=;
        b=mFhSGBshlh3eAHm2/3iZjYltVt5gdak2z+oFoE41pYvz54VTH5GmDEoNNHKjWVSpb5
         9Rw/u0TRRBK/Obd+H/zob/Xc3GCV9P+hPXSc3ZO1Cu/cizDesucfHKgRAuYg1j7UB/bS
         UQreOL2gl+vA0MbOKnXD+wDfDx52LxTFulXv9gRAoqZKbAti5TpE7RMArY/Ach3bIUYQ
         ut4hyKf9cmHk/bJ5xcDhcGGEQsQMxpRMcYQNQwiEHTQKmDv4Hyers236023cbDYCzTYI
         /PtARQh9WCbatbg1X3ORzjiUSza4+PgenR6m31Lfxq533PXO5tm1McjbUUawTg2A0I3O
         uVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760213315; x=1760818115;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+bPSfRHOJeSnzWiDSS27EnDjKJ4L6fIJpBa9mrTAeA=;
        b=mOlsd/KHCEp26AxaUKvR6fStNdeEEI0pU+s9p8vzxfPcKn0KU45m8HbawtPCuuiG6V
         +WEunbl/qZghpixMEssOsPTd1YD5aUqSSpUW4qQxqjkB8lJMwsDwBSDevawlov6tFiPX
         FIdZ2QXeKTU65/p7QVZhuKMmV9W6a8hFXAr2zXWajt4T9xw/brUaFVGH9rFTnkbPD1b2
         kQCsmYHlzq+G5QA74uxmPuup6kjU44+Q1udD0RCD78XbAT1kK2vYEFjt49fMkK7yPO3e
         vQ5GpBN1o3wEvZmxonXldMBZtvL22nmWPskm5oG8rsElFiBCl7F7YgEm5S67/Tc0PwNX
         J9dQ==
X-Gm-Message-State: AOJu0YwtLiUfmgbKUw3BoFDfKQLnD33Y/FcNuoh6BKPsvj8hjXfFT7Uo
	2NgR5gUdtbAZV0nitoZAoU91X3qJJ8fVxhFIpPiQNAakdAjubYFNJ4vM80ntZg==
X-Gm-Gg: ASbGncslPavRZ9r5tKVJYgDTLcbEW5CBS3a8MxXVeArvrS+fOWr3xv8WkBRkaegu1f8
	3t0wZJ3p6eX/Il3/mvWFHmcSUkns5AzJUQew2maNL6o3WLH5NuS2X4XCpA0JA6MAsg6WJ8tYbto
	jtcDvkwecedcuvQX+P2nlETjeYpKtnogcRDMR5icOylgB0fEce7JVaW/66yICaW+etzkduJA0ub
	s51FreuPSYDhmRDVpD+im4uX+UB4dm/Vhgo3etvn67T6+IWUepugiRnNSQS7qPsWr0694svqMPk
	I22sxn8+IUiiqS/vb4Nqoc6zosrhhPeJcExDQk1/tPnJLOfdJliE4w/075B/V+WdpMjaqfwsBg9
	caIQy4o8cxgUjHZ0f89PLzacRzsgc7RniJhJML4dlsFO2W6ZvtQyOzTN5oYkd
X-Google-Smtp-Source: AGHT+IF5wwHjC36cBZ8XMtBSbxWbbVHi7Wk3Z8gYXw94aAtJ+kLoBBQSMAA/ymlTyuMHNnCO584NTA==
X-Received: by 2002:a17:903:1a23:b0:271:479d:3de3 with SMTP id d9443c01a7336-290272152eamr219382105ad.12.1760213315137;
        Sat, 11 Oct 2025 13:08:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.191.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f362efsm91058035ad.89.2025.10.11.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 13:08:34 -0700 (PDT)
Message-ID: <68eab942.170a0220.d49f.4623@mx.google.com>
Date: Sat, 11 Oct 2025 13:08:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7364069707802668137=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: check pac cc and metadata length before use
In-Reply-To: <6fc999ce7a1a375d52171f7934dbfff0335baba7.1760208260.git.pav@iki.fi>
References: <6fc999ce7a1a375d52171f7934dbfff0335baba7.1760208260.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7364069707802668137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1010380

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      19.86 seconds
BluezMake                     PASS      2584.72 seconds
MakeCheck                     PASS      20.02 seconds
MakeDistcheck                 PASS      183.18 seconds
CheckValgrind                 PASS      236.33 seconds
CheckSmatch                   WARNING   306.91 seconds
bluezmakeextell               PASS      127.36 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      913.90 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7364069707802668137==--
