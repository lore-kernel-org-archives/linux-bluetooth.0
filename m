Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6IHIeF2"
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC81AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 15:00:36 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cd4cc515fso27283031cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 15:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701126035; x=1701730835; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ej8cPDyuYylstAV7VFzNT34JM5vtPfN51qRLG7c8DnQ=;
        b=Q6IHIeF2nFaKBFdUcfRvuwR+el5VjdX4PnjO6EHitD9epoz/WEpxWhvAqVG4UaQ7uN
         POgE9dg6WQ9wQ3IBDvm8rBvHn4hT8ZJjiif0Ki1Gl/ECctziFE6bcFOVit8aUL8QiAbD
         2EA8/N4oqwP/AwDCLgXQGp4M1i4U4O0OYDkRqweIFNj5T0oO8AwpWYFl8EISeDrQJE2C
         rIL9QYehRWIxzcXlxBbijd7EsS9cSW4wfbU3M+Xo5TAIQgrl6lbWw011zfhqG7Fy90zl
         lawNKtTKL1t8razYQHTcWMCrRDQMJwNin1mpSyP73mBMLzCJPNGOFS3vaLXpxV16WKeg
         S2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701126035; x=1701730835;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ej8cPDyuYylstAV7VFzNT34JM5vtPfN51qRLG7c8DnQ=;
        b=UAJCrbv2/fDJSzGfpYCmE/3b6sTWpcL+7c7mkKeir5GBIZGutt85OmK5e6WU8eFYNV
         8b74s9PCNY8aqo7hh0FO/irCpbtdtc6A+zUlqEGW88gWbfJEAlkUJICTZEXJPBoV3ule
         y2xalOvxFMFysCbkk/CuxPEN/AhcZrH2Ns6znfqs2B98iC9c9qNIJ1KCuvwEbKOYi5Z6
         o46ZT1XxbxhTE58FDmB39Kua28FwdoOI/PpIYFSWCsFOh5CKFARymqwiF2KsC6QsJfhO
         7RpvJfrmi2oysX375XoC7T1yttlbekOlpgF3flTFwqGxwT4N80vQ3FvO0KMER+/eO/fV
         ScEg==
X-Gm-Message-State: AOJu0YzcMWalLZsu9uIllymWQ5/Hj/IDYybf7UVjkHHpsKIaIXMdm3B7
	YgteSm/aQhPZFjkuHTHQdjPPzVQ/AMOHBw==
X-Google-Smtp-Source: AGHT+IGpQktDoCAgr6OOq9xv/grn4Qx9gfgfmYnN9mQcrX6HN5XyFjn63oquk0xChyFxSzu2zwEGmg==
X-Received: by 2002:ac8:5d91:0:b0:412:cd66:f65d with SMTP id d17-20020ac85d91000000b00412cd66f65dmr15919906qtx.13.1701126035505;
        Mon, 27 Nov 2023 15:00:35 -0800 (PST)
Received: from [172.17.0.2] ([20.51.198.145])
        by smtp.gmail.com with ESMTPSA id kr6-20020ac861c6000000b004180fb5c6adsm4104179qtb.25.2023.11.27.15.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:00:35 -0800 (PST)
Message-ID: <65651f93.c80a0220.41294.f27a@mx.google.com>
Date: Mon, 27 Nov 2023 15:00:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3587450611200022192=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] iso-tester: Add tests for GMAP broadcast QoS presets
In-Reply-To: <20231127215801.1531286-1-luiz.dentz@gmail.com>
References: <20231127215801.1531286-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3587450611200022192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804677

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.06 seconds
BluezMake                     PASS      583.11 seconds
MakeCheck                     PASS      10.55 seconds
MakeDistcheck                 PASS      153.08 seconds
CheckValgrind                 PASS      211.05 seconds
CheckSmatch                   PASS      320.02 seconds
bluezmakeextell               PASS      98.28 seconds
IncrementalBuild              PASS      544.78 seconds
ScanBuild                     PASS      935.79 seconds



---
Regards,
Linux Bluetooth


--===============3587450611200022192==--
