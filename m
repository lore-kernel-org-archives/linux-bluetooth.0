Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44C39A079
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778790962; cv=none; b=ANBlNBfDo1mkylzu7zJrwWxDWVKMnNIJAzluR6KYg/urJc7nITI0dJPni49CXej0OMiONDAiVG4naGJX6VNWkkjQ0dUpeXgPms0QHehExgvlNZVbTrewT78ntI1J5rdtkokh334BaYJI3/da44ZbDcvPRUccLyLuUl4AHzL2NFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778790962; c=relaxed/simple;
	bh=+FJigNeWSvrOQxI/8SvZSZtlrE2AlYa0UrHeWO1ROSw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=I6mFlpB9POOMJqCt5cvWjotXTAMgRSBuop76igg4VO45ueS0uLzd7LaKJXv3gE4k27PdgmPxZfoaeWyTjsIn6mXivo+CElIBPyPkU5CH7T3Bbc2eyavWOb7z5ZLxpoMcmJRhq5L2pulvLg8yKeJX0LWcjT9rm5s15DNVFAGKwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shRUOPFW; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shRUOPFW"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso3803355eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 13:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778790960; x=1779395760; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBKvC1KgzZdWNmQP/SLDBsvejhqSzEvDboXs5K9MQUc=;
        b=shRUOPFWQwNlEg3qOpcGjSvXwGfdX3jBv98X17gtn0Rj4OKSOIava8W8J59MX1nwmn
         x5C8YWDTw7/9qjBYedpa04IotHbsNkk29/h0b6xjo14LAp+TNw4uMlSwvYVN9f6d/7tU
         ySLyW7kiUvVZkKIiBFa+tm0bb9/nXyTEfeYMoqqzG7+2JY7Oq3Po4Qd8HvnU+pA3MChf
         Kz3gwmn34DFvNUeqT1pb8Mpi+/D7bMkJDYeddLi1Ws0YyvyaB9OLBsyoIp1lky5C3r6R
         kSE/4u6gcasvgqnrH3PuWBQzWR2yvuReLpFwfNrhbTNSTG0qIyR9X/Krkw8zYrCC+LEn
         feZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778790960; x=1779395760;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBKvC1KgzZdWNmQP/SLDBsvejhqSzEvDboXs5K9MQUc=;
        b=oCmpykY8mh/OM/VW3C1dtezatnkklh4K/Ka7dV0wzaoEcjUdQ2+v2pUfKIkqYOPYEt
         zKo6VtKM0tCN5Ui13nwJ+Xld4GZIQqOJPKZUWv/GvA1BqBvSerLkEJ4Y40dlRV8flpJ4
         wDyBAijR24dhwR5IYbo4co776Yxku6IW8K0UxolnQzfkc+cOEm0VbB509Eh78WWAX9Sx
         UfxmqZyivbjaAEZ/jmKCNoEbU4tsKOrjF0tHuR7m8fEhY/reaN/lnYLX0oHZl/elXqB1
         n72veejhdMhx4ECEmhKEtvKJYtBStLNlvQlV/Q1xvkNiz4qiSlHnw+SP15dz/I97PHvx
         y8sw==
X-Gm-Message-State: AOJu0Yz40bk1G1sR8ONGSzhkBVl5cFmt3VjhqeEoEFzKRrihrYUDSiZV
	lFGO7uUFe60SQNygdPogLw6+ipzov4EdRIoZJeF59xl2vfPKQmruvViNdypmpw==
X-Gm-Gg: Acq92OFL+CI2VYIGDHTGgQVAw3ad9wc5hdQhuv49pWX+AwT6seYzfHBnl0jECDu4hwF
	5YMVzrFwsw61RJFxTxWUz44fsvUpqK/qEknFm/z0paFXuujnLthaKWxRQq67X87duNq6pV+GS+P
	K1+nfFrZOrTA1AH1aKZjYm64QB5IXyqL2dh+fmy0Sjbj6yO1oDsRc8o12CYPi/QZCyzRmGoL5DI
	WOZl/hZ9o+E0Gaad0mY7CVJl9RIJ2QXvPBoh2+1DDJHrx9j6la2Z5NTQpAenEvpMJmYYyA+lxRp
	IXysacLmxpf8Pb62qD1wAcCl5r1RitPYs+p+1e8+BBX9WskeZs8g+v5rOLXKAsEEoEr4cxlZbV/
	w6DCu0dFS5H5Pfr62Z/m9H+BeRmX4AsmSEzuXJBqW7m0VwAcotS1VxLBHoeCUCsW8q9CPXoa/vY
	u9eGKRntpiwDJf+EjAKAnPEwvLusLaThctj+9uYiDXZA==
X-Received: by 2002:a05:7300:be17:b0:2d8:7302:d21 with SMTP id 5a478bee46e88-303986010e1mr548394eec.16.1778790959802;
        Thu, 14 May 2026 13:35:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.198])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm4429530eec.13.2026.05.14.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:35:59 -0700 (PDT)
Message-ID: <6a06322f.d7da0740.26af4f.639f@mx.google.com>
Date: Thu, 14 May 2026 13:35:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7444513135804012402=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2] Bluetooth: btintel_pcie: Fix incorrect MAC access programming
In-Reply-To: <20260514190248.1275299-1-kiran.k@intel.com>
References: <20260514190248.1275299-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7444513135804012402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094956

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       FAIL      0.20 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.73 seconds
CheckAllWarning               PASS      29.20 seconds
CheckSparse                   PASS      27.72 seconds
BuildKernel32                 PASS      25.86 seconds
TestRunnerSetup               PASS      570.97 seconds
IncrementalBuild              PASS      25.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btintel_pcie: Fix incorrect MAC access programming

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
19: B1 Line exceeds max length (87>80): "v1: https://lore.kernel.org/linux-bluetooth/20260511133932.1217624-1-kiran.k@intel.com/"


https://github.com/bluez/bluetooth-next/pull/192

---
Regards,
Linux Bluetooth


--===============7444513135804012402==--
