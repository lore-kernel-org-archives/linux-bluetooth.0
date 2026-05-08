Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF64035E944
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270790; cv=none; b=KTZSh9YgjwVXgFRoBuYF7FAjrQRS7AlT4+t1RayxmK6OuZk/GvO31afg24g//Y5378nXH3J97SsFcgHXJN253nqOLk/POFGO2bMEonQZ2g+24GkKvMGVfatH6VDB9K/O0WmZvN2V3p+Blja5sBAeiYurPfkHAJqEMXPtS49AgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270790; c=relaxed/simple;
	bh=+Lq3VwCfL3DWJZsad+J+gksrV4sKd0REYKVCdRz3Efw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BA25YYgN+RV1uERZoU56Tn1xEwbYZkBBWyhxRCoxbAl6tu5sCdbzuLyajzatWy8sz1XZ0/3lBVCxLS0rN6ug7cmAqIPgYcFYpTSBIpw0515o+WQTl+5Clm1ei6Xbb/icWe7fQfdirg2MGHoiwcUVZ08lnee3NBpKvY654s6bMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoA4Ws3l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoA4Ws3l"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8e0a768331cso365521685a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778270788; x=1778875588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Lq3VwCfL3DWJZsad+J+gksrV4sKd0REYKVCdRz3Efw=;
        b=OoA4Ws3l0SFD+/axCAkBnRNYd3gWitmTwXE8c5jUm9lZ6LbMclgP6SWxctjhxRdb+f
         /SAmZ0+EUZiii33qmZsD9MnneJPXvDtNUdIaSYSvsW81NpqFm9fQuHhYZHYyRWTe66+q
         8x466OnwnxcqUrDt57HweHc8uQ4+KpB0JlzISaWCrcCzuw1dVOw5DCjGQkjVvVdK7YrU
         /XT/dUxypgK2U2gO3a4aYhhz8Y9nNlVI4J9P7otwOQqXmIoKJCr0u+WZUFKMVEZYFq3p
         aAmUu4PjvDLnVQyygEJYIDX3Y+H9h1LnXtvIHOskIBJGqTt86FBii7+EYl+A7VGeX5V0
         yXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778270788; x=1778875588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Lq3VwCfL3DWJZsad+J+gksrV4sKd0REYKVCdRz3Efw=;
        b=QrhGmDDOBxbgflm/FH30Kxzkbi9YqGagytn1TEWo7rBQU7ybWwo4e8HG6f7wEuTl5I
         +aX87e2kN2JLeHZ+w1Wf3BziNEnDNBUvPI9aBSXSe09mq6C+zJ7vO38kQe6A3cmNgjjY
         Ospw0M5nX6r31HNhR5/lC9Kwys8SKVnekOEtlhv+02g111kotmiPrdu+35+JCJhJBxTI
         KZUUO/Njd8KfCQ+iiCpxxYbCoG71a5ZhZ/6BBQMEctHN018iziWnNMBxQVTn2Sa6oUc7
         QF55suPZ9CuQw0b7St7MnUAfYB1S17DxQtDpZrtWiCV1IyF9C74lcfnVM8Y+oyplsxel
         UJrw==
X-Gm-Message-State: AOJu0Yy7OpClY7eDy4V0yzgVrf1WyIuMgBFQjZ7avQyYYM0nfwGMLZKv
	cdY/0Lg3g8ediaLhsPRFlBujbhZ6Y62YKslpGd3Tn4g68LzFg6PM0Ls+AgEExQ==
X-Gm-Gg: AeBDievRDdXaxO5SXfq3m5/9jHe8jJ7YrtjMwWYhGeR8PSte08s03f/kf9AiK5bxFfW
	CCgReN8AtzOPYaiP2kpu4ORXoeHT9fi1HZkOGOyq2Y551OIZWggd03csxPx9aw1oZZyIYsx0/aP
	StTre8118rpZPrLUnIMBKQ84/rprf5AI14Q5zUJjJxGpkRtlB/jtIvZOzn7jaVMWD2chEGxH+4N
	N0jo22wIpMRpl3wi7s9D3d7yRAMMTy1mPQL88Sr9C3Al6+WULfRhLCun8UY9xxhaxc8r1RgIQ8D
	lNgPxZi8rGWi6MEe09PKrXZWoHMzGy6dObZuKnlTt0Y86Jw//N8BUfuxsFYtHgCmn+/4PmwSCzX
	BbaYpZZxHjeMfnXbq1lqfqjtFzkFQVeea/PxACLGl5Q53l/47g4D6uUO+NLO5VSY9U4rprBah7W
	1+Hngm1SlkdcTHeu/8DriasRuzctJhj90=
X-Received: by 2002:a05:622a:14d4:b0:512:e7c0:4f00 with SMTP id d75a77b69052e-51475c606c1mr114961391cf.29.1778270434768;
        Fri, 08 May 2026 13:00:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.180.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83dd35sm24837501cf.29.2026.05.08.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:00:34 -0700 (PDT)
Message-ID: <69fe40e2.c80a0220.1729aa.1446@mx.google.com>
Date: Fri, 08 May 2026 13:00:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6373702516277129871=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] monitor: Fix RAS CS step mode parsing issues
In-Reply-To: <20260508191728.428868-1-luiz.dentz@gmail.com>
References: <20260508191728.428868-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6373702516277129871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: monitor/att.c:4425
error: monitor/att.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6373702516277129871==--
