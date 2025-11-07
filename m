Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCD2C0299
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475471; cv=none; b=D2B7EpU9E54K5T0lMyDFYldFDvn8xdcUGC5r2bMm7Md5mYij/TkIz5Ko2bOSxkVASMOsQKUEfUztFY2qjrVmjpGYN8aTirEEzIsGK/dOJ2YZN/jGrUDMx4xdrOXjh37LDwvl8Blo9HOzKyVDd6plRdWhR7hCr6mjriqn5S0v4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475471; c=relaxed/simple;
	bh=YEQTSDbJAF9O+xexDa4SCFG/x1OCxF5iy2SW6ULt520=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AjAVMjpbq3LH1jjGM09S1FrpnC9McNJjd1PllguobmelnHflKDxwX9A8flfsXi+RH2VokYItOV8GDsTwHRqmzXhYmA44+/QNKox19MAha4tB9Em8xDXjriw22wUYXtOUHmPIfzoZOfI+tBbu9h18qXSgkTko1Z7DF/Op5tFsGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imyvORSD; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imyvORSD"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-433261f2045so1556645ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 16:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762475469; x=1763080269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nnyaT7n0mfocbnL8rW49eRQZ8qS4ptfAMPoJn/ZTICw=;
        b=imyvORSDDFVjCEPLdeTwHJU01mgppLQSOg0CTumeAY5SzJF0o5BdwUjtnWVj0ubiiv
         MU4Cb0wtvWi0N3wtl1BKaaCa+bKCZukzgRy7gKjjzIfyFq4V3g5DlerOP7wLGkHwMaLt
         A3TudpECV53cpzk7qIDklsQnZ7ghccjiomnnKYkUHaF1CO6hRE1jIgpNN+labNrHVlVb
         deqCpUgCM6WULnE06cbPv2nkrr72hE5+nqdfemJPHle66gJibkJ5amWbjFmK0jXjroGI
         8ysEhWVyr6W0H2UEoXYUff/YR/UGaawV1U91wUzPXMJj3nmoqe7aPBWaObypTO5Qy38z
         Jltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475469; x=1763080269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnyaT7n0mfocbnL8rW49eRQZ8qS4ptfAMPoJn/ZTICw=;
        b=ojQP2RYi2A1bw4CXfecPw9qCGvlSX2vVWT70THHECtIq9wrLyY40BrpF0Nzu7ZXyHu
         aDsD2Roxh5oeKIJBa5eGuOkkvWwx663WfiHFBTl6ect8Vqg5EMDYjS7zBR592BP9j9ZA
         hNYHppmWoPunz9hmetOn1nqcMdDgASd+5i41AzA0wzIq4doECFO7xwhH3yJAI7mWBg6p
         JQ0eRZMhBpZ3PalTunnEGLUuM1XWg9GWG+z9SPp7DPxFLMrYZfA2lVwTDp1Y+Xay6qNd
         2IrGWPGU9BEBFlwd2iONnaLZoesNrYPmuLWS6TWl4ygnAuBGYppYV05t3BtqaemkWOeT
         haOg==
X-Gm-Message-State: AOJu0Yw/ktxir2Jp42p5IDiNfkmhYpcvCoHqvlcAhIfmm/nNNBFtlVjD
	pyyUckweZD2eDdzfw1YLtZQ87+AG7dkOm92uhjW5apd77RHUpH0t+BURus8S+Q==
X-Gm-Gg: ASbGnctiyAPOCaLx8QPY/zmftQNbmvN2hihEEYjsG9rLejQ1lw8+dKAVcUkeEuyLLy0
	hzpkR8zqroWMZNZ8DdFX0pSEXvMLVQSBULmRh7j3y6NEb1WpPtU+yGlCor+uPUjCm547SQ7djEt
	F4FMSW/Qc6qxttzQeMZQrbMhcuqqLNCuQ/EXK5+uaM6XCvzL0sNXUsYRaZ82/F3wCQm/U7kTr1x
	xTtmiRGloRDJ+eUb60wp1SUPdG5eSafr/5PAR1RBqxhpByT1CCcRTapKIgjFT7ZyeQlJL+jX45f
	8xk06Z4eIvWuEzeLM7QZOIzzmKs6GCghL2IxFb2kBHAtCSho/SVN68+dUz2B54gsl/Ralbd1RFy
	h5960gEK1zgg/S7FL0UbK/EtX+sEQUIU95RIkBUA22S5gxbgJJG0mDzu+KsdwKyRiqKaJjSgbQ+
	Q8ac/FIa4c
X-Google-Smtp-Source: AGHT+IHRwI5luwpqYWJ9pIjf5kW8ViwgOKrTymknQTqr23rJuCBMv+8fuKiYsuzLqgAevoUWIeKG6A==
X-Received: by 2002:a05:6e02:1c08:b0:433:23f0:1ebf with SMTP id e9e14a558f8ab-4335f3d026dmr22719165ab.9.1762475468859;
        Thu, 06 Nov 2025 16:31:08 -0800 (PST)
Received: from [172.17.0.2] ([172.212.163.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-433574de933sm12615965ab.8.2025.11.06.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:31:08 -0800 (PST)
Message-ID: <690d3dcc.050a0220.105c10.230b@mx.google.com>
Date: Thu, 06 Nov 2025 16:31:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4713925283944749296=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] emulator: Generate PA Sync Lost
In-Reply-To: <20251106230848.876764-1-luiz.dentz@gmail.com>
References: <20251106230848.876764-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4713925283944749296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020667

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.09 seconds
BluezMake                     PASS      2566.32 seconds
MakeCheck                     PASS      20.37 seconds
MakeDistcheck                 PASS      184.52 seconds
CheckValgrind                 PASS      235.98 seconds
CheckSmatch                   WARNING   308.44 seconds
bluezmakeextell               PASS      128.79 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      907.31 seconds

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
emulator/btdev.c:461:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4713925283944749296==--
