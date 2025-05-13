Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8D2BFC75
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747163705; cv=none; b=Pdx2FQnuc4+dgi1wdy1Ic3sm7pMniPYMU3o0B6GPTjG3lsd6c9PJT8E/LuZxjw8gsAbA7DDqPG4e5W1p4utkBgtz3+BiEoiY1YG8XUIS2qq7mdkSDg82GfsjVELWrxSHjREXO/D4OC/uFSlLGYlqlUQy0zPGRTsSdS68zbmHoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747163705; c=relaxed/simple;
	bh=j60Lphjz07TnUecbkPiSf7+5euAZs+lvjhZcqXFwxGs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CzD5xrwfXsZ87nr1wGcju3WTV/p3EBt08D0kWI2KZ+//OerIVZMw/y+I5HwC2gjbDP3CVQETRQ6R9v/2mu3nUKRliEm9CxVMjZhGJjOicAltksIzAp9B16mHAixcYXd9Hy4YUkkwu/IffU4gZUnU7tWfaMtL1GWQgoOgXyeh2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCE7n77A; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCE7n77A"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4774ce422easo65591291cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 12:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747163702; x=1747768502; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IxkSGnwfsdh8kiLocVEmONBGuOarUN2ptvbvkcaCwvI=;
        b=NCE7n77Azp9bIyiTYpJU2EyXCE1dO1xqYapFrmeAYS2BE48O7HtFVN05b3c++W/Ewx
         fdc29Aqpfe+J3LFj72q0f7YBVMrdImtjlvcymb4wyOQPEQTDVzCucTvsr4CiBTYaLLk+
         nkGbHXVPEo7YLHwk177Y3h8b2F69xKV7zmfIqAnvetcT7gZQqwxu0WyZfTK+QzKXotAj
         h1fx0QNyf9N1pRc5yG5pHPxCIsvjy2ZXxC52bwYgiE86ODCbeStP08P0qWoBwUnu8AOp
         dYDHQfWtjHBqLFqRnIgvPRqmwNcRjpMnonLbiTGAfuWqz1wnr8MfbARTWchjn0Ii7Gvc
         noww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747163702; x=1747768502;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxkSGnwfsdh8kiLocVEmONBGuOarUN2ptvbvkcaCwvI=;
        b=MHV0ZPchabX44GroeUOT/3IffYh/btTsPNEZW5pofnW85auop0vrRyWmkPXBcFRUk7
         T+Gx85a/vvXbjZmfFh5Y9XmMB64hUI1mEGE4sZBRP0lQpX3EgA3PJK3EtTzLTfG5vi27
         MQIDRUEyBaqkVa9gJCMY9PSAP0NYp9K47faQH2VdJIPWNYsjCTvuVC7KOjgbw8Mlhzu+
         VRFokN/xZI0e+K28IMr+UwdhGZGLzWJctzbUAZWuj555NY1JHrON+IcnE4pSikBn6HIO
         VXnpgz3nupC3fsTOpBl2IFfudORjFx//BX/8SaIwoFvi2NqLhI5XdQOO565tTaQ3DgA8
         KQ5A==
X-Gm-Message-State: AOJu0Ywo45As1OxOKYedCQTbkoEYOiKUVP+G0of2PeAYJiKaPyjOvrUW
	AYqbDSxgvSLtILGLLzE/cOur4zFR1FPMNOa0F35+2P6fTzrnkSYvPrpBKQ==
X-Gm-Gg: ASbGncuhOwszbFVyGjJcHHBfAU5nAdLjZ1ttzQMzil97HOz+Pt8COHfVV39b8BDFe+b
	Y3yu2VaD647W41TLtmEGysI8Xwkp1lDN08EV8HnvVo8PYmcyyvE9r2axbCaKn0nTe2hu7V35gFV
	wWn0lufVBofWv6YlzEwXev1enfruW/9a5YeNGW62edZ3WcmrJJfeotXhyoiYRTq3F89mMkO3R30
	S9e3YrWjOuCELCE8g2l4s331XBnDwW8kaYEOxbwKVz9k3mjkAIlLTiolrnyTiRcNCNaDXukurWC
	SvfqZP1IZbQXaMiiFi8okgZIbsOe33qaQHLWX5hev9nRekgZquFG9IR5
X-Google-Smtp-Source: AGHT+IEX8GkVSvkgVfVcf9r48ydlOOYIPdzLBIMfuoeRApMEjOMh6A/9dksx6/ZT5vkYYtwjkLkfZA==
X-Received: by 2002:a05:6214:1bcb:b0:6f5:dd5:a594 with SMTP id 6a1803df08f44-6f896dfb53emr9862246d6.5.1747163702424;
        Tue, 13 May 2025 12:15:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.10.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39e07a5sm70480626d6.15.2025.05.13.12.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 12:15:01 -0700 (PDT)
Message-ID: <68239a35.050a0220.342769.9213@mx.google.com>
Date: Tue, 13 May 2025 12:15:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7788080392477145398=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] monitor: Add definitions for FSU command and event
In-Reply-To: <20250513175600.1158690-1-luiz.dentz@gmail.com>
References: <20250513175600.1158690-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7788080392477145398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=962526

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.68 seconds
BluezMake                     PASS      2648.84 seconds
MakeCheck                     PASS      20.62 seconds
MakeDistcheck                 PASS      197.81 seconds
CheckValgrind                 PASS      272.07 seconds
CheckSmatch                   WARNING   301.54 seconds
bluezmakeextell               PASS      127.29 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      896.61 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3617:52: warning: array of flexible structuresmonitor/bt.h:3605:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7788080392477145398==--
