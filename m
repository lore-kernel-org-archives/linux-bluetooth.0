Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59438DC0
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093098; cv=none; b=rYmmvGVMuPMr8rmdfwFjwRTGZWpALs+njH/mb8tEfWRxRmOqrx2cA7/P08dK909ZvkH/28kIPvyPIlaqu3F1OrEQkonqPm12Yncoxkoyg3h05Tl1maejT+Glb8gUn8MHFGwVx6I5PmgykEDh3o/P9FE7KwZBAzsSTzZlWzsg0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093098; c=relaxed/simple;
	bh=LNtBbzZhTGVy3L9Mpm/b0oVzKSOmfn4elQVQiyebObI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Lq+LclbOeoaXka1ZC1KVTpHqmWPX9S+cLK3aJFmCCbww1AT/soKSusbMblQ2ou/uFl9YBXGBPCJxdV3+PEIDfuZ3h9SgOzS2+smn2gr/KdrpoI0T8wbStVTjuTf/S0n+P0w7Z7Z/4Idgb7FVU1/fSN0/EHa9KDxjY+4Hnr3CjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdSLyx8Y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdSLyx8Y"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728d1a2f180so1320350b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 04:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734093096; x=1734697896; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NkdFJJ7iP+4Bc9VSIRLrMIHlmAz3Yyrhv2Tx1EY/GRA=;
        b=JdSLyx8YATSZ4RMssmZaj2t6qyBExNBrw+1eEyD9xh76dyR/Nlq0QFayWEEFgJrcIT
         uBRlJtCJyx4FeS6HOMithRRrogHTbLjOkHAx+ekxtx3SfJBDErsMmiaU2BXsIJrTBtq+
         aUPNqJHUUkPvz8oNoljISlLLQ/3BnCGrDV8+6OZoRlt6eFxqmbBhTz3VOZREZnJvBFF8
         94dfeEHhUN2fw5lCNoWxoPLEKZ+E2HT+owXRjb6br1GaLS4TClfJnW/wmKvigeMjguvS
         HOlEqvPftzk27l3KiBoaDaTUiHvuuJRSJQy3HakjBR0Vrkj3QogMPPhj1/rFmRV+9Kz7
         a4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093096; x=1734697896;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkdFJJ7iP+4Bc9VSIRLrMIHlmAz3Yyrhv2Tx1EY/GRA=;
        b=I+j6pkko5o2AFu98eHCyL1KeRx+lOcdZ8dwTo+e54jOn9jCkuVXA/3OLd/VrGAiI7X
         xT9Z23omZPdinBJeqvRMgpAnA48/p49Qfhgvf0kBQh+mfUK7f5+hbneke+fbz/fUg+bC
         fP4ZTxDZABCLndd/abvQCSIjmADcG8fK+HUknkPCGMKRQrPF5SgV4Xa7CRfonoNRia5/
         7VSgmB/Nn9Sxv/ghYcbiCvOpzWmoiI19dYFNJOtXUmUnvKpfus5z5ZzineODLvkjqUL6
         a3prmzNX7PTe/jkICAfGs+PInzCV6e2Mf/2j/ONhRzUd2dZ7uA6bapR4Arw2gZwS/Rqj
         WHZw==
X-Gm-Message-State: AOJu0YzlBLVHpaFmB7fYC4+iW6717qRHmbp7vIVeX9iyvun1F0Pwm3ek
	6deoxhUMr4nwlszNqcNU8kCFA0B0/N1JFO236DkWuOrCnDNh50QewxVwJA==
X-Gm-Gg: ASbGncucX0g69LwPuIowbzEbg53n+YPPOfU0HZjvQoHB9ObZ3EPcv+D/W7UPXr990ye
	eI1/THr61cYVMRS6Za1/hINbFjStbixh0WjlbnpAfgwxxKsO1VWcglqzNtIQNtZ/3cQk8x/3ZQx
	6JIess2H/VZS4jM+pK9LEc2IwtyLFDRbLY/DOMjY4Mkd5eHqrOLGaYHMl2NPxx+CwCwSMF6/gpE
	tuXlrlUN4fPAKT1RKjVnGGc3QfoqLK9uztqSJtV8dxF35HWyirK5iaWvLUYGOQ=
X-Google-Smtp-Source: AGHT+IF3wTO/l8TqQdLbFT/s8//kD6eTpvNWxkW1wU9VtWtB4XNQnOsB9IauwhS6PaeMoODKjRVLGg==
X-Received: by 2002:a05:6a00:9a3:b0:725:d9b6:3952 with SMTP id d2e1a72fcca58-7290c51376bmr3384409b3a.3.1734093095766;
        Fri, 13 Dec 2024 04:31:35 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e67ec452sm9621533b3a.179.2024.12.13.04.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 04:31:35 -0800 (PST)
Message-ID: <675c2927.050a0220.3a8a46.2876@mx.google.com>
Date: Fri, 13 Dec 2024 04:31:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7609858659916352566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obexctl: Enable Map folderlisting operation from obexctl
In-Reply-To: <20241213111940.3475051-1-quic_amisjain@quicinc.com>
References: <20241213111940.3475051-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7609858659916352566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917564

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.32 seconds
BuildEll                      PASS      20.31 seconds
BluezMake                     PASS      1586.90 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      158.05 seconds
CheckValgrind                 PASS      214.43 seconds
CheckSmatch                   PASS      271.61 seconds
bluezmakeextell               PASS      98.69 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      843.81 seconds

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


--===============7609858659916352566==--
