Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B933A033
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439930; cv=none; b=kkUoFw9GTkkjcDeQRWJ2A8+ea4QRBl+zxK9c8IV8axeTnbpgytUGVibq962aTFKYyCmaqGPhMY26N3AyKme48WAqiInHMQH4DUlj2YHKJU40Mc+ywWM9h/IYW+7cDMvVCyLvTTNwBYSPOnqtFxRo6qdsMR8crCPMogbPqzmWRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439930; c=relaxed/simple;
	bh=GBsVQjtaTcfgIdZWcnllSPrchuIjBanBl657bQ6fVpk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pDv76SH16OZ69EPckPGKGkkcWFrwKNzWYF8lmriaCGq7+hNf2q1UvsQAc82clsoUcEWkkc4/gQ2oboZN1s9I+wogksvyj/my0J7v6r2ld4aiUNaHj4VJIqIQhyfs3nj2xPKY6HXWrGzG3JLuYvv5uK0Ksrkcj2eVaNkyJfGz1Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qowdmwv5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qowdmwv5"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-516cc5471bdso20290721cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779439920; x=1780044720; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SFa7uFCLoIojI1WRGASGJvgyFoAR6VjqoAib+xIdFRk=;
        b=qowdmwv5xW1sHZsG7BnuZMFcz6qdf2A06T8CFrL/Pj24RjToLwkaFVZruEMZpB0bMZ
         6k8z52CKrodqMMU9TWFlnaSMPfIN7cnhc7Waj4EmxjiftWgWKch3ZH/g3qqf8gMKyuhV
         MbHOoNdGeMs5w2oUc6cKT2glvpOHGTrOPguAlBh+9y0eAnZwVwjtnh/BgcRgizXMfOdn
         aY1MmqiXsljspyUxQM+G2wQm8wXGJq068l+V3Dcvslj5Q/25VQR2xdTSy/9oGRVHfLBo
         sbst9KoHFVkPsJwZWtHo6eObNJL0xh+gFfj9PeiPn6ZIawFV0gHcDLqomyIOOiAENOn9
         VzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779439920; x=1780044720;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFa7uFCLoIojI1WRGASGJvgyFoAR6VjqoAib+xIdFRk=;
        b=QNRcoy8ZNe+Ts13j8nE1rYDlkPl7gD/1hf+ZI0twbfg6lwqIKct3d+3eEvF1sODtol
         rQ1xDJyqe1g8zzkqS1Q/MeUOWsDR5YdR5ZuxLhOEmi1gCfxk9iBY81IvZQbnPksV95T+
         BLpqKfPML+07uolfYzPEqqIDoXFNmrGU3QotB36mZybEPB3Bva8qjcWp/hZ1xL1NULPu
         SAeW8UD+naxFh86Hx5YWROazxzfM8Rsy5kqlBDURDLjRPQT650119R8w+aBeDiG64wXV
         e1CQYkIePVqfvjleQsjUu7IHwpKPKr5sVGE48cjBYvkw4WoxZojqvTGiTI06/zksjCvn
         BTgA==
X-Gm-Message-State: AOJu0YxXYMQDyGtv40q2gl80KTHjCm4zWbkidEjSjdjN1ajfZIFgV4dy
	qrhk4VBbPMI1kPGneRn85PBHDVLYf91CimtHlRVAbiQv5AgClCNt5u+rO+EnQg==
X-Gm-Gg: Acq92OFXhNPPBlLp0XVrLJgOrmf/3ps9e21yLJflZ88jso/LyGjh6aS4SL4ClwqAPd4
	MXN+s0u8HOrQocbX5M3z0+3Cko3dsPiDJOwuah9A1ZpZzkQreDGgDxpgqSuPN9LEFG6+/1RnhvW
	nPG/6PuzsjuQyli9bfyqpz/a5QxwEY8PXX5L99wzyTgmAp5pduGrydFOqv1nzDpB4908PlLF1EP
	iM0LBj9B12hjaIeZhk7T2jgnmQ7nXEWZc2aJUhTpyIunwy+BDgTrjMhDLrlLxjUzaOUB+tJ4Vnq
	1KcnJry5IvZFc0+YG6OYRo21MVVZkcoquQ8ODZUctryv9dizNKItiqZNOq1s57/UFzMNbONiPUs
	uIXv7hx9+fkCMb6v/D7vetueWf8mOMuOYfDBgKiYGYOrOzbn53A1ZFkxXIbEUzZlfpYTLgARvUR
	NMtfjH4NP+3iXFfroUYbmkYp2uE7SV0rlBqxADI3sL/A==
X-Received: by 2002:a05:622a:5910:b0:50b:48e3:47a7 with SMTP id d75a77b69052e-516d42e5431mr40913141cf.18.1779439919585;
        Fri, 22 May 2026 01:51:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.239.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b25c69sm8468531cf.11.2026.05.22.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:51:59 -0700 (PDT)
Message-ID: <6a10192f.12ee227d.3179dd.95d0@mx.google.com>
Date: Fri, 22 May 2026 01:51:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6451430874001216858=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhiyuan.sheng@oss.qualcomm.com
Subject: RE: [v1] obexd: fix PBAP PullPhoneBook failure with ebook backend
In-Reply-To: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
References: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6451430874001216858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1099150

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      20.38 seconds
BluezMake                     PASS      679.47 seconds
CheckSmatch                   PASS      362.36 seconds
bluezmakeextell               PASS      187.61 seconds
IncrementalBuild              PASS      668.91 seconds
ScanBuild                     PASS      1076.15 seconds



https://github.com/bluez/bluez/pull/2145

---
Regards,
Linux Bluetooth


--===============6451430874001216858==--
