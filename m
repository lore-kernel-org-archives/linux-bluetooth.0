Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B111BF38
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707454; cv=none; b=s1ZbaxakjG/cDG1Dnzx9NcUeODKJ7oyp2w/XvoH4bTgQAYPSEmwOmYwrqXo5bf40haxlcuGGIICkFkjCce+GgqKkPn6RPVJhYXX2phc2/GTRXw0blZ+PnSYlUYIv9wqOxf+8+K97UlD0xEa4re1Fkc2FmIbPKTs+ncMH2QrXBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707454; c=relaxed/simple;
	bh=96jNtp6oCDX1ElQk7932B/t59bCZM1EBHULoxeK1b5U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p/HEVHBRM4jXGef4lq9gp2pZwpvuKLLUVB/P/k4647I5aip6aJ6izzR+/ATmi/wlH/ZGS4z63eda2KIOT+iFH6wVYgRJy21TcXFu7E0QQfOos3m4eNVInivMuIbOnJjbxR5pTOBlq5/yibNiBnDeTAHdv16n4GHzj7IiNEXvue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ3Hyx9d; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ3Hyx9d"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff26b612a9so2802133276.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718707451; x=1719312251; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv8XV+E+X84N/MtBYtrWhhb92R/gqoMRmV53NV4fs5o=;
        b=eQ3Hyx9dLmYdPDcJlznHTWfNaoTiX+FQuXk3gUBT+JbKMSlFvopbBjeOBlgfSJwcdp
         To5tOEupwOYLNn/kfSUqKexZWelnjq+SGsG0cWbpEMmA4LyJViJILdSkhql9cEHhUuqH
         9mOEJZtu9ObaErGvh/gWUAnJvHyQXoYDavXiUKo5FSedeOmhnrGeEBybjSyypkHsQHe9
         rVyBykk6O7qIYv4zqMHxAz94pJEFPKybkbjBmF7mBnDWPsKXipEloEK6276j6O6b8+6S
         +vqkFRswqyR7PLaqtAHX7OM13ja2A5IFEPfY742h5ToEA+WDkkMlD/G5SpfVzK/h1xJz
         XTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707451; x=1719312251;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv8XV+E+X84N/MtBYtrWhhb92R/gqoMRmV53NV4fs5o=;
        b=H3piScTo5OprNB5tjqNB7rDe6gYUnGs9qkSd2JOxF6CMZItcc1rVEKd8p4l9kOpWkt
         kJBfNy8EBqoJoqPBBmqaPIlr612kq4pO2iksiKa+ycQaFPz5EN9u7wdQonMSLMhYWoPA
         3q45HbtXGJ4KxZQy73QJ+FBPs4JY+YEaPcBepC0DTfgrIgmxh7T+J2Et7VDyAA/iL7iT
         aMTo0trfE6pamgZjROvIzfvPrbtjUx8r1CboBhEkqoMi3hcZYcFvXrBR+pL7/va5ntei
         d/AUsHJkMR//YDHld5g1/AbG7hzQ61WmXYTdXbcc99Mhwq+Mxe33qMSNHiMyRxWIuP22
         ZE/Q==
X-Gm-Message-State: AOJu0YxGmdjR5YibHiydWCaeqasJH/bzavwU/7aN1+RPC45gVI2sBH4L
	OkxRDCArge9QB0LV6jgoHbhhpTzHzG2ikUc2rloTFeVK/VDQkYO5tVrEHg==
X-Google-Smtp-Source: AGHT+IHFOnlNvqZwu58srFlXL6dde1Sb+Pt5NEo+80FussGih1R/eCLSMeeVnJO3zPImlenQSgeFuQ==
X-Received: by 2002:a25:b19b:0:b0:dfe:e98:be37 with SMTP id 3f1490d57ef6-dff154a13cbmr10538780276.42.1718707451527;
        Tue, 18 Jun 2024 03:44:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c58eb5sm64936696d6.67.2024.06.18.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:44:11 -0700 (PDT)
Message-ID: <667164fb.050a0220.fed25.4330@mx.google.com>
Date: Tue, 18 Jun 2024 03:44:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1720309436423946751=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Allocate memory for broadcast code
In-Reply-To: <20240618085823.30798-2-vlad.pruteanu@nxp.com>
References: <20240618085823.30798-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1720309436423946751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862936

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      25.46 seconds
BluezMake                     PASS      1731.99 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      183.45 seconds
CheckValgrind                 PASS      259.49 seconds
CheckSmatch                   PASS      364.19 seconds
bluezmakeextell               PASS      125.23 seconds
IncrementalBuild              PASS      1506.81 seconds
ScanBuild                     PASS      1052.66 seconds



---
Regards,
Linux Bluetooth


--===============1720309436423946751==--
