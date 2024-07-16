Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A0D19F487
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147883; cv=none; b=HfBkraEXVHK582JHxWwxLy56nZl7A2m+VBVrhTXa/UQj5p3AG3PkcLHT2eQ5X/9HrPM80x/pymjUqaghAwBG4RXXoNQ7dN41b9cbpEGc7dMWnawiwnx7FWKhUgb6NKXWyiKWdpigZlpV6zAmC5+lnhFN73cBy+z1tkESKtyiAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147883; c=relaxed/simple;
	bh=RpcPERkgibU81bHaUob6QB406IDZtxsU08XcDuRvNSc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=no4sfB84AtEyy1Hj8niCyO/XYCbIxECxM8A6ap0PZ+oiT+lZ+oOgTw8Y8Ydzy+pMXxmMTEFEPt9q3DmWM1RMkN2erW/Mgqlvl6aayDdatUTDgrbpDZiPuQTwAU7/5YgSD+tiSm1DlzuJaeBFAK5y6UC5Qyd5FJf471bnXrJ4ohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8eqMQXj; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8eqMQXj"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79ef93865afso341850785a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721147880; x=1721752680; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O48VkzHTalBmREWDsqc4aXjAe9aycq0gPR5n7XUMFPM=;
        b=D8eqMQXjkuyNrhQJKQNN8rVXUaiPbqpcatWPHwFWgiHKfeaSFlMxwthgq1L4mMp5ya
         eowDVImBYrMXAJRYONC3jtyxzUkyjJjdzxuBK5DGWz2dlZLVW0haHGlwFRBWcMLRe2yF
         tNUpb+APV/CZaYA9OfOcGTVzrnSCMFTDDWmjk3tXT+fpYBRjrX8NU5cFTjOGmsA9scjq
         7nLsb6vl4cdao3EcB9ktraJFtp99isZJyZBCWcVxfIknJL0+eB0e8NbAN1xdOumKCqlY
         IB2aIYyPuLhf9OeJD/2nX0ExrnzCkFC4QgDA7S5KNIPfJtXML7/MqLIjz/Kp3Yw9LtmC
         cfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721147880; x=1721752680;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O48VkzHTalBmREWDsqc4aXjAe9aycq0gPR5n7XUMFPM=;
        b=XD1NkuE+pfYvfOmYeOdhD0w22cmPVXL74JM+CGB9Wr9ejGTUyZF41ox89DO4b5Gtpp
         Jz0sshEtH8L56kyuzlu9jmvCWGyLsBc6oAdgmlwbQSvZbGKa6yI7Wf7gxeF1F+F2Xh7F
         gaTxlP98oZGDUGuHG8AYZZ2lfodc0KKzEY1RU+gL/7ocwKlCL3pqefRLNTVZT0i1GvRO
         Ua1oxgfcrzZBOkyNXyUiMa5LRZ2Ls1uJ+vq4gcQzRW/IAoOhTGNekhrSgDo2CR4Oj8mE
         bZKcXyf2YbRcOhwUrT0BdUU4AVGbe4gIzaPVB8Hn7/TaPqouXHAJSD+novj2pWUQA3Bn
         SsWw==
X-Gm-Message-State: AOJu0Yz1XMf730zxqkbok19CxYjw3whntRFoF4Hfkeo5/pU6lK5bUNQI
	Hy+6zGIAgWm8ls4lWqvcpNkar6gkJ7esu6HpUNoFbfPp/Vd+vKlzU3VpAg==
X-Google-Smtp-Source: AGHT+IHp+LE42Lvw/cPmevFq2IkNYxdii/l/+pcCKb6UMmB2W/nJTFNbsQDp02fgthulkmZYMjWniQ==
X-Received: by 2002:a05:6214:268e:b0:6b5:7ee:1d79 with SMTP id 6a1803df08f44-6b77f50d0f5mr31095886d6.26.1721147880339;
        Tue, 16 Jul 2024 09:38:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.119.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761a580b5sm32556746d6.127.2024.07.16.09.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:38:00 -0700 (PDT)
Message-ID: <6696a1e8.050a0220.c3fda.e6ab@mx.google.com>
Date: Tue, 16 Jul 2024 09:38:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2764207302399959260=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] monitor/intel: Add decoding of Intel Read Version event fields
In-Reply-To: <20240716145354.3900742-1-kiran.k@intel.com>
References: <20240716145354.3900742-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2764207302399959260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=871704

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.67 seconds
BluezMake                     PASS      1642.17 seconds
MakeCheck                     PASS      13.41 seconds
MakeDistcheck                 PASS      180.34 seconds
CheckValgrind                 PASS      253.05 seconds
CheckSmatch                   PASS      354.59 seconds
bluezmakeextell               PASS      119.96 seconds
IncrementalBuild              PASS      1444.64 seconds
ScanBuild                     PASS      999.47 seconds



---
Regards,
Linux Bluetooth


--===============2764207302399959260==--
