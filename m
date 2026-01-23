Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B428145B27
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190053; cv=none; b=CK/JjIxdwyxGdBGHO0UWbdRPBF0vcubXMXCrSHQ2lqp57gcZ4uCHYdABOLZ1+jeG1rjrvWw4TMj6gClgAMMz8Mbu04ZCcpBFYHv8FODByyt4/aMedxEUPMB7URXlmeWPTMPid9JV2t19jaWq8vKCSBPHAMgfa5dhIpy7/3c7Lho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190053; c=relaxed/simple;
	bh=flipDGsi7CFtB3CY4kgWuoXaZRtj3Wvh2L3dWEk4CVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=c8/sTfmluAPxByYl0/66Kmk1PD3w6We5smUfkv0300N22pKA7/IwNxPup2XbQptovv/GmwGzlcIYsHlP1aYud92TlgDK20YBolMxAJ2U9t+sJHIMXKns3dV7Dgqq+32A/aox3pvVk+HpZFbV5YwNNzlyiV/2mOVtGdwfA/I4wzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOjiJyLk; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOjiJyLk"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b714f30461so2312882eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 09:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769190051; x=1769794851; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N14sAgDzzybJ+jGyP4EpNzjDI3WDBQ8mUqLeln03KHg=;
        b=cOjiJyLk7HGro4XrmSTtcfyUwSkg7hwT9TCjdkTIsWlH3Ra51wSIXymi4vujRylfRU
         48kTyQJ51dTQ4+FGyRrcOutATbAaV01lKDzTvvJJbMqDgBovNOYoF3YNFIVYSlKrb2In
         YTUdbOi5SNqPG7nv0pS87ZCsiDGmraB3INb8SMyYwJTVdJhp5ILkLBJrCLMYPwtSBLK/
         EW40luI5EolYsen3csv6IofTfDE8gG7+5klkNSr9VEqqm9IIqTaY4Q7DvgDXmZHvXvur
         oOkeKWJnzVgqmHiGoePYygNFFoqX77+lPm/0MC1MSfznQnbG7coCKovdILUQCkvCZlT/
         gdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190051; x=1769794851;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N14sAgDzzybJ+jGyP4EpNzjDI3WDBQ8mUqLeln03KHg=;
        b=ML4Q+vtFg+D85XFznHqQnMqxb5FRyRjk6G9TZXViS0pza+0JInWca424HKaM2bHS7E
         Ry0dXEfvG80CNkorWoz2L/urQ3gOgd+QCIvySQfc5YTH4qWcEzy0w/N9LPLH6nHzLZIm
         03VrBIg1SXx3xogb0U83ZQiQcxOMFKj+PwZlPtySxikQiPqTkT9qC618S7SUlLiOUvvc
         aUYfuVvxlwgHAB05T8Wg5/g5tYy/t13XNXCJLRVS+0b1bINb22f4V4BaE0gpUqo6HacF
         EhDJCNlZGN/Nbzj8pVyXLH2up7n6OpOJ++fk9JontbERy3KX5fgXPbzTuxL9i74PL2eC
         ZH3w==
X-Gm-Message-State: AOJu0YxUm4A/BrdP4rrZY53RPFZzrHAyOv9TOFEyDOj0PO0DfyORJXz0
	UPu4/kCLh3wSoAmT2E+WZFItjcukNeEuP0l4XXPhudoI3g2pu8i9Dr1dcLJvtA0N
X-Gm-Gg: AZuq6aLF63OMW+8FMqOLI/zTco94+9aQWwQ4cPWFDRKdIeB4Fbs2UTomz2Pkl09cJ8+
	INAwm1NDhcZDYHH6mSrKbe7SJtszvKr0o0o44mVGA7QnXGVwJ99DU2/RrlgyBZTW9Fa8UJkpDIq
	tnoHRpdak51CsvgVXoBvU8jB88kGipfqJ9UHosDkxCHhQsmDUZ+HR+CQJABpKZCkWyt7axUhW38
	Gt1aBPBz/fJM4JyAfAy/N2+cbv7zqQRwjvLU7bYT9nrGtaQ0yUa4ml7FReKW8ivdwzP3X4jmNhc
	Uw/4JXF7YgP+o0+MkPUImiFOAkp/TUq0RDpWcg0SVqviCvT4U0N8iOli8c9eSqfiANbptkmos+o
	BHi0b/FKuAHT5tp8T/2gGdmZ68f6Xv/cqZ7X4tgSdKHqb6rsznl06v2pbCgwudT42Gbw9KrGMQq
	q+HGiWdjzUufHAdeAmxQ==
X-Received: by 2002:a05:7301:1e85:b0:2b0:5342:e00a with SMTP id 5a478bee46e88-2b739992d33mr1455045eec.15.1769190050980;
        Fri, 23 Jan 2026 09:40:50 -0800 (PST)
Received: from [172.17.0.2] ([172.184.210.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1ad3sm3741080eec.19.2026.01.23.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:40:50 -0800 (PST)
Message-ID: <6973b2a2.050a0220.7a880.347c@mx.google.com>
Date: Fri, 23 Jan 2026 09:40:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8131532333354137199=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] doc/qualification: Add PICS and howto for the SM qualification
In-Reply-To: <20260123164733.855824-1-frederic.danis@collabora.com>
References: <20260123164733.855824-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8131532333354137199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1046381

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      649.14 seconds
MakeCheck                     PASS      18.17 seconds
MakeDistcheck                 PASS      246.43 seconds
CheckValgrind                 PASS      299.39 seconds
CheckSmatch                   PASS      354.66 seconds
bluezmakeextell               PASS      184.91 seconds
IncrementalBuild              PENDING   0.40 seconds
ScanBuild                     PASS      1032.66 seconds

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


--===============8131532333354137199==--
