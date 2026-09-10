Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA136331ECE
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073913; cv=none; b=j49ElMx8jC1W32IBTEbXRz31OFVgn0mPJeEPqm7+3D5AZ9bEreb34lgeNF7efDEpq8U2TDeYaBjVlK2bwHvftysMpaTlaF2X5+hhOVjL1CviddTmA8pCnFVQ2rmJWn64H0RokmjE2WatttK8Ice5CjE+H1IXx7aGBmwhargyF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073913; c=relaxed/simple;
	bh=AGAJRW8x/inkTPZmOic5kEyCq3OHU2K+erPiR8D2WAg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kYW/7piQQFwlqlU4IjEOvL4KZQPrwsgVqmCUU9e+U2C5GdntQoG+HBxyjHphaQI9GXAQZuCu3+FtruAqiI07P4SaF/+UKBeyr/CGdHCjWGYEJsQXGEq00kv2q45nWIbX741Vg3fLOEzeLLcTBqD3VT2yQad5MMJOsMm+udCn2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNivopqz; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNivopqz"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso261826a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 13:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789073912; x=1789678712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IkkAxnhBJUNsommrm18H5rb0BVmqp/PcotncnwLxmig=;
        b=cNivopqzL3VdEcNA/qyVX55KWsld/6XrBn8gdObZv8PbFRpVlrYRiECfW2TQvghYUi
         ADmSDvM5USvxGrh55QJsk6+7LagrLTCUYF+l9S0IUS/SU1Gfa5x/uLPPkHtKAHv3h+hL
         X4DTjyZDY5IBx+2C/7uBvK3+KVUYYpaATkkDfCsT+Q9cRDnIeEWG4Qp6J6N3YnCcRK2s
         yinnREeOd7OE5ZjQ3mjHJ2CwI4q2Nqx+Bh1KYdgpJb8PFjysNqXsYjcSy32kQGXWT/1o
         5OvU0OWAI/wTBiv9e3DHyXH3X/BlQn7jTzK7YnqakeO5fAn9bmOVQJa/7DbYn4RSAujr
         puLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073912; x=1789678712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IkkAxnhBJUNsommrm18H5rb0BVmqp/PcotncnwLxmig=;
        b=AcjnSBEWuVP3Gb3V6jCI82BmGZQWVpt022bA2kP79kOUBo6lxuyff+tNmXb7rVl5Y4
         HHyVdGy8PkShfwNuFAN4W4rQwiJA4V0bcCfghckdwxHiWUsf3esuLI6nQGeKatioaaO2
         5MGImokVLtLuBugpbg3Fep7BbMJb0XVdOyOFk1GzSicVscNdkLUpl0t7oLAN4Jc/HUMC
         wk3pBYBQ9uMOo1kBkbY+0lgriVzfA0+WuyehOUAbJYbrIEg1mwobAeicg2NXaFQLmG+u
         7ZysWNrX2EoaO6H7ptHGCr6V1atoNl2ZA2BjsWFK67Rb7j4A/sYtv8hyNok+jRnP+vFX
         Pckw==
X-Gm-Message-State: AFuF++lp3Sv+h7DYVw1LM6YHoDDwHUz+9G1Pe9wS5h6EmfTuqKKXfzIF
	W3Ry9/a1NN4VhnT3h0BTzx0TYRyg61EYib+Z1veMDcbGesBm+qi1hOkZqU+Yaw==
X-Gm-Gg: AYBFou1vpS+lWMJ2GKnfD2iPyO5LG+B59cBEsMNjXhSnVF9lYAEPhLxR1WqPr3LuH1j
	zq4VwdP0ElGO6Z/jb2RsGWrv5R4K0n3voZZl8+qMma7s2AfcqD6c/A4KvtVGB8NfFBCnbOAoB0k
	490bDBMhdXvmfGpafnXmGsCGQMRwiKqhzgWVt+MkChglP+F5uPD5tyTOqq+VB1o61sJ00vtPQ9z
	96h0Oyup3sKgcEHzwNV6HqEDPkMhrfSs8IwFeBzUmANiDScwai0R83Ods0g9YDgdax8/7W5kqkx
	VYV7UDdlRT8nYG60Lpov2JxEGF6mZvB7JXWmN0eWJVXNAS/uMjLg48+sYJPNwtC6xz5AdhPB1Lx
	npT/XN0CVL5WlHHp/PhhAJKfNf5GFx5/NQs28o867oMIWCtbwLfcQX8C/hjLlyXoJknFTqGPdJn
	60MFUCWS2lktGeagRNNbD14zvJfn0iZe2w/gsNa+j2Pc5oXin1eoktB1BBgUhp5k1djaRmXMkUe
	cbFJ/6LwL/Qcg==
X-Received: by 2002:a17:90b:514b:b0:39b:ac66:bbc with SMTP id 98e67ed59e1d1-39d9bd5e466mr1068937a91.7.1789073911918;
        Thu, 10 Sep 2026 13:58:31 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.4.122])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm1193180c88.7.2026.09.10.13.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:58:31 -0700 (PDT)
Message-ID: <6aa319f7.ee10049a.d1679.bcc9@mx.google.com>
Date: Thu, 10 Sep 2026 13:58:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8677278751694424584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: ISO: Fix parent socket leak in iso_conn_ready()
In-Reply-To: <20260910181206.1558734-1-luiz.dentz@gmail.com>
References: <20260910181206.1558734-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8677278751694424584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1162293/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.43 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      23.94 seconds
CheckAllWarning               PASS      27.45 seconds
CheckSparse                   PASS      29.57 seconds
BuildKernel32                 PASS      24.43 seconds
CheckKernelLLVM               PASS      24.86 seconds
TestRunnerSetup               PASS      598.80 seconds
TestRunner_iso-tester         PASS      63.84 seconds
IncrementalBuild              PASS      26.18 seconds



https://github.com/bluez/bluetooth-next/pull/751

---
Regards,
Linux Bluetooth


--===============8677278751694424584==--
