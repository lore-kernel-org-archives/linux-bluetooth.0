Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656552153C4
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825147; cv=none; b=bR9CYj++EdnUxYLlVP3xmqceHdAdtm4iP9aEQLRt7BPRZKAXzkHAx8wsER6iCRBB+YYKfwowdtWg5eLE+PRjwAwyKOhBs64bcN7Bxv7N7lPXtz0Mc7HtdsCd01DKX/QUSSJ8tBFVppWKHzUpXIfQc3zSkMUxBAUB8O+f4DPo73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825147; c=relaxed/simple;
	bh=Kz8U6v+dEwKMRPZVHK2uPvLhv+5SuevF8lx3yEDS2fM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CvJC+cj0+XW2zhKVb7wsqvpBozk5F+3FyoDd0WI/6hV+GH5RUsu7u10y+se7WawDhD9+Rz6q/8uWQUCtXbVBmSjvKXD0VwzcSqfx4jqOBB/VqvA2GesFTRKo1/EJ8c9hObaVWdoYLQMxTsu9Q08/cCYHqsJ81YYiSS0FKbdO/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8L4gGbG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8L4gGbG"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376e311086so9473535b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744825145; x=1745429945; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FiZFu3Uu3SNvdbhlue9vqlWtQMaptutTd4ikGfVbU/0=;
        b=f8L4gGbGmmoAIff1U3UbDaqReqW7i2JXEtvFubafXHlJh0sAhyAUGJ0/GFfissSuRh
         80wB1Qi/VJP6n9yMLogdv+9i36CRrIKjfEhL+aUcMZn8G3fIPv4z94LAaaQVqVG3Nmgz
         JmgfqXUtspe13jTUhwM3OvKq064vUkhxjgITyG+jlJHYr+hr+i1MgdCpVzO2xwoqQiBT
         58hPeItcc6l1eggHVGbolbAQ+wP6zfoO/RxZf5xeHF6O/slxB2N27iOsOSU3rxpwhu2c
         uNNTMr9tQi37J9tVfNjY0dG23CmM830WuKpBmpMekvO1+bNbVvRXquy7BwDrHU0HAEqO
         +GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744825145; x=1745429945;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiZFu3Uu3SNvdbhlue9vqlWtQMaptutTd4ikGfVbU/0=;
        b=CB7TInVyH4/GtpCMQrgjsNdaQfYFLI/w5JI2fLHi7r2ikStv6T1jBAZ1G+HUIviBk8
         OlpSv8SZKfm2MK/PwBJaHCST83Y+QLwRG2BcrKPNwFmapiW6nOtW27Dc8X5w/kU53/Ai
         /LHjEGoXDQZ2HoMdlTiwP7nCgPKjy3sG5rXmTqyMGccpxp+pjw3jzWglAfeS57ekReIs
         GDJJbOSQIXxD7eWABNntA9sdPDdhDDDpWCkmuxZ4TgRPsK6NfPiQD3lIGA8vm6Bkzw04
         e5loFzdqJclJoEk3QWcP5o1lE26OikmBMdjyjxV/oupUyHqSVX87heMfaT3HGZMXTzgm
         xBsA==
X-Gm-Message-State: AOJu0Yzd/uctIjycERwjOW8adrBsjVbs4hmzofsljpu6Yjx1KmoizHoU
	Pg0wB2NR3RnvfpHs//3EZ9mHBw7qhXbnDkROWmIYzm9sFPlziSbIvT9rXA==
X-Gm-Gg: ASbGnctTZ1XuzUgErze0LlX2FzpUlTDI1dcP011OJJjkWJgp6vpuEzOnvmuzV5d4HtJ
	ACC4MKZmpjIp0kByHgUzhbo0BDrwkh11QDoUMGPhd6hKtH4/uvY4ZjboBpZ17TQKWcPZ7zhTO7o
	A0WbWxa+mXTZfo38XMmQdF9zZ3vJ5xoV4i2zH24DK7sZhma7gOCRAQPiOihPDNYHVYOpAzxJrlS
	7KGFH23KXkgPJlI0ASWLpo1gXUTeTi66kJPtYzAknByMfuJiqoJ31C3cgOgddM6NNsj8WaXVqWM
	3cEBuXQVGl4ycgGEQacyD3aOoJea+7J7kKWS8/ZO9DF4ZQ==
X-Google-Smtp-Source: AGHT+IFdueUulN1eMsp8ahwlc3LUFX22MNnuzdwInzL+XOqfa78AolJJHv+dSzCCl8+rL3DU0L/6ew==
X-Received: by 2002:a05:6a20:9f05:b0:1fe:90c5:7d00 with SMTP id adf61e73a8af0-203b3fbed1bmr3762012637.28.1744825145185;
        Wed, 16 Apr 2025 10:39:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.33.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220fd37csm1585492a12.44.2025.04.16.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:39:04 -0700 (PDT)
Message-ID: <67ffeb38.630a0220.26b4c2.53ff@mx.google.com>
Date: Wed, 16 Apr 2025 10:39:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1612792008077376480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] device: Reset svc_resolved on device_discover_services() request
In-Reply-To: <20250416155503.250763-1-frederic.danis@collabora.com>
References: <20250416155503.250763-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1612792008077376480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=954076

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      21.65 seconds
BluezMake                     PASS      2640.54 seconds
MakeCheck                     PASS      20.53 seconds
MakeDistcheck                 PASS      199.25 seconds
CheckValgrind                 PASS      276.84 seconds
CheckSmatch                   PASS      311.95 seconds
bluezmakeextell               PASS      132.45 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      945.63 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1612792008077376480==--
