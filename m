Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9212B60
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOukEl9J"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4258026a9fdso28587521cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702974984; x=1703579784; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oer+pE30m7YLKnN5BO8AuR9Q9iiBrmnQo6J9HhmgnVI=;
        b=aOukEl9JknxNag4K/Ab418Yp0VROBWSZT8PTblkPLVDnPjuKTwmR8k4tig46ff+iL2
         8dflhaIUwMqMi+W/lW5uJhfXsuGj5zURwtENXFDw6x4TFlfT7WfbV+iSJPLZZ2f1N5DO
         bZ2qIZU96Y2IKkf+G5q6Br7Ph5q3KGCA6Qx6auzCxYvwmzEXy7sqrkUivPJVl0fN3rdC
         wmqYEoRk8kjX4wznTrDc7l1RHFBm3sczi9xG2Q6Fl3JKK7nS+GnEONO81C4UysI1IpA3
         yOAdbPP+KXxOQGmNdefZ08NnP0axotxs5E3y9QFx9Xb2A/2owCuujYP0ziVERcFFntuY
         GPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974984; x=1703579784;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oer+pE30m7YLKnN5BO8AuR9Q9iiBrmnQo6J9HhmgnVI=;
        b=u+XgE85wQ4CvW1ByUFmfSN0OAvd0X5K7uLP0C7Ffr8honW8HwCpp3iKbq6a117+0QZ
         8K+xMmvwsZ1thXUm0w+zdAW2OSE+Nnwa7c/LgebakB+969UeOQD8L495lZzJXow8IydU
         ue9nIjOHyjBs5AoNcFDyh1e0nesQSYSUA7DnByNz9uxNwrLDpCxMfzTLwy7uiukIsnig
         ZMCjmpyNTI3ajMPLyKcvZGm+cvBlXsTJ5wVpx0TefEAOL+Uz3EOt/uZwrVfnXSAh881c
         bt7TrYEdautbiveYMCncPLReErCuCeiBEBZLhgwuhoSU2Hug8UT4p20+hcYEnxMRWJc1
         noUQ==
X-Gm-Message-State: AOJu0YxVgsafwJb5K95EpxUJaQS7fc1Z9gpbLXmmqeRyXlODB9BkryM9
	OfTYDHVtmkabGM3NIZ6uTM7bulrzzDU=
X-Google-Smtp-Source: AGHT+IHIulY7yMeToYcAW/w88508bNVpJJViFdhpvh86Cu6CoeUu9I4T2n0PMPp1KmzmFpcX9XvxnA==
X-Received: by 2002:ac8:574d:0:b0:423:6e29:c149 with SMTP id 13-20020ac8574d000000b004236e29c149mr21015769qtx.1.1702974983941;
        Tue, 19 Dec 2023 00:36:23 -0800 (PST)
Received: from [172.17.0.2] ([20.55.118.241])
        by smtp.gmail.com with ESMTPSA id k6-20020ac84746000000b00425442a2f32sm10035817qtp.16.2023.12.19.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:36:23 -0800 (PST)
Message-ID: <65815607.c80a0220.79998.4fd5@mx.google.com>
Date: Tue, 19 Dec 2023 00:36:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0468619066742592332=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Bluetooth: L2CAP: Fix possible multiple reject send
In-Reply-To: <20231219081022.41395-1-frederic.danis@collabora.com>
References: <20231219081022.41395-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0468619066742592332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811317

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.24 seconds
CheckAllWarning               PASS      30.86 seconds
CheckSparse                   PASS      36.64 seconds
CheckSmatch                   PASS      100.01 seconds
BuildKernel32                 PASS      29.65 seconds
TestRunnerSetup               PASS      437.46 seconds
TestRunner_l2cap-tester       PASS      23.32 seconds
TestRunner_iso-tester         PASS      44.93 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      160.83 seconds
TestRunner_rfcomm-tester      PASS      10.86 seconds
TestRunner_sco-tester         PASS      17.82 seconds
TestRunner_ioctl-tester       PASS      12.13 seconds
TestRunner_mesh-tester        PASS      8.80 seconds
TestRunner_smp-tester         PASS      10.14 seconds
TestRunner_userchan-tester    PASS      7.81 seconds
IncrementalBuild              PASS      26.58 seconds



---
Regards,
Linux Bluetooth


--===============0468619066742592332==--
