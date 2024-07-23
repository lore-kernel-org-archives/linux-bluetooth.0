Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D613D882
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738830; cv=none; b=DT52+i16iaThryZLvvgVmSZQx1lnHMYninABW1kF2BbjW9yCCdYb8OKkuX5JzgJSK5y8nWqBqSWkiPtNvKTqMRnkZZwtl3DiZ6TD4fnsMxjDMZ/MKu+A0z2RF+IyJu9ajX0+UgTbC6x/ZHBuveoiUosqmpiaCJbN0QZ4I0enR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738830; c=relaxed/simple;
	bh=VOgiTVUDWiGVgejkuk7Bi+V+ifaqGbIZ0eEV8Aoan4s=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MVqHaYUgsGzCisfGfhg2LdaVuiTeGf5p1bg+laZuE81DxcqUBWRX7pPd+KumzRBZNYXu+gaFVkRfLm0RIVwiTRe+J3cNL1UY69jqqV2plBZg8n4d26N0V+johclrE+Uz3+HJ72yowEOHGpcrs+jL1Rzhox8yz8g7UHs5nzqQp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKFPRL8y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKFPRL8y"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so1407279b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721738828; x=1722343628; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TS12aGoPOJ9/SZiy8wgkSWM54FnRHjMGosZTbtXEAV4=;
        b=LKFPRL8yc37FVtPNt99M59orwyMSvqccL7B3mt71OEkm9jSkU/5l8WSS5YFFkcPk9k
         420OMwQB0g/piHp535jLTpnrkPGzSbGP4FyhR5LJP4/YuyYCllGGvaLs49+Gje7APkgd
         VLGnpfZJMEwzP3TlQnN3SZnR8IKQ+HuxprKJzQjiMIWfRNBEjOaC8BU26NfzIVBm4suI
         Y8nPIVTxoijrDZid7MMC32UeStd8pl07kYeXdCpRevuCtUoC4Phd7wHB+P/V8WuDb6Ky
         SX2aSelt0kpRkm5/jrS/573yzqUNOdN4Bf23gbBCaWBQKau39QZeADYxzcJZLAL44BRO
         jJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738828; x=1722343628;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TS12aGoPOJ9/SZiy8wgkSWM54FnRHjMGosZTbtXEAV4=;
        b=CZSOUqz6LRNDBh/BNL+L+oyFcGvxLhhrkn/SO1dx7DuSjlV9Mq24ZQn2L07q/eyzG4
         6lNAePIP7/OPxtMloRWXQc6KaTQamZKkfHx94ZMnObbTMOXt01llJsDWCR//xp8ZDaV9
         fQYhEo3EwVyp+B81XATaW1483znuX4AUla9l4NH17h0DbppgvGkK+6GYD+m6JNkYvSwS
         07t6Uao+Fec6gndWmi8A1ickk45lM9hRPWUEe+lOv7IsagenYo16AvgGU5CqMl5ubrnu
         U/IPGgMWekgbE8qN7krg9UWkB/8UJ0gqb34GnzO/lnsNlrvQ5gNbK4rtjK2o8PTGdXAh
         472w==
X-Gm-Message-State: AOJu0Yy3CjTwhAk5zUEZU7IsiOmd8QsXjwwaStJEsOJbVMwFr3PhNhPr
	3ONdReazrzkqcUpe36lwAG4NuwX2S3lgRgPF99fmM2zvoPIDLJrohp7YNw==
X-Google-Smtp-Source: AGHT+IFv9Zpz/D1GfL/MhOjAvhmwDjC87E+kgDY/I2CxjWxwSAygVzNNtYGEzfweWCXXBRnLwWyHSA==
X-Received: by 2002:a05:6a21:99a6:b0:1c0:e3bb:83ba with SMTP id adf61e73a8af0-1c428573440mr8346241637.5.1721738827804;
        Tue, 23 Jul 2024 05:47:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.24.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm73757865ad.219.2024.07.23.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:47:07 -0700 (PDT)
Message-ID: <669fa64b.170a0220.320dfe.312d@mx.google.com>
Date: Tue, 23 Jul 2024 05:47:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7291091126971472176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [BlueZ,v5] obex: Move size emit signal to plugins instead of obex.c
In-Reply-To: <20240723110514.8598-1-quic_amisjain@quicinc.com>
References: <20240723110514.8598-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7291091126971472176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873215

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      25.67 seconds
BluezMake                     PASS      1798.24 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      185.50 seconds
CheckValgrind                 PASS      265.17 seconds
CheckSmatch                   PASS      374.25 seconds
bluezmakeextell               PASS      127.24 seconds
IncrementalBuild              PASS      1647.88 seconds
ScanBuild                     PASS      1098.73 seconds



---
Regards,
Linux Bluetooth


--===============7291091126971472176==--
