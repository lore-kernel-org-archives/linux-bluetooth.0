Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B8446B8C
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKYJqOIh"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35fac40c0a2so2469805ab.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Dec 2023 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702834297; x=1703439097; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o899sQgcdzc0Sm90Xh8H8N1k5G7FNPC9PIZ+13LFKbo=;
        b=cKYJqOIhYAsbWkgKs9p4oiAdIzypuTmPGJUdVCRrvtwL2MXqKOfsvLwQnh/LfVUaHR
         mAq6VOSRB9kP2wGLnOKls64Zc8JbhlbLTFUFGjhE8DDA99TqlhbJCO3kIOudp6IhLPuD
         GMXgK8PTgGI0CVFuVqTepTijzWBnXf/Cs0OfOe0a0zAbMhrEqA8ZtRaPwchoiCqffIdr
         8+DXoxm1odFA1Qp7hvQQ1rVhkisSFKRIRSZvLnkn1akM9BgfrnuYyq3eH56uM13woNCH
         rjluNjqIxy/1cZ+O4eGWuGcZyA+WIyaQ94UEIjQSeQ6mdvOtv3h+ujFg3XbVIswOL1eH
         lubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702834297; x=1703439097;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o899sQgcdzc0Sm90Xh8H8N1k5G7FNPC9PIZ+13LFKbo=;
        b=k+j/652Q6DklCL9EP69OIJNQLKGip1ggSzMDLM7cJRZvjLi5Jn+Dm9lu3t/zQiOJqf
         dqCyLBfet7L+a1rwvNFn+s1+klEp9aQFQGUqdalDwVdFZbty+LIfX5iouYpJc2bgMJRz
         InXx0107FCgp7EzdvizsXbpPB/xeHUjb49XXdIre/e0xHt6rU17T0PP/nk0NrZPlRMUo
         341yCKs8oqNEa3SGwer9Hcrp4zb77CBpnokKFZH9wy21IfmAkdfzxAOA5qNxTpkgCRKh
         yPHUIImX0BMO6/x1W4EufrNZcNfrwfWNJgjqwExgVtqUOV/HF6HDQdW6d+nmzWQgAEVH
         cxvw==
X-Gm-Message-State: AOJu0YzL9394eZN9bqc9xfJPqyb5BlmID34Oa5IPcHsGXshXofiQZ7BN
	OMhaJBs1goWz0hiXc4VgN1gOX4d4eso=
X-Google-Smtp-Source: AGHT+IGUc33033p1mOO4ANgIMmqCTV+adZEsTda2L0zE0lVmsxrXH8DvRs/UylzSzkj78xtLANQ2uw==
X-Received: by 2002:a05:6e02:198d:b0:35d:59a2:68f5 with SMTP id g13-20020a056e02198d00b0035d59a268f5mr22163285ilf.34.1702834297430;
        Sun, 17 Dec 2023 09:31:37 -0800 (PST)
Received: from [172.17.0.2] ([52.238.28.65])
        by smtp.gmail.com with ESMTPSA id jg4-20020a17090326c400b001d3abc86c9fsm1175628plb.195.2023.12.17.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 09:31:37 -0800 (PST)
Message-ID: <657f3079.170a0220.f8158.2347@mx.google.com>
Date: Sun, 17 Dec 2023 09:31:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4854531126706715996=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ] adapter: Fix link key address type for old kernels
In-Reply-To: <20231217135012.1476534-1-xiaokeqinhealth@126.com>
References: <20231217135012.1476534-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4854531126706715996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=810816

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      23.78 seconds
BluezMake                     PASS      699.36 seconds
MakeCheck                     PASS      11.67 seconds
MakeDistcheck                 PASS      153.15 seconds
CheckValgrind                 PASS      214.28 seconds
CheckSmatch                   PASS      317.31 seconds
bluezmakeextell               PASS      100.06 seconds
IncrementalBuild              PASS      641.96 seconds
ScanBuild                     PASS      915.99 seconds



---
Regards,
Linux Bluetooth


--===============4854531126706715996==--
