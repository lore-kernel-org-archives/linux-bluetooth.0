Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9743EAC6C
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945213; cv=none; b=Yua+mW4m5N6itD0fU89P7lvoBCdqXuO/dFok9barG4FU6UcMmwKyB+qgDeK2BMsGIvxe+DLS3dZp0qRjDtEl4n6h0Wqp/addho6/MJDPwg4edZureI1tRlllmNWhwz5AR28tIDRmfWGNTeHFmu8rzv29V5K17wFSDDwkFkuCV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945213; c=relaxed/simple;
	bh=0mxbLqqVFlST6Ji+fxMEX1Jy4ysYw/vzG1P5hslPOQw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZlxEHjP7YuqQfHgeCPMzV34Xz1xte772YYeZGEWRZMi75zA7mUBIJJG6zcBQX91GyFlhmNh+CmOY3g0xSQnFP89LHDOBbFy7UUdQkcF3/TT4JVJ11r0kcIt+PbhzHagAU9UWNWcGAlnNCynGnUMdxFHq7aYoMqcMetcZsPlX19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCbDQJ8w; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCbDQJ8w"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89f87257904so53973916d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776945211; x=1777550011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y92tei0Aj+oTUZ/IFO2k4mA4q0ViANosi0MBxxjpPfo=;
        b=FCbDQJ8wouSl8/JDWOf2CMy1YhqIoOQPISeDWrqDD2IC44y3eMu8Cmkba4HTRTIr4+
         FyGlt/VGPSkySxDOb1+wXbeoSgFnjskEZoYXank6Y5tnSUuenbSf6Irz45ILRPnCwrjA
         0WSQsmRTlU+5NsE+ugv/hdoniuHqG7/QZsdoILkqdBISzupC5oMPEUXVapbaknhkPBFc
         rS4Q1xE7dipN0JInfkMNTew87bQTcMfbda8guwWE2LQtvNTtMfZouZgOhwjxVVirYnma
         YMPNsKSSnYz2YRTk2ZFo3zOLjiRHKPCK5MHxpeh45grRTrtV5pvcmnUJg0jjeTRPxUxj
         ce+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776945211; x=1777550011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y92tei0Aj+oTUZ/IFO2k4mA4q0ViANosi0MBxxjpPfo=;
        b=AGoOrWmEypg2Jq+G0GKLyzV/l8SD2nsY/q6HdpKiMvogvvF+ilTuRsr6Z02cgN9Cz8
         xPKL0947MK2wDWXYLIddo9YmiYnW2LmQNw04iR2QcOgKo4DZ0OYTP53REk7alx/8/sON
         TZAOABllwB6ZUMHRNZpQoSADO4BEKHyaXKNi5YxlPCiHvX2vyXaVa8k8d/slPTZMxZNp
         kmWb+Z/0Sz4Le9CdAizFjqHqcH7no9Xco3v2OmeP0jx/HOo33ZSwJUGWf5cSyiQagpUd
         NH4+rGQYA70p8gZWNEkHxhIockRvsM8XgqzV1XSiSiGjWK1dXEwQPX+hshjetZdT5NYv
         otgw==
X-Gm-Message-State: AOJu0YzyML5uzx11dygLxkR2hPjNe5Pmy1PdUqF4h68NqDYsUx4JTchf
	4JLvUzMR1nxkVbyEyf/bph1DtxYVvEa5vf5qPsyj9H3ogS4ZLEmIWlrNZbid+Q==
X-Gm-Gg: AeBDievYrx0vYfCwGEavZRbMfd5iuJHYpQDz1TLUc6YTIeMkPcZ5iTsayt2fpQry6G8
	hx/NfA8FWXzr5oGwvQk6aqab3ZPWOhcXy3p3Z2Usdl8MJbSYrPz8CIZfby4w3NwyyccO8qIfcF+
	NIOpASv0ylV8kVe66kLZeDUmsjz3H7JwhLpfy+gmD90O+PAbJ9Qx4n4yRPsJm4zF4TQCYRfuYEj
	h2JaIn3wbDkQDpUpsDjioDJKVzjSv4gmOsu7QU6u7lUq7MrFHyPqIS2i08E2juSeCkLh/+wUZBf
	96QPxz9pFqXKSAsxhsK6/xlT1RFF9k20/AnEEh4hlqO9OJxHLBwXR+bhCdTbP+2eEIHgC3uhAXR
	03cMudg/uzcBj6S6kaHm3dXaV5zPzlZTVKRWcpEXuEleHSH7qkTaX1fDtrrmsTpMjxu/OetOtgL
	yu8k+AjPLn8xfxYmP+Oxr/P4lWPDlMt+dhGENufZe5RwjOi3TQG0E7
X-Received: by 2002:a05:6214:400a:b0:89c:bf90:e4e0 with SMTP id 6a1803df08f44-8b028042975mr433905046d6.22.1776945210674;
        Thu, 23 Apr 2026 04:53:30 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.103.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c464sm153660516d6.32.2026.04.23.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:53:30 -0700 (PDT)
Message-ID: <69ea083a.0c0a0220.7af9f.da45@mx.google.com>
Date: Thu, 23 Apr 2026 04:53:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1094562459487755451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v3,1/3] audio: Add ability to force CIS transport Links property
In-Reply-To: <20260423103934.22799-1-frederic.danis@collabora.com>
References: <20260423103934.22799-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1094562459487755451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084652

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.99 seconds
BuildEll                      PASS      20.07 seconds
BluezMake                     PASS      607.25 seconds
MakeCheck                     PASS      19.20 seconds
MakeDistcheck                 PASS      235.07 seconds
CheckValgrind                 PASS      274.62 seconds
CheckSmatch                   PASS      321.53 seconds
bluezmakeextell               PASS      165.35 seconds
IncrementalBuild              PASS      619.37 seconds
ScanBuild                     PASS      926.27 seconds



https://github.com/bluez/bluez/pull/2065

---
Regards,
Linux Bluetooth


--===============1094562459487755451==--
