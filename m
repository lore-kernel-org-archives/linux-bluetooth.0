Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0136317B045
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546611; cv=none; b=OZB3XranNU+c+TPsMGkUhG3+PcJW4mMtbHG3UClbRQshMovaXfQH2ZlCVuabKU2X2E5lJYymYCm6XzlLWOwgzgoEpR+eSEyzSOQk/O3AW44/8mHBlMYAZikOToSc42P2D+mGdhPk2ZxiEoFqzKhOTgfYwmkCLfFWCopkAhYdu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546611; c=relaxed/simple;
	bh=f8sQ6R9FOaf/CGKcPef50qrPsWXVutxJgTQDZFrNXeQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cf4igB/0XbWu+ePFIX95KrJ2VVswWJCKCwpvCSMm3DqlLfdAOSo3PF5aDcJEjymLaQ8On/565EMQSike+fJ1dWBL0Tk/GK3Kr9YA7SIjq6ezTMa5leN/WBLa36aHbDZFJ6k49fqCI0Q1d1DOglywcbgaA34Ns3gmsoOOx42xTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc6+SX/A; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc6+SX/A"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5dc36b895so30902016d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546609; x=1721151409; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f8sQ6R9FOaf/CGKcPef50qrPsWXVutxJgTQDZFrNXeQ=;
        b=Oc6+SX/AOOmf+sl3rC9XgZqzIg+EuPIuNM3BmrGWTKm3KOoxI3npGGA4zAfIaf3obJ
         V2+1nJmbLGGCU3zLziapHDzuHNaHA11zGsQXb1gZTyf+5mEaKHjHb9VgD5uizltc6oyT
         X4UZJKT5Ks1bXsXYh8p8Dh6GBKr+N+iixCht2vaGmMyAtX7KDfYbjDhEkhhOY+SBfaQO
         hJ0JFYEBg/BUvG2WfZil83IdUT2Eq9y+zzVDrNtexrXfSyKA2uarNx0OhRikAth2tGHF
         Ig+fVFJBa4Ki16NimSEErotsuEYethaXzOhZKltMLsGWK6BIPYxJ4lZpCaHu7DoCIZbC
         mrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546609; x=1721151409;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8sQ6R9FOaf/CGKcPef50qrPsWXVutxJgTQDZFrNXeQ=;
        b=Y1/FCFdtaJLjsG3lwArmqonHKpYh5jHGmE05ESvbVUlyeMj7wh9mmDtM+npyhNxLGK
         E1mLiEhexW5m/nwNhujzdvLwcbA2G+AwrBJgMI20BibTPxreCTkJilNMlfsnkHpcezg1
         n6Rplheow+l+O3uizuh+A0CgsNDYm3BSaOrWU51ccv/s9GJ3mPuMoR2gH2eyNbES6Euh
         VDwF20GKilUIQ4l2EpH1UERIX//dV3BAjuUavpBB0dehGf34nM1h2wHq06NCO9i0I7bH
         TvYPjB6XtpZs3YZTPBnaKf65VTEwVSpvOH/vpehBkAziDkwab/J8YivaBn0QF6WaMWQd
         qgZA==
X-Gm-Message-State: AOJu0YxglwyZQ37GMpZLZU5AUdUiShPhCRbwWe8BL79v41eUOyI5l28+
	gKLu4nbfTxYfB551BlpFOJ/Ie6xYjPkMrpBOk3loMc7bfbVK0v2TxJ3UAw==
X-Google-Smtp-Source: AGHT+IEpSu+y1wWXFsX/nrhTkxR+n/diH1f49LaTFh62802eOLQsPC6vDAgWc0U/yDtruOuXUZoBEA==
X-Received: by 2002:ad4:5d4c:0:b0:6b5:2b33:5445 with SMTP id 6a1803df08f44-6b61bd0500cmr40383496d6.25.1720546608883;
        Tue, 09 Jul 2024 10:36:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.51.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8bd03sm10453966d6.115.2024.07.09.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:36:48 -0700 (PDT)
Message-ID: <668d7530.050a0220.b2392.4c7f@mx.google.com>
Date: Tue, 09 Jul 2024 10:36:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0189251735577292847=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Trey.Ramsay@dell.com
Subject: RE: ATT: Error (0x01) - Error: Unlikely error (14) Prepare Write req (0x16)
In-Reply-To: <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
References: <SN4PR19MB54215EF3B4E7380A21387D2EE4DB2@SN4PR19MB5421.namprd19.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0189251735577292847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/gatt-db.c:2127
error: src/shared/gatt-db.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0189251735577292847==--
