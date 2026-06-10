Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D3400DF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089350; cv=none; b=R4kmoA3FEZVhTwNXf6vt3JapXSp7eI6ELlUuOa9s/UA48iYD7B9NY3x1jW1LoVe3oSAKyD/hKEj6K6kks/akkp0mknHk0CA3j/iLcSSHZ8BOsxyBS0cIraQ0znZ6vem6FHX/PsgqxcjgsPB1l6LxECOICPDN7BCEGH5xSt8JCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089350; c=relaxed/simple;
	bh=kJd/ADYJ/L09edCQQGOp0FE7auHd34hSIjTdx/xnvTo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sULzoGQh6BNdmX6dHAajWfG9aAQO7uTUrPw2O6rblx/IW6RZeTac1zbqN2ZRL3kLHMT6m+wh8nMojPun4Co5s5r4W1HO637cvucHrHxdGomemnd/euCkTB7VHtOFzKJckHa3T6uFpHiBXqCS69/welrBFjnpjio/TJV2SXKbHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFtpeH9a; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFtpeH9a"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6608c1a4215so7442662d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781089345; x=1781694145; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1jjldgex+nvchZlyagRIFe7kc+fw7yDi5iTnT2ytbmg=;
        b=IFtpeH9aw11lrck72eBuGbllVOJsJdYti3A1WjyDKXQIDBCx1iq+HF++FZJmEJAprF
         y2iL3iEHsaKgifkP7d00g956A4R7Wz+FA6gS8OHn7sW6wcQ7uWfra2KmUpdNsOojGS/L
         OC2mOlacKo6NRZzdcfMs+D5/ZjuAxixEozGe+YTPdkiCoONcSLQBvyBH7wVPlas1b1F4
         /CJ6q+FQXTBnk+ZXhAfxg1oihSwBaKQeqo1UjIR1yHL1BZ94fgRAFQRCLHvYPEert5BK
         r4fW3QDUgizip02KQjE9NsD+os2O3jAtmTS6Dtp0q7C5EpeAnUX1Q0w7GwfAbDKwP2tW
         GmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089345; x=1781694145;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jjldgex+nvchZlyagRIFe7kc+fw7yDi5iTnT2ytbmg=;
        b=eBybdBaUZJQ6JeJfKgiXjfyfcaxYhCwgtWUJa7pjRnqQsoDEzw70a6XL2mmF4+vzZv
         gGZfCWoBlXnQwh+G08LV541dOwkdps+OzEFfJXofETXzH4QT3+4Xu13po2crCG0yQVFx
         MYVk/QsuCARhuZTCjq4UIVRjOljan8BcBNdSghPg4p9TPcPLCKr8qijl33IgSob7csM+
         GywbBtrbk293Z+iY9jxzO07vyFmvh9KTAD+CBBIRRASrR3378yy7MQUTWuGN5B2wpoj2
         fVtL/PTH4h888gLwdTNPTuzOtcV3Op25iQwWhWY0w81EclB9HWIIJpC31DRo5M2WNzLp
         7BxQ==
X-Gm-Message-State: AOJu0YwiAmq7uhILDqiNCH02y/+S993+JiihUSL+FyQxJFgnOcjZH1I8
	TC2lu6tBMEJcURiFIMeHo7DOzPGFdIpdsMfw6DV0URjqAhU4ilNu4RKCc/jF/A==
X-Gm-Gg: Acq92OFeIHrSPE50xCgIW4neNfBuzoj8SlbhTLIwjMZUmJnV+SHUraTgJnlJxO7wR4M
	NZa5hKDHskoTcRuVvOBZEHKTKpwaYfMiA64mlFNJr+ZV+oGgdCmKX7ZNghzgJQ5NgUzxNwmaAV4
	wSaM1v5FzXHfqcGgd2L2r+xb8vGyrCdzJhwoPl3L3xRINEZa2tHxSx7n+C2ZGNETdRWf27jAA2u
	YBEZVc8h5OnF/YCsAiarNXyWkxwetY2jUopkvT0CsQmX12HqmZlIAMXdR/bCkFCgNXGRQjD88hM
	J4yLVc15HHtNbG5hxruwkHBQORJoQMlN4xquY7U/fc4QEujJnAxEG3Nj5V1yLXtKqvEppiIiMcx
	E8FPziDsOO27Etf35RS8adIsrx5k9pqHsTS3cmRQOBReOoVRcSD8oNisvkAL6dnpkGJ0qT3j9z4
	lI69YNpALQU03gct5rm6yVFPN4I13NUOpgDEq8LBLw/Q==
X-Received: by 2002:a05:690e:1489:b0:660:4abb:de7 with SMTP id 956f58d0204a3-6610a69f730mr16754250d50.16.1781089344968;
        Wed, 10 Jun 2026 04:02:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.220.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c4648asm233065661cf.10.2026.06.10.04.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:02:24 -0700 (PDT)
Message-ID: <6a294440.9d199663.2004a.e350@mx.google.com>
Date: Wed, 10 Jun 2026 04:02:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6039158013456413787=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2] adapter: Fix failed bonding attempt after LE link disconnection
In-Reply-To: <20260610082054.3915366-1-simon.mikuda@streamunlimited.com>
References: <20260610082054.3915366-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6039158013456413787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1109089

---Test result---

Test Summary:
CheckPatch                    PASS      5.58 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      21.00 seconds
BluezMake                     PASS      619.90 seconds
CheckSmatch                   PASS      325.95 seconds
bluezmakeextell               PASS      166.15 seconds
IncrementalBuild              PASS      605.73 seconds
ScanBuild                     PASS      948.54 seconds



https://github.com/bluez/bluez/pull/2213

---
Regards,
Linux Bluetooth


--===============6039158013456413787==--
