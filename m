Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpxrAPIC"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5310AFF
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 10:02:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d06fffdb65so11046495ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701712919; x=1702317719; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yIIncQ8zDLkwl9YmJkoqFahirO0iwaqYRrjzDWzcSXc=;
        b=CpxrAPICH+B9wOo8JmbVopydh3bf+ImF2OvazMZJwQI6RBh/RDDjRANrtka9hRB0zg
         MZsPtEBIx0kWVWAmQTWlXX7l6w+mFoTzQ4qHAEsRG7gS7FtFPgDZspM40/fO8EhLCJfZ
         uptr/7fD+aOwh6hVklbayal6HC+Y8N50d6iI33O2HPXUqHoNbKD+4S8JJ6OWEGANui+X
         6CDNrWbxQcjr62WxygyaytvLwg8R0qi7vylMyBnadiO0fy3jRBK7gEHLxkTy0+3dkBLU
         krGNnafTA5PUQXOPc4Kesvy8sS0bwxgLSTmDKX+KDUZDETPRfwHOvRM7TzqkP3B3ZaVK
         TQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712919; x=1702317719;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIIncQ8zDLkwl9YmJkoqFahirO0iwaqYRrjzDWzcSXc=;
        b=IphrlsOH5BXijBQ5nfetu4rUGRwHaD3owkvc+nFXERilvjPAyVR2yEyJw6eXZQ10rV
         oOA0IgBMxdV75knNXiFTQkNrQmJGQ5oFYQifEs2lP+rhqZJdVqNoE4rM39DyabR/m1cz
         VtIWMxgI4zXvtKNKlEdU1OSWGKW4Mr0hKSOhukJ+Ma2sEEV+z+unGiA3RYQwFm7YAzmB
         5my5niuIWNDu3wiDk/LTUl21hbPT7+Cs8opE63v0cz153rtrAozqia1vpcMkEccqxYOn
         vTZ+92pFZeoNxG6eitlLz3ilx97SHZ6xHiO1y37Jy12hth1AhGCwQIo0UOhlimDzZf/x
         ke3A==
X-Gm-Message-State: AOJu0Yxef95yqXJRNpxvf2d4gSKOr3IEn9BLHPSKS3HhTF9uV5qT1R75
	/NVd5oGm9qOd3OpFOOmJtC5qJMKzTi8=
X-Google-Smtp-Source: AGHT+IG6KHyfs7zQLDVA2Y8r9DZYx5gJ5ScAepWpF1Yd8IjQdMg4aOzkQOxTx/7N/b3h5bZ9Utc16Q==
X-Received: by 2002:a17:903:41d2:b0:1d0:9feb:b73c with SMTP id u18-20020a17090341d200b001d09febb73cmr1822340ple.30.1701712919495;
        Mon, 04 Dec 2023 10:01:59 -0800 (PST)
Received: from [172.17.0.2] ([13.83.123.189])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cfc42ccfcasm6981342pld.152.2023.12.04.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:01:59 -0800 (PST)
Message-ID: <656e1417.170a0220.4eb6b.2b1e@mx.google.com>
Date: Mon, 04 Dec 2023 10:01:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5330775164541326993=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bass: Functions cleanup
In-Reply-To: <20231204165934.2847-2-iulia.tanasescu@nxp.com>
References: <20231204165934.2847-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5330775164541326993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806714

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.39 seconds
BluezMake                     PASS      583.59 seconds
MakeCheck                     PASS      10.39 seconds
MakeDistcheck                 PASS      151.08 seconds
CheckValgrind                 PASS      210.49 seconds
CheckSmatch                   PASS      323.33 seconds
bluezmakeextell               PASS      98.66 seconds
IncrementalBuild              PASS      540.90 seconds
ScanBuild                     PASS      960.47 seconds



---
Regards,
Linux Bluetooth


--===============5330775164541326993==--
