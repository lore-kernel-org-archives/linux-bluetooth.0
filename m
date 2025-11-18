Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511DC2D47E6
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459087; cv=none; b=T5Kn+4ZyNXTFAhxFcrJu0wGABuFqWl/QSaV1oYw62wEk0+kt8N7qEw1UyD6mjbFMZjjeVFupMAREReqmDDACK6QKmsdn2XoNVN1mV78bLPVeArBmEpzfb8YBVNQ+V35Tsxqwj1Xdmmv/CwBDLpF+y/wbWqOOz0NuiluqlVsmzOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459087; c=relaxed/simple;
	bh=oUmv9mQdrK8tx5dTYXIqsmK6GMQK3AP/dW9UHSUS0aI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gB+mniYUp7m38nrUo7GFTk9lDBFfBTNR2KRj7ugWBtFSP+4DP3LJIQ31SonSgLsaSwJn53CuZhpfe6r3Pp/BPCjchgrHZTe3ttoC9DD7MIzr+nLqZwM/WZSOwMqJHDMiY3ilkfP4OSnW6HGGWWzeh6Phx+efTzBptKJZ8lDxTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcKWKnTh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcKWKnTh"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b25ed53fcbso704131685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763459085; x=1764063885; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oUmv9mQdrK8tx5dTYXIqsmK6GMQK3AP/dW9UHSUS0aI=;
        b=RcKWKnThxpAqH728jKkAxxXCKeMBvV1zWjk12tfMTHJMerMlm8IB99rePVQJYFwLAZ
         xnw2rNt91UPUtBxA3yxTKPxs+68aVnl2s4Cvl1daZR0/Al2YK7xQsnTYVMFP17UuCRfh
         48yOK3X6F98AfvAPrmfD5Xr+fHX3ip5dPcKVDXqOiRDy7RfbFErurU/TUCJDQY3HFnAE
         T0PcLJmA5GM4viTqWIi80DlKAUHklM/QA3p6PE6/8CZYDDaj5WJTbQvSBSqsZIykh2EL
         RFW7bgJNz+t2Sr+O22z5D/9b8/gi601CXxBPDBosr+lJBZCnDFmMAYwqHkS9ihi2qg1H
         fQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763459085; x=1764063885;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUmv9mQdrK8tx5dTYXIqsmK6GMQK3AP/dW9UHSUS0aI=;
        b=SG1iTkgvw9bzmH6uJ8k+seaO3SeW1mGBVgADmVAEcfqsVICHHIqgrl3iSC8JNF+zaZ
         z5YPeAjoJy8Icc/C+r085gnPyc88nVNRZ3OHfvvjvOa0aMwaPpjqGwzYtbCILcgLmbSx
         z8COTzSKZDPW579BG+Bo/5+89RYwX0yuTiR170oFlT53tLj1aAbwOmYAiBF35tRw6Sho
         WxXM1rl9/UYUAdD+RpP8MUyRLTS2S5kGO2+D9eQcFsb+5ZN3HFf1Z/GNUzwCDxS3GTUh
         uosCbse4sf9t4nzz9CkO7wbHv07/ZpbWERfaL1exjiHKQP0pfXvBmtLKh6FFeFAY1DGX
         QBKg==
X-Gm-Message-State: AOJu0Ywlg6za2jpcIgiPwiZZjY3UjcVHHtGNvxgjLiIEpaC5t3US/9Sv
	zwNp8Wur48JrpYadN3uekE5qrrXYpu2AaOgkYnz5VziqenjBlHkqrjIzdvByYQ==
X-Gm-Gg: ASbGncveeoBDC8bzbg2aqXrn/rU/XiFrhipV5QFl5CKwT7BVX5Jce2Y/XJCEtlfZqvp
	3X7HOjoRLXo7SuxKNNkrQV0zHEzJCmrJUAj09CmuNBU2AR93/TWPdCok2om8VcTv1rPjlDS0D5i
	uCnCdfBK9FS/9orElNzzWasYG1BGG8WCrMtVxxgMHWKj7zjTE9Nf9TdRGr4cZYuI++106DSMT7w
	L5IeY44Yejf/Tn2LY5smngI2zw2MsKG+0HLoF/QHdOM/sd7Qz41QIg4PHBcN3ThsYxaZdIQhUPw
	Sm3W6vJwAacCjnbns+wFAFt2FIPkCECuAol1r32OsBKGceC4+l2uNecqaTNEkEiah4NRUgdheIr
	Mxd94zTYWp5gI++KY2etKPC4PuhBTboS5b7n/XknISAj8LKQIldDSXDKcKqUq7QihALGABsSpeA
	m1BLOvUUZv9VrrEc6VqXs3C09KrimAww==
X-Google-Smtp-Source: AGHT+IEoXB0NahPttONPqr2VSriUYUyoFaaKBkiuUx32czUJJ7tUowaSIVRHqO/bAs2uTHReFkY6qA==
X-Received: by 2002:a05:620a:45a6:b0:8b2:9b48:6052 with SMTP id af79cd13be357-8b2c31dab1cmr1992365485a.84.1763459085052;
        Tue, 18 Nov 2025 01:44:45 -0800 (PST)
Received: from [172.17.0.2] ([145.132.103.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2d3326a7asm794981985a.40.2025.11.18.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:44:44 -0800 (PST)
Message-ID: <691c400c.050a0220.5ffd8.f1fa@mx.google.com>
Date: Tue, 18 Nov 2025 01:44:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6435181559341822485=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 13875017792@163.com
Subject: RE: [v3,1/2] Bluetooth: Remove unused hcon->remote_id
In-Reply-To: <20251118092844.210978-1-13875017792@163.com>
References: <20251118092844.210978-1-13875017792@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6435181559341822485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:750
error: include/net/bluetooth/hci_core.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6435181559341822485==--
