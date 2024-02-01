Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049584024
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809065; cv=none; b=Yn1av/mU9x6IwQ8+842uqrG5Ir8RCvM1yQYi/13VCOdkH6Au/pi2x4N0IU0yoHDGW0Yn+XrqxozH9B3tZls8Wl3nDtaYWzKbE9CNg9hpvHQi0TQB6/3/Y94CLs0DyzyNwawv4/iCwB0ia6tOk+Fham42x8rePwfg2Er7XtKSrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809065; c=relaxed/simple;
	bh=WwS6/+pf69po9hxrAgUI7CbUc8BfXnq1etzUEL0BZ7I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PpSj8iJshKgHxTxJaW3NWglsZcaL0xlO4IuZjeW+LFHRU0PLcNUFa3ksSQqmAGz9L2QgJdLnf3nfhk2tgkvHBu8SN+HZB4n+2vZKQoVfTsZ7TQml9LJHYs/OUEXSERBA6akAQtFCI6c6QdBbevGNRxlPQdEBHm4MOvGJonXmf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5AW7B1k; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5AW7B1k"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42aa93264b1so5162881cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 09:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706809063; x=1707413863; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EI8mYwKgZ3G7My6SPAwt34N71/4wl188OsxXEioOjxU=;
        b=l5AW7B1kO97u0lTyd912HbXyVAxBHyeoWwYbsgHkeMwOnVWsl68L9uP4W9l9mdGe8q
         JRijj9C5qrW7T4QoQSFwqf0ZHbYrvW9SRLDByQfv6JDBNUPk8A5GFlglILtg/3b9uRl4
         TiaUnRFEnngCXCmjtcULbtO0cDN9hVPVSvJizDFZ9m6011vVSjWIzMR5//1KONJwdUuV
         IKytjG4m/Di7jYFV8POsWYzblzwcB4M1FiM/QPGkUKrnHKRL/ixOb5w6oYLvMWogGH5W
         +4J3Leow14gqlw8psM4pHVh9AiB+sKOrSAYk5CSRTbXsmJZpZmlYXhnDDVMXOdm6P0ec
         Wf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809063; x=1707413863;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI8mYwKgZ3G7My6SPAwt34N71/4wl188OsxXEioOjxU=;
        b=huTVFF/RXPNPQqby9axlzXUJStxFKJnWxGz6RWN3QKvkXrwZGvho9WUbQVdOzoHReJ
         PpdVcpGcZNc1lGrqHKVBo3yY2WhhnekBCtIjY9DkM9K80Ndr6NBKxuHShdJeEdhX8h6y
         5YKILQillzTdIgttZpD1eHJU38aXtZjwJjmmaYHjvf/lPrlzOnuxLoxoU3h7gXssSJY2
         SkvFurUa2HvW1hUnDjTptp5HNmMx+Qtpu9IPEnE9tLBbXxyHxf4rZlbJ0qJLj/xWwGQ5
         GIF4Wax+OW4o2AXtc1ibEXU+mNEFgmGk4PWGkCJrPjY66AiWy6rmNMG8Pe0QouM95LMp
         JLgA==
X-Gm-Message-State: AOJu0YyeO0GFoKVWf14LjzAUPafW/vYHzwmvcpQhnMcNGUuEQigTT5ri
	cxcAxUSPEMnOLO5mD3R0qn8Mn9oXnPa7BhTSscURsT9bibYfg1/hYskYOIQY
X-Google-Smtp-Source: AGHT+IEroDyJyQ5kH285AF8rReCPCrco0qtlN0C2pHPI9bOTRcbPV4JBX0XT1Rpd3mxiGDznW9YFuw==
X-Received: by 2002:a05:622a:143:b0:42b:eaef:4deb with SMTP id v3-20020a05622a014300b0042beaef4debmr5214268qtw.28.1706809062984;
        Thu, 01 Feb 2024 09:37:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVje4eBB+6ciLlgi/tRFOQNgD1uIkE9odSYkyVx2augSz7W4QObOfKqhB01EoL94qOEGMwoEOylkuISS+cJu3y+5w6nYxiULj1N
Received: from [172.17.0.2] ([74.249.5.188])
        by smtp.gmail.com with ESMTPSA id cd3-20020a05622a418300b00429c9bf789fsm2510292qtb.42.2024.02.01.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:37:42 -0800 (PST)
Message-ID: <65bbd6e6.050a0220.4f6a5.01ca@mx.google.com>
Date: Thu, 01 Feb 2024 09:37:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5830618051472885244=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes on the bcast source
In-Reply-To: <20240201152835.196617-2-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5830618051472885244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=822172

---Test result---

Test Summary:
CheckPatch                    PASS      3.34 seconds
GitLint                       FAIL      2.43 seconds
BuildEll                      PASS      24.07 seconds
BluezMake                     PASS      724.99 seconds
MakeCheck                     PASS      11.65 seconds
MakeDistcheck                 PASS      164.10 seconds
CheckValgrind                 PASS      227.51 seconds
CheckSmatch                   PASS      329.70 seconds
bluezmakeextell               PASS      107.31 seconds
IncrementalBuild              PASS      4692.55 seconds
ScanBuild                     PASS      942.52 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,3/7] bap: Create a new endpoint to be available for the next BIS configuration

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,3/7] bap: Create a new endpoint to be available for the next BIS configuration"
[BlueZ,7/7] shared/bap: Generate single BIS BASE for a configuration with BIG ID 0xFF

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,7/7] shared/bap: Generate single BIS BASE for a configuration with BIG ID 0xFF"


---
Regards,
Linux Bluetooth


--===============5830618051472885244==--
