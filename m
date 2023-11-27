Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nglohScw"
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC11C102
	for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 20:58:01 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45faf180a15so644190137.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Nov 2023 20:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701061081; x=1701665881; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Arhtq3ojkXwqr+iRI/lQB/a1JRlFHNrhVjoKXAQ1Owc=;
        b=nglohScw2s83S4Qt2iQvhWM/uUxx286UyclfBveeJRKzOpibthQB5T4MbScqKrgqQ2
         hV+dR4KXZH78NiPcOJYSxOz0HOjxmNmE9TM1DNYWIcLrhI/qIW86kALJiSHsPaawIHvd
         eMAZH2ussPj6ndHVOJbmBgpi5NITZ4s5Iae+aZbOtLTNGYsVEmNTtimqogGZP0PUc9bO
         yZTa+j/FmQT/cKArmfzDPKEtdydrx0Ss4SX8/IsWh6rlgjng2zPgb/eAqAtfocijeFfS
         LFRfx+TklAeuIHXEsgNHYFhsagACljUTuXbdgpxQPvdo8dUN9nxRRNshWYSsgJZwFcc8
         JAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701061081; x=1701665881;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Arhtq3ojkXwqr+iRI/lQB/a1JRlFHNrhVjoKXAQ1Owc=;
        b=Hl236jrrWxHbDnVx+Y6r5ApR+b4vFFn/bP2GrbZUoqVkL6HZgB29Hd3z7xE1eJX/nZ
         Iahb0JHuT+CxtcOjpF46S5xyU8nKj+sf4pA+ORYXjwy+W+Efe7tPAQcDnnp73va0bDsT
         ZK8cHrOLNIc4UNJQYqVhEvbsqTwPbcHohqwWk4KN/s4HuidWWoxC6q+nCfzAYe3aOa+T
         HNUUzvN8GwURWHw20lEKZvj+UB8G+l1+cgziodwBV50mSaNqu/TWZflajuihzY5lreep
         uups/O+VqW64db7oWMNpIfWlH47UitI9C3IJ+JeDJ25BbTk4lFMBKBDXSHzONlBB/or6
         353A==
X-Gm-Message-State: AOJu0YwOOTRCBzoLgM9USJO+MvKjOaryRjaiSQdbG/CRYybZyGnCUy6n
	gGYC/TbRlD1B/1aBHy13IMMJTkS80APHeQ==
X-Google-Smtp-Source: AGHT+IEDBN3Zc+Ub+fSXJUw4AlWvEUpP/s4oDLIeCGxY6CY0L2eLviIJ6gCRI+WIz00tS6ikE8wafg==
X-Received: by 2002:a05:6102:5489:b0:462:9a72:a1a6 with SMTP id bk9-20020a056102548900b004629a72a1a6mr6103830vsb.28.1701061080757;
        Sun, 26 Nov 2023 20:58:00 -0800 (PST)
Received: from [172.17.0.2] ([20.55.14.237])
        by smtp.gmail.com with ESMTPSA id q2-20020ac84502000000b00423829b6d91sm3451843qtn.8.2023.11.26.20.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:58:00 -0800 (PST)
Message-ID: <656421d8.c80a0220.a5947.a084@mx.google.com>
Date: Sun, 26 Nov 2023 20:58:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3144883180733099643=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: Bluetooth: btintel: Print firmware SHA1
In-Reply-To: <20231127044202.2456465-1-kiran.k@intel.com>
References: <20231127044202.2456465-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3144883180733099643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804376

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.46 seconds
CheckAllWarning               PASS      30.12 seconds
CheckSparse                   PASS      36.04 seconds
CheckSmatch                   PASS      98.65 seconds
BuildKernel32                 PASS      27.03 seconds
TestRunnerSetup               PASS      416.41 seconds
TestRunner_l2cap-tester       PASS      23.01 seconds
TestRunner_iso-tester         PASS      42.93 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      166.13 seconds
TestRunner_rfcomm-tester      PASS      10.94 seconds
TestRunner_sco-tester         PASS      14.71 seconds
TestRunner_ioctl-tester       PASS      13.53 seconds
TestRunner_mesh-tester        PASS      8.89 seconds
TestRunner_smp-tester         PASS      9.83 seconds
TestRunner_userchan-tester    PASS      7.29 seconds
IncrementalBuild              PASS      25.64 seconds



---
Regards,
Linux Bluetooth


--===============3144883180733099643==--
