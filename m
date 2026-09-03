Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79C4BCADD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446852; cv=none; b=r58GspyZXF3YYXTHT52Pp/OVZy7fPo+npmZZnIBaCt47zRoTgyYkuCfFHJKI65+5QuIA2//w/h70O9nYEroMFIWjhUoqeLg8fCLOYkImgbvseKlq5yIumoFzAluE/9laPe3OwFAtgy6wIle+/ZfswO0XkSve/wdbP/NGb0Xqt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446852; c=relaxed/simple;
	bh=1/Huyjp2BtQDweJapnx85yigHy3PuVxkERFl01j88wg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=twrybN67SGWj98F9h1tQjVHDcp1dpraqJtd0V+vktLjEyGC9UqlP/abG9ZMvaEOCm1nVPMNK7vBaAoFdSDR5PQHBHMazmG9mDzwQZ07nU6ocxrzOtOmRQfwNHR9Wgu/XOeLV1dydD3GZ/bV9efUb4qGb/tFWQd+gPqEgIZPyyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgnNgOnV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgnNgOnV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d9201076b3so30650385ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446850; x=1789051650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1/Huyjp2BtQDweJapnx85yigHy3PuVxkERFl01j88wg=;
        b=RgnNgOnVO4YCPhquap89R11mmcrrwTMumjbKcQteuys+JJY1tZ7twLxKxrrcZSBCsh
         UGG1P+aHElXsJFlBUFRpFQNqYFseS72bsz44zY3m6v6XEyrVJTwPVL8ItQao0sSR9giU
         OCsfx6C1y8yYz3bw//J0sn+hY/WU336gYlFMG1qkej1DHHg1z7hUGRWJ5A54iv9L1dki
         CgGSwzsG21jP0ACe5E6KbTdJ3b288j3qyR1G0Ccq1j7g8YRnMlgN3gFMpeCCRdjvEJzE
         CRphRXX1VbjE08E3+YFyColTvaUxZg88Qe3ajNrSslGHWatsPw8gxHURHVaz610OFaCt
         3CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446850; x=1789051650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1/Huyjp2BtQDweJapnx85yigHy3PuVxkERFl01j88wg=;
        b=H8elT09h1sLcwrQr+Qbo3xZgswccIVKyn/+sGggX6nPhZZEbwtLTDVhtKDRVjExYdf
         JJvSpiC5ZJxqL85zuxvDX5J3wbZQUWQWaEQzbjrpG6D+DYg4xbxdpRlp80b1+Puw+Umx
         erC2+YoMRRfWIl3yof6wPqbgvVyWfz3VrFqNwf6Pb067Woc7OoM6AEXVbvdpNQe0O6fN
         hIv/hLQNFI3m2ufSycAptg5ZTo332HlHUf7sV7PzRfQixZc0Kx7Ixi9Bx0O40n5pwOVi
         /ZqH3975jthiSD4CIREo2AqbyLODjjDJT/nIOf1x4tmar0KFbTVFO+OMwxPOuSWQYCpn
         um6Q==
X-Gm-Message-State: AFuF++lYF3+VKHJExr7HjUXHBvjsiaJxYhzj7LM1oDG4UzXIcDYZ2PFp
	2CJhnsmIDPS/vAN2HFpyBSettukx8l6kayeazDzaYFTSn/VHROwBxWAyaH2nTg==
X-Gm-Gg: AYBFou08gjSk0ERCTpPpnWjOQ9OTSRwbW/8Jd+ySrJuGClNIoxHJk3Vg9ojhKSo7MUp
	EAYCfjq2NZO+Sd3LhqjuvKemyvVR4Q/FgeeGt30dnnzEL5do8qUTRmI7NS1KQfNvsHBNLx2MmPX
	vOVhAjnMDeml/k7WFdRExhnpLRqw3pxMnot7OvhY5yRP49HGVrcthwjIRX4n5SvusPpuIPavbtj
	3GyKY7X2KXKLubzf/pFNCG4MggznYMB9R3x6/ceGXhkKBcdD69ZCQnSrk8POTaZNNBGn+93UiK4
	LaEocljfGVdHZBc4Th1HmOIrKg2BaysUReIqD1fa44twFUmIwD1QsoR4W+jqcQGQadeEeGv+rf2
	nyXayK98F1C4tI7ag+HyIhfC1frOJxZIsDzcoHlqjiAbh8PThfU2fCllwOqjjL6coa6+mYwDXqM
	183pcWMwXsw6E7bpEbJOwMHzAW6jiFRv1Zn8XYDlNiMNl0fzmWd/WIh/2fEGRFcPypfIFK69Q+y
	wbW8w==
X-Received: by 2002:a17:90a:d403:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39aedfe2ef3mr21269060a91.8.1788446850160;
        Thu, 03 Sep 2026 07:47:30 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.141.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3325680c369sm7056354eec.28.2026.09.03.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:47:29 -0700 (PDT)
Message-ID: <6a998881.160324b0.160b2.c178@mx.google.com>
Date: Thu, 03 Sep 2026 07:47:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6269571374492942051=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vladimirkondratyev2@gmail.com
Subject: RE: [v3] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
In-Reply-To: <20260903142911.125301-2-vladimirkondratyev2@gmail.com>
References: <20260903142911.125301-2-vladimirkondratyev2@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6269571374492942051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.h:53
error: drivers/bluetooth/btintel_pcie.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6269571374492942051==--
