Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CF28E22
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmWjtWst"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7817070291eso51599985a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jan 2024 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704393141; x=1704997941; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hQvCl96bhydCtvoHb1QTErFNlbB9vXslmKMY5LMI3c4=;
        b=VmWjtWstwgOfHwpmh35UvVR7DEktS2MythgvFlktxqF21DJYPUCs9RXAvMmMyDD1fz
         VHoFzYpH4aAcbqAK+Y2Me26CcVVomhZIf2U9y0ztC6OifNVfT6JPBs7mkvFneFVe9BRL
         l9Zky/3vZJY1pgcTVF2kcElgEwuh87EGZHLz1XURgFVNlWIj37ZLQFP2t8rFUYU1LlgV
         oVFoeuQcsqLOeopCxsqHaPac5s9ofFwJubZLb5J1wmICNJAPt4fyDS79lkQuIfSHEgfo
         68jwVul8xyPdu+mmE15mJ1ZuQxLCJlA9qXLHsyp+s9TiSmrf3FMdzz7bfWSytJRa1Sc/
         BcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704393141; x=1704997941;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQvCl96bhydCtvoHb1QTErFNlbB9vXslmKMY5LMI3c4=;
        b=Pe26kMtEDhbqh7HAg6uHdhLEU6pIXhVRUz4KBfy4D0usIfOEFP9h30Ql0yfdBH8Aqc
         8A572AnY2G782+7Rd6sInRZg50dqT8fKF1mcE5DMGTbS72ScJza7x4bs+WW9FdN2o4TI
         bJ6Udy/VYaksU3sz/NQKb0388dk73/WQCen3GI7pBo8DQS7Z1ryGXnJgPyFvzBx1ZrVK
         ruZKkTIn5wSkjULhVyZzwAA/dnyvc/S39Mno+VBQE1CZtLdKOIC4WWqh5hLhBixCJKlY
         UQmWqXBl2JRtDZwdxNAjnQLRoIxEgKVWA4hS+nQvSnvXo0nFwEQXWgGhcBHDokAi4x++
         2FkQ==
X-Gm-Message-State: AOJu0YzWHnuLMvqz+CwlMv7gsFDh6nQ6YCLQjMputM0eHh6KqHOZiklR
	P49syiqUQKXxpbz1K4zlIgfzzBGWpOY=
X-Google-Smtp-Source: AGHT+IEjOl1XsvjV4h4x11gDlH3FdFep2TMQ/yon0cAcUXTkFJ+QvVVUhBRlnHiIz3qvgcSqMQmbnw==
X-Received: by 2002:a05:620a:1034:b0:781:314b:e835 with SMTP id a20-20020a05620a103400b00781314be835mr1087176qkk.68.1704393141655;
        Thu, 04 Jan 2024 10:32:21 -0800 (PST)
Received: from [172.17.0.2] ([40.76.117.196])
        by smtp.gmail.com with ESMTPSA id wa16-20020a05620a4d1000b00782873d7202sm1596qkn.61.2024.01.04.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:32:21 -0800 (PST)
Message-ID: <6596f9b5.050a0220.2bb71.0023@mx.google.com>
Date: Thu, 04 Jan 2024 10:32:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1978882260582687568=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,v4,1/2] a2dp: fix incorrect transaction label in setconf phase
In-Reply-To: <20240104171400.124128-1-xiaokeqinhealth@126.com>
References: <20240104171400.124128-1-xiaokeqinhealth@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1978882260582687568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814435

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      741.22 seconds
MakeCheck                     PASS      11.95 seconds
MakeDistcheck                 PASS      165.31 seconds
CheckValgrind                 PASS      228.03 seconds
CheckSmatch                   PASS      335.48 seconds
bluezmakeextell               PASS      109.63 seconds
IncrementalBuild              PASS      696.75 seconds
ScanBuild                     PASS      1004.66 seconds



---
Regards,
Linux Bluetooth


--===============1978882260582687568==--
