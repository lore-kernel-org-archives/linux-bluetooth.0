Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272D182B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038847; cv=none; b=QFIx7J9icMqb70oHFI02G7lSM0r7/2EIAldO3GBp0Iwi8q2Zjk6r66dVtFKmuCuio7qWRYyesbH7P1BehoNUHMJpn8pTAYWUCTuipx7Wqc7fQRXfAlXdwm+XhYjsmiMTThX3NEZOVHZn+QxbCUAXypfFlpOnZCgg8BkyZmSRm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038847; c=relaxed/simple;
	bh=F/A8YdVivpyWlmC/+l/NSiuty2WeZrBdnFYlXZJdrnU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IhvNw30NbSgwo9N5nKN4g2KDdVnyVm7ts4FhbbdHMjDQYiuyZVUnFhqWKG8bvpr6oLwAIiswHspTjUg/k1ormg3rVq/xK48DZ8OGLfBIlBLfBpotXTOwMWj0b3FaSY41EUSi1hJjXrklI162gbwpct3K63jMU+Z6daNq/hfCNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6oLTIfW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6oLTIfW"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7075bcdbb0fso36719076d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755038845; x=1755643645; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D8sHAtAGx2VvyZb6v+DavNlSqSsO1im6LSjDkkXu8eQ=;
        b=M6oLTIfWbMBh/W5eqJoDGFo3M6+Db+W/RYZE8obUO3EE1Z0LBjuhcbjCSRIF6Zcl2n
         SDTUsrmbzbjct//6Eu+XwSghcmj9h3WrQuW47cf7B/xJVOmCEO3nTmGXm2fBenSV/NnJ
         ozt5gUzNGgVfZ4kQmntsMEPg4Wz+vxGXr3oktesF8eeaXXZQDfCZfzkkWSBjKXwa9LCN
         lEzaicARxGaaK9vrkvNXlr25w/7jsjqF9b94WcCtLZDnn1/KJLk3y4jMyCSHWN08OgeA
         baNUejt/4uwZtCa4kE2c3bJP4XALksXlZw48iaaCeP/iDSWFDypvuRKs7fZJFJ0En/kV
         CCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755038845; x=1755643645;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8sHAtAGx2VvyZb6v+DavNlSqSsO1im6LSjDkkXu8eQ=;
        b=PL/Cv4V9b+fqEC0rTu2lV+4moaBxbxlzb4Nd4YamIoLwl1E9IjN3vNE+1gU/8V6eaS
         6H615bZodzlHoXthCFLxMCZugQUxGV6aBy0wvJxtIzNPK0BQMcX9o7LT74pAVHtXCove
         xLekUSR5I7XpppYvL69oNs+zAkTm3HwVb0N/NGMkj9ffa0omLLqEDS55dCRtllVJ4MjU
         RCK5lP/PwbDhWkn9mMr2uro7ngQlTTZvtdvIquDuKYZ+6zLyz2SaUcTyAzlxrHjuCz0s
         GXd6tCh29F7CNJEcVnZ4RQ0ix6rg8HD5QGWejCqVeHW5vj7+CluBenPfX+OHN4/2kPkN
         q6BQ==
X-Gm-Message-State: AOJu0YyYFH2Fn2eTUqV8yxpVhkbNQ6VXKFiAetYhG43dvgZgHMEk/26R
	EnH1JnGS1q4pewPsYSwf0HregRr7dRoZJ3UoiDUNq1IyqSYriCirvXbzn7zdG8qq
X-Gm-Gg: ASbGncvSCvwTsW/ti8OkZEiAooA1Hn+gNe/oHr7TNAb2szpLp/noFWY5qEhXvdnpqCl
	J66ypQj1FDu4pI2ZxV4HYdBHf3ZHOSZuLlJ5Nit1+U9bMD71Ay7u52qOj506qUh0OguyLgvZieS
	UWwtmh5jMq6otQZCcLfylpaXPTeTq8FIe7sx6+W+EyDCS5CczI+hb7WYKTf0uNoOJvBvAUAmWEQ
	sScCkJ46KrEry9KICS56KfDb3ERJjA/z9Oo2M80JpAECldEg/2n48fHcLC4Ja6/pbZuBQMsg2nu
	aTZoD+MG18b+bapYlidpj1ZNLegn+A5jmGRzX1dJFTTGWdA7juTiHyPj5fnhastmZXi/x4d19v0
	HUVEJXANdqvefmNeeP+psxFHgWDQ+
X-Google-Smtp-Source: AGHT+IHOngG32NIZ0tuooPCEzDH7sil9zg3cKpnyJxTWTock/oy6FWCd6xTr7axlxtg6Kg5r1OHz6Q==
X-Received: by 2002:ad4:5dc9:0:b0:707:52f9:5253 with SMTP id 6a1803df08f44-709e8837711mr9970626d6.11.1755038844952;
        Tue, 12 Aug 2025 15:47:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce24cd9sm184273896d6.76.2025.08.12.15.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:47:24 -0700 (PDT)
Message-ID: <689bc47c.050a0220.c05c8.a1f0@mx.google.com>
Date: Tue, 12 Aug 2025 15:47:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1785924860711988105=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mgmt-tester: Fix tests failing due to missing LL Privacy
In-Reply-To: <20250812212227.1541519-1-luiz.dentz@gmail.com>
References: <20250812212227.1541519-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1785924860711988105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=990735

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      2634.21 seconds
MakeCheck                     PASS      19.84 seconds
MakeDistcheck                 PASS      185.67 seconds
CheckValgrind                 PASS      236.17 seconds
CheckSmatch                   PASS      307.83 seconds
bluezmakeextell               PASS      128.60 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      921.64 seconds

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


--===============1785924860711988105==--
