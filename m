Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65FF9C8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Dec 2023 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a61nsJfF"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb766a7699so1154401b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 23:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703229068; x=1703833868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0bLm2me8r9GJ/2IvkIJoBTzXEp/DXWIRWhPi48ebTOU=;
        b=a61nsJfFHedsAZ2kAGMU9vk8gZQqnk5aIqX6/RHdW98G7QTNfpxLWi5cDgc0uppuo5
         3GzTMvuypSqVZl4GIOlKVy8N/DeNWefFE7CnfDTuHjoYw6Oca5Q3L7GYJSY7tYlH6/Sh
         OCZZ7RFwuKNLUGKIhqUjDRNUqu+gEMvPNeRnnEDfROpH4ouJQgwb3+nyyNWPLnyOs3ke
         loPkEVCT7YP20yALWYT4DyECGsjxKW+I5El6SZpkjg7g+Vbby59JEXXz1Z5+xqDTnHmx
         tprxgvX8bDfNhyYnqsGdH2Jmhd0FSjW82nACyyntcj2Q5iY7JhCDpUAcX+1pzMVtO41h
         y1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703229068; x=1703833868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bLm2me8r9GJ/2IvkIJoBTzXEp/DXWIRWhPi48ebTOU=;
        b=lIt+hQDa2gQk1xqPl5HMeVUuZTobVepcJve/2RnB3V7jyE8yyF0q1olq1uU/5UQnmB
         LzEBFhLNQiuMdCKWkpbqgNE8gHF9hUMwPnmSVF358qZDHCwY8stLTzMvvclDm2dro1Ns
         bJwP+eD31T8l0KJt/xDZcR/v7x4E6ncjdJ9ZNAsiCuGgYzkQbxx28tleTI0Zky1ibRqO
         6BH5rfpiH0dmD/CvYBzeimamuB2m3zjNXzUrTksNYGEqDNLr15IxhbO3Fi1OmAnJ8si2
         CPpja6GkRsNKxYR85meinGv8cvrZH8j+T1RCaXdCKeiiRTOY00eHV33NbWz6sI3OQpt1
         40/A==
X-Gm-Message-State: AOJu0Yzl+Gy7omplGvhmSHQyZZhoaaniJJGx5hypIJ1HbZiqE2be87n8
	uxA3RcrHfogWUApDIMszj5ceTStONt8=
X-Google-Smtp-Source: AGHT+IHJtofGqDJYR/EH7V2uoheTU30YoskFL0DMzliT10fMIUmYCbgLkaJMxvpg8MgRlgZzsp4oXg==
X-Received: by 2002:a05:6808:2383:b0:3bb:70a1:24be with SMTP id bp3-20020a056808238300b003bb70a124bemr1099051oib.36.1703229067806;
        Thu, 21 Dec 2023 23:11:07 -0800 (PST)
Received: from [172.17.0.2] ([20.237.137.153])
        by smtp.gmail.com with ESMTPSA id oo25-20020a05620a531900b0078119504b20sm1197059qkn.101.2023.12.21.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 23:11:07 -0800 (PST)
Message-ID: <6585368b.050a0220.f0ee0.6b5b@mx.google.com>
Date: Thu, 21 Dec 2023 23:11:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2822403855548990281=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 15013537245@163.com
Subject: RE: [BlueZ] adapter: Fix airpod device pair fail
In-Reply-To: <20231222054515.1266741-1-15013537245@163.com>
References: <20231222054515.1266741-1-15013537245@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2822403855548990281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=812386

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      23.90 seconds
BluezMake                     PASS      734.76 seconds
MakeCheck                     PASS      11.50 seconds
MakeDistcheck                 PASS      159.71 seconds
CheckValgrind                 PASS      220.13 seconds
CheckSmatch                   PASS      324.61 seconds
bluezmakeextell               PASS      106.00 seconds
IncrementalBuild              PASS      677.70 seconds
ScanBuild                     PASS      926.75 seconds



---
Regards,
Linux Bluetooth


--===============2822403855548990281==--
