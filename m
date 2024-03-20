Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB644C8D
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945628; cv=none; b=mqTGd38TpKw+4yRy9G3gsb6YwG9M1wj0wwc9xIDDHzQmexefRJ+Ck71Sk6fTkO6wrj5glc0ujSaXEQPwEICX9diAarZ309Eq3MxWVFRO5WM1Y/2NsHmgoIJ7ctVI5RMAveYcccUAZJlVVsOWxUwXJgVW/uq+BAFX767xR+svHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945628; c=relaxed/simple;
	bh=q+qQTFkcmB+VyxMcq1GqOkHKKSesfUhAA1dSWYxHeJ0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HirvwyfAfc8B4QmChG+CD2l3PMlUtRQAcm1kpxnpPFYAB4zYuPerJXgOm43NGNaCGHgT7JNuIRqU5e0WhrFfrxtjCEz9cPLOt6x3ff3dtLOfDjCAtte/pjTsQK4Rn0hpdD3axXM+8y4ss5dmeiSHuKrfsmhoCUU4E+icsxAN4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPu50OGi; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPu50OGi"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4739b6ddc94so973535137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945625; x=1711550425; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OD0kjLVoFsHxtw7q5dW91Kt7gOS2HJf9Uue37qSobOw=;
        b=mPu50OGi2TR7LSQZAB9skSQ99GN7xkqv+K6ZLsA2meN2I2PFwz49W8lhxVCC4anELf
         AylLhRDZooW5kjc2mse/nZFLPywixJ4JD4p+NFIzxIDOdx1NvICqy+gyhjm9iA7L2ED4
         kQXzcoeFWyM/56/rjDfZQMYkjwowLn3CpLTmVDUetJjkxihBCvEg7umvMoeVdhqTAmzP
         HVBUVyhOMUq6f3VydgufuLm31FCGcCvslaqcZknvoqGXEQzaf42OyLeKi3ylI0iyOg3i
         pQrS4HI9WkQWBEU3zhONy3qIqQkCQgzn0E4VWhkO8eAdDXTT1kvCuGPdjEP/auZIT0Rh
         19hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945625; x=1711550425;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OD0kjLVoFsHxtw7q5dW91Kt7gOS2HJf9Uue37qSobOw=;
        b=UEE+pbYae1zFMUezf56pOz/zSmzW15ToIJROBWcDgqaEfGvbxba6UoTtAskx0dswJA
         Qa+5i0/V2cNattc86mrtawv+cI9YYF9U6Sdt8bBJxNdjtFFHKRkOi1PtzI71SyIQLjyu
         2XeNU6alvFGd1AKSKrYJKHkMKXF3rDo1hKwHg7Vt0dZoS1aq/z/QESaUgwJli6dFlhFb
         3W0s3j9H7tDR1+A1ZIMGAEZRogebjFSrYRtUE0SPsbGFhFnxiwNaNfdkrG2qh0oeDQuy
         Yiyt2Y4snbZNvfShPKqyJgh0ypsgFh+EEYPUODjskSTgOXWROAizxeOGyFZdZKXsdNT8
         jmGg==
X-Gm-Message-State: AOJu0Yw89I/SQSn6NM1b82QpriCRuDxcFQVmIdDAd0b707pzpTeeR37p
	u7jIrfDz44lHOm1Y/APxiz23kEI5i+48kPrKujki+5cX3gbUHi3QZYhDSTO6BGM=
X-Google-Smtp-Source: AGHT+IFcn8Bs4WGFQHMNo5YL+R9/LHrYFWr/GxgLRo7MVipDuwajVoOSu50g6tjTsAvpZ0yhEoth2g==
X-Received: by 2002:a67:e34d:0:b0:476:af2b:2845 with SMTP id s13-20020a67e34d000000b00476af2b2845mr2523586vsm.20.1710945625570;
        Wed, 20 Mar 2024 07:40:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.84.67])
        by smtp.gmail.com with ESMTPSA id 9-20020a0562140d4900b006904d35e1c6sm7933022qvr.58.2024.03.20.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:40:25 -0700 (PDT)
Message-ID: <65faf559.050a0220.b16f2.25cd@mx.google.com>
Date: Wed, 20 Mar 2024 07:40:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6983294761793308545=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] input/device: Fix not handling IdleTimeout when uhid is in use
In-Reply-To: <20240320130119.854959-1-luiz.dentz@gmail.com>
References: <20240320130119.854959-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6983294761793308545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836747

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      24.03 seconds
BluezMake                     PASS      1635.29 seconds
MakeCheck                     PASS      16.04 seconds
MakeDistcheck                 PASS      174.94 seconds
CheckValgrind                 PASS      243.79 seconds
CheckSmatch                   PASS      345.49 seconds
bluezmakeextell               PASS      117.45 seconds
IncrementalBuild              PASS      1424.62 seconds
ScanBuild                     PASS      994.25 seconds



---
Regards,
Linux Bluetooth


--===============6983294761793308545==--
