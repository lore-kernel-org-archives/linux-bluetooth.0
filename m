Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99B1632DD
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782754674; cv=none; b=GrPxPUOVe7N9YRWqxo0R3A2mKBrzJW1xQ//RXjkO7ruwGKvDr6dm7BJRnHhm9m1IhQNS9R4rThes8tIrJg8ATzZLLWKGQDdRn8BOmIrVplgGaBdIuUBQzLblwL3xaR+E+9joSZgWrKvDbw5RHi/lLexmu28vGi4Pvx6sMadew3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782754674; c=relaxed/simple;
	bh=iXldMiOCd1jXVHvcYs08c1sajMNaaiK8D3JF6IWoYUc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Sj3YrIMW/yIafyoIhfYZBuw1RcxvFwZOax/Y0Xfj1VObBuDX4RyC4gRAYSho5STXQnhq45yCwEisgvcqM/URBjPSoUDObbzVmSzvHe8qzaupnOZYNo0t6wwneSI57HE0DAbaeomGR0m3+vb2k1G1IsrCBWad9yaamHARv7JRiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy45IYKo; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy45IYKo"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13981833e13so4429823c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782754672; x=1783359472; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R6ciW4m1nueKaGq1p2RBhz3W5ESrCnD9nvDm+C2UiB4=;
        b=Hy45IYKoFNqiP15OgHAqxW1xGsYXfpmTObp91UR4TnxP6WBPOCqAhYe+tsn4/MZdxz
         v1YcqGGyh0wpdRknJ2NKd7CmFWCbo6xwgQ3HU/Dzpy/ueM10tnWDEj21t3fSs3EuBM9P
         fMJaqdpEUX30ISSbHvcRj57nQ62YZz+L6rKVZQocePcaos+SQTeXfIbmA3Mf7mYbxiQe
         WLUc5HcApljOQcx6K2tz42YQ5WZAqBkFQNxBvJVbSXEQA9bMLf+8Ar+gXXXr5YSMFuO0
         iK5soG+epwS+9yBbtp/OZ4ju+LNcd1DeXvBhLNxGWIX1kQvV1CY29zCUShF5pYtGGZEx
         Uwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782754672; x=1783359472;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6ciW4m1nueKaGq1p2RBhz3W5ESrCnD9nvDm+C2UiB4=;
        b=M2AmLTMQnhgjVNhadOsukVGz0TkX6KmMLX8j6AIlEzMk5siWdIiMnlkYTtdSbz69uw
         HD7fbHbgSSE+Wdk7ZhK2ZwQWSD0ciyupmcmcVQsPqmVJMIdoPdQRurMSXtNEBx0rMOYn
         v71XpZCbjB35kWFiQNoHOfZ3bRdURfEaM3ZU6qbmbzuXOWXHYH/rlopaD+jhV3smii9f
         Vn2ST4Lz3yneSS0oUkZEVfUPulHWjFf2JEc3G9+3a30tPCITJGTQXn8hF28WaQjBXkf8
         /sCWAVr5c+mLTTIdDEjbY/z0/0z46STUk+8IC+m01E+4weJKKyc1WRmcfdQLD8t9EGTG
         dDEQ==
X-Gm-Message-State: AOJu0YwCWPo4HLN8a3ZAlZcy0Q1EUZgFsWAce9b8hD82vdTT5MkJxKYO
	Tgh/KZ31+u92vie/a4SG9g/WopjVgtimZ2VybwVJMQRdbcxbjdPa55aeAZP8r7Hx
X-Gm-Gg: AfdE7cm6p4B2PqBNKl1pHIsuqv84YGDbq129rU0YLHGngspV+zLP8Py3N2nSeSZBenF
	YDCCrVFtulJJoHAIGXXSb81gAzxibJJzk4bWvnO6/Q3b82ysmi9raapIlHX824Z9o7lqrHqEtL4
	5uBGmKaPgNQm/vj47iYbP840mHRv1DgRnnN4qU4r45AgL0zfZhBwjgaKpxYiuS7Q3PRgeXDZ49w
	TFgvxou+p80L58DtJGck82PTRhZQe9/zcAY8HOMkU6r+6P+0qFdhQ19LSJ99+kMdlln1Puhgsz9
	u4OmjHVtsDtEoucshNVEyA3arwO38wU1QjnL0E3EkbewEVSgRoNP6WuJ4xViY2EWWlSGs+FLLCk
	w2a5u0MEDKvH4+X3ZWqHtaOwS7uNEN/mtP9o3D78S9WMKL/bLJBUbYxNl6ZEiV2k2re00idYCzu
	pO/gdAsYk7g5WFZzJia+s=
X-Received: by 2002:a05:7022:672a:b0:138:2c88:b3d6 with SMTP id a92af1059eb24-13b2a173399mr226243c88.18.1782754672265;
        Mon, 29 Jun 2026 10:37:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.131.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30edcb595fbsm4169200eec.21.2026.06.29.10.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:37:51 -0700 (PDT)
Message-ID: <6a42ad6f.a87eb5dc.95ac7.d454@mx.google.com>
Date: Mon, 29 Jun 2026 10:37:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2774973823406248684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/5] bass: Fix possible crash on bass_update_bis_sync
In-Reply-To: <20260629142649.966025-1-luiz.dentz@gmail.com>
References: <20260629142649.966025-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2774973823406248684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118322

---Test result---

Test Summary:
CheckPatch                    PASS      4.37 seconds
GitLint                       PASS      2.74 seconds
BuildEll                      PASS      20.52 seconds
BluezMake                     PASS      528.64 seconds
MakeCheck                     PASS      15.00 seconds
MakeDistcheck                 PASS      155.99 seconds
CheckValgrind                 PASS      206.07 seconds
CheckSmatch                   WARNING   306.66 seconds
bluezmakeextell               PASS      100.00 seconds
IncrementalBuild              PASS      586.32 seconds
ScanBuild                     PASS      949.69 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2257

---
Regards,
Linux Bluetooth


--===============2774973823406248684==--
