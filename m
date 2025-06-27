Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171D1D7984
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751016859; cv=none; b=T1EjwA59nJO68U7is+ES1uM396e/4tx5lIsE4EsX5h4hu8ff8kqF0Vxas1Y6SiSNzKtRh8DW1dllM6Z3XUONXfVQG1V0uYs6DwqiiRdwA5nSLINyybZTPyloeSlUShjbT5vxVVY+8N7Nw2qnbvKxb8HxzVwWWA2FyEjorgOTZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751016859; c=relaxed/simple;
	bh=khGXDtdzZ0qQw4DWqj6yTQoigDWntKwbbJ+KQq3coLc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KWvXwgCftwMDJv62CfKC9RM6zxzxeVSXUYPTIK3TcSbcwgIeEG/LpYn3oxWJcblEph1GTGyOjdgn9OLmcmGMVKl3CGlTEG7ag/PRt08rs+AII9LFoIeinZ4otczUQt/TpbH5zUYSbp9OUpIe7rK10zbMLIAg3CSvTXEIbNhW6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yc1bkXMW; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yc1bkXMW"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ecf99dd567so22343726d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 02:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751016854; x=1751621654; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qGFvZqM0+MN9Evg9zsWSdA4X05EVj4YxARatXYaBSPU=;
        b=Yc1bkXMWWP1pvUXyOjl0oa6z12s8BZAQSD1myUhreihKt0dqTyafto2AHckZFbNzk7
         dhYIn2nAM7Ic5IMFCLcASyqVQeHc5nsFEOwA0kK4so5o41ERb01d2nGgihX0w7Gv/GRp
         At1JU2gHQoPjvW4ka8mBgCpEuyVIYYDs+z6zmakINo21pmJac11uzqISJuC8apCu/WF3
         oSt9RBrd3/d9KnTQnXIVs1DYL7JfNsf3uPDfNMA7x4VehW3Vt+kcKl6iiD9iDG7DzFBR
         CUBgmJrkJsHv00ashQpWdjKRPSkCNWSFOAGe1yvT6CY73KPsWvcsKGGToufgu2OZ2ROr
         tmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751016854; x=1751621654;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGFvZqM0+MN9Evg9zsWSdA4X05EVj4YxARatXYaBSPU=;
        b=pAcHNZpSxxvAJkQyfOs79XYqthZKAhUXrFJamNo4SHw6qFOeLmecTAX7FowTBGr+Hx
         EyDJUpx7zb3XoDnz9CFDd/plgLRoedVwimShu0OIucdY82+6a60DJtIPhrh9iPXTM7J2
         WvXUKvlPh+R1Mxhu0D8UHETVRBQWf8UXVwS8c8CdFgDAUsuKk8X1xjvfkfk7XIIqB7fm
         HpIwKwSwWSMFCkFWfjLYZcWkD5ve0DuKT2Si4y0d+qmq6YTmYxCoGrRlidk8MagLIYwE
         gP5YT8KYjSVE7OHQP1bPeMiawSi6zNDicuF5z1drv7Q4hRk3B2/SYUYjDyGf43VBGVi8
         aB+Q==
X-Gm-Message-State: AOJu0YzFh2rtDfmPrIoTaamnPkFeEqiM/WVswAakEjzpP+McJmbhB3nx
	uXd/c6zsKGOkefYeeu7ehx5w++eFqsdHL5p7ui+S8SXyxtqR4WF7LDkvscWJDA==
X-Gm-Gg: ASbGncu7p/OAeZv7NJkZOqNzZ6z9YJMN3QPbrP4Q1HxHpFIR7Xv7kxm0UgasKDXCsLz
	jY8oMdCNj1IkNrCrssTQUqA26sjGCHSQ84AajKmPOgJeG4b7dwaKNzCm2lLmitxgSHTF0pP56nM
	I8jc88EDtI7eynGkbVba2h5U+VVcvSRe/2JuKybbHgqqnLB2Yw7zNWcUTB+fHyzBYYmqSC8sg7U
	ED+bUoxsjppfKchJ6Cp52kv2J/t4XyaqzJ0v0HMAyPg+fkBfTijyn46GFzI+eVyI0c9354RXds8
	T2aIQ7cR0P9moIOmuruCE9XT2xqeqGAX3ZN3Aw98CAarHjXyFvLUErSN7am/KW6cKIfCBA==
X-Google-Smtp-Source: AGHT+IHuHNlFmy6XzPU8jp+bIarfvCBubpvGb6IQ/MKu8SRnXw/yc2RYWYNRtOv80czC3GcxEb+6uw==
X-Received: by 2002:a05:6214:3c9e:b0:6fb:59de:f8ab with SMTP id 6a1803df08f44-70002b09787mr46345916d6.10.1751016854365;
        Fri, 27 Jun 2025 02:34:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.134.157])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e4357sm17103586d6.72.2025.06.27.02.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:34:14 -0700 (PDT)
Message-ID: <685e6596.050a0220.32c2f9.52ff@mx.google.com>
Date: Fri, 27 Jun 2025 02:34:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7631203712984657984=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,1/9] doc: mesh-api: minor copy&paste fix
In-Reply-To: <20250627075805.19597-1-ceggers@arri.de>
References: <20250627075805.19597-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7631203712984657984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=976513

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      2798.73 seconds
MakeCheck                     PASS      20.83 seconds
MakeDistcheck                 PASS      198.09 seconds
CheckValgrind                 PASS      272.54 seconds
CheckSmatch                   PASS      303.99 seconds
bluezmakeextell               PASS      127.45 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      911.55 seconds

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


--===============7631203712984657984==--
