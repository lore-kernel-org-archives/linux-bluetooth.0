Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B824B3C
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHkojyOT"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso464678a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 10:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704393035; x=1704997835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zwmWxD88GPrnnsIj8ONviyfZMfld55E1LvY6hTuEonA=;
        b=dHkojyOTcgcOdmY4kOGLRPoF0ea6jrToUoRXCP4kpu9EjdDDLshqZpKDmKTCchH1bo
         dlea2xJPmPcUJMm7N0xl51idKJkpfL9LYa2TW1g25Tulslct3ocXjNjNrk8IJmm8aNgz
         WsSwyJXNH/07ft6DdFRvDzWGs48bw6ikDs17rPKXxFgGeI2O9gLfAhsHG3tEQGykc0BQ
         t23lEa1BrhBM/J9pyW8tevP0HHjkBF3+mFwezuKoWhhvYUErAUuq9k8930yZjfeZR3iA
         EgoLCBAcqAzacRZFRtQ6EPXbraCPMFXV8ptuFqZY60LbOX4/aQMDSVqJKxZBVd02Lxzx
         ipMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393035; x=1704997835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwmWxD88GPrnnsIj8ONviyfZMfld55E1LvY6hTuEonA=;
        b=SbWwdxI4CkUpAjt4BV5QzwF2dI/Sp4rwAir0SDlbmpHYTUjVxojj8aM19antTCmT3O
         2vGw2dE17lqOupIe2WD/0hyI6qhkUI4EVWRNIKbhYty6T/2OkfxFehX5OVk3Poew4szt
         v5y7xJxQIMqrGf6it/Hi+ofZsyf/VxIGnpQzmcnodKx75RO4jzTDxLjprUhsdXssRskx
         MmA8PL12ZuYfLgk+nr/jSIOfNh+4uVl14ipYOs7KdANllHaCemAsFhu/vS8ENfH/YtLu
         q3dTqw5o9pBn/T4PEx762bpmaS64JMZWkF0l1sEiOjtat273RVeQvNljOJsZXQYzUlXo
         ItKw==
X-Gm-Message-State: AOJu0YzvVSlqR0fL87CgY3yg2dPSaSVLhQMcWigmeJLC/mHxNtRSmp7m
	bjyKFBMjA7t/H4AJXc+0RS2OudRwe0E=
X-Google-Smtp-Source: AGHT+IExvcABaaVDFLVRcdTz7T3Plx3LHxPTf8y/xTdZfvqBBmtsG1WsGsogE53CCfgwBHguY1jItA==
X-Received: by 2002:a17:90a:a78e:b0:28b:d8ed:7fc5 with SMTP id f14-20020a17090aa78e00b0028bd8ed7fc5mr799460pjq.89.1704393035590;
        Thu, 04 Jan 2024 10:30:35 -0800 (PST)
Received: from [172.17.0.2] ([52.238.27.68])
        by smtp.gmail.com with ESMTPSA id p19-20020a1709028a9300b001d4e05828a9sm1135111plo.260.2024.01.04.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:30:35 -0800 (PST)
Message-ID: <6596f94b.170a0220.c0452.29bf@mx.google.com>
Date: Thu, 04 Jan 2024 10:30:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8815187081851950308=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,v1] avdtp: Remove unused transaction parameter
In-Reply-To: <20240104171338.124096-1-xiaokeqinhealth@126.com>
References: <20240104171338.124096-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8815187081851950308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814434

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      24.28 seconds
BluezMake                     PASS      717.52 seconds
MakeCheck                     PASS      11.78 seconds
MakeDistcheck                 PASS      160.92 seconds
CheckValgrind                 PASS      222.79 seconds
CheckSmatch                   PASS      326.78 seconds
bluezmakeextell               PASS      107.29 seconds
IncrementalBuild              PASS      670.83 seconds
ScanBuild                     PASS      967.26 seconds



---
Regards,
Linux Bluetooth


--===============8815187081851950308==--
