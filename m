Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECD2E639
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717677093; cv=none; b=KQy+yYij0rR2D4SM1MaNxrpFOG20xrCTuq20U+kPCbgVloKe9f7l7mcAShst855uTtwTx3EsmIoEX8RG8WB4SzALCC5AoTiAdIJNcbbtoQJBvApf/RRCYo54+qv21ZaeVcUBCgfV3X/bmmVqGN4WCFkZ4CLiQLshfxsk2qlYCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717677093; c=relaxed/simple;
	bh=hG4wkAmsCzzgnBsNRq3HdCv+iO7kyCaA2x3PriVg3kk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ePT/SoUxEbs40yqVWFrmheES+cDWaHQN4T1CEqTB6yc5KETxZ99X7SB9Q9apIrm4g6n2JrIHJqZ84KblTWTlRChF95H9BKk1CnzdArrN28VXCEzDlNvd5lygYa/jLevQQCru81w7SdXikobTfQYXUrDVY+KfdgkxI3weNYjujLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwD5s+Ua; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwD5s+Ua"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f62a628b4cso8655825ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jun 2024 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717677092; x=1718281892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/QvElmohQP/hc6x8ktal0L2sRkGeG55hJ1JwonWIu+Y=;
        b=QwD5s+Ua+lW5t92Jito6vjLt4YgvwCGdpW3ITEtL8Fr24ZO/a+w7ULmFY+d0ZbRPaL
         57KI5wgDDxinZtz7xE7e9IzyYWCCM5vw6sCYBqJEQnR7/a184CiSd5dxc5CZ4GEtIAeC
         JFlUSqepzgTnOsS971CIKhPraUG6W2QiyZ5PFlqP18kXZ/5tEXDyS0IdOXKkGPq2efrf
         gEAnwugLQmRM/9GJIReGPM+8zGDz+16j9uGmpXPxDu+IYe8F2n7PWhERVVnuOGVujY2V
         soG2niSdUC43GLK57AYiLfurlqJX/ZaClDVpTttg4x4BTAejbaed5vRo5rm7Odz+h3XV
         HvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717677092; x=1718281892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QvElmohQP/hc6x8ktal0L2sRkGeG55hJ1JwonWIu+Y=;
        b=YyaAfENHBZuTkwiymspQFgbTUNQMjbnTSsS6FrgT5TDKkM7ICruK0nLrn6+gAjmcnK
         SntSXab/bqZLzdhrna2B9PwBFBJERbWYvYhpLka6bhhg3/1cc/CtKJqhNH2+ToncXOi0
         ezPZOLRccTyDMnUzgJETZWqZw3w19Mb1ybEUBYO/QwEhtxpBCNr/F8PDfb67hZKzeSae
         YLdbhdwePQp7wf9CPEvaVFd49BTuYWsP4ZXfoEGHOoa8KP3bb1JEkVECFZJj900K1cL7
         lR1CuuLYxuoV+3CD0dbhbnMDtjL/wfgeJoFcS4w2gHMETSR+Z2mgrLRj+ztL0UZKayd4
         6pmA==
X-Gm-Message-State: AOJu0Yzd/ppkjSUWk43xip7jPUtR8NNQP7+3cWqD9sUfvIDvXZ/58Sfi
	NG+IDp6gYEvp+KqFKnvpISuaHOl897OyRJBX8vxiE4s/s9Z0MNbkaoq4GQ==
X-Google-Smtp-Source: AGHT+IHgiJSxsIUj57KGOLfaM9DgvLMTtVzvj+eph7rVcDqiIZ0UXB4OpWJuY1gFhqMMsUYApca74Q==
X-Received: by 2002:a17:902:c406:b0:1f6:502d:ca88 with SMTP id d9443c01a7336-1f6a5a5babamr63104795ad.49.1717677091670;
        Thu, 06 Jun 2024 05:31:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.5.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f3e6sm13943575ad.17.2024.06.06.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 05:31:31 -0700 (PDT)
Message-ID: <6661ac23.170a0220.fb30b.303c@mx.google.com>
Date: Thu, 06 Jun 2024 05:31:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6430730178940648233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Source STR MBIS tests
In-Reply-To: <20240606102541.5395-2-iulia.tanasescu@nxp.com>
References: <20240606102541.5395-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6430730178940648233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=859457

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.44 seconds
BuildEll                      PASS      25.43 seconds
BluezMake                     PASS      1670.30 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      180.34 seconds
CheckValgrind                 PASS      254.86 seconds
CheckSmatch                   PASS      359.76 seconds
bluezmakeextell               PASS      123.43 seconds
IncrementalBuild              PASS      3115.42 seconds
ScanBuild                     PASS      1014.02 seconds



---
Regards,
Linux Bluetooth


--===============6430730178940648233==--
