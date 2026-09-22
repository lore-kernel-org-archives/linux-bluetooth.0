Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D183C10B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062908; cv=none; b=lU6RYKN7KlH+TyWXxTPO28WhOvSJTQ3etWYq3fuj9khfz4EcQeH7G2RqxdaOKTHDli4hFScFSVTeDcbQAEMf+RO9CuiJITW6XLgNeVEf7vOUJnflZcQoSINPPTNlwU4100Snsa7FT6BXcYeWI3cejJJ1Wvkj0E/itQwtYxhvjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062908; c=relaxed/simple;
	bh=sjy7bHKNzz0v9yWuGvOWBYX5p4D4jzJmZ3lZ6v51WM0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T7CTQduuRSSrMa6+d6Ffr8HW23onX7cO8CLWPU6gwU8lNvgGp85wBxzpaTHyflEiyNR46U+jmS3a0b6822NRE+gx1KFN2lcIPQmuvq8jz2gWmLPnQlnrVC5fNKJ4CxzhwVV5LzAy3ZgUwnXozcEP2V//aDsjO4Z8jWGOZHNUol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvZpndAs; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvZpndAs"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb767cc97so40557021cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790062905; x=1790667705; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gxn4kL4FFZAVO1Uj2Sqnn3TLd87RteE93otRZsnCDa4=;
        b=pvZpndAsgpP8uOoP87Svw+w5GpvncdNK5O7mvdOzaLfH2NZmbJmzOMSxVlM4zLA35/
         ybhC6f4AwXjmC80qpzlnPWY0Zw6obJ+p3DYY3qlJ5xNyjMHpd00qm52tJEucHwySq5NQ
         8beA5G/jZD73TzhAGk+qTzZFvIpwxDQFfasVtH20oB+lTKxWX8X4r9FcTyFbtaPx3TU6
         4/ughGsqclanhLFgxxcNDi1LzxwiWzr24SLNnpL7UVy2CBsagBICgEon+a99AXXST/Kq
         Q+a4d/Dx3GcEMl/QeKwxqkqaATvutNbFVc2biIz2hGLEz+zs7PHNOldIQv9H/bRvex49
         wUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062905; x=1790667705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gxn4kL4FFZAVO1Uj2Sqnn3TLd87RteE93otRZsnCDa4=;
        b=hiaVO39LXVM26vRNZlEnRtIxBpToV48tnfMpTDt5HGVqHzBs/A1toXZ0G+RETsrWvo
         otfvBCRiFBKqv+7vybpDTGKZwZsOUjNxBn9mbttB2jVmZA81tgvGam8Hyf5D3V4I3o7i
         ihFU8xbojZjmwxftxIaZLJY/65TNoyRuIQOCPmpkAdpDVGE/ngGePAmPjjXZR0fI855V
         sIFqpP7UoTr3Hb59H/nDj0I5w0aQ0wSvb0oXDhrFKjkqj9S3KgghbrIU/Xl+nDin8os9
         VI2VZ9MZJgn3BUAkE/BML9rU29CpWwuwlS0xODf6OfE8BrvY3iI018PbGjWkc2j8eNjO
         91ig==
X-Gm-Message-State: AFuF++lyIsT7nRlLPr9Ujy6TbSjPxA72TBnIwfVpvqNnZcKU0Usbt3Cb
	ZgAbQ4jSH4WnKLoha5OO5fV643I73zv3Ib81AO6laOzRF4iBYHS5MhXn7dpWRQ==
X-Gm-Gg: AYBFou2dacPPiVV5SbPYw2/x1hrZjqqHft/+d7wbCVKYHX1woJBS6rnQycEv3FnLWxR
	nkzmPNDC4d/qbXSksPgB29MSIYYIe55BEp7GW6ArCwOSuo4C8NnZREpEBKZc6spmgNXTAc1tnXU
	QpMhsHCP21BDTf66OwyQ4dt14lhrmBpyLb3Qruk+7qiZDhP7zP2oskhaZm8cfESz8vVjQdhF4xo
	IXBG92KHYC5wofoSCGtVdoGUgtlHXUkisLIwBrLdTwXk3HxisTnNJ3Z68H3ZKA8+V0FnGyDJoPq
	hV3WCmy0wiGJk0kopJwWNKivz0IhlyBN9Ghx65WClybFjjCydcPhpAByD5uSghJmSIEa0PbbjUK
	2W/xBTsGre7wbgKlLI6m3VYak3XmlWj7jQCBX1YgNcC47DkcM/prmIvvY9i35lQtgyWsN61WL2r
	S298k4Tw+zlwwfQY6CeCKuSorvim5fMId7qVV2rsY5/j6lmzU+X/Qk+ytF316/yRpjVDLL0iT5D
	mKB8Dc=
X-Received: by 2002:a05:622a:550c:b0:530:f77a:b162 with SMTP id d75a77b69052e-532d8d6a32amr39202051cf.27.1790062905423;
        Tue, 22 Sep 2026 00:41:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.104.167.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e192badasm6542591cf.20.2026.09.22.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:41:44 -0700 (PDT)
Message-ID: <6ab23138.a52e8b4c.f7fac.5495@mx.google.com>
Date: Tue, 22 Sep 2026 00:41:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4859124759783191384=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: [v1,1/3] Bluetooth: btintel_pcie: Add support for Intel Draco
In-Reply-To: <20260922061744.20192-1-aluvala.sai.teja@intel.com>
References: <20260922061744.20192-1-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4859124759783191384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1171028/

---Test result---

Test Summary:
CheckPatch                    PASS      2.78 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.15 seconds
GitLint                       PASS      1.12 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      30.23 seconds
CheckAllWarning               PASS      33.92 seconds
CheckSparse                   PASS      36.87 seconds
BuildKernel32                 PASS      29.78 seconds
CheckKernelLLVM               PASS      35.53 seconds
TestRunnerSetup               PASS      796.66 seconds
IncrementalBuild              PASS      32.76 seconds



https://github.com/bluez/bluetooth-next/pull/811

---
Regards,
Linux Bluetooth


--===============4859124759783191384==--
