Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C713CF93
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685094; cv=none; b=dJFMELlh1kXc/LWOdFoR3C1/dha80WiRXly/zOKXl4KQVr6r3XilA1GTCSO6Gynufd4mCjUvFYZ3bry0ZNrcuLB59YKzCC1A+548s5YE2V0LtoG2rKr7i99UfWzelkdhleRrPjItM3hx7OYIoJl/8oTDfHwJLbHalwcSHQkIH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685094; c=relaxed/simple;
	bh=AVxxQmtiMw58GomTLJMnPVby3KLGBbSrBaEC9W9qtL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jhepSMmqaSpdzu4/XNegEQRaDSIz7cp9LgjNs+V7I9uFIBHyjfp132tlE4s1jLAmXNNIRvUzQVTCBzHJJCef0+XyyhKgsMVeo74yyfY2W0MrvHcagLs3biBAJzR369kNitSL98cidOQUIw3JUiliKg9dWn/87EQbvNw59zdfH8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdbkkUft; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdbkkUft"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso4292195b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715685092; x=1716289892; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AVxxQmtiMw58GomTLJMnPVby3KLGBbSrBaEC9W9qtL8=;
        b=EdbkkUftvcDWx4gJ5KApMPWyI2hYulxjuyHRf2PkNfpoXZSk7PSaxt0uorzlsh/S8r
         CqoVBtMv/isA7O/nDTXeHA5/WoYfoXNJcKqJC4QVfBFcrzZF4yNXI8Z9tzCTj9UpnnaR
         /PbVJsFiiw+1fRZf6xR54E8JRBu2X4/5wTZtfT0JN6+f9wpRzSnYTBj8Fcp8taLfjRAc
         135bF/Et9c8lYohXHp8B1iJeUjGVEflPneH7ZQJQaWdR8gNxUqCRu1TYcFNFBAKZDLJx
         OBB6zpRVkFbXoAhPmpFhnz5m8/3kqLCTb2WxDqNa6GSm+VMIZN0AEbGCGCGOGm9k+hgi
         EErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715685092; x=1716289892;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVxxQmtiMw58GomTLJMnPVby3KLGBbSrBaEC9W9qtL8=;
        b=qE9fy7AJahlJ+w7ncWSSHQOEeMZxi1bqN6Uiw7MGcKnIpQQLqwezOqo0hchOn73sZz
         EvBzwYUr0EJZG1+4vgi+9p3H1nIAv83EyWyHPJDeG1oRJoB5dvpQLExCHwKWl9k/i0ZD
         M5ZqDjlzXnkJf6bPtMXiqZq7fpCZCPqXXX6kcR1GNQbF0V0yUxbQLF3FxZpnxzMbyIb8
         K+2T88GHJ5wnbwdaOzcRozoLOz07puupBOXxI6ROPw0Febwm42F7LPMPHQ8/+64bUUvk
         dP9F3jQssImyJCL65rVLk1wFiU6dWBzHftpq5hKTnmzdYzOvdhl1lFFlsCgNQ4KloqYV
         R3/Q==
X-Gm-Message-State: AOJu0YwNWK2bNZgWiAvzKfkDwZrDe0n+i3Bf9C1gtfXsiW6r15Ft9ckC
	z35zYfCbrlO+hP3337M0gO0jOXh78tqzWEDTeAJb6vYaw33mgT9/zJw3Ow==
X-Google-Smtp-Source: AGHT+IFZ8AcTQTTspEtDCZjqFQpyIVoYTFuROLDKfTgliWv5HwVldZDnA/IoAbjAIJ2O1EjDG0u5pA==
X-Received: by 2002:a05:6a00:1a8e:b0:6f3:88c5:fed6 with SMTP id d2e1a72fcca58-6f4e02d341emr13993592b3a.19.1715685091838;
        Tue, 14 May 2024 04:11:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.152.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b26593sm8871112b3a.201.2024.05.14.04.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 04:11:31 -0700 (PDT)
Message-ID: <664346e3.a70a0220.60909.6e96@mx.google.com>
Date: Tue, 14 May 2024 04:11:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8670074523521803822=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, SoloSaravanan@proton.me
Subject: RE: Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
In-Reply-To: <5aweNli8mhqprLPB0O418QX4MYtylYw3R6Zaof-xBxNqcuBY9WfT23vrdlrPGSDs2lksHC0iwXGzyVQq91VRQ38hJOecQZX2c_eEqk8Snz4=@proton.me>
References: <5aweNli8mhqprLPB0O418QX4MYtylYw3R6Zaof-xBxNqcuBY9WfT23vrdlrPGSDs2lksHC0iwXGzyVQq91VRQ38hJOecQZX2c_eEqk8Snz4=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8670074523521803822==
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


--===============8670074523521803822==--
