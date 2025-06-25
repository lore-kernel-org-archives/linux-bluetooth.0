Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8711F8BD6
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841515; cv=none; b=Tb2IOV/6DH2jatWaBfiZ6PxgypRFgYwCwhHRphGEvqTTk0YX9YmFMPhfp/Gl3bk+ogieG/WUVqNyqErDldbgjubK8pt+83VkK8bRaN5nohEfqgm4TD4/2dAYN+dd1cgssZAkcRj4ctS8SUtFUP2kbDVH8HnUTUSbDcO6Gw5Y9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841515; c=relaxed/simple;
	bh=HvBPG09dQJYepU73JVE5PEPQChWEGPQvBNJwUWIl2LI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=feZs/sXz+F17pGHUXER/Zt8/85qikjVl2NtJweYjwv0/N3d96F1PPy5rDG2ZiQc+G55nu3cETGf/kE3+U2ptjXQTfYfwj8egCO3hNIcwzvqRgB8bfF6UhKV0cwvqRCxPc5BJBrdLVRQNfmHby03+iumL+bplZmsoVye9TAbCH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjZsZ7TP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjZsZ7TP"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a5a196f057so28997951cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750841512; x=1751446312; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HvBPG09dQJYepU73JVE5PEPQChWEGPQvBNJwUWIl2LI=;
        b=JjZsZ7TPv6ThwxNKPi1x8aZyUTli8bdG8YNMHkASkPLrVTqsR3kF6oiKFrsTXRU3WZ
         6lsrCee5/qU7yeGtTWQFQo7IHk74ryC3YQugq7zS6lUw/lotG2ltIGV2IJh8BYoSXrWy
         4v1kV8E0b7VfOlGl8ZnhxHl3MOQ77ybRixb2N3WJhZX4vxyISHfPFSke68sKgIr9YU+p
         gmz/pmc37b3L1UlR4SqdxIdMQN2k/yV46296qzrsWP7ZycF2oIw1/a9iwxpcHUASd9mU
         LGIFdCLh6CJ4hnQvKQTFUepWy5x3f9KT2GutS7LHFFdUq3IRdRew+2fenRsQbr4U8Sru
         w5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841512; x=1751446312;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvBPG09dQJYepU73JVE5PEPQChWEGPQvBNJwUWIl2LI=;
        b=q2dI0VcsLCuONXA6s5M/B/15X0rKdsqg2uquYHwMOmVTW2PU0z5aiH0TQXbaX3iEoe
         3Ur2ydR1ZE2H6FmC9rAUYkdKSLynUJlZxNYXGOpnDXVdRq1HfG+vJVXOSY7nsUiFtj5I
         uIXsyQ15/z40NhOundYWzpXgmhPB/XsNFCyFClzWGcaIOF7AkvHIye6LYfh3aV05gKX1
         UFX7IspysWGbCJ8utKVGIulPsZDIDnr1BRyYRtzg8AuaA3HLXGuH0GGyz6OZE2r9AN/8
         XdeTdXvI1t5JVSpxKYNXZIo9F+yy+dgSRUFI4ikCqA6JBdLgc6c1TtdD2cTXrNldZOoU
         AKdw==
X-Gm-Message-State: AOJu0YxrsJlFKtmcN2ExQftZEagQtOQKZfOe+//SXw9Ls/tk5y1DdbJX
	CmhUYyS4A0NLz8MwOH6dEeUcVmsH/+Siv101x8L+0/RIdNuOzD9W+SBbtLEIHg==
X-Gm-Gg: ASbGncvzybJRO65WvOZCLa7Bmlr6G5G0Lb7GqtAUVqycnkCPjRCjOgxf/Bl5Nx3zGSN
	hTI9rVQBNVLYVH4SF4MNDBMA59tnu6NbXU7wrVwsgCTJiCeSrGGFY7tHxSj+y7NHNFYVF9txGPz
	+s4/s+h8/yFlWCaEtC15iCxQSNGn6JUcn0zzmPLM8AhCOB8QOl9ceUvoUJxa8PoUjb/A6b3ugeS
	K8M/Va7nKO30e/7NeDhEvoptBIQib1WVApgVQGVa7DgJppPT8GG3jzjzXajC5Iyswt2IGXaT6S3
	ViA5nTp82/PrYnstdNkSsBauk1tWMlqR7BZ931MOSOVzWr5eCTjBX+Lw7lmJ42nkixuo
X-Google-Smtp-Source: AGHT+IG+hB2Tto4BI5tKvh6Oql22vS2JSjmz5L01UFp9k8nPVrYbZ0X26Ux9ynW0WuXxio32oGDH6g==
X-Received: by 2002:a05:6214:41a1:b0:6fa:c3e4:4251 with SMTP id 6a1803df08f44-6fd5ef456bamr29704826d6.15.1750841512361;
        Wed, 25 Jun 2025 01:51:52 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.31.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0959d85asm65709546d6.107.2025.06.25.01.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:51:51 -0700 (PDT)
Message-ID: <685bb8a7.050a0220.35ab8a.7745@mx.google.com>
Date: Wed, 25 Jun 2025 01:51:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8078359965246021981=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v4] Bluetooth: btintel_pcie: Add support for device 0x4d76
In-Reply-To: <20250625083901.822922-1-kiran.k@intel.com>
References: <20250625083901.822922-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8078359965246021981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:35
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8078359965246021981==--
