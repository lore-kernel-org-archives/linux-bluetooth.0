Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Zrfx2C"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E69BE
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:12:27 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67ac8e5566cso35967666d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329146; x=1702933946; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ/ONtyhmRxhI7zxUdA6+jajdmdO3TIpJG9k80JOTMs=;
        b=I8Zrfx2CFOEohbG/uV2G5Sty3uPp6sgDHnXEBCftH5G3GgxClNnuLW+RGbOrD9S16g
         J9EuMCgbmm4eCodOjYAF+WjG/WghQ+r538ufp9X5/xB+2vm3jzL/P+/7y3utSsIq/Ogl
         Fh+LQu3WfygD/a1S2UHwp3lhJprFSHatg2oL6XbN+MzjEr92BIzN0ROIS0onyoVYQxiZ
         J81f4Oh4jYj+rq6Pxilisgxa+UZ0ZWRIxBE8Egi3GbcWUqTrMDyfVopYCCu+TGG25GO/
         Xdd6btDJu5zrmjQod9HEc3hQCW2AQ6E62lDmTDedBhEDCgkFfy6NtCZUOQLaYUMMZ+TU
         dilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329146; x=1702933946;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZ/ONtyhmRxhI7zxUdA6+jajdmdO3TIpJG9k80JOTMs=;
        b=BPxpMchzMub9mFxzsFsTyD54bcCVRbLv9+morR5XN9pi1ifcShN3Py3bSa0v7AFkAv
         r2Rsghaoag8RJmd8gIaFjg6QovgVZmQvdZbKn3aK3k+qbUGnse/QqhUJXOTqeYULVCQU
         FG0tLkkggneldDWhDWmjkvAdwm8FlsJmE4eezB+vP4ZzTr7GUmV6tAohGI5zcVNBVlWP
         Ct0Ou8oHXVKClMF1z1BNTGEsmyn/aruZ1TbiCi4733+J1yuSsOSeEmF+JGo50CqvOzbl
         Alw2NyxWo/YVLHIkkebThlE5TjcMrRJ91TBla1GhMouu16ghIrZ41mdq2Og0b+pyxgZv
         YsVw==
X-Gm-Message-State: AOJu0YweWSqazT0AdAVao0arTNHxJnjK99J3JQ/E7xqJBHk6iD+ZXrSo
	UHgw4X3AToJYASzvs2f2coWEQgsCDbA=
X-Google-Smtp-Source: AGHT+IHaAgtZxzW++XkmpVwPww1Mibrxno5PmDDD8tQxLs/VgjmKwFJc83AhBG90HZ8G/98pxyyl4g==
X-Received: by 2002:a0c:e58e:0:b0:67a:8ff2:34de with SMTP id t14-20020a0ce58e000000b0067a8ff234demr5662174qvm.6.1702329146291;
        Mon, 11 Dec 2023 13:12:26 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.244])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cea91000000b0067eabe0116dsm3335705qvp.72.2023.12.11.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:12:25 -0800 (PST)
Message-ID: <65777b39.0c0a0220.fe537.dcf3@mx.google.com>
Date: Mon, 11 Dec 2023 13:12:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7824269921563304361=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/6] bap: Allow setup of multiple stream per endpoint
In-Reply-To: <20231211210429.530964-1-luiz.dentz@gmail.com>
References: <20231211210429.530964-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7824269921563304361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: profiles/audio/bap.c:1902
error: profiles/audio/bap.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7824269921563304361==--
