Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AklFlHXi"
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377E9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 04:04:09 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5913b73b53eso204261eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702382649; x=1702987449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ipf5mTS7rL4nPpv0SBJdHIiqRoPavoHxtqxLkKqI5Jo=;
        b=AklFlHXiriW4AH7/QkOephUcQ/GI8xPMIxQnKPddPbtjuLZiOuEOyiExzby/b8vyZx
         dsZsLDe/KeuoUdoiE+S7ZUE1u0EaWc7TDW+6tMNxA6JDtHI4Rt0s2z/+vF3rJHQ7y4Tc
         igs4F9ggUYng2MMcteoTtJe1V49WX+FCDrUcqQDul4heeXxVF++3p17WV5eVc79mgbkw
         qDtopV4/15uaO0Dghl5fRo/SFTF5IwTSAEGm0OhDVNMmf0wh3SXVPVVrX2wXODeO0KUN
         2lhdbry/VFGMSAz7SF7ILf5AeNvw+7ZlAZbNBRXRPO5yFlracXsJ47Hn+7h25kVkvJ30
         FW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702382649; x=1702987449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipf5mTS7rL4nPpv0SBJdHIiqRoPavoHxtqxLkKqI5Jo=;
        b=Fm0HDo6eHJalSmpCxwG44DPbWlt2Su4lwn5LcrbjH21ImfoyNoxdfVXjdwHs+nCmWE
         xz2AquAlbXghhu1owYyPc+MrNyYou2Uy6zFJDJNxGkFjPfF2Z35Rd8xzmmH+wdte1ePi
         S7x9M7hvv71vwnwfGTtj20lpUJ4iCryoVFR3EskswAa0YFEnJw/8Z9/GU3KGctYP3TU1
         gccbclpKSWjCA6YMFv8yYKUsjV0rLqwk2EfpeN83RDO080/CKx7ZqXE9vi71648CKAom
         kvDNF2JoE10+Ck2VwcdmKYmGFewvcn3q42KH40BCNpPtaqbvpUwHsKTXjfdtNUXkxI+/
         BGbg==
X-Gm-Message-State: AOJu0YyETZTf/2A9cUtUEYzsJbmwh3CcA1jVqc27yW8e5F1d3I4DB8uz
	xdfA/q3kAe2h4Mh+wQP3HalAzS6biXA=
X-Google-Smtp-Source: AGHT+IEBvGUNAKrSP9HokmrxVh7YQDbSWTFGmyT5Tux8OD4ZCIeXfmYyv3euYxNLQ62USTcaR+oxbQ==
X-Received: by 2002:a05:6359:458e:b0:170:7e3f:c260 with SMTP id no14-20020a056359458e00b001707e3fc260mr6530439rwb.62.1702382648814;
        Tue, 12 Dec 2023 04:04:08 -0800 (PST)
Received: from [172.17.0.2] ([74.249.13.191])
        by smtp.gmail.com with ESMTPSA id j11-20020a0ceb0b000000b0067ae405e0a8sm4152164qvp.57.2023.12.12.04.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:04:08 -0800 (PST)
Message-ID: <65784c38.0c0a0220.5908c.290e@mx.google.com>
Date: Tue, 12 Dec 2023 04:04:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1690137445604999488=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [BlueZ] monitor: add Qualcomm and Mediatek MSFT opcodes
In-Reply-To: <20231212190531.BlueZ.1.Ia938c97b56083995e9f6bbba445a01b4cb4de0c9@changeid>
References: <20231212190531.BlueZ.1.Ia938c97b56083995e9f6bbba445a01b4cb4de0c9@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1690137445604999488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=809171

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      23.74 seconds
BluezMake                     PASS      706.11 seconds
MakeCheck                     PASS      11.87 seconds
MakeDistcheck                 PASS      156.79 seconds
CheckValgrind                 PASS      215.04 seconds
CheckSmatch                   WARNING   319.08 seconds
bluezmakeextell               PASS      100.50 seconds
IncrementalBuild              PASS      645.16 seconds
ScanBuild                     PASS      913.01 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1860:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1690137445604999488==--
