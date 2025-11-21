Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDD32BDC35
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719641; cv=none; b=TX6Gs8JLfdih6vRxM82E8O+u5vq8wQdCoVuAjwDHYechXmwxy8dsKjWwmBF8MYR28rDRDefTQKSsQL13anxrCjfEun2Y4rXR07bD6R20Ace0y8Rh358JGuavkakMe+16VlBUentCX1EYJ4PTHDMmcKnjQG0oRxKD2JE7KErLs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719641; c=relaxed/simple;
	bh=vfqj9bIYpHEIt1RfAqHYNU3mt9VcKvhkE0D9W4lnlvI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JeRl0DrZkDnxy2vhWRSUzXX3EXeIAnvlirGXlCsLMsy/9Egc195PLQhfgr8sHIUUJm46Oz+zn4udLN4cd+qnD2wuqi3/Xfb1e3EJc8VEeKRxXyeZ2f8Nozu0668+krhJBzGObAGkHnZrhWDKfOfj/kLuzpxFpnPoGVWpx5Q37QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5hoUP62; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5hoUP62"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-94880a46f3fso64718439f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763719639; x=1764324439; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=45Jk01240Pc0HODC6NETmDt7YkQCBHWbjOVhNhy3Uwk=;
        b=M5hoUP625t25SCCCNdamoLECQXHIKnHBa2iZIvzeNcb5ZyxLopEnaFErEg0jLHt2CG
         F/RcKivdAq6bVFHPz5nXVFG/6jxx9Q3nLshEJqr+UHkWjirU1nPBeFpNVC41hcW0jEmP
         0fWdp4UnHPzXdDGgKWwB/vVcERbg3y9uU+yzzyN/Ia3Vf8SPxd1VM9VqPhjNTEJOzRmB
         MhIi0hxTWD+/4E+ckQJqswoby4Eq/drsi9SnjI+0uKVpakeuXGFYRSRucqlRuWS6EvoC
         jnK/RpX941MDiN8CI6BPCDUc0SYnSHvSfJvwwj0z7OUIYWwOmrLbtvd/PwBEozCMsBf7
         knTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719639; x=1764324439;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45Jk01240Pc0HODC6NETmDt7YkQCBHWbjOVhNhy3Uwk=;
        b=TW3Ae98EZWX9c90Osda8aDOzm+kijSK7C5TTVwpgl0OBsE3jlj5nn2sLmDxqQND3fV
         Jm45zYYwmfgHXxX1IoEEW8RPtt/gZheYBSg1JwTfYL5+JrPNR2JX1m4P09+Csv37nRNu
         +LmXKhesnIj+q8xMG6wnp4f7Mw03KJixfCgnV55hRvTUdwBgj600Emh+nwL0Jc8RMr9/
         uDAKdsx+lVuhvwy/2HeUlCzBV9WL24bxTk9eigmO6876xp7Haj2y8MqTCZd1TCRJhXwU
         /B1VIicr4N9zeT5OswfJGYmBRdRfmgmn8c1Hz9oEHaAKI/+Bz+XGkps73R2520Yyn0UF
         ZUdw==
X-Gm-Message-State: AOJu0YxcV4UIwPKrGjJXqQD8zat/4k/rMkxY/1If+Ysy2roElH7P94uQ
	rpPeDgJnpBHfjk4Ovdl87eFd/vGREawptu+wOsZ991g9hixwXicGO6IELZ9R7zx4
X-Gm-Gg: ASbGncs38dvJe9+I4a08kPBiyhArgZBQU1xmW4auCpr24Fzaxc4P4IhTz4MXuokeGXv
	r6tA5bpzuIVrsjehxqdk9Nyvfl9bzsuseP+M54HCLlYbOSE6kAmwj7BhVTYbmU7g4OmT+Qt90hy
	2ApDI80MLLjNFH32vVDh+HaCs30jqoL37/4l9DJ6AZzj3paq8mU/62e6sNzAvhMk7gxmKq3qpKa
	ke8klGvPE30G/vZTRz+oqRflNx1w4/1kyqj6MOGRyEJz4sVf5aNwRaeDHTjnwkeF2k4kKeGqyXN
	dt5fvbbzwkTLOxCfToCw8mBg5gno14xkvjeAsr8JlH8xkMC6lu2f4LBUx1GgUqWR+jN4WCsOsl6
	Ivj0zYp3ICgOwqbTM5dImRJI+cd3o/F8AmUsteaz3hFheBUjOatR7IGtwYfjLIcBwuNQ2J/VG/h
	ZCPN2ITYiWYyT8dZK/MA==
X-Google-Smtp-Source: AGHT+IHyt1VVCzpFRznbNJ4thf5GZtGbMVaHdWyiltqA8/WKNnp/vlxksSLaqxaVQyMKbHxvGAgmOg==
X-Received: by 2002:a05:6638:ad2:b0:5b6:dea:8ee with SMTP id 8926c6da1cb9f-5b967a8a3a8mr903399173.17.1763719638994;
        Fri, 21 Nov 2025 02:07:18 -0800 (PST)
Received: from [172.17.0.2] ([52.173.219.151])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a7976bsm1982399173.26.2025.11.21.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:07:18 -0800 (PST)
Message-ID: <692039d6.020a0220.16b642.37a1@mx.google.com>
Date: Fri, 21 Nov 2025 02:07:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0937188137005743507=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] client: Fix issue of bearer info not printing correctly
In-Reply-To: <20251121-bearer-info-v1-1-f38dc0cbbbd0@amlogic.com>
References: <20251121-bearer-info-v1-1-f38dc0cbbbd0@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0937188137005743507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1026231

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.68 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      634.14 seconds
MakeCheck                     PASS      21.56 seconds
MakeDistcheck                 PASS      239.42 seconds
CheckValgrind                 PASS      298.84 seconds
CheckSmatch                   PASS      344.43 seconds
bluezmakeextell               PASS      180.67 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      982.55 seconds

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


--===============0937188137005743507==--
