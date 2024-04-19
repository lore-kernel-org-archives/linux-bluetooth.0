Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F852A1D8
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713565638; cv=none; b=l8UrameFaFpwollqlZMI82t0jxFuHtwkJ4us8md39XIEmOaCR8qE2WreylqcT4oDyjYVBAzxLet3NKUlpzaMIFUkAOakxVtcViS6R/ic6znH0gGqmef90F6U+M4o4wK0ToJe/pyZMz8twMw/eJYLTQXuPUesNuzl/ZIYER0BlDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713565638; c=relaxed/simple;
	bh=pWLlw4EvipUzDFSdwRMuW/7bedHsM8yX+QQertTNQ08=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=r0YFmIG2yhIMWXRwUd/8nu0YHHrbTmnAII+KjZ7sz60XsmRQ+dgmdC37htYfbh3jQn2gnyOgxrFNQZUDKAIQB3aczzFP3kdTKpT+tOQrapIlL5fgmaXcSR+QGXdeO92KP2Ai3Rd9rspuqAOG40hvyW583ol8zxWE7SL/TDbRJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/nFLq9O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/nFLq9O"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3e84a302eso19677545ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713565636; x=1714170436; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VwaB6yxqnBeCj6ioSMvMBZ030+Db4HmCiX1qTkYWnQI=;
        b=k/nFLq9OoawR9rL5wrFp5oNo+XCYoAgAqDRNI2kHklw0+yD4Dk6q5mGo6cG70cC3lD
         wv3UkTMjplK1rrUpyBT2vd71VjIpqbI0xYrrLWNBacx8gJ44TvDuT9hE1u6CtDeonL/z
         /aL0M9lqSc0JpxY98IyAPJfBglTskEu3ENKo/EvSXxXziUDH2tpCwrQS68+RSHWnXvOR
         5MUwbqFk0QRGRmAnBtUDsoSk6ZxnL2Yvn2/f5R+3x8EqII3d2wGofSrKMmBl9Cljvsy/
         i6//YK5iWf8VKR9IHTRUmqpcguINnh1gNFqofttNAZajaHQcd4tYY05X+CxhCSfBrmY+
         zuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713565636; x=1714170436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwaB6yxqnBeCj6ioSMvMBZ030+Db4HmCiX1qTkYWnQI=;
        b=c6hGI9g9em7BfhCa0SJXuiCCtIYkcTh++ukM/lMCwiOTsKriGFk9UTMeuAI0i21bZg
         q8UXVLN1LqS1eip5ai9plgyuSm8xBY2XAbmPWyn4gqA/SM9HqlwAR0K43BZPoRqPXdAk
         BPhF1pv2XupD7ednk+xASsJ5CP7kZXLOE9+0hY+On3rkiOcj4eJi4sq4Bmkhbr2dutQN
         CKuBG6EP+0asJ+ACGkeRKA2rU4crGWtad6pSRGg7gG9cAX4Vyh3sbcsldb2Gs08f6/Nu
         9mqlhqN12tcV8vcndziTI73sYby0CYtB7ODKD5r8lFNGwe8ry7L9F240rnKgUWt+p5tU
         mxmA==
X-Gm-Message-State: AOJu0YzU1Lohe3Z8s9T6oRW6mkLQJNOqEmezb2IA77HOVReGeDoNRfha
	H8S3cOm5qpWanWgH9vh1IRREARSD0Lex2btGIzL3g02AaMII2K92Y7PaWg==
X-Google-Smtp-Source: AGHT+IG0wiV+YSCYs6GyWA+iBLa1dpuG5ZZkhYvRPImgzU69tw5Cs7hvzGh5NX4nblRFw9vEUAabng==
X-Received: by 2002:a17:902:6b86:b0:1e4:1f86:88d6 with SMTP id p6-20020a1709026b8600b001e41f8688d6mr3353900plk.17.1713565635643;
        Fri, 19 Apr 2024 15:27:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.76.31])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001dd0c5d5227sm3855520plg.193.2024.04.19.15.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:27:15 -0700 (PDT)
Message-ID: <6622efc3.170a0220.593eb.ebac@mx.google.com>
Date: Fri, 19 Apr 2024 15:27:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0318954612226577823=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] client/player: Fix calculation of number of packet
In-Reply-To: <20240419202341.1635591-1-luiz.dentz@gmail.com>
References: <20240419202341.1635591-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0318954612226577823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846226

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      1676.42 seconds
MakeCheck                     PASS      12.84 seconds
MakeDistcheck                 PASS      178.48 seconds
CheckValgrind                 PASS      247.63 seconds
CheckSmatch                   PASS      353.43 seconds
bluezmakeextell               PASS      119.86 seconds
IncrementalBuild              PASS      2962.74 seconds
ScanBuild                     PASS      1017.77 seconds



---
Regards,
Linux Bluetooth


--===============0318954612226577823==--
