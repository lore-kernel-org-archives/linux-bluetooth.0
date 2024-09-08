Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F599181
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Sep 2024 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725753885; cv=none; b=HMLYh3p7ZPe9eRiEp+ioeZer2frmzL/IVwcWrsVu9UvHElGZrww8Jaovxb0DKmDPRL/4YaZphd2pmWK5k/i0uMKgXHjXFLKfob9eHqs7V05sk9wIHt3vh+LngekjlFvXK5KsYbesSv/d/GVl9w9oHfr/6QLMppmz7Gs23CXMbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725753885; c=relaxed/simple;
	bh=cl/3O4fEEGeot/e+PENThgKNggGjMoiNujeS1UHSRXY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HvvJ+5/GN40zlbWZgbnH3/S+ETP3apb9Yp8H+IyN9mevDx7qKg6rh3ZA7iLmkuCFqceC/N3CFxkOUKwiBdo85Rh0lTG6MsBN41NZwthxcPeZkxcCy7tHx/bTkUCTWa0KmzYrl3felhqf9FTxjCIT/nbNY24jfLrXKcmaV+VHZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsT2CP8s; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsT2CP8s"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710dead5d2aso317782a34.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725753883; x=1726358683; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uDSGEoBPNYOCtF++Pw56LyFPqZTEhwdoXYLML/cI3hQ=;
        b=RsT2CP8sK3D+omNUlSCIWozGEFwsFUClr6E05+0g68voGma/ZY5f9xoKYGVbV8OjFG
         jXyJjmb28wY5TxGPQvM3re5eerwfg9GtiIc1RopbHgo+2KtQAdR+NPG5WIDmk0Vfn4Ie
         qKBu0D5xsSS3NQqcEECLjqAz4G6W0rQg6HtY8BJMdcCQPLhZ2wVyvSbXo9dcKn61FsCa
         Ywp8ldIpmdpqwR4tqsXzIvWg7OwWPMk5HGi7pTRFeFxyLsmiawV64uDoVRlIR5NmLJEO
         7FjN7k29GBverXNRcRLVOJfS7nueDxFtIHISwdXYHhSn/nlvl8y+zmn6Vp+lEhqjpj75
         45Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725753883; x=1726358683;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDSGEoBPNYOCtF++Pw56LyFPqZTEhwdoXYLML/cI3hQ=;
        b=Tu0ZJgv5/ykXOKqiy+xtzII1WrjIZrB2zdgs9HGZhoe/A8AeSeYOn5QiaHFXdCbyQG
         +ctyG0Qv7zYpNwqEsQrAOfkI8A3W5d5UCldGABTCYXB9DOFVqe8ZnV9PrsX/xYN0Q+Mk
         gnKIC5nhqI0BU41w9/ICkuB4K2hdVv9ZN3AOK2epqUnKIBr1nLXTjTOVW7GqwUGqo7XK
         hfPcn0AV4G94wSiZg1/QNMel1nz2Cyld1kINKAfq9FWpAu7dqpexen2EzNYDuVebaxb5
         nrr9BrzqgI1sCXfZG40ryxpUkdzvVp6+mujYAsMEVDJJUQ8rQLo07H3OUxWMLRMXdsmh
         /88w==
X-Gm-Message-State: AOJu0Yy4hINMwLF6XebQnQ/nGEL4Esql93WXhg5+XiRZ055qmsnsoT6m
	CwLtK17+TDO5kEW8071whlVubPVWmwnTtCw3yh26TH535Y9pMAa7WmYDCg==
X-Google-Smtp-Source: AGHT+IHRM8qbhxPCeXcewA8Z2f1dsi98CNwF2Exx+M3veHxbZCbaahUQFgmV2qoItwYNbs7qXFNb7A==
X-Received: by 2002:a05:6830:2b0a:b0:70c:a521:7e5c with SMTP id 46e09a7af769-710d6dede46mr3916176a34.5.1725753882784;
        Sat, 07 Sep 2024 17:04:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534774752sm8573526d6.117.2024.09.07.17.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 17:04:42 -0700 (PDT)
Message-ID: <66dcea1a.050a0220.3797d6.29ca@mx.google.com>
Date: Sat, 07 Sep 2024 17:04:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1320477737077082335=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vibhavp@gmail.com
Subject: RE: org.bluez.Device1: Add GetServiceRecords method to get a device's SDP records.
In-Reply-To: <20240907213301.14000-2-vibhavp@gmail.com>
References: <20240907213301.14000-2-vibhavp@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1320477737077082335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=888047

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      24.72 seconds
BluezMake                     PASS      1682.04 seconds
MakeCheck                     PASS      13.55 seconds
MakeDistcheck                 PASS      178.67 seconds
CheckValgrind                 PASS      252.77 seconds
CheckSmatch                   PASS      356.35 seconds
bluezmakeextell               PASS      119.86 seconds
IncrementalBuild              PASS      2978.48 seconds
ScanBuild                     PASS      1001.94 seconds



---
Regards,
Linux Bluetooth


--===============1320477737077082335==--
