Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD5314B8F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470383; cv=none; b=NpcpTXML8ZCebtYVOVbYrzc3ggRvj77CaisWBHobOfmWuoJn8tcPXZ3YHa8N8Txg81f4fXZNCbs8TorfUK5J01uMBWDSdTT+EITgIXbE7BOpy1ABydd1vi51PlBPNMwFH8SQOjwGL+3jH1m5frsXji3mSVzqPMt62QgpuyoVvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470383; c=relaxed/simple;
	bh=8SsPZX8Blky4X7IqptVuABphyu/8qyaMI0VokJ4iyEU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SwzBlogS7QsfyUjN+Krc2YFlPDCkkpwGkmBoQBvRImmhdDXxamn45AQTJkPSvyjm61R94rIyT1YSNSdpQNIpMQQTqW7Z2a9ZAdEfu161er+Tmm+5K9C6SvhlXYnSqXiAgdciK0uTo1YOxlHvCkIHK8NE9U8FM28C1m46PbRlswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9LG9+SP; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9LG9+SP"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6dcc22cbcso897432a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780470381; x=1781075181; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8SsPZX8Blky4X7IqptVuABphyu/8qyaMI0VokJ4iyEU=;
        b=I9LG9+SPGwRxjzgdEO6gwstZVbRRw3QFvdzAmHHFcW5xxm2WmVKQdiivTRjZqoUL8S
         m+FkEmjXdZNC98Nnfujp6FLZHFY0B1uFy9mG4IfzTzgXq37MFdJEU+aPTHxdsq3WSvUY
         ctrMUxMwetQRlcb9GBtDrMj4g3CV0nzFEetn5BaqC014W5nudo84HtnmyPBj6tS5cKM/
         IPRiFqR80zb4lVK9ZF3m9iuXY7uO+5FISeajln7lcd48uvr+iXFzvLm/KwxJjKp7Q7E+
         I0EblNa8qbN2Vi4yMR2xvDvxebv50Y7GrFPGhG9fVZFba51cjBc8hA4KN9eVx5zxtfm0
         WMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470381; x=1781075181;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SsPZX8Blky4X7IqptVuABphyu/8qyaMI0VokJ4iyEU=;
        b=o+tiy/fnR6woZTo8MK1DVcQu897SgYhmParGqPQpqU97qb+I7sCA+GW5+hDVgt/qeH
         IOO+4/O1EBrAG73NU9tVjp9gHPSElDBABQTx+hG2pT8zmRsSK+q43V1InN5hPQBGHX09
         Y57biVm75GQ+6DR/+/VvDtRYY0h5LXJTg9VGIV+9z7p3PlWj2e9zmFiQKJUpjZ852rwx
         CESeu/XSBFsGVS6JKon3AoaVjQxVfqW48RdQmSwiaczavHt1vvMZVMuU3cCq9rjZx3O5
         wgVNQaKblNhJxA7vXBJoHDBOpM9TuwfNztUxD+L+Bj/gL5V7A4UltnTKjuE0joo9DJo2
         3iwQ==
X-Gm-Message-State: AOJu0YxmafOoQdN2KmLj4M4zIeV04HDjqMcFutpyWRXTqs0bEWIX226c
	07pfaJgf9iNjaeRR/A3n1ecktEedQ0PFRevfQk/Zkn7G6CiX/ozy4XctZzBVz89J
X-Gm-Gg: Acq92OFsaaNX/QwLZwMrnRo7/6JScmw5ijuQ17azPUhe/oXM8J4eHnwIBfYoVSywCXh
	9X20x1YtLBtfO5/qjO6v31Fo71ehtstBSRkLLnsoS5aUhq4KVVuaWKTn+4XXboA4F53icgKjati
	L8SPiRncnG5aQ/zNPOjwyPhRYVT7Z7LMLjCbMfnIAQ5knEl6RBG+y5ssrtwbR67VGZts3XkJPAg
	3BplT6HP0l8LIh9U0nyb1O8EHU84hNzlPb1+vynb9H/utB7lHdiYSWfYXVFCTHcouoIuPMCu9xr
	GJFtYT+xpn+clSmqGoRLeKUX+3UB+W08An3BVn/Y/R1xjOdq+jj0cW57CvfqmaDGXLRI6nJiME+
	2yW2RGUeV7i31iginyYIHyG0zq483dzu9eljiyg/9lGPG3vcKl1c8zUV78E2aGrMQIDCg8SReIt
	x8AhoXcY8kSrBevE4KYBWIX/HTJred3x/5B6ex3QAU8w==
X-Received: by 2002:a4a:e746:0:b0:69e:41d8:f7e8 with SMTP id 006d021491bc7-69e47e83b53mr979875eaf.7.1780470381260;
        Wed, 03 Jun 2026 00:06:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.243.102])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8295aaasm1998429fac.9.2026.06.03.00.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:06:20 -0700 (PDT)
Message-ID: <6a1fd26c.2b222633.126eb.9af0@mx.google.com>
Date: Wed, 03 Jun 2026 00:06:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6029987773826653354=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jaggyaur@gmail.com
Subject: RE: [v2] Bluetooth: Fix Use-After-Free in hci_unregister_dev
In-Reply-To: <20260603043925.228091-1-jaggyaur@gmail.com>
References: <20260603043925.228091-1-jaggyaur@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6029987773826653354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:2698
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6029987773826653354==--
