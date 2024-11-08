Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF441C1F24
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096693; cv=none; b=OMhgKOd3yXm+9dqSzNe7CIKqZIip5qhC6J32h4jyYswVXVJC0bZouaSmrWsJhWXvk0bQNAwSUXwNJsnqYxX3Dn47GKGNAFgsHLNYiyuRvjM7wVyMcamoR5JONehZbdHT2I1JqR6OUOpv5bci4M2SE/8gCt0HSfdPIj6sCMyRs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096693; c=relaxed/simple;
	bh=5leAS/EIFCTkQ6xvysqSW4tQZNo+nB2XgFHyqQLQcNc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g8KPIdm2J3nliA0BvWJyZizMngII2VsWQDIj489bP65BZd6RYlUema5wTSMV5iwrlLQvjXs71ihoDmNc1DZdM83rbaz/xcqYFBpAleNQXRiFPEcUubS2BdI9/LLd8gw3y9QxXKrtMrPenYEBxXn4WafAksUuaOgq2PJOHDaHoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMfe+zoA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMfe+zoA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c803787abso22464325ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Nov 2024 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731096692; x=1731701492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ye5mr+sZA+sIG4wDk5yefHlJBQV0czE4EM/Sh+rgfw=;
        b=mMfe+zoAk74yGJa0weZg1m59h+Ufh1Gw8YMGGDVRnD2jF3LylCKD3A0VEdlg8puJnv
         b4CXYNJtoYPYQuZ5/4lCyESS7gWnI7Q0wMm/laKUA2WhD/n+NQpADUtKG/ItJeogovxj
         kreJj30ZVDWAv+BBOAH7CG256zaUD50eNdB6/kye00CqeYoHwq2bh6QfOyTgr5gOoQJa
         nRb9Z2Mx2NhakTHm+iPEgiLbcF6Qz3eR2P2P4mxEhCECNfz3tpe1hsvEAOaabLfQoor9
         Eoz+f7UYa8PAjBAKRPXRGvMP3lMuCwjDrqKPacseEAswWj779wSPVKmGbm6OKgcBEws0
         pJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731096692; x=1731701492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ye5mr+sZA+sIG4wDk5yefHlJBQV0czE4EM/Sh+rgfw=;
        b=LEDOrUsTAc7yToAq9Yr+cMbhj6uHDcEP7B3VmuGVWQ1zcn8hsJPNasWcciBkTx4Unr
         1kpAQybLgVaM3WeP6TzPBGlhUkDRFR6VKQzjReYB60oRdH8VGTDlhLmmYHM8loucdfkF
         6/mwbqrgujpp7lPIDHIDbyD2MphxJmfWq3mbkl779PAIKPlEkb1PDSVvVk+Nep3APFuT
         jeBBOlX3ZkD6LaM4PRbuGdR1Bs+x5/+OM9Sbh2XZrUWBlk2Sc4ZPyaIAoGz60rJSWVPu
         OXnDXxOGmrpRSZdyqN/dzipN/8tXDf+nxgGfoWA6JI5ukW9LMMtJBTfaeHlQ6OVJG3Pu
         X7gg==
X-Gm-Message-State: AOJu0Yy/2JpIaqsIXlfjGf9kMIJXKEJfhaecNh3IP8/Hd33LF6+LAIMN
	YYSfQFqc/NnDucyzlLcW4vq6ja17WVaxtsj/9SUkrgtKnDo87OJGJM917A==
X-Google-Smtp-Source: AGHT+IEyoQAxKBfByEOodDNgKeht+aFudM/Y4NrhRyljgirilSzMIUU+NngwgG6GkTn7P8g/0uy3SQ==
X-Received: by 2002:a17:903:230a:b0:20c:6bff:fcb1 with SMTP id d9443c01a7336-2118369d530mr65638965ad.1.1731096691621;
        Fri, 08 Nov 2024 12:11:31 -0800 (PST)
Received: from [172.17.0.2] ([52.234.40.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde1adsm34805175ad.65.2024.11.08.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:11:31 -0800 (PST)
Message-ID: <672e7073.170a0220.156ab.4190@mx.google.com>
Date: Fri, 08 Nov 2024 12:11:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8305577719222884593=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] avrcp: Fix not marking AVRCP_EVENT_VOLUME_CHANGED as supported
In-Reply-To: <20241108181921.309039-1-luiz.dentz@gmail.com>
References: <20241108181921.309039-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8305577719222884593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=907911

---Test result---

Test Summary:
CheckPatch                    PASS      0.25 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.63 seconds
BluezMake                     PASS      1750.10 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      180.21 seconds
CheckValgrind                 PASS      254.75 seconds
CheckSmatch                   PASS      358.79 seconds
bluezmakeextell               PASS      120.89 seconds
IncrementalBuild              PASS      1501.67 seconds
ScanBuild                     PASS      1024.91 seconds



---
Regards,
Linux Bluetooth


--===============8305577719222884593==--
