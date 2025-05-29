Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E2136347
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545670; cv=none; b=nGSkNTzCsvZ+xbgy9puhbIiaMGRyzkVjz9vHYilDH3O33YwqDkMhIo5GP6sYlViV68B8GkYTix7dtnOsRAiM1+Lntt+fwDK2zdTyoWlsBIZuNCMZTxcTszhlH+rZQ08+zIWS0qhoC70zv2NOEjeIexB6vrEHSOFwVOOIAYstHbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545670; c=relaxed/simple;
	bh=Wu8akzzquWOlAw3q63sNTS1FmIlZCDdujUgoksw4i0M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rQal7bHsr/dfm1syHIqC6nhg41Jo27HRVU4mN3BWeFXSpAlTDQtfqtQ3BDrLX4OGsDvFEnybZk/+JLGHZEEqcpySAL2McGTO4FMKsJZTGaOD6Lf9sARxK7WOMQzuVSZ1hM8p+SgkLLpQWDaXCGia4lq04NVLiMO9pLu+qo6q0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT4g8y2E; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT4g8y2E"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6face43dfbfso3659786d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748545668; x=1749150468; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wqLzRSqDD4/iNiMxKevWTAOzFi99tg+8yy9VkA9VE0E=;
        b=gT4g8y2EBCbHt05z2beGJfSWxD8iJwZvOE+JZilv5yS5uoorHH9dm3sWBPdxcD38Qk
         7yMMh9GixZ/rD5ef5nnfMojn/Ap/o7ueS0FG1BLRUpbrKMLeOxopZwf8G5tmhp1zI4IR
         nVihHXy6vaRI2AZdvgWoSs1Oete4xxI2AGJVLw+0l8c7+IIdjyJHjTy9u30xGbc77ts7
         VHCCIVpjO6thxpi517nE4U22qyvWqPPOY6qYFuv1V7KIqbOF5CyZBwfna4B7OeDw93LS
         I0/3oomcX4cNdRUFk8xcn5HUrCz/tS8uC1odRSYlEH1sSTheLLKr2GSwr0Kp2NbGvhke
         aKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748545668; x=1749150468;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqLzRSqDD4/iNiMxKevWTAOzFi99tg+8yy9VkA9VE0E=;
        b=DFxVDlZmxysTTviSbtFEJUyll78+mk9vYr9UbssEyw6uB8qj8dXTKlR66C9dJonzAY
         h0fFJbdBdb1jEgH0mrTKa0+f1Ug5y9bEfPCoJkRvEctIotoISpeq/Xl321sfRRakDj0g
         +R/7qOFkassuoAGQpI59bkVqEm8kgXhR3KTeTJLyBazRnIWzmK+RstfQ1YTatVs2P3di
         PW4ZOqQeV4MEu47uHWHJyMfOe6G29q5a09FVYSi5xo2JtQ1BTUQRRoOrcYSV9h2G0wIw
         vub0xf4ySwvcEGZVSz0zvnmSyIDwzzDBgv+bi8iRLWnZsUljk+/ltIZRWaxh7btnMuVU
         rIyQ==
X-Gm-Message-State: AOJu0Yzv0AdrZbEWQndsIl/Fz6qxsJ1GO5cl/9gxTwJ0XJ4LudpT2J8O
	fxYnQdsMcBpyRb/OSGzcN5un86npWHlhQ7VsvG8cTHvbE/s1cQU/47XnLp0iEw==
X-Gm-Gg: ASbGncuxubK34BJAkQVs00gDmNgsu6eh/eL1KNWjn1+E7zFI9m+2hl+UHhBUHkLEKpV
	sxpmKV2AuFFshfE+rpI8kWHF97Kpb//kNih0AC3XszTzdEV0ddQc4gMy603loOklJDvfTN+QTGR
	xThJPoTqT6f5raX6gn3pRJmlThVlOjmrb7hJoZaSsvH+uWHsJkYdvc1V0Rk7193CeWvDT50kDY8
	skM/fLxQpC14fG1dH/JnJ9ajEFxTX7OsbLGivVH3z/41Mmul51Ml4+/BUDNKhaHjMG59qw1dsug
	NuA8iQPbGDBSla/QtBVOPJAo3CwSoVXdrUpcdO9ffE1bLKQisuiPF9DW1vP0
X-Google-Smtp-Source: AGHT+IEZihkApnFVPbPDPtRydoAFUfwXxedeVptMxgFh1XHyjge3bajvgdBrTiCw1RbWZrudOl5AWw==
X-Received: by 2002:a05:6214:ccb:b0:6fa:cd9e:7fe1 with SMTP id 6a1803df08f44-6faced44d0dmr10675946d6.24.1748545667551;
        Thu, 29 May 2025 12:07:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.146.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4d6b6sm12570266d6.44.2025.05.29.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 12:07:47 -0700 (PDT)
Message-ID: <6838b083.d40a0220.92eb8.4f6c@mx.google.com>
Date: Thu, 29 May 2025 12:07:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5454667090117261592=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bass: Fix not setting SID for assistant objects
In-Reply-To: <20250529174349.197433-1-luiz.dentz@gmail.com>
References: <20250529174349.197433-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5454667090117261592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=967405

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      2664.28 seconds
MakeCheck                     PASS      20.77 seconds
MakeDistcheck                 PASS      199.12 seconds
CheckValgrind                 PASS      283.47 seconds
CheckSmatch                   PASS      317.76 seconds
bluezmakeextell               PASS      131.19 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      945.53 seconds

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


--===============5454667090117261592==--
