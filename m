Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508061F03CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046327; cv=none; b=H43PA34LNTOeg72oRc4C6N7gR3jpvoX3d/Ngz284GHX2xVoFrnlMzMhuoy1lkEOXyBMEK37pFb/RtsmLTmxANUUZq5QsvL93XV6walkPvF21VQ29Mx9xRFhEzxnwZrfiFwl38kkweqX3KuGQj88x41XM3+IM1f9nCMOgVAp6Ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046327; c=relaxed/simple;
	bh=Diqq8ExBS4TDoBkxZ0MRxGyhyB8pcC7QmyEDNV0l4Ic=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tPZCHdQ/ZM9bZ96H7X/qv385nUNQY7Cu95S8XDUtkSPZyP75CdMuaP4+RYl0W1qhshxogjezzrTWiRl4CAEM8MRxvgfsd/4qBJcgxchbjZIoTui/zociEHYhW/nmXypgyQwaEmRpTf1L3whtOuwW+BdL7GfcOoeNGdo+oBx0/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmyyHJ1N; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmyyHJ1N"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2211cd4463cso12919475ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 02:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740046325; x=1740651125; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FdOkP21TaYlsyPIIkg/Hlr0ni6+h+lt7dDKpc1OoWaM=;
        b=EmyyHJ1NW0DJ7+K9yXMi/5JcnSbpG12p2d5tnKYDl4IuCvpAnRiNHtA0wP5weerIBH
         nPdArC5LS0Nfi540iaIz3QnMXMZZXl0gWTMswRYG5BlDYR8mLdMHNjdKCvx1FKn8GLAD
         /2aI66ydIVn0MradgrOKFr0xxvXIlM1cQTnZr2ijsgTf//0HV+Enq1GSfQlV7pXBh9An
         IjW+dzOdjKe+H144/IgmKK/6CGAL3KFowFqaLzfU7DjqsgEwlCD5yET5upbna9vnZ5kU
         wONGN8Bwcp6ElKDPRq6EpdUgC8xtf1GC9WUy4fMRYtn2Ooy4JmLytPHAUBC0H3HG9tSs
         2GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046325; x=1740651125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdOkP21TaYlsyPIIkg/Hlr0ni6+h+lt7dDKpc1OoWaM=;
        b=n4cv2gZ3daw4VuYm1sdZhJZoqANCUAjHBe/D8gRl2bk8bR7cEFxHA0RjNsOZ+KXi+F
         voTZznlIfro1NSyFGeVez6EJQGm4SX7hGR+LI2qxSyBvG3FWycZu/SyL3NnaNBTEmdwL
         tUu1TtiG+5PCgS8wCdEhkqLzgEsuVnoWsASsYpflpMN60vTdhuRYdmMUgt8YjnbHC5dP
         EF0/a4S29CjpwSFm/BIk91n2ms+3KPY2mg8+feciE6ZAvHg/wWmDmxlZnx4CcLoIFd9h
         KoyOnxblevqSeXT7alu37sxMRLjWZB2/LZ47pezHod03LBRlJzLjd/XnT6A1yoKgQ3cD
         UTaA==
X-Gm-Message-State: AOJu0YzLPGQ4Gjj5NRsKIZh8GSjPQpoZDoTn6z/1t6clguuePtYSpc+8
	t/TlXe+YKPR6t6pGxigOHxefE6hxtjapTHhD7zOhSGeocrmYtG6SgFZtpg==
X-Gm-Gg: ASbGncsBhS+2bvaHk0oeEEfp+WA7rkkETUxYUgSsSXYsl+QkFPNobPxmztpbMzJMMEL
	wp0oxssPjDp7Evb/Fxdj5BiuMWmmAM8NNTwB6zM87B3uGuCZX5duvo0pzMdMxAo5rBBirhkRUxu
	DABcpcMpe0xlhZRUlzfaDOV+TwadWEXQ+5j4qRssI6ZqRGdMVoZ9mSxDB635svDI7ek3BWVu6L9
	Qq0VjYhMJL07uZDun4DMbSZZepFd78NzaA40b/WC405Lx3KEDLQTMuEC73F0mtZtdIKRnlKZptm
	q4Y9rors0FYrnHt2MVnW/w==
X-Google-Smtp-Source: AGHT+IHBSKyaxq49e4ay2LvKD/c8rU1byqoWnAo2iGsTJgQP0yHv8wcYpOd4zGO6Sl5WTcrYRk5pvQ==
X-Received: by 2002:a17:902:fc4c:b0:215:6489:cfb8 with SMTP id d9443c01a7336-2211c554f8dmr361955525ad.10.1740046325329;
        Thu, 20 Feb 2025 02:12:05 -0800 (PST)
Received: from [172.17.0.2] ([20.169.15.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53494afsm117407665ad.18.2025.02.20.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:12:04 -0800 (PST)
Message-ID: <67b6fff4.170a0220.3a1e25.95dc@mx.google.com>
Date: Thu, 20 Feb 2025 02:12:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8084436872541703071=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] obex: Add messages_get_message() implementation for MAP plugin
In-Reply-To: <20250220084349.466770-1-quic_amisjain@quicinc.com>
References: <20250220084349.466770-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8084436872541703071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=935896

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.98 seconds
BluezMake                     PASS      1538.43 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      157.77 seconds
CheckValgrind                 PASS      214.57 seconds
CheckSmatch                   PASS      287.09 seconds
bluezmakeextell               PASS      100.70 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      887.16 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8084436872541703071==--
