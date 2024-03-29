Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00ED101D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711701472; cv=none; b=nbbJe2kmvNIOqJKOz4wzvP7YZfxPoxOadZBU2rdz2wPzAOyZp77FRY2QhChk4wOzd/5FDjglkqzInr/OkK4FAY9SJT+Xhss5B5TCZ5+GrzhWPSlu/6sPlB11gat871O19BNhgP6SABKFUKhtId/rJRS0uyYegmV1omyp0YOwDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711701472; c=relaxed/simple;
	bh=Ng4vwGwhIyJ6ngXiH/PADO3z2yeM7+FoBjND/+cD8E8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WNAb+SptpnHNhk2M6LtzZfBqIkoS7VpY3lFpurozjVdT+gUO2Yl461LyKjfmziHKpuImJE0II6q6rpoECLza2wxL2Q09IDYIvREx3NQT8+PeFSJkL5lhXBIxtJFBhK9JXdySjrhju26YQFry56kAPGLAUMY7BgH34NZVNMzLZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgfAiCbz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgfAiCbz"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a60d10eeeso110691585a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711701469; x=1712306269; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GHQD2CyfP0gPHY5vcRpUBxCl2aXFmz7rzIZGcVBmfxw=;
        b=bgfAiCbzjqx69L6Z5Owyl0qrCTKcyJCPHjSw9cGX4gCSMVk3rzaU6WBRbRDIArgMxu
         MZEFvaoz8a1Q/3Uq3AOTp/3rLwzQGFJOmXyqkqodkdBjuCRSKwyQOc3H1CuwePXBfgeI
         LmQo4C3UP0yNEper7M8YWmBQ6wUV88t04pyFWOWa6yIP5Xf14NtAomfoWBEh9owveX1F
         3tKUHbZTNffcJkXna8OqvJRa2RmVhH+VAoBKaq4SZuYhgT/IEjQpG4faRnON0VcCuAme
         hVU2xjpcEV8RWkysryFzUdjasNiD9YW0JqrJW37ygE86fbCqA3LsTswwWPt+WCVQg/+N
         q8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711701469; x=1712306269;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHQD2CyfP0gPHY5vcRpUBxCl2aXFmz7rzIZGcVBmfxw=;
        b=JooRyMbdfIHrV9i1A6NWmpg71uLdZayDxygKhJsKdRMl2YdzegfMcZ9e8EKZhxfCv/
         1OdcVvy7G7GSqMkEE/7XI7F2aSVTY5EewQMCK0SdlubGaTbIgIlddY2LLcLyL9Jb/sFQ
         JlRjS3RI0csOcM9bg4RTnTT33TAdXuXS/Q1q7Ipdq12Y+SOqWAmthDC0mOMwayaCRgrs
         f5Tx3eKi5XPotmsfZuGP+obgRAh2KCRPL764GvIELLI7rIdNMJkxfYtomhgDw7YnZBtJ
         bEvn8fRPsbeUfx2+NjoiFyJV5dTFwFBC9aS5AKbuWdWLybem/SHlF3WYdMhx5k0iBgN/
         lJKQ==
X-Gm-Message-State: AOJu0YypIUQcDX2j+ew1XXDVaGdoohFIiplvgBGyiyzvW6PZ53DdUElY
	v9QUY5fsJDf8T/0qSEQTBnjpm4VmoEyH/ZOeFoENu/DezaK5SHKbLYN/OpoM
X-Google-Smtp-Source: AGHT+IGbFlKrBsWPq8ywoxV6FmyKdAdwtMcR1VLO/t2yFcpevTwHdW0TGewDrtTr5QW/RMUApVN18w==
X-Received: by 2002:a05:620a:4012:b0:78a:5e3a:ccdb with SMTP id h18-20020a05620a401200b0078a5e3accdbmr2359160qko.28.1711701469603;
        Fri, 29 Mar 2024 01:37:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.240])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a144500b0078a6db384b4sm1219582qkl.30.2024.03.29.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:37:48 -0700 (PDT)
Message-ID: <66067ddc.050a0220.852ba.9b8f@mx.google.com>
Date: Fri, 29 Mar 2024 01:37:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0173228082426310947=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Autoconnecttimeout max value increased to 20000 msecs
In-Reply-To: <20240329063534.56892-2-mahesh.talewad@nxp.com>
References: <20240329063534.56892-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0173228082426310947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=839675

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       FAIL      0.48 seconds
BuildEll                      PASS      24.42 seconds
BluezMake                     PASS      1658.83 seconds
MakeCheck                     PASS      13.87 seconds
MakeDistcheck                 PASS      176.99 seconds
CheckValgrind                 PASS      248.83 seconds
CheckSmatch                   PASS      350.74 seconds
bluezmakeextell               PASS      119.39 seconds
IncrementalBuild              PASS      1440.37 seconds
ScanBuild                     PASS      992.18 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/1] Autoconnecttimeout max value increased to 20000 msecs from 16384 msecs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v1,1/1] Autoconnecttimeout max value increased to 20000 msecs from 16384 msecs"


---
Regards,
Linux Bluetooth


--===============0173228082426310947==--
