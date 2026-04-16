Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798D385510
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776323715; cv=none; b=cxrf4T0E77lC/QCDAdgfSpq2UHD6KVpwx0P0mWgfHu7V8i2eBRZilWxZqTndDXGxVxuBpNmyYXudVxknbEzSlfWckTfkWwJYtYgYBIblSFlwEjBofrZmcr/qp/Rxg4TXM+BrTyoIhHAa9PGrV9l/3Gz4hgKyWhDB2geItslLeMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776323715; c=relaxed/simple;
	bh=/xwVCC5TDjmqL1cufI+Aq9cBorJ99MnBrAX9Ydm9kPg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g963JmIQ+21blS5wa7/z7yoDFpaGGyH4M3ueOeQgk1C0sI0FrP33S7YtYe1Bi+Gbtsw5mgp8sNXIyhbAN4p+sRzxZ856UFn2bpS7JE8YcJz7B5GysHSq7RTQmTC1p0AxMRnhkK9ctW/ew+Mw0Dn2K4ND0Rn36bT+Rxyrxn+2qbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTsRCEMS; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTsRCEMS"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c637089ccso1469209c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776323710; x=1776928510; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/xwVCC5TDjmqL1cufI+Aq9cBorJ99MnBrAX9Ydm9kPg=;
        b=ZTsRCEMSj83HSNrVirSk9Oncx4MHZmCouRIW+KULH7Iwhc6X0QiyOJwqzvHCvS4SVX
         seWtSbv3Lcx4S50j3QNsPT4pIrcUgnGuicMIxV0HUrwH3ZdM/ZKMrOVbbe3S2Gmb/I7J
         OxTYyfU1Hghm5bxr3+gMXlVkJDZzj8dJUVp0xtKU80ZXksxSpOUfRUCJ7PVK4gegt1fJ
         2aTU9ahluTkXVkDk89IlIa6OLVLfSt1Impssb0Y8yh4UdAaoCa2o96uqStmMMnk0F+Qc
         c148CXSlyPc2GmBtHQ/0L+YlLA7P1yJlYaLX7vpDMiRFmJjFYGqARkaEkAEZa/DUG1JI
         Ad5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323710; x=1776928510;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xwVCC5TDjmqL1cufI+Aq9cBorJ99MnBrAX9Ydm9kPg=;
        b=bAs4EvtFUMx/I43Kz84Vnk80RyefIZ7Wvl974AZdSs+4/ktifViigBmMNf7ZwGhyfe
         P4Is68E+sFtre1P8Zor0oHy16CbbvxDu+qKzvE3hVCeZH+JQXDYy9W5Cg67E74iYl+ol
         +EQR+pnnW2GFZEUR3hqkVqmYjNuvBegSvZTHWi9OgOE/BtR150dIW0tz+EATH5xvQSsq
         L8XxKFlPleEoUWNMfD+PYTO3ql3DNUD+TbkJO9axJqbcHy3DY9b45QcNnUkVHO05hE/m
         M+ANA9AiuK8NBAAMrKG1pJiMhUOGRk4XdAyoEX7FbsnlRXzDdzGvqjdSFBZUf4bA9bp4
         iIVA==
X-Gm-Message-State: AOJu0YxJrBPYet/iGnGm2O5c55ObdEscQyEcVL66WvehURslM28ykDDh
	7IZeDIl7GQdempujINDwLtwNz6G/xivyQ0Dw4zO2A7e2Y01zTKI0qKwxPuX8Hw==
X-Gm-Gg: AeBDiesOvl3kEoIQZfxJPcsvT97FZvlKSuEt6OHDDWPTSg38fGUuMklgHhcw6WkOCgG
	kpjjU1M1OLuO1xB158mgOyUmSAM7R9A/4jJQ3KjfBOum2o1n7qPnlS2a1VhsC8IttJ1budvGxRR
	cnzjAUGTBTJjbg/i1SL6/VJERsQhIh1Z/8fDp+CkTVO56ulDmRNfxwSAw2YT42y4Yc5IKniTalQ
	aOVYcv5lRJBcjQe2pIGu06MogxpR7psOTnnjrjCA54o0F7SRpwmCVMJyUROvnadAsxBsV+m03J/
	SsJb+8sp4Na2qKSQCkS27sh2MX4Iq5RK5J9BI9KwZsVGe1mpUNebgfK2UtXaEHagJ88GRIWZmCl
	FvF5TXcLJRp0JxvbZaV/dJyfUboDPAPvlLhqIbKnmed8PKV8rYkPrDe5OGit2aPK7BDBX4Fld42
	jRigY34MtOHf+aWGJBbkt+8TmbsYtuManJpCIvfCV8JA==
X-Received: by 2002:a05:7022:699a:b0:12a:72af:83d1 with SMTP id a92af1059eb24-12c34ea9cffmr13839990c88.11.1776323710188;
        Thu, 16 Apr 2026 00:15:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.213])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e62b9d1sm4960827c88.5.2026.04.16.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:15:09 -0700 (PDT)
Message-ID: <69e08c7d.050a0220.2dc4fe.33c9@mx.google.com>
Date: Thu, 16 Apr 2026 00:15:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5104489517183847875=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Fix build error when CONFIG_ACPI is disabled
In-Reply-To: <20260416060352.1392139-1-chandrashekar.devegowda@intel.com>
References: <20260416060352.1392139-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5104489517183847875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2280
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5104489517183847875==--
