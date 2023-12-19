Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9E39AC0
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwvsnQbH"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba0dfc9001so1778298b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703010873; x=1703615673; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n4qVXkCdrTF20c3rmK5WTJOJxSuU94KxHy47ohOZkBs=;
        b=iwvsnQbH1Mb7zugv4f7PHQ6RqdBkwAMW/gH1dnjlidorAgbZIiLb14Pcr/QuDlm+8s
         QMUZMkF4gtrZQ1/49gWBjAFMoFgJpbZxauNO0JtBCwOLXMlMFN28LmWYi9Bo7nIvxl7A
         6+2sVREJqLhpcqx9Ch4ooKUJQMz85lgX1eh1vD/CRtBW8oznikwf9Fg4bMqbzAhKfbHJ
         Q/xf/SofC7N3UsfhY0hmFWYDnggqWmvPmQk8RuzTAYdXcJihstWSCW2RiNUHlUYEiEVm
         tzDq7qKXW9wm25ZPeJRdngB2YxpPaqYpYdzRzWIk328crQQSFA3XbWjsUnkaV+mOobRM
         VQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703010873; x=1703615673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4qVXkCdrTF20c3rmK5WTJOJxSuU94KxHy47ohOZkBs=;
        b=e0kDvYtwGf+pEvIHNWWfq+gDnI/9mZHofE2z3mbRK61cPP2P6l+MonFgIWLXlGbl8U
         rlbLysq3nVCC9r9lGjvAY7fbRyizHVOaiBSAQmOuIwOZnPIrq3eQ3wh34lhRkZPwzYou
         gpPCOU80k2a3En66NjNrarvQ6bB1T3Cbjchtgv+03g1NATEPrrURbvVqt70y5YEQqVDD
         BqsFMEbYhSncSa9U0H0TNA1iwpkzns5HMt9RN67J8kIw047dnNYKW82oo+WPAbg9Ik7/
         /YwysqHsmd6gjqw3r/KanuZJ86O+Obn+2Cv9RCyElEtz/Z23dDNsebefhngRBAxAQTfw
         epwg==
X-Gm-Message-State: AOJu0YwbLD9EdJ9TF1lFo5gWSvlsteyTD5Hz1lBK2KbGjv7qq1CkwXxX
	+V6uJxjmeeEhSezPXAMoqAGk2GEmX80=
X-Google-Smtp-Source: AGHT+IFFcoRrWDf7y+OkXj3hncIdGdNA5HoohFOsfAa0IGx5ToUqvt9ivLPwMZDN7lSDWCK9d9yiSg==
X-Received: by 2002:a05:6808:14c9:b0:3b9:e468:de10 with SMTP id f9-20020a05680814c900b003b9e468de10mr13845307oiw.66.1703010873441;
        Tue, 19 Dec 2023 10:34:33 -0800 (PST)
Received: from [172.17.0.2] ([20.57.13.220])
        by smtp.gmail.com with ESMTPSA id ew3-20020a0562140aa300b0067f610329a8sm662396qvb.31.2023.12.19.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:34:33 -0800 (PST)
Message-ID: <6581e239.050a0220.2f26b.44e2@mx.google.com>
Date: Tue, 19 Dec 2023 10:34:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0094210248772693463=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jagan@edgeble.ai
Subject: RE: [v2] Bluetooth: Add device 13d3:3572 IMC Networks Bluetooth Radio
In-Reply-To: <20231219173547.337962-1-jagan@edgeble.ai>
References: <20231219173547.337962-1-jagan@edgeble.ai>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0094210248772693463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=811497

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      28.97 seconds
CheckAllWarning               PASS      31.58 seconds
CheckSparse                   PASS      37.78 seconds
CheckSmatch                   PASS      105.16 seconds
BuildKernel32                 PASS      28.41 seconds
TestRunnerSetup               PASS      468.83 seconds
TestRunner_l2cap-tester       PASS      24.13 seconds
TestRunner_iso-tester         PASS      42.24 seconds
TestRunner_bnep-tester        PASS      7.09 seconds
TestRunner_mgmt-tester        PASS      163.62 seconds
TestRunner_rfcomm-tester      PASS      11.04 seconds
TestRunner_sco-tester         PASS      15.04 seconds
TestRunner_ioctl-tester       PASS      12.48 seconds
TestRunner_mesh-tester        PASS      8.99 seconds
TestRunner_smp-tester         PASS      9.84 seconds
TestRunner_userchan-tester    PASS      7.30 seconds
IncrementalBuild              PASS      27.97 seconds



---
Regards,
Linux Bluetooth


--===============0094210248772693463==--
