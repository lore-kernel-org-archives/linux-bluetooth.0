Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AB244667
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674216; cv=none; b=kOoIgsf1US5SoM1PrZC63/lfPw2fSPggcOPwdwSZli0AfTfvIMOe1j0a5eFTpitoJiMU5RqdW47fuoKx1MWqZoOIRCZp+dfecGZO9D/XkFd1iIdp4isw93MtEoBq3S7JprNgCD7Oyhc1BhBw1P6rxruXGCEQF3O4EoISk6RqYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674216; c=relaxed/simple;
	bh=aSqbv9IJpbt7c8t8gVTw8rBAmYE/EPGINBo8yy/qKxs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lTfWT+VqycYmqihz3FSMbyC546kbz5Ih/mYXdJWF69jDFV1XJ0eXJ2gfCBrrroAzAEa49Z1f9l6L/gDMYqJqR/blEdQVgZDNVGBBwtl5+g+bTbOsO6022ge6u+O7M/zmg08q6Yqc4W07d+lqzZuCH8mnabXLsxX6+A5Q5FBoK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exuegiKB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exuegiKB"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb40277a8bso783295985a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 17:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772674214; x=1773279014; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aSqbv9IJpbt7c8t8gVTw8rBAmYE/EPGINBo8yy/qKxs=;
        b=exuegiKB78ZP2+w7gTkLmpu4T0TBGx2xfbmbO7BGueoraZxIwvOVPV+sX1B3Z+85ti
         clV6Yt7JLMVh7heN1HjGVmThzxsiuA95I3QtS9sssM+6AE023g9UF7avuPWxQYmFpMEk
         cdIC9iT+yabhj5wE3I7whYSzqkyba6gBEErWkip6ytJHXLQb5tZn7aJfpx78Tc6mRkX4
         8rbhzlz7MeCPW1NlA6cXA7n7HD55WuHfGFx1npnB+mTqJL+EuVQgQ0szu3/ofnWAUTGP
         Q82upxxNjV8W9XWlBsVfJyhCLeFOXL6d1qLHwSMIQU0Gzp/SuOLynJFQ0XLQ277QjHgC
         yIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772674214; x=1773279014;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSqbv9IJpbt7c8t8gVTw8rBAmYE/EPGINBo8yy/qKxs=;
        b=hAkUgEiNefXcASCIZTusJx0mYiJPnkWmKYlOP2op5pPTWWmQkfpQye8qTQ9NFLyK9D
         Xy5c4RhfrQPZXRS79NmTU1Oy4fBlXKW15qa2plAdZVlYAcKdDm6e/TtJk+Md4fIoZqUg
         ca0YOhJdFXyjCkaXzpo1AI1DTIzCuYuon3kT2IBdxgGsqXeyEujpBwpMbMfNjrcRyIXr
         SJQ/vTXonOtaJr80PyfhARynTlss4GD48YLO7oT0Z9PmirgRvoXd4OC81AT6T44vVLNw
         Jf7D2UC7ijHxcSVpJ/1Fc2GO+W4SiluJgUIflO8vDBtthBSjzrxDcPffizUQlvlqG7lz
         xiqw==
X-Gm-Message-State: AOJu0Yz17kyqlqSeei4vwUQQJ7LK4+ibMV1x7/T8c+O/sxpiPpXSRkEg
	K56KZ0sra0f3sdo6YW0p95X8ct3eyD+OqVTJmoUKfnjDlW0+8PvFFsjUmAHIFA==
X-Gm-Gg: ATEYQzzhz5griaD8kcr5d72hwTIL8zLEZYoRJAclxFT3tz1wspVrVJAIxWSHq+NghNw
	bOSjMujgb/NYRKVXmNAxmeeKrXYBlLgTq56ze0Os4HNQpKx03nTu5lhazjU9YKles7SRtsLpluw
	QHklUbg8bHxZoj6qmxgJKf8dFpWTNo4mS+A+tt9B13V5MKFnW3zMWXuFWNOfrAMJtTDnXhw1gC0
	KmrlXQsCZV83KWevR+nwpwO5vddXfsvottd/+qN5Uy28swxmCzA1smgy3RAEa0xNmHEyA44UKnL
	nSpLQ/H5oR5gHXNJtkTb7FR2wzHzAhEDiKp8uRr/SjCQJjhqabTSF9j3uZgDEwhQHS7XpIQkKKP
	qbAg/6WbfU1gZruUs3vDmzGbu/PS+0MuHM0Q/HY7XFwYs5Of7US2v5Uz9el6XHQlXDb/xe3s74n
	hZXkJbXdmFyzLCD6PrgPAYQpcQjBSlEg==
X-Received: by 2002:a05:620a:3195:b0:8c9:fb0e:ca43 with SMTP id af79cd13be357-8cd5af1a395mr532586685a.24.1772674213840;
        Wed, 04 Mar 2026 17:30:13 -0800 (PST)
Received: from [172.17.0.2] ([135.232.200.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f4fb7c53sm108774526d6.30.2026.03.04.17.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:30:13 -0800 (PST)
Message-ID: <69a8dca5.050a0220.24a0ce.64f4@mx.google.com>
Date: Wed, 04 Mar 2026 17:30:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7931701531633149187=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kai.aizen.dev@gmail.com
Subject: RE: [v3] Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
In-Reply-To: <CALynFi7dq+5R+TRYa3T-9ethQ_TKegBtiv1AAAG5Lfb9oMto2A@mail.gmail.com>
References: <CALynFi7dq+5R+TRYa3T-9ethQ_TKegBtiv1AAAG5Lfb9oMto2A@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7931701531633149187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 10: @@ -2196,6 +2201,9 @@ static void create_big_complete(struct hci_dev
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7931701531633149187==--
