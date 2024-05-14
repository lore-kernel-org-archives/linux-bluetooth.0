Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45533219E7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689334; cv=none; b=b7i/ZiZJ6EOkJ8q4JqJcwG4BSFdv8mOOz5ieoUZNW2mxgujeqfzTLq9nzB7qFzNVKRfaljyD9i9/egd3Vehra7Cz35HMVJt9g/Oyl2jwe4vI0s69B+4NB7GTVMXuIwQJFb+SX9k3BSxYw/jLOjsuLtI6mcWxmd/TVkbVlQUtSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689334; c=relaxed/simple;
	bh=7+gJvmrnwmk7Vhb1XvDPx0eBxXl/Werb/n+GsXCzSrc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZqpUOW4bPXQ5oJ/hXWdJntQAzUU/q9CL5o09NUngkTc4g+FzHxvTEw0riQfDrJKBnX77rwMxlp4qMcFL88Ut5L8ZGZaPEQjkMlBN/I4PsDYTPnH6QfTQONQZS1cccjEEie/utr+4VNeIRR0E5QDP6bRM9K/OjEvn78bGGbTKbzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHBiArh6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHBiArh6"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792ba098eccso477648285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715689332; x=1716294132; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7+gJvmrnwmk7Vhb1XvDPx0eBxXl/Werb/n+GsXCzSrc=;
        b=EHBiArh6d+lqIwagKaPUAFOVLFr02ij6pgYK8HV+dK/mpUqJPnnxXsQBEDzPAMEgGq
         OdYjPMSfj6aC7Iin8hjp/VtFe/qezZuY7W0e7x23sqQVJbVC5p250r7ptgjXNHNmAWab
         Hiq3PPG9OkRtVrAWSti6lRA6BMjwpx5Uyx3KuoHIGpJsWHMcGUaKuOCnU7qaM3nVfML4
         BOu/mtVSjFkupMGCOr8n4V8yzdpm0tJzgk1iHaEc71v36UELqa5KZP+OD5yHivfIURVZ
         dqKU/snYKRktQPErCL4T7FbM4Svs4p8hkGu+lls0aLVFmfTefxAcH3Yei2B45wytBJAk
         zI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715689332; x=1716294132;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+gJvmrnwmk7Vhb1XvDPx0eBxXl/Werb/n+GsXCzSrc=;
        b=hR1C667xEzOyMDUTHHN56LeHkjWwIqujOhFXD8enGr0XgcOzsRNNwqaE0h8gKC5Oa2
         +OpqUu9OK/qfkgI6Ml0fOC2LM+K3MArdW8kSxbuMWVsPgnrmjj6IZVljmhonlj9DT+g1
         T5Zc4sNstzu5p2SCdYrh4hOz9SBeyU/ZXlz0cJjpiOuHTNwZ47W6ZNu+nN18DKzh+aVj
         h+vHLfEZ5/iHcG5+MCdPvSwT62C1VWTL6Ut3mipUk/8iS6ai8qf03t6wW2QEPEmhsrfz
         KnuO4ACK35mK/bPn0NZLNxBDcoIC90upPiAeagwvGSjLo2BVFamwMdQd41+I14lH2CYM
         sxtA==
X-Gm-Message-State: AOJu0YycK5RVC8O9lNglfdaw/KP0+XuKC6dFCo/hemM3wCnOcjtp7hvh
	BMWFuaA4DmRpKC3lfKpKkcuXgCGU7ZdWEsEEEj1PGJhdMbaMFeP3zhHoqA==
X-Google-Smtp-Source: AGHT+IHY4oLUNU9yPzvNv/jaRnmwAqEFTokA1ORL7yuYrOR8qp/Kpb+jeFWa2EVNGYJObTE1oTnYiw==
X-Received: by 2002:a37:c441:0:b0:792:d298:7d68 with SMTP id af79cd13be357-792d2987e83mr957415685a.23.1715689332070;
        Tue, 14 May 2024 05:22:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.158.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2ffdcdsm559774485a.72.2024.05.14.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:22:11 -0700 (PDT)
Message-ID: <66435773.050a0220.1bc1a.1937@mx.google.com>
Date: Tue, 14 May 2024 05:22:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8544400116301296246=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, SoloSaravanan@proton.me
Subject: RE: Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
In-Reply-To: <uhH49zEgffN2Dn70XKLwBv4_mxoAaSY0e51RI-YzQGTMKyK_BRvH1sz-Fb92NGHC1g5i3DqA86ykWYBoG7lOy3QTHAluqbc7bJcnbGS-I7k=@proton.me>
References: <uhH49zEgffN2Dn70XKLwBv4_mxoAaSY0e51RI-YzQGTMKyK_BRvH1sz-Fb92NGHC1g5i3DqA86ykWYBoG7lOy3QTHAluqbc7bJcnbGS-I7k=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8544400116301296246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:618
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8544400116301296246==--
