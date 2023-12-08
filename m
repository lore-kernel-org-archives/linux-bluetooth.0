Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLBLbMWB"
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD451BCE
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 13:58:59 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67abd020f40so28607706d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 13:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702072738; x=1702677538; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g0oJEVELrX2o4NmIvqur+yyI5q7gq5Awb+KL7TESRBc=;
        b=KLBLbMWBD8CFkqYOxQADSR17Eh7ZML51u4lVWBwXZq9RO1wjm0kg5iwHwy6xJ6zR8A
         E9NI/E6mzVmeETyBzFOQqpjRDSbz4k+TPTdsYonxmY+wYVnmCKQLWRJJCSSyNd87ghMF
         xRhxXVW6z5oyultItNQaKB2xXSW8uqEpx9CqxpNWWUP15Q1o8UfECCexzZgL8iT/YsTT
         33IZD8FWtiGTjC5v8P5T7fOdfaD6pku/oaUm8U5JQDQiIhRJW9MDA4o2OP2BQXLm7AMP
         vv9pTmx0WXyFm/+MUOAQCzv80gEj2FQdMzrX3yDcAwnd2CPireHBMozzNlWQ3Ru3SluJ
         w6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072738; x=1702677538;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0oJEVELrX2o4NmIvqur+yyI5q7gq5Awb+KL7TESRBc=;
        b=MHt5dEyQdqZPHZP06VQMvJYBRMFzsqwc/GhS7KXzUhf3lkeFOXEVRsla0/YMjMmyhQ
         0bgdYVINQ7ErWa4bRgdEvsgQV3ifEf5UGxzUqHWkDrZ02pU8fw4e7x5fuRsgxXN/RCqX
         H14SIlv+9eTH6gz4BjwJg999HsllUfAQevOrBeQ9sAvU9WLuJsZjK5XA8vQI+9/sCrM4
         kiN7qOddSlfMskUqZv1AEsBtnOUMPZSBM+YIL54dq8DBDVy1THHc9FkUgifybJ7o4/ni
         FuahCQiEBSdmM0WU3ZdwmGqQLlsubA13adyKPrkcvdOBGvAoPgWF1XOWdOKoxzHBxceL
         fYjQ==
X-Gm-Message-State: AOJu0YwHyMp8MK2yeR2l0rzl2ZhVzeAShSFbDZbZMpaSvUjcvxOogjK0
	bNycNbv6JJGMY8T5Fzg8dHhRiMwRMPE=
X-Google-Smtp-Source: AGHT+IGfriDfMKzcsA8OFD6XH1Plh71oDpkzfI23zuRFGAAkjxYcNjQHqk4C5PCJWg4ShZjXy9aXoA==
X-Received: by 2002:a05:6214:301a:b0:67a:d96a:d6f9 with SMTP id ke26-20020a056214301a00b0067ad96ad6f9mr1963178qvb.33.1702072738514;
        Fri, 08 Dec 2023 13:58:58 -0800 (PST)
Received: from [172.17.0.2] ([20.51.207.133])
        by smtp.gmail.com with ESMTPSA id pp17-20020a056214139100b0067adf6ccd77sm1109530qvb.118.2023.12.08.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:58:58 -0800 (PST)
Message-ID: <657391a2.050a0220.f993b.69e7@mx.google.com>
Date: Fri, 08 Dec 2023 13:58:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6244073008454183715=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v1] Bluetooth: btmtksdio: clear BTMTKSDIO_BT_WAKE_ENABLED after resume
In-Reply-To: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
References: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6244073008454183715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808392

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      31.33 seconds
CheckAllWarning               PASS      34.58 seconds
CheckSparse                   PASS      41.02 seconds
CheckSmatch                   PASS      112.13 seconds
BuildKernel32                 PASS      30.70 seconds
TestRunnerSetup               PASS      473.45 seconds
TestRunner_l2cap-tester       PASS      24.56 seconds
TestRunner_iso-tester         PASS      47.06 seconds
TestRunner_bnep-tester        PASS      7.56 seconds
TestRunner_mgmt-tester        PASS      171.85 seconds
TestRunner_rfcomm-tester      PASS      11.66 seconds
TestRunner_sco-tester         PASS      15.22 seconds
TestRunner_ioctl-tester       PASS      13.18 seconds
TestRunner_mesh-tester        PASS      10.50 seconds
TestRunner_smp-tester         PASS      11.30 seconds
TestRunner_userchan-tester    PASS      8.04 seconds
IncrementalBuild              PASS      29.36 seconds



---
Regards,
Linux Bluetooth


--===============6244073008454183715==--
