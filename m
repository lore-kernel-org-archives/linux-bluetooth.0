Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7D6BFB1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681762; cv=none; b=YS4rKUfyJQN/1Ntp6mgEdKY/2KjWNBb4D+fo3k83lfSsM2jwHg67k5uxZNiQG29aTJZsvA/YwQtoltWwUNLiCr07y5ELGGJcysNdiPtTPE8jsZBdN3AZRKFnZHms+6zlFvFFZCJHcHc9UzgjJrEj7B8X3B5/QsOa1HykSEqlvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681762; c=relaxed/simple;
	bh=sV01fmaxsVRVbEcgUkzVzRCl4KkxN5EuWr40VCQgZk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rv5TIBjN8zOHN+6erDsqL9JG4iqCAFQyf6Vm1u2hR9nDwF8ae/WWOd1AfMcioyaVBqA0TEXVDYwKRktvotqAYfX76v9XFPuCSr2JNOX0WA2nhLmzVmxoEr/8ZOIEByXKLcnCVaVvNsZdWc+r3YeK3ggGz2tS6YFnutxt7bTkDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThlxU99f; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThlxU99f"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-792bd1f5b28so545625985a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715681760; x=1716286560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sV01fmaxsVRVbEcgUkzVzRCl4KkxN5EuWr40VCQgZk0=;
        b=ThlxU99fV3WNwtkFdHBfNj7LEPGSHYLvWNhUCOZr+XVpCIwFAzDjgUtWB9AtWSN+Hu
         eT3QmOVbiXruLP6RZYamADlXpWu26ThNQ6+t9gQODF2oBYgxrd+Y9grbqJ770ZfjMtmQ
         LpYVg+PFazMo7eg4eiST7jcgBHNpTV8wegV8zYnIO8h/f+IfLNORb7QWwlH0PidklSJX
         G6aLZOfMcSGn1UT1ccRXaeK63ez6DVF+nJdfey0iqwloCYsQ0bpvgzzxTRQHe/g+/Q5T
         3CSO4m7lXAq9PE+8VOXrFBEIJOZQhbfs75LnauzvmCaqelzP92giHk9R10mAxUnKSBkA
         TJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715681760; x=1716286560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sV01fmaxsVRVbEcgUkzVzRCl4KkxN5EuWr40VCQgZk0=;
        b=PW07+WJ+yxvzMMec9hHkokY8ZGezNN6dndP7mpNMKhTaok0+vZrKybCyfDnJi5C7Uz
         pR8LL+N3+1FJuwZvrmPqwqtW57CnTpCmPGjRDeTq1AMs70YTknN51Rd5v88wcSx8hocb
         Kf+23oMDVhrnMSQq9vKXKhyfUmF3W0ROTJB7gV/hJ4FGccJS4vSJyGCK6ihanG2K2Hqp
         YzVPX6tmr+Lt45LVAKgEk9cBskxpRzOk+n1rugjSC9sXXBZMd2uR+HcBKgVelna5D+bV
         EUMhRgvUY3Ob2c90WyMQSsiBlRP62DMeodA2C5MG37yV1edVskAkh9SvJ8xHtCP0KkT9
         LbVg==
X-Gm-Message-State: AOJu0YyruoaZcoEcxj7rheiKV0PIoMeO74fhLMNqWgbpAgjI465/mApj
	cq9tgMFa0+8wnS4dRr785gGnf3w4VLLUXm9va/tPnAd1gAMAVg4AfpWwnw==
X-Google-Smtp-Source: AGHT+IGfPYB7bTfxeGirdGNTxI3+Wi4MjtAoITelf1cYobmJ5nEyRbDevCtJ4G45WKI9qFv8+rR6Jw==
X-Received: by 2002:a05:620a:4709:b0:790:d62a:da09 with SMTP id af79cd13be357-792c757799fmr1569575785a.5.1715681759727;
        Tue, 14 May 2024 03:15:59 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fca1dsm548951985a.92.2024.05.14.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 03:15:59 -0700 (PDT)
Message-ID: <664339df.050a0220.db919.0ee6@mx.google.com>
Date: Tue, 14 May 2024 03:15:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3010860877731929240=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, SoloSaravanan@proton.me
Subject: RE: Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
In-Reply-To: <JXwMChGqaA3oLmTz9wy26FlzjhHGqOWSO0HRbgYAeoy7jX3jcAaHmbwR6Dl-aMdkPzhdHO_kgV4MqoYahTdhn39W_GCOo-GbP1kU0C6kx2o=@proton.me>
References: <JXwMChGqaA3oLmTz9wy26FlzjhHGqOWSO0HRbgYAeoy7jX3jcAaHmbwR6Dl-aMdkPzhdHO_kgV4MqoYahTdhn39W_GCOo-GbP1kU0C6kx2o=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3010860877731929240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3010860877731929240==--
