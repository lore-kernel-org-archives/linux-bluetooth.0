Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDD19754D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506438; cv=none; b=fxHFBPVrptfoG/evuNPIezim+p6Q3tp+STce5xSYpvbvKn37NVGBaB8E3Q+K4dcluiT4MV1jHrghFwsZzNYt8cjgKPxYb9beBqS/okpRiAqJWmzrGwcUmolSuITswJPu4abrm7veqiAQEKjPcY49voCzc7tI6oro7VwyMeWj5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506438; c=relaxed/simple;
	bh=0UutwxHtUXPY1nBPt2xMB5hcl9ZvZHl0z1hnPLMhkl0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NMupep0ex22RMfjhH+ifUgF2Nlq+cuzahCkOLx2cgruhV2Y/c2kpm2KYrsj0joLd+qxxd4DQkdJigWp7Z5BwK2q03zMHLMeAQhF+QVoTRCGkqCEieGmfraS/a/fChrMp4ik5LfVftd9Gog5/lHq6+aJgdJX+f3Mlz5XJBVoGAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4puVg3J; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4puVg3J"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79c10f03a94so173703385a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719506436; x=1720111236; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wScH/IbvZG/TZ8wYKhA6TWn16TnOzHGzinJq+x5rvqA=;
        b=M4puVg3J3UbkSbwF21WG5eOWsnW1P+5mXSshTIHXih5Mno+pat4ah62R5DdJHpyDz/
         0qT4aUEB5QAJ1a4s0u33IeSlAMB/PrxvXRmITTT8T9gIFm4ve8j4+pwohlrgrCjcVPDh
         ElihN4nxfhEkI3vYs1qMHfC98BFLEGLt+wTL7PKCG3S+PRV2gi5ZEJTdXasAQ5uGDTvh
         j4Xp8kLe0D2ztraDKi/Lm6+fdm4S4zn38qxN+GIr8OiauV+59uqpay6fks4tSybJwWLR
         DbjDxnoWPtwbFmUMdyVU+5Zj0tzeJaPk4J8x1O7VCpSvClIxx++ennIUnpMOoPytqpIW
         5EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719506436; x=1720111236;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wScH/IbvZG/TZ8wYKhA6TWn16TnOzHGzinJq+x5rvqA=;
        b=XtaoXwse0JYveQT62bVvpwJkhhb/pHO1tjB5c3lm1OYZXrzOmc2t6op6h1h5CGWS0T
         GP9PiEBk8go3uyNK8hj4IsAiCCNEXM6E2ivzCqWeL+g6UPzRuW1lfHnMP0XDoNrCHJNP
         PRzl+B5w4tOIlqGmym7j9hJsTeaXlhG+35qhp+KGKX9e/c7ylubeXhGNKpnJQ4WJ4Gu7
         9zWuuuZVWBjkjPfz+zSvs8UyNKdQ4RapQ9UZ8Z64s4jDu6grY1dxPIOT59P7T8pjYKur
         RroXt1waR8zij8BqOI73ezZePlaAm4lHZR/BhobWowuL1SImp1x75pduoHG8oENtAOUv
         CAHA==
X-Gm-Message-State: AOJu0Yw3hQUt/O99/f2PrOnEQR7HvMyccbph1AXi7pmsZKiZj7Ya1DEJ
	ZSYxdMcAOG/DG8XOZSBNcUbvDnYhZt3Vp7gSq4QCLW6Se/gPC11KOIkOdQ==
X-Google-Smtp-Source: AGHT+IEd25zeJIlUWF5HVO98WNf1NhD6HPr1KMyBUCW4Nogjl/gOgoFkSsRJUThdqgeCaDZqvO6xGw==
X-Received: by 2002:a05:620a:b05:b0:795:59ed:21e3 with SMTP id af79cd13be357-79d5cfc4756mr295836585a.3.1719506436173;
        Thu, 27 Jun 2024 09:40:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.214.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c8add59sm70242885a.83.2024.06.27.09.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:40:35 -0700 (PDT)
Message-ID: <667d9603.050a0220.e236f.385f@mx.google.com>
Date: Thu, 27 Jun 2024 09:40:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7085960274503952428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] gatt-server: fix memory leak in bt_gatt_server_send_notification()
In-Reply-To: <20240627150917.85755-1-r.smirnov@omp.ru>
References: <20240627150917.85755-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7085960274503952428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866206

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      24.60 seconds
BluezMake                     PASS      1669.13 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      177.63 seconds
CheckValgrind                 PASS      252.82 seconds
CheckSmatch                   WARNING   353.79 seconds
bluezmakeextell               PASS      120.50 seconds
IncrementalBuild              PASS      1414.90 seconds
ScanBuild                     PASS      1002.35 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:621:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7085960274503952428==--
