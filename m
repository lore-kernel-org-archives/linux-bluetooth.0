Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29D83CF75
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942977; cv=none; b=cbrun4yxe1DXkTVpYzxbMupYpIUXr1UqnKRObm+rb/twlmidVD67OwSLVajY4jTFSnjhk+e5LK/YtCr/vIkWf73v0iSTIIHUfb/TlCr1ORikrZUlnOYZc1sCQHAXh+Tyn51k91cHKqHyL6VdNWX07/dtIHpe+4ZLg7Hsv+ef0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942977; c=relaxed/simple;
	bh=YxQJvgTf02re99Ue0lmPvWr9anUXwQURBEMizFocEgQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Shi+AtNzOHfxKIWyeQbnjUMcSbA443oYlWAFqMFCnt3a1XHHvdowh9ES6gRrkn81hkSLZc/6ZH0vu1OpFEGQNjHZ09jBnxMaWUctryNNRnl7F5N4Fc7ttRyXULH0i3llUT8NTnhHew8kw9uMet5RhEEGnSO/1dHP0Ut4st8GS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI85Swtt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI85Swtt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dbce74f917so1001845b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 09:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705942976; x=1706547776; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J1y7lTwXhyCHwrIksmjecgAui6Jvh392u3yj6fSronk=;
        b=iI85SwttPlxyffzYv4XzibhSyYVtVCtCv1fL+rBK1gGQpii69LeHPctlrhnHMG9RXV
         0mi3VwR0Ph6K1ykvlx65mpvci/w5FC4Qbd//xMHcz+B+Vk20vJ44wu+rJ4LwW1QrdHNw
         VDjUlBJLpFgstJRoHJuf6LN2sq4/KgIUdSIErHAL5akCCmSs2dFlNrk5R9TlLzDhnqUO
         nMwuyHHijWgvh8TIhdVt94NgY6hTTw+w+KLAmH+jveNvr/dckvJdgOjTFvWtRyp9RSH1
         uH2grfXwi3Ov+kwk/lmqisGYp2j/NWkgQmYCmRWGcZHWn1yEaNwdS+QDOsmtPLZJqEma
         GhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942976; x=1706547776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1y7lTwXhyCHwrIksmjecgAui6Jvh392u3yj6fSronk=;
        b=O/VTbgDgng1/fI59jjMn/IGK9VOr7I8LOWCIMdDf840AqWlgHn3lsZRmtdITssGUHZ
         CegRJeE5ztAlp3DIWCLKuMJDf0NpV5EnMBObx89FPsFlBTL2ARrG8o0gkIhOCKH6FdQ0
         npXCeDbsVsPePT5srT9Fv0q/NKnLGtZF1uTnFKHX6yAM2MYCzikYFYlv5VeVbF51vwwi
         yG6BOPFX2WC1jtZFGkWKmirjjRyBXZdrdfyic0NPUehr8PT6m5g8n6JA/+KkU3xtu6mZ
         HrmJefmo2Bu23NDP+167oPqSyN6vb6tbpQy1b7GRU18eHKWT/oXYoHsRTGBLfTV1oLjS
         OCdg==
X-Gm-Message-State: AOJu0YzUedAbX3DJYYrlkPqz90Hperoom5hpilrZ7r9uvhKWME2P4ccy
	40l+raMIr/jen6uXh7w3ovRW1/M1WGVsAyH9aXy03yw5xlXGiAMA0SCzEM8U
X-Google-Smtp-Source: AGHT+IGJtv5/2z72OQOj21eYOHnay38OPNma9YIwf0yHgL2tEOO0CtqQdkHwIYhFFy23CF3tcOOe3g==
X-Received: by 2002:a05:6a00:2e1e:b0:6db:ab59:806 with SMTP id fc30-20020a056a002e1e00b006dbab590806mr2502419pfb.50.1705942975668;
        Mon, 22 Jan 2024 09:02:55 -0800 (PST)
Received: from [172.17.0.2] ([4.227.115.144])
        by smtp.gmail.com with ESMTPSA id fm27-20020a056a002f9b00b006d9af7f09easm9765367pfb.29.2024.01.22.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:02:55 -0800 (PST)
Message-ID: <65ae9fbf.050a0220.e7652.37d4@mx.google.com>
Date: Mon, 22 Jan 2024 09:02:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5098879641907888566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST
In-Reply-To: <20240122161521.2650805-1-luiz.dentz@gmail.com>
References: <20240122161521.2650805-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5098879641907888566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818691

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       FAIL      0.55 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      28.24 seconds
CheckAllWarning               PASS      30.11 seconds
CheckSparse                   WARNING   46.14 seconds
CheckSmatch                   WARNING   105.09 seconds
BuildKernel32                 PASS      34.58 seconds
TestRunnerSetup               PASS      429.32 seconds
TestRunner_l2cap-tester       PASS      32.05 seconds
TestRunner_iso-tester         PASS      52.07 seconds
TestRunner_bnep-tester        PASS      14.42 seconds
TestRunner_mgmt-tester        PASS      155.89 seconds
TestRunner_rfcomm-tester      PASS      17.83 seconds
TestRunner_sco-tester         PASS      18.38 seconds
TestRunner_ioctl-tester       PASS      15.94 seconds
TestRunner_mesh-tester        PASS      13.33 seconds
TestRunner_smp-tester         PASS      15.40 seconds
TestRunner_userchan-tester    PASS      10.14 seconds
IncrementalBuild              PASS      38.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (117>80): "Link: https://lore.kernel.org/linux-bluetooth/CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com/T/#t"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============5098879641907888566==--
