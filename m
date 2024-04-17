Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F5142625
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369783; cv=none; b=OBgy8PecuI/+lIMPhIuTMHHd7gRcDQdyj+e/BVt/z+0zbUeZDqxfWzCH2UkEUYEcP+Psn+tl2SIkRzG61N/kyTVZHJ+EFo6m8xodmDvBfnq8vnfbzCKYziGsGRn7FmaDLF+MxqUckytAVenXXrJUyMqrjGOsqi43GfbXRRI0p/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369783; c=relaxed/simple;
	bh=FKM8xLFm4s2GQoY0v0iSJL8fe7JtF1QRPuew4jOwIL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IBxGVE58nZ3fuaDy2WR2L0HBl+Hf9pBNCUvLkbyyLM5ceT23imvkQPvkZJCDc/fTFdjZV7xTosQj6bJZnZnX7W7OKvD/Rag0DFjAI02wRY/ZltVhU6D5CWs+pDX8eiNq8G7Oo1eLPW/95g5kout9nUV66wtEvhdR1uZZQGalHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+3UmBpl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+3UmBpl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4365c1451d4so22877281cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713369781; x=1713974581; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M5umvmS0tC+l1Vr8LwyCtTbBEH/sNHO9as3psociAMc=;
        b=m+3UmBplRB15GkIVOy2M0JNGdhmxmlX7IYZxPGYklEiigcuzC2/rRjLkNjQ0JU+p2r
         KcE9F6QPdtICoDcmfQWzHszmCuz9BpDdVGaA27JDSGt79tdBEhl2q5T8D0Ran+P58b4b
         mBtMMzX15q/rVpJfpHDlYShj7jhliQM9NxRcnCNZus3jPTaDsxcSB8XgrcXXemydYTq8
         Xf+1rKhJAMpvYr9DgKlXk6Zz7+F+XGD9MeuaTGM2VFO0oXMJleSqTNgU6dZ5beFWb+e9
         HERkB5j5j6ZA3ShS7lZQtigJGsfhbelyqHTMTRC+6ZJ9SuPDN2w43zitMo68vGzJpqML
         2YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369781; x=1713974581;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5umvmS0tC+l1Vr8LwyCtTbBEH/sNHO9as3psociAMc=;
        b=cSGeJjHeise1bt6pqvcksOO8VzMdXeAAPZimI67WSqmZkn6pKX25Jsn1NgDuw/5pP1
         xUtIJTlvT1oRV6ymlQkmxGQEaA2mS3AznFLAdTwRoBHswgkLx+RVAOlzdj4BYZCb6x9A
         5kxZgEafJs9/lU2mZoFc2Fnrp3Qd4vO5gInpuwpr7zjOoipF5IcL+EwTgrTgxIyHV9h4
         mPlycIm+H+VQVKHqmtvoItjni+z6yMoKAKFzkVpuct3EvkI7691nzC5p1kmYW51p0rzH
         Bn1YW3BKlyMH3iL/k382ugNdZleinHvzLXGm9vLK0YoUSYfnXbBpADZKN5Z6Q4isoB1Q
         RDqQ==
X-Gm-Message-State: AOJu0YxF4MJBC8fb/6jXmtq2KgsvgIf+dkxjglUoCLoH4/0pCL4cBDm/
	JbcH6rwhZqEfgUG6b37S9WWx45zyjNeNdGynhsCTUqXv3B9j2Q1l8u6smw==
X-Google-Smtp-Source: AGHT+IGEvuQgfTkemtBopl1VbhIMEKsPFi2p5npOLutYil8dKOxXZ595qBkDq6Ko0JpRSA4ykLXMgA==
X-Received: by 2002:ac8:7d0e:0:b0:434:b3b3:4729 with SMTP id g14-20020ac87d0e000000b00434b3b34729mr19141953qtb.33.1713369780748;
        Wed, 17 Apr 2024 09:03:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.126.35])
        by smtp.gmail.com with ESMTPSA id c22-20020a05620a135600b0078d68c42962sm8529431qkl.83.2024.04.17.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:03:00 -0700 (PDT)
Message-ID: <661ff2b4.050a0220.b37af.8261@mx.google.com>
Date: Wed, 17 Apr 2024 09:03:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1882980017888831425=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Replace global bcast_pa_requests with a queue for each adapter
In-Reply-To: <20240417142537.6523-2-vlad.pruteanu@nxp.com>
References: <20240417142537.6523-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1882980017888831425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=845470

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      24.78 seconds
BluezMake                     PASS      1718.54 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      176.30 seconds
CheckValgrind                 PASS      245.93 seconds
CheckSmatch                   PASS      348.62 seconds
bluezmakeextell               PASS      118.66 seconds
IncrementalBuild              PASS      1532.26 seconds
ScanBuild                     PASS      987.28 seconds



---
Regards,
Linux Bluetooth


--===============1882980017888831425==--
