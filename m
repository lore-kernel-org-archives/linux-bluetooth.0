Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55374368D55
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572987; cv=none; b=h9SvWgO5akSnA1UZlWWIu/BjgszVuzX1jlfenRwNz2dzOPUB+1D7i+ClwMx17OBZQMH8dfAn9k7JjndccUC+tvX26s1nIPMSMly+b/rdAhoIy3Li382RZInDj1qJettvJcWDjV8ghmXi/L7UbT1xBBaqvhSAxDD7po9cI+/oWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572987; c=relaxed/simple;
	bh=m38z5BVr0l7DODHgDKAx8RGSw7wiJFwe+zU8J8w2Neo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ULksNCOnR1qQg2kkOwEqwE0loOiAjSzKQMzbLyQl3s2swACMZfBi60TB/IXUwr7yy366/JsPOkp6lE/lgHY/+aP665W5A+SEE7YNb1D6LICslNbEFuVf0JyBbtUuADjAP81st+bI35nA1d+sehsx4qXSZiD9s9TZpKCi3VLbTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQWlejUj; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQWlejUj"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dcd689829eso4718658a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778572985; x=1779177785; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oMuQLUl+VLrbUjDtdr3HsSHntiM6iuQ6xlhblNLT4qA=;
        b=LQWlejUjyoPptbXtsuzQOJe5BySAhTGM+wlY6gKyaUmrl6IFDH39feyHh0OUkgaMwz
         9g9tVUO0wpy6iNtwp/2vGbb5/wOvTXiYxF56r4TQN49P1LZkHbZpFFdrumg2NWojIOSS
         8o3zelboAjJiJGvdOv7nzUQLntzdC9cXaChZj5VHj8obWNd/uJRiBt521PjTnTVvs/jv
         hi9SPOn6nrLJ2JpSQrq6+cGBC36JgE+s6KkO4dMjtM+RJujinExjtcJTNd69zZMuUnp6
         F5J7n0gZRgo7NHJQGOPTqOOvlrcRwATIkjBWScZuK7e7nrj0ctvuL9HIp8EiLJ03RX01
         8GFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572985; x=1779177785;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMuQLUl+VLrbUjDtdr3HsSHntiM6iuQ6xlhblNLT4qA=;
        b=tCAb3zYZw3XYl5YBostofXnwNnjCDPee4fcE0NRed0RnlwNIvImHhAQAz7Frcc73q4
         CocT1k4vZa468lopCcQdS1Qu70Fogb+y4IV70BCF2NVn750D2E99f3N8wJLfZUZEJQNj
         /s3sWP8N704r4NbMq73qEmV2JrEunFi2CgAUeezo7wfFjCxBSIwcpFRuJBAwT7nHKxXG
         WS+4dE5143uSQzTGOo11D5cTZfIdFJQxRDr337leNOK3hNA9qcmdzYtuKP/ASCrP/ZFE
         xQ0w6bNT21jIYfMM1L2YSG5rVD7erdV91lIQ+w3v6QgCNba/VUBf8GIomq6Kz/Gi9wgP
         7hDw==
X-Gm-Message-State: AOJu0YzZUfGXc7+C28sEwcDBP4sn834Pom0bzk1g5rRs+QUYwdZBsnP3
	Fjuo5c+FofF8JVG10kf6AAAX7yt9yc+3rnMuzvD758586XTCN38gapGfSeWwzA==
X-Gm-Gg: Acq92OGAz9aRUHwwTcntIGOZ1WOIjAcp9+e0FzkPIQwswKp8Hd/Zeej/DJv4jD5tlMz
	04opiHaUdy2MPpnf+vJ5d5Kxg8eJjE+/6c0gnQRdORr77Z3ePZ05AKwjg67KBfjFbqGc+Vv/lmF
	Sldr/K2MDz1YFQRcrFFydiZ9LY+NEXMJOQuAMGXWb7Zi+GqTfCmoU0TTWYoXcq0CGLF2/25nGBo
	81vtLi0FgepW1n4TsCuOpcZrv++DzkPWr4njZtrNAGBkMnttk/FamWZ2XmpEFfB5DUV2BkueBFA
	VrxfVJRF1stEySRA7VJlavTwsIYm0quQpHsdR5liLuSMOH96F/3v3VSRb1CwiWzSSbFhbexwmrc
	DmYOc8vvljP+9odZBcghwTDm5RlPM4WxgwuI413WT2r57hoCuQva5AwZ2AMD6OTI9AQ3StodopE
	+sfwIJUdkZkSqOclnu8scU9C4t2IlGsqw=
X-Received: by 2002:a05:6830:6af9:b0:7dd:9b19:a875 with SMTP id 46e09a7af769-7e36615e5c4mr11420078a34.2.1778572984959;
        Tue, 12 May 2026 01:03:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.163.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d90148sm8743830a34.20.2026.05.12.01.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:03:04 -0700 (PDT)
Message-ID: <6a02deb8.050a0220.1647c4.8305@mx.google.com>
Date: Tue, 12 May 2026 01:03:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3430092000831098187=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luke-yj.chen@mediatek.com
Subject: RE: [v1] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609 Add VID 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip.
In-Reply-To: <20260512033422.3242781-1-luke-yj.chen@mediatek.com>
References: <20260512033422.3242781-1-luke-yj.chen@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3430092000831098187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1093267

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      27.95 seconds
CheckSparse                   PASS      26.49 seconds
BuildKernel32                 PASS      25.11 seconds
TestRunnerSetup               PASS      522.03 seconds
IncrementalBuild              PASS      23.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609 Add VID 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (116>80): "[v1] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609 Add VID 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip."
1: T3 Title has trailing punctuation (.): "[v1] Bluetooth: btusb: MT7925: Add VID/PID 13d3/3609 Add VID 13d3 & PID 3609 for MediaTek MT7925 USB Bluetooth chip."


https://github.com/bluez/bluetooth-next/pull/174

---
Regards,
Linux Bluetooth


--===============3430092000831098187==--
