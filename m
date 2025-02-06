Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA9198842
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865401; cv=none; b=MFGqWcbP/KDtTL9CnmuVOcLQcVikx6UGd4EKekL2GRWZPzPGIELq6/k12WAC2qFKRTeHQzRD8Dwdtfwq+ztwVdyyYJ5QcYzMdSCH8ieXE0255uYbaWIoHqfdLOWwIdbktWRTKqn+iRDtDEHKYf3MzQWzlQ9eBVonEecfUgY1PGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865401; c=relaxed/simple;
	bh=emk7zqQBr8Eqc4lbWEUkHBmx9/qwOcdF7bmCAhtKVg8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NQpR/3xR/1lbFiGTEzm6Z/o4vU5DzdXI64hjf+qFCjNZtbpydE2gbWBc0GTrwncAb0PmPXBlY52mW9K2hbYsy8WtNuEnG1ch6iVx+f6oa2+ClnXwhSJeidpg+7W6bqI0eTOk3BvCox42OuC0AL1VNabcWmlkbmoEmz0IAc1LaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRNQGPaa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRNQGPaa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso29678095ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 10:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738865399; x=1739470199; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n8UPi0irp/saNA78sBKgsRtBqE0iNf7gnZc+uS1enws=;
        b=GRNQGPaajfjFHJnsUmBvUYA3go5YE/mO0AdpzocvZjnIhfbBnBLR8ZuvrIGsTUo2Q7
         PsvEs24oa1OBPvCHtLeLItjYWMmosDkkK24fkeJWkJP2mc7xUN0ROFkcRskIEzNmFTAd
         pYMi1RlPajTQQWt/pjKHyelma+Z9i3KINMWm/5uOCpJxz0y2jsYYtvlsX5wYlMuhOezd
         V6CkboZ/dNNOobySXRPwXW+LYd7SRvNnxpsvT3V0JgWC7N0nznCsWaB462VSL6VCCtts
         uC0Pik6e7iih6yNW4AuOlxDffwvJModt7cWDm4thFSl6zuo5gWs/xbZxBrcXQF4tjmLH
         li+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738865399; x=1739470199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8UPi0irp/saNA78sBKgsRtBqE0iNf7gnZc+uS1enws=;
        b=Gm0Q0gdj3g9GQ68k5hwoGqUW+N86fa8MGeR2Y/aKag4nK5f7MuCJuzsCTuH1xo4VJu
         JneyV7Oi1BOAbuQ0SFDeISny7J2oFlew3ndjgylzYZjkVD+aqQhXDE4+8gDV9uXqwIJz
         bhC046jBgrpRG62b1NVq0QJKva0wTouOGAtyyiBr+8fobDyjnLNggHaL1SHUjhpvsNig
         WyVvB54srJoctonaOaCUBs6p2DXv68168JgfNlC02+yn/8YKtB8+AHPQhDGLuyclYSbO
         Pn3nZM0eFaYmyk8zPdEi4wrsrlNSpKdZvDLGPuwEJTYOV+QFCdv7hWQt9s94zhLR47W0
         W0UQ==
X-Gm-Message-State: AOJu0YxDTN4PqLaDoja4uHYUZh22Lv7nIeT6kUb1Yj9/Xu2S76JP0cpH
	KIPst604JKp3BgeKWiTmGzRal4UyFMaL2QCrILUTD48fjW4c+QNeypZYQg==
X-Gm-Gg: ASbGncuxxpMjzVrROsPjdNykyk/oqB9Ccp9MReQWQZ0OjTFF/KfJ+BNn41xiQKGtdp1
	L81+hL0eCP+bISh3/pbyYrLEGrkFT//TPru3wJwkUoa3K6L+By8LT1Sa5QIYBSPSPnzap9RPVfw
	a/DuMLKwWXKOBqddNlk+PkEtc3x9Q6j9hXYY8SRdpYI2i5NZocf8uLAphE7nYJi5B8DFeNM8F1p
	n+jSGmdW6sfEu23TIBBnedZyE3Vz1g88Kgtlk4LzEbwE2tl03224vpiUWm5xHk0sud6/QzFCuEx
	GzSq2ExbrgSPH9aj7QL09w==
X-Google-Smtp-Source: AGHT+IFluN0hK+wJ842VMexAbxfm+axMHAIOYzVpiTuzEBtkVsf85XeI9akYJgtsBHc6hrCx5HQyKg==
X-Received: by 2002:a17:902:e802:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-21f4e76372cmr1300145ad.45.1738865398718;
        Thu, 06 Feb 2025 10:09:58 -0800 (PST)
Received: from [172.17.0.2] ([20.169.14.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368da40asm15948555ad.257.2025.02.06.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:09:58 -0800 (PST)
Message-ID: <67a4faf6.170a0220.40bf8.e1e4@mx.google.com>
Date: Thu, 06 Feb 2025 10:09:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1872274006808816812=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v2] obex: Add messages_get_message() implementation for MAP plugin
In-Reply-To: <20250206164852.3649751-1-quic_amisjain@quicinc.com>
References: <20250206164852.3649751-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1872274006808816812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=931275

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      1598.52 seconds
MakeCheck                     PASS      13.92 seconds
MakeDistcheck                 PASS      161.51 seconds
CheckValgrind                 PASS      217.20 seconds
CheckSmatch                   PASS      288.93 seconds
bluezmakeextell               PASS      99.55 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      885.93 seconds

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


--===============1872274006808816812==--
