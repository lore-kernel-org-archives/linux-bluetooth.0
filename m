Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6524A06A
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281269; cv=none; b=bB+KzI186SI7xYSV3/us8g5T7F1MJNRqOU4hzry++lBWMpmfCRyuoXNU/PpiiF0k/rDJCkjQKM7gNjFLyIZN6TOxBSfZSaBAjXW7gF5DPf7EsTapNHFiMsqdnApFafgNUcww3yLpU90qpz4NeTcI+3yx9jTlrWC6L4toddTKiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281269; c=relaxed/simple;
	bh=F9YFpd4pWRufluD6WtpNrRnvd7RUGHNQVsHk9OQ8TFg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=oLnK0QxTsUZeKAsu+SdkOxlZdm8kEhz8PBvflvrf2DUN4L75d6e4nTjQ2qiclM2fgV+Julrk4+jhgrntEKknltEsP7kGTu2o2aAUr9tMZhoIYDG9/mXwZ+tCKrqljc2dnjU/g7lmLQis2AznYdFZQ5UBqcCKk1/fZ9j8jBwvnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG+qzuG9; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG+qzuG9"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0818add57so89732885a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 09:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741281266; x=1741886066; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GTEEx4k3zmugR+DLXElBkZkFH+cg/6V+sOlyV6jPlL0=;
        b=JG+qzuG97/hJ2nDQ+gpG6WJUB5H1o+aRLJxsOd2g9gFUDjVzY8uYdEbcGLTRuDxlzG
         /ROtMzTcHj9qKFpUmuyChL5W8T+PTgqNhheQSAmSBjMze+29ji4tWDmnf95mTwh+nfi6
         jc0kLIj4IMODCHF7Ax7K0tzFaNrVovN9el2SN3HgSh8dDHWMVT+zLLxGNcayNwkXk6AB
         c5i2UJgrZyNJ+3xZ1Q0SglZqSlU0foGIObb0eiJJVlqOGK4dM5LhprDWLckb4V9t3Uty
         mXF+cG/A8wWcf07zSvLwzNYo4zG4XkO7HmGy672rqrwfyFtte7EP6KdjBKGKHTPnCRSA
         fBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281266; x=1741886066;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTEEx4k3zmugR+DLXElBkZkFH+cg/6V+sOlyV6jPlL0=;
        b=FgTDDHU6qeKPXajMecj1XCFlfdSvl6/E1gwJV8nn3kp/AJUi2l/hduzGR7zFRFl2lY
         Uog2YssAsa12tUKtXWZYHdAad1KuJLrqCbtvGKEjiXiT01/gujf/5jcz7aEZAOnn/cPp
         nsZYiMJa6EMbwqctkIfEGZar3EOzv0GxFi6AHp5E745+bwaYgH9vNELVwvz9r8lJVZ2X
         C8frqbMZHB+7MmD53FqJVNNJP71KMXfY5UFB5HxDxMSbpn6H2HkQx5+VuFi7uevfKA/y
         1Yk2m8A42av3aF0jwk2YT6+RvyHwiusz5zUX7Kj4HjOspqdZlIM0dgkgMQMC1aKWIB1Q
         lNsA==
X-Gm-Message-State: AOJu0YzPlofG17PKFEg6SPl3uU33xq5yD59gvcFF8e9jRyYGidD+XGDw
	j5XTImt1hud3WL/Rm2vAPZ74MOlT059zC3gw0tIwDeQzIymWCpEWSdAh/g==
X-Gm-Gg: ASbGncub8l0UHeY6phYAsiAP39AlmNcINeEoDy0N/jSMfEl+QoV9s0WFAa+kp5OxHOX
	ZaaHO9CjOl00Cd+iU3ORrtdUJGdRD3YKDlMsoVgItPm9GAFnJMxuBFgWWjskAM4fnV2+QrTcERl
	AWvdPjy/pt6BJ8gP7viPC+6CEWMib38ho5fzttzbv/rtVHobWq/6U1XwB2p+iEliYTWPXe0UDzA
	3GPoNWSNYYb6TCEjfjYv49pr9xcN7rGEvdOa9tfVkwUjSYS2uYP8d9LrE9JqlnURQXPy/GI6uYJ
	VhjXO/7PTGTniUpqJjL8O5BX4Ft/Nf8qVpWb3gynxHS8iTGklw==
X-Google-Smtp-Source: AGHT+IGLbN8kKR+fL7LXP6s99OeWM6JUCWjTEajKUMoMPAvekoptOJDZpf9MIx3wtuqJ5V5Km7pVZA==
X-Received: by 2002:a05:620a:1b90:b0:7c3:d86d:94a with SMTP id af79cd13be357-7c3d8e558c2mr1247983385a.43.1741281265996;
        Thu, 06 Mar 2025 09:14:25 -0800 (PST)
Received: from [172.17.0.2] ([20.98.37.235])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e54ff907sm113283785a.77.2025.03.06.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:14:25 -0800 (PST)
Message-ID: <67c9d7f1.050a0220.279f58.43cd@mx.google.com>
Date: Thu, 06 Mar 2025 09:14:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2117700574983948945=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] btdev: Fix scan-build warnings
In-Reply-To: <20250306160003.587816-1-luiz.dentz@gmail.com>
References: <20250306160003.587816-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2117700574983948945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941078

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.21 seconds
BuildEll                      PASS      20.77 seconds
BluezMake                     PASS      1518.85 seconds
MakeCheck                     PASS      13.48 seconds
MakeDistcheck                 PASS      157.01 seconds
CheckValgrind                 PASS      212.28 seconds
CheckSmatch                   WARNING   281.44 seconds
bluezmakeextell               PASS      97.61 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      852.14 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:450:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2117700574983948945==--
