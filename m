Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF154BD7
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIHduy8D"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d45f182fa2so18613545ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jan 2024 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704738546; x=1705343346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Yex3Ib8X+In+IqonO/+vb6TEwFCe+ccBsm7Q/O1QXU=;
        b=dIHduy8DeQF9IZk+6kZmLN6PNX/C0SLlA6M7zGCIHHmFGpifcu0tW1hvDbMJ5+suEj
         2Au7igMJvsEtkH0KRUFo9rveMbmAGJtb/Ce9KJKFcogZ9zRafzP2G4viCCAZrfDdmD7D
         yk4fBOU3gAkqNOQGc7YAcdXl4XI9OPMJ/jddqZ+aZKrXydJE+8QaooUelwgbsbv2JOHj
         TqSBty+SrD7KRaONH+1TKzryYE+pdfjmrz/e90OkvKZjWNgbJX59F5R5Wr1VuQPIUB3/
         lk+22pv+301rtjW3CnWS1DDyCPM1Vk44qdcG++KUs1hMsCWxJ8wJckVHELicELoD7tp1
         DIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738546; x=1705343346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Yex3Ib8X+In+IqonO/+vb6TEwFCe+ccBsm7Q/O1QXU=;
        b=w+pZj0D1qn9Pb3lFsQ0SU1asHQKlglWJZozGvXHSNxqppHHqFCYiDalX9XiON6lZVM
         DDXLxWzcboSdS/3ywhYnfWXOa+1fV2YV1yE3YDj/+YYZvPe/ml9HvM9mPeduroBUAQQ+
         n8YLLX4OuX1fAvrQoIZb/GKX8cR+i2VB14JyncoXHmOlOEErnlwxMAGFjTAaFn27S8vI
         0dZEkGjokA5qSJWRCVdN01qw6+zAK27mLpTpoonwgfpd29dxjHL8jfNXAEbxA0FksIgK
         PxPv/lQrU8RM3ZCVGJrQXvNnGXYYSBYcrZH4Wab5Xa1RS6cPZAWO3+cgAOJxl+A/gqWu
         aUyA==
X-Gm-Message-State: AOJu0Yx/nINb62hDn3p/s5Ecv5WBqmgLRJ+7DO4+8MVprL5oOubM6TVI
	9jV9MMUxSCngv86o8dzAkOiazA9aRJc=
X-Google-Smtp-Source: AGHT+IHyc/G/noOn+fyZDyKUuU3chdYdj38mEe1VGBluS8+91n749MmdHhjH9L2KDJRT5N2+hQa6Cw==
X-Received: by 2002:a17:903:1249:b0:1d4:54cc:d89e with SMTP id u9-20020a170903124900b001d454ccd89emr5925510plh.62.1704738546609;
        Mon, 08 Jan 2024 10:29:06 -0800 (PST)
Received: from [172.17.0.2] ([52.159.137.229])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902b08500b001d49d07eb10sm194460plr.218.2024.01.08.10.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:29:06 -0800 (PST)
Message-ID: <659c3ef2.170a0220.51b9e.15f3@mx.google.com>
Date: Mon, 08 Jan 2024 10:29:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1149285925734582140=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes
In-Reply-To: <20240108164258.77332-2-silviu.barbulescu@nxp.com>
References: <20240108164258.77332-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1149285925734582140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815144

---Test result---

Test Summary:
CheckPatch                    PASS      2.19 seconds
GitLint                       PASS      0.65 seconds
BuildEll                      PASS      23.75 seconds
BluezMake                     PASS      712.69 seconds
MakeCheck                     PASS      11.42 seconds
MakeDistcheck                 PASS      161.34 seconds
CheckValgrind                 PASS      221.40 seconds
CheckSmatch                   PASS      326.86 seconds
bluezmakeextell               PASS      106.26 seconds
IncrementalBuild              PASS      2021.18 seconds
ScanBuild                     PASS      941.29 seconds



---
Regards,
Linux Bluetooth


--===============1149285925734582140==--
