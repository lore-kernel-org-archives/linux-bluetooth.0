Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3E4C60C
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyvkxQQh"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb89215406so2736370b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Dec 2023 23:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703575910; x=1704180710; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zxP656qNQ/hBx9baDj1DYIhQiXdraoHSUTQel7MzIRo=;
        b=IyvkxQQhFeHv4eUDACr4ZZ8SL+tdadDgAzgPkyRBNKyYo299iX6el0hK0fWESkz1wC
         bVq/1ZomE/YmNMyvbJJz24bTjuNgEa34P49N72yi7/78GWjA3U0nErflY0LOHG+4jfio
         xXzTuOT+cwHNilFWU5Q/Ey0cWmqi69v78swAhmV/VznqLPjAQFlO7/vWqWs69DsPWLi5
         /EOry7lAscV5EuzDPDf8FcDJqb/rqErCYfBSGviSsA9qvphEaTYsFL7ZfdJBQRlHZlHK
         xFjDRqshjC3KTr+hzdzYw0ID+7IgbTANepoe/VLYa2N6UvVXu4njEcfkSSgQxJ0VXqUp
         2C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703575910; x=1704180710;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxP656qNQ/hBx9baDj1DYIhQiXdraoHSUTQel7MzIRo=;
        b=XdcfP36Q304ubGDSxi9lVJ4QQWYiczIL/XPbiHa76eInEr9VwiVc/MUq2j3On+6ecC
         xONTFJ607M7W1dJ6qnABVmoskymr00Uvehn7RbCqTlIZpcDYmDsVsapsSzW8C1XMlMzF
         NuO1ieRtvDQcE0afEpBCvssrKhrBqb/ArTgDdAlIn2NFpe5m+DdrAOfLUTsjw8pgAAi3
         Ry5Sy0Ei25X85+gp75mOhZpp0HDz8L75AMM0+pmewSNAeNjwSNM6sicH7tdBzQWqEAOs
         TKgRjzBThMFeS/heTspEFRImotTL6Ohf2WE0QOIs7kwrCtdCB9fBulNcJDem4XDIPtA/
         YOyw==
X-Gm-Message-State: AOJu0Yxss7Hupnf0JJU8UFGbHUQpkt0SzWN92i0wSVZ4he+jW2HsRmKJ
	f5fkJpV/P/Oj1EwM+xTKP/bowD1oItE=
X-Google-Smtp-Source: AGHT+IGOtMrJVE3r7RlZFc0F9i4DbPr8AIJjwPWov7fBq/lOa0m2Wzn78TA6JR3whbphdIa0+DynzA==
X-Received: by 2002:a05:6808:2f12:b0:3bb:9fda:2d71 with SMTP id gu18-20020a0568082f1200b003bb9fda2d71mr5618006oib.109.1703575910184;
        Mon, 25 Dec 2023 23:31:50 -0800 (PST)
Received: from [172.17.0.2] ([4.227.115.102])
        by smtp.gmail.com with ESMTPSA id j22-20020a62e916000000b006d97cc5cc13sm8107206pfh.8.2023.12.25.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 23:31:49 -0800 (PST)
Message-ID: <658a8165.620a0220.5d8f0.3c75@mx.google.com>
Date: Mon, 25 Dec 2023 23:31:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1931093455511525486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, clancy_shang@163.com
Subject: RE: [BlueZ] adapter: Fix airpod device pair fail
In-Reply-To: <20231226063028.2457072-1-clancy_shang@163.com>
References: <20231226063028.2457072-1-clancy_shang@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1931093455511525486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812857

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      25.95 seconds
BluezMake                     PASS      721.87 seconds
MakeCheck                     PASS      11.55 seconds
MakeDistcheck                 PASS      161.60 seconds
CheckValgrind                 PASS      225.26 seconds
CheckSmatch                   PASS      330.62 seconds
bluezmakeextell               PASS      107.11 seconds
IncrementalBuild              PASS      676.37 seconds
ScanBuild                     PASS      964.20 seconds



---
Regards,
Linux Bluetooth


--===============1931093455511525486==--
