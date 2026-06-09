Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C840D594
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046127; cv=none; b=HFb/m8CvMVbgANynWtjOOrqAlASJfcO5T1EBIvkLx6aYIUsCREkDf8Otue2+k/ewDdZpo1uLUyp/KPO7aiUhBuDJSwARlAqqKGqIv3ol0Q+Jqc2siw7fQ1iuXbha39x4qpV7wmkvILuEbZnrnLojMakLDjkVtigAF9mbSLaNsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046127; c=relaxed/simple;
	bh=YGJ7odUnl//XVn7tjqMD+luswbV3XgiL2g9n7Nu8ilM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KsB8ksAhfMuu6dsGecxJkdshqd7+5FOEJ/7Kq70ieP+21fbeZosg2XUrLvryvBLEbMv87dJM/RJOmngMTiTVcn1nVYCVwjsCfv3XcU4fyNZKIVi7fBmPMOFsIk2WbHw/zeTtHrLO3YYZD0tQRsdLl/34RZJZuHAKSqUL8tAUVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA66NCtL; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA66NCtL"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43cce7db292so4303350fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046125; x=1781650925; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mD1hqateSfze8N5gmm2m9S2nnaUpIBptNxfoNJPndsQ=;
        b=EA66NCtLn31g2fa09AGoPrrWX5ZEE7wDeWg9bnLOCYklAl/pOtF2mVl1Fq3uoAkyBZ
         FmKGOOr9VSDp5cz1kPOyIdxcyohuq4tcdCTO72l9bQSTHBYKrrwFrTTTmq0e7xMToaUU
         IA4Ji4AgVKooJnMfjPxsVqHP+jMAkUcvkE+thiP4i+RfQW1Nnp5BYT3WqZ/WcbRS0iyb
         mWru/jLVO29gR+lhLE7x5pDbksf5Jb48GgDRMtBG3d1D5faudAhWImbQIyW7ODlYFrvw
         FcDIJZUBsaVdW8noHGq+T6uMVrXjxVsuOGFDkEDctSZSV1+EtuapNHH0o1dTgZOJxIiy
         gOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046125; x=1781650925;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD1hqateSfze8N5gmm2m9S2nnaUpIBptNxfoNJPndsQ=;
        b=cwaRpfKt0HLXm/wavdcfEKrx3Ey4IBvDDO5Tfh3d+Uay/AtY3vVMQycJM0+4+1HWn2
         64MSeveRNnikoWLqFPMbIpNk+tzg5Dd0vZ9reh0MzJC423Z9uvIKTJQvUiyAcHSByaCR
         rkQXLTDgLBlAy5BW8dtAZ4tHJ1C1NAGLADcg/+4qXmR4bFbhxtyIw6/vo0WkXniO/t55
         fRkT8tR5zSOP0NNd2I7B285OSBy6qqIacxKld4WlKs4PuE8fAs7M0IVFAAgJwhgDHuNp
         cQ/pij1BL1nviMiklU4x2c74GIE3Djh+ENfssGAxeqbSiZcRSOoIh5Q0Elpf2anQZweQ
         kG1A==
X-Gm-Message-State: AOJu0Yy0uRtp1DGCJKz8VOUq2pVzrX5H3VlgckacOzKFlehryuwdEpY8
	Cti0o/kiK0Eqxg/lQqbMiDla1RNaKUtGu+711k0l8oOWpB4036Tk9WS6EtbyiP2v
X-Gm-Gg: Acq92OHND7n+FFQXIjTS/fikYn+ETns5l/2CTpbR5suiM6ZPw1IODNOTDi6wbE7L0RL
	uQ8zZFZ/8BSI0eCRSz1x+uaXxipxkuZOZJKBdLBcRx5ZAHknWPclfS4UjczdWZ6jdkY7INMsGtH
	pDQvzGtQMl0tcpagykoNKaGx2mw5mFE/inkFofeSQEUfofS2rPkhbokS0LF1EXiUQ0s1zaX+NCX
	lK5gGYLGnTTGrJrRAb27avPqDtKRKNX35PK0aZZs7EPCMkYRFfGcC7l6JKayxf3qnhROytjMUnK
	4hmw2Q0gbIr5ov4iHfi4AxOg2v4BlmiLZWILxd//JGUb3WTKwGaPynKsyLyrNFiheirB2AVje8P
	N2mvovjY6JgXAaACNa++Nk0ewLXZ9bzn5CSqEM69XvWPJ0VVj2RkpSkDzYG0ouzW88kqd6aH5bR
	IA5JqG1Ne/DyRHbWLkpOErdk3TNpCY7CVnpd+5NWnz
X-Received: by 2002:a05:6820:a28b:20b0:69b:7ac2:5abc with SMTP id 006d021491bc7-69e68c1dcacmr9126264eaf.30.1781046125255;
        Tue, 09 Jun 2026 16:02:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.158.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda2601sm215031526d6.6.2026.06.09.16.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:02:04 -0700 (PDT)
Message-ID: <6a289b6c.ff298dd7.3321df.f2f1@mx.google.com>
Date: Tue, 09 Jun 2026 16:02:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3747669539853838954=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] shared/bap: Transition ASE to QoS Configured on CIS loss
In-Reply-To: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
References: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3747669539853838954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1108825

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.48 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      625.65 seconds
MakeCheck                     PASS      12.74 seconds
MakeDistcheck                 PASS      236.69 seconds
CheckValgrind                 PASS      257.53 seconds
CheckSmatch                   WARNING   326.14 seconds
bluezmakeextell               PASS      165.85 seconds
IncrementalBuild              PASS      622.35 seconds
ScanBuild                     PASS      935.06 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2209

---
Regards,
Linux Bluetooth


--===============3747669539853838954==--
