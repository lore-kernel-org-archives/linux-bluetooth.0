Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE1ED0
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Nov 2023 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg9OQSgI"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018F449A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Nov 2023 18:09:20 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778940531dbso98528585a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Nov 2023 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699582160; x=1700186960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DbeSJHSjWT8nRxo3AcifVKeqTQKpVYJWSOe7YOUhYWk=;
        b=Pg9OQSgIBxWbSephr9n3COWFS9NZA5yhGJXCTWWjkmVH4TFvYcgLfYlL5QLWfEl16x
         Qn1IWk4j9dXrmkjc8mM4qhe4ZsHjwYLqmYdsMctCmAPI6UZ/CW7KnIjV5NI5BjszqDOH
         skE6NY2cydu6O7LX7cjTvtmFEvuzRjfaP7L8CrMmXH9ufm6ho3UCrj8LHN2KG5J8QG/1
         oPzX3RpEhNVY/OfXCMYxbMitLgzH0o7VDIgqqTTXJzGCFor8cVvreHnMUYbRt51WkYT0
         24RLvkGbmAt3QsO2xoboZ9Clgc0IZvyYI8Tb7oL+QtGiNqnAQAgh+Fsvkk0m0QEPmqXj
         tNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582160; x=1700186960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbeSJHSjWT8nRxo3AcifVKeqTQKpVYJWSOe7YOUhYWk=;
        b=I5ZNI53hVsnBQNNXWAunzICkk1k3UdrrE4hNnUZHvAQB6UJSpLYhl9fK3B4TF6kEqr
         m7kcLUhPqbTVFEzEy7jimlckF4qUhpJQAYJ22GKWa8Y7OautRW8PwbteJ3w+DX7mFJml
         tfxRWHCeFz5zHlcSavZajcgF3nLfSsbNhWBvQNi+xaIZrcZhsV3ESzETHYbgXMBz9Dnb
         yq2Yn8BITdAUGbfbKn/gdwKzUw6qiqPMnAYL9u5PeJl6Sfs8OmKW0ypIl2wbVvcxP5nS
         jOxEeESuTidjRJh5VKvKlZWtB60ud5c7o0BwFe5TbXxGsrmCpQOtuV04a4IGDV4cSwGL
         9LIA==
X-Gm-Message-State: AOJu0YyOcUKcI66rU9hMhoTXKzmTZHszftcbBzIvoT6S7O0yGXGb6KxE
	PaFaJLqPuCQDViWv1GqYs+gm/3zuCuU=
X-Google-Smtp-Source: AGHT+IFbAnQzwd+9g6ll2J44lmZngyKKxhphs/OjV0mzmLNIhbLz4e7Z7zrHLlE8D0Jx/KaPG1r1lw==
X-Received: by 2002:a05:620a:4410:b0:777:2e7c:11f3 with SMTP id v16-20020a05620a441000b007772e7c11f3mr7707605qkp.9.1699582159799;
        Thu, 09 Nov 2023 18:09:19 -0800 (PST)
Received: from [172.17.0.2] ([20.55.46.193])
        by smtp.gmail.com with ESMTPSA id br42-20020a05620a462a00b0076dae4753efsm370095qkb.14.2023.11.09.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 18:09:19 -0800 (PST)
Message-ID: <654d90cf.050a0220.5f2d2.23a6@mx.google.com>
Date: Thu, 09 Nov 2023 18:09:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0530849853029737972=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [RESEND] Bluetooth: Fix deadlock in vhci_send_frame
In-Reply-To: <20231110014605.2068231-1-yinghsu@chromium.org>
References: <20231110014605.2068231-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0530849853029737972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=800102

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      26.98 seconds
CheckAllWarning               PASS      29.80 seconds
CheckSparse                   PASS      34.96 seconds
CheckSmatch                   PASS      97.68 seconds
BuildKernel32                 PASS      26.29 seconds
TestRunnerSetup               PASS      410.70 seconds
TestRunner_l2cap-tester       PASS      22.77 seconds
TestRunner_iso-tester         PASS      41.80 seconds
TestRunner_bnep-tester        PASS      6.88 seconds
TestRunner_mgmt-tester        PASS      169.80 seconds
TestRunner_rfcomm-tester      PASS      10.89 seconds
TestRunner_sco-tester         PASS      14.49 seconds
TestRunner_ioctl-tester       PASS      12.42 seconds
TestRunner_mesh-tester        PASS      8.79 seconds
TestRunner_smp-tester         PASS      10.53 seconds
TestRunner_userchan-tester    PASS      7.24 seconds
IncrementalBuild              PASS      25.39 seconds



---
Regards,
Linux Bluetooth


--===============0530849853029737972==--
