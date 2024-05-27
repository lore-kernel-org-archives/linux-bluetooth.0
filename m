Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51915DBB9
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810885; cv=none; b=WCYtYWSdzTQdXmdEprRoCAgnrOXHQ5tlRGne0Ffebh0sEekbNGcud2KEhr1uSpfH6q2FjzJzi2zVB4fDkUSqqt8wB77CwqD7s+c4A8Rxz2pxDAJlIEM3ecssp9VCUzMjjyC5IVMJ8V5fZigr39Sq0a4v6nRb8fsJW37GeD4bwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810885; c=relaxed/simple;
	bh=IsvEyiIap4MwRPL7+I78TVklz9nBKQ+p1Hyi2O3BqJw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KZ/M0j1weQqTzboWCStvUJtkS7P9c7WSXvx3FfQ37Xl1TLZ/gBTdYZ8JGYg9IwY0dzkMxu5k1hyBN1I5P/TTldqpsIYe6SkLYCqXNLXP58zk12/Z/oP4/sk0jJUDZthpp21X4j9ZkGIJ3kdZHCzmTHI3QtKybICgBHNAYe32vxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MURjiDdI; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MURjiDdI"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df7812c4526so2315507276.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716810883; x=1717415683; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Im0MspvIZzheGIPpWMlVJpsWkX6iqlotN1MARYU4Wg=;
        b=MURjiDdIC1RKL43mOfyc+Zpon9LMkjp08HWw85yxlr1V84aGmRIbyFi9i/7Gzbbeja
         SjAa7Oun2vfq0Kr643wovmsfF36Wfl3oJ4+hChqCvqfMPbeDiYwBEmi7Q383pXOFFMdB
         /5KwY+6fCPb1W0zQc3olHtAUml8Xk78vPNmPtbP4CQDhBC5D7MY9fIy9mPKQPMVOYs1C
         wE9bZbCduGxHMN0V1nSES6cN7MbPp1EqXBbVYdYasWSeK6QoDG/9nilBjuCySfxo4U2/
         BCLRl61ki9XDxSksqFQonQRn7AqxHuwTBlaAI/T/a6eCt5xQZdsR6Yvpm+7izx0uT+O4
         orYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810883; x=1717415683;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Im0MspvIZzheGIPpWMlVJpsWkX6iqlotN1MARYU4Wg=;
        b=NHrmTfIJbP+uLyhVkSCEcHRVD3I/YzNRYmMoLIBshBmxoE1edIz0WL8/1rUBAnAEZP
         WOpIn0aJRSzt11pvjn6Ia2QHkSoT0E9mKuHZWGA1EvM26ZP0DFFnj69r2dnBdTMd7vxr
         RK5mxMX/P/kPa2hRu5Q5J8t7SG7vW9zHRzk0qTDaKGLt5uuPLboHfC/FFc59p0mlm+AN
         PQlVB1CaOmE9bbTyafkwUtxvTI5xJzpwmPpRafQJFGnP4C7yPHFGkzJRWFyo4sGgn50O
         zFFp168RzUZPp84BKFTT+d8H/MhXyeOmRAUMjOy7TWWYuoeR/3daYB2pxc2jiiNeHzcv
         OBUA==
X-Gm-Message-State: AOJu0YzM0dqbz4w1/nkcy3Tl7xi2B2Ydv90orM4nauIl1RdoXd6CFfmY
	KWk7/MG1nKP37uTLobnFeQESF1/EYlZYTzIPmpsY757dzshk0NrGtBa6/w==
X-Google-Smtp-Source: AGHT+IFKJPapvItNKJ89PazUdHyRa2+GYYp1ozDDT2dUIf2tiOvnmwbB2PS/bNQL9Zki6EgYrfOL0g==
X-Received: by 2002:a25:b2a2:0:b0:dcb:e82c:f7d with SMTP id 3f1490d57ef6-df772256da5mr8721284276.41.1716810882555;
        Mon, 27 May 2024 04:54:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.198.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd31557sm290091485a.116.2024.05.27.04.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:54:42 -0700 (PDT)
Message-ID: <66547482.050a0220.35509.9829@mx.google.com>
Date: Mon, 27 May 2024 04:54:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4830813423146128683=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add new BAP BSRC/SCC tests
In-Reply-To: <20240527075422.18953-2-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4830813423146128683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856047

---Test result---

Test Summary:
CheckPatch                    PASS      2.74 seconds
GitLint                       PASS      1.89 seconds
BuildEll                      PASS      24.37 seconds
BluezMake                     PASS      1633.36 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      176.30 seconds
CheckValgrind                 PASS      248.67 seconds
CheckSmatch                   WARNING   352.24 seconds
bluezmakeextell               PASS      119.17 seconds
IncrementalBuild              PASS      9382.93 seconds
ScanBuild                     PASS      980.76 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:286:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============4830813423146128683==--
