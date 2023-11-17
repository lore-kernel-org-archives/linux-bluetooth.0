Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcMB29Ay"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1396AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 11:56:56 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-66d0760cd20so20274226d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Nov 2023 11:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700251016; x=1700855816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n1Tczk8PMJwDB4ckCoyIqXF+ijpl8sjxYxb3MQ+bqWU=;
        b=AcMB29Ay2hcm4ScR50WYFr1pPfEr/ajdDCrW4SNsrwgm6bFhMLvDEIKi4BXOvIfyT/
         AkfJM3VJ1EUvQtQ+EA5QEbC3Wis+axef0j4LbInoF2L3qyW2B87d9NDC3Gy+PhbURaGG
         5pXkXOAuOEliNizdq7VQ6VrfSCgHUdb1PmFpdA/HY554T6rREZOV1JqtpxbJSSpBcGbH
         XeaXAKNPSA0457tENJ7O+JFZLzvQ3J879MO8AOGytJppb+e3p+aTLOV4XNMG9v14nYII
         wpRfx6QD2/yGqIzzmvo3H75XHq3uryhMX5pT+r9M3olCRGGhItWrvYhEZHlW/o1APTAe
         F0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700251016; x=1700855816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1Tczk8PMJwDB4ckCoyIqXF+ijpl8sjxYxb3MQ+bqWU=;
        b=dSUEuWNMMhsMTKqoU19YcWxFMgh0Y8voXX2HO1XgmC1yu8ldxtRzqzWkZekAaqEADc
         CrVf0cKJzXc/rz6EeFYBu/TgIuERA0MMtZ0IKwBAEZrkZsSBCJZTvmZatJFOyie63jTH
         38dxXqfGz7uQc0SSn1M8XqOzpcEjsCQTZ3EALrLmAJJ3oeVf39WV7cQ1znH9p7arn7Ou
         uDG55/PlBEsrBRZ3ApLLgggxhbKhOkYp+AY/7SN70SlCm2IWTfUVqeYxe3vIp6We2hRQ
         T8Cz11RRT23p6yLvx/Z3ETerxbzyyZWSj+d0mXoO7SZdSFZmmP38qjm097oq6TMzQKcl
         6vUQ==
X-Gm-Message-State: AOJu0YwKIcM+STR+m+6QU8tlMghdW67BWlTTztSYd6+N3KvnW2Cjv2PT
	ZHTuaFp+8rnODvyCJS+kzDVm0lWaYCA+xA==
X-Google-Smtp-Source: AGHT+IGrxhVa4SPo+TRTNSJk7haGf/JaOo01WltvOBILHAMZXAhklorSIswt0r5zML/mOivO0Boryw==
X-Received: by 2002:a05:6214:310:b0:66d:327:bf8f with SMTP id i16-20020a056214031000b0066d0327bf8fmr8254382qvu.30.1700251015681;
        Fri, 17 Nov 2023 11:56:55 -0800 (PST)
Received: from [172.17.0.2] ([20.109.60.240])
        by smtp.gmail.com with ESMTPSA id jh5-20020a0562141fc500b0065b13180892sm882113qvb.16.2023.11.17.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:56:55 -0800 (PST)
Message-ID: <6557c587.050a0220.5ea5.5829@mx.google.com>
Date: Fri, 17 Nov 2023 11:56:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4370012674940995667=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v2,1/2] Bluetooth: btusb: Return when coredump trigger cmd fails
In-Reply-To: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
References: <20231117112833.v2.1.I4c7ab22148e168e3cde00f27b89748ff4bc651c2@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4370012674940995667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802039

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.63 seconds
SubjectPrefix                 PASS      0.27 seconds
BuildKernel                   PASS      27.85 seconds
CheckAllWarning               PASS      30.67 seconds
CheckSparse                   PASS      36.17 seconds
CheckSmatch                   PASS      99.43 seconds
BuildKernel32                 PASS      27.06 seconds
TestRunnerSetup               PASS      418.24 seconds
TestRunner_l2cap-tester       PASS      22.99 seconds
TestRunner_iso-tester         PASS      40.48 seconds
TestRunner_bnep-tester        PASS      7.39 seconds
TestRunner_mgmt-tester        PASS      166.09 seconds
TestRunner_rfcomm-tester      PASS      11.09 seconds
TestRunner_sco-tester         PASS      14.54 seconds
TestRunner_ioctl-tester       PASS      12.09 seconds
TestRunner_mesh-tester        PASS      8.94 seconds
TestRunner_smp-tester         PASS      9.73 seconds
TestRunner_userchan-tester    PASS      7.33 seconds
IncrementalBuild              PASS      31.82 seconds



---
Regards,
Linux Bluetooth


--===============4370012674940995667==--
