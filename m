Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FF350A05
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672545; cv=none; b=bStSHRea0Gq+pKrXdwJHBaAD0Qv2UXobZ2alFGXLf0pqT2Khb/mmE5HvRGnsRS/o+VE6RpAtd6S9gsK8YrJKdYRi7r69zhfg0HMlRCf2yVm4cITA/gE8Qh97hEpzWG+vsnoP9MIOsarFOdywGoQ1T44/z6bH0GIqEtIG2FnMY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672545; c=relaxed/simple;
	bh=5yI41wWurcDCuo7BHEsjSwkI6WR4A/rp12cJasKU76E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K1bwXbtJ4QdCPgE0UneiPags8R4LK0QpQN3Ev+eWbKJKQkT401C/2KPw44GLQqnvWzeezwoJZNB6lrPiu0qwUOpaV/WAQKZaddgS7Im5cEFXgjg94fW8ZVcqAhb4CkCOdr3C95o9bLtr2AOSI73FRWTPEXuH59HIx+GRBi+hedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWpo8F2D; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWpo8F2D"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9fa42f08cso597252a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 01:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783672543; x=1784277343; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5yI41wWurcDCuo7BHEsjSwkI6WR4A/rp12cJasKU76E=;
        b=dWpo8F2DVmMCApz17GkizS5En2T7KY13/+ejNTF8LJ0hPtbM3IL8wEgCCCJUM6npyC
         0tZ9z//tqoD+lH7+2C70fy4ZbQkbtM/bTq31Nhmfenutp44guIaBn6PT0px8g9XhC0fE
         qf04pPJgd66Cp+5Clm1uSfmKzDwRTfVO1Vd2qlpOLPbCtXrxQkuCKkxoAUg4op5yLpQQ
         /2P1tiHqrf7M8xWlXdVNh1LMpSomKlojsP3jOZExVxWHybsuuslk9UO0kHdjAXnlqt6T
         wq/PB0EC31ZruXfhQB7/fp1gKXVyng44g0nKtwjYH3eHpAW3OhNfu7iHEyr6i3j9R6nO
         1RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783672543; x=1784277343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5yI41wWurcDCuo7BHEsjSwkI6WR4A/rp12cJasKU76E=;
        b=jTebfp1aQrZo1KwiiDY210nFy3dacJc79sy25cnVWe2QdIX4Q/+gJK42WBXFbez7pK
         b3oSCRygAmSjTnA8plluQ6LDU62IgPGOD3dh32oyUykqPOYd7W2XJjPFk4MNzOpEr5pL
         gsAT/CToGB9blYLAOMeE1Xii9ghe5C7VQy6Yfh8qn7/EwrkLGz/cq4lJzJKUbyTUF8cH
         aG0wNnuXvxR+tsADtPNOZs3eTfoUaK/LpQvQ2pgErG0QEEOiUDXN1U7/Zyn8dzIU9pyk
         EPJJCawfGwRHJnD9HtIBAIbJ8aa9/6+PeveopMB0Bz5Bfect/nbflM7HtQysHFDszeIX
         S5fQ==
X-Gm-Message-State: AOJu0YwFDPDExMDPvxinYXeBjRF8Vt5za9Tlbpp3L60ZU2JWLI0YdWbS
	p0SsgllLwUtpv6UWhwOHo7jzdVZDyV6U9Qj0rpaMX/I2Djsnd/F6QuW9E+HMDO2a
X-Gm-Gg: AfdE7cnDMa4jXJgYIMUgKIyzQjm87aD6fqg3iUTYq24SMUrZ7eMv98tslVdPA5RlNPw
	97UFgA/xQ2sAQO5jaHZbY2KZ9t2DP8gXRVfRuef1YZKy9tQjKiSZ/AMXdYAeb2YOiq20Vk1sYIi
	F1qcrHeYefCijzwxswr3LdzE6XBL6ArpAFlN3cBcOUGjoo6QibMfb4FPR09s0QRyEThKGZJ13rE
	A0mL8PRKc2XuZLz7Tss/oWWSJ+R33gAR2dBTOODPfgr+HHr7hNL4L4qn0lmoSHMYOBWNQ+nHP0P
	2MI6/54AmeDdYpJl0eo5R6gYJrfk3q5YwXNjEpjzXLzLlnB2dvUDxK9hSoufci2RXNA7Qi+fftC
	WB9fcW2PFj+M6YFIxdLAIF/M1noZHRHOGJTG9rcToTg2O+d0SnGxfNLUyClTataTaOJc4SLXw2/
	xxFOf2HaLh7IGC7o9o2U8=
X-Received: by 2002:a05:6830:2109:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7ebcfe54187mr7923635a34.1.1783672542710;
        Fri, 10 Jul 2026 01:35:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.28.215])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm5965718a34.27.2026.07.10.01.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:35:41 -0700 (PDT)
Message-ID: <6a50aedd.bb286e2c.394855.648a@mx.google.com>
Date: Fri, 10 Jul 2026 01:35:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8881913339933806078=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiuzhuo.shang@oss.qualcomm.com
Subject: RE: [v1] gdbus: Skip BLE random-address devices and remove broad match rule
In-Reply-To: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8881913339933806078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: gdbus/client.c:937
error: gdbus/client.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8881913339933806078==--
