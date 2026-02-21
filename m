Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6F17BCA
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771650347; cv=none; b=JErqxzKTthJ0W9F1at6GyM73WxB9GFs6Q6fQtREEZOINNHxV8UiLmHsOFb1UuLlzgpnJln+Z7jgxGgqC3jXia4qxvWe10yXnff6tQss86F+S9A6ooR42eXK8pbEMD2nzzv0Atx1JgDRRoeg0jDd2QCOwdmK3uT0dQs8iphIjLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771650347; c=relaxed/simple;
	bh=roE8GW4lPZ6FRSQAOMLeRnZ/3MBkMhS9P/GH6CoTLss=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CH/IFwaxSn8wkpzAxhcWrfkQMpGLRL76Qf/W9XB4H3OuUORZzSotUtFu511PjtNjsueqy7OKXkNDQ8Ss+FXhVZdpm87qU1yn3agIqzxEHfu3YZgSsj8eiUbuZmPpBsQpR/De8R0vCvr5zWmqWrSYX3bomLCqEl9JFWtDGLGxzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFB+ec0w; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFB+ec0w"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb4081e82aso345992685a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 21:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771650344; x=1772255144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=roE8GW4lPZ6FRSQAOMLeRnZ/3MBkMhS9P/GH6CoTLss=;
        b=iFB+ec0wK1Xb4esWgm5JwrYOpjtZ9h8/2R7Yuz1Csj2GhuX/NVoRNCRO1aTp1YZEvV
         H2+1bgrjso6TP/ANviQJ8txysVMryFvBybgXjo17NPZiTVHFbD26IPyyjYvE+rEZL2Wq
         dKNkFiGeaMGNG7kJm9k6GP7HfFCHOmKKmNQnuVuOY19xI21ICRkUMVpO/qW1fLLqE/f0
         HKeYAcIFzqxxa8eaWGx4IDZxfEJPVd48X83oyNG0C6//DxyIsIT8Z/q1nMJWh1aQYyRR
         CVOTScCQh3SWo/Am3bZANNJv524oYU3rVPmdTUezUfzyK1RpGrcS8BMWS0W6sZGQepDR
         ATVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771650344; x=1772255144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roE8GW4lPZ6FRSQAOMLeRnZ/3MBkMhS9P/GH6CoTLss=;
        b=X7mLS7VkD04OlHdCygIE4geydAixNRSxKmq4wDoYvNETRrrWSXZzXRHukvEbV1drHf
         NcZEdYzBYH0LGscxLlEKjWJrYsQ5pDKx536VpCGPgie8l7UfVIRkkqTQHhy/dkgC4dov
         dJCydGCgTl4ljEnLxGady1viyymB3grUgbu/dWvFeQuDBC3LFsaTeAtNutP41XDY+CRP
         DARSsV0Ec499p6IhV7isoQc9oCNTP9CbA7n0sXQx5pZCoQuTBG2u/xGAR5eJaqDFYDlJ
         ODGf/9AR4P2Y3BwXY1/l4M+KzNYXjfYJXIADfqTogLu5PsUadnmdrBAVGlTo9g9+9POW
         655w==
X-Gm-Message-State: AOJu0YzRPeZc3AojPfp9Dxm21yw3EJ08psJcE+Ddqysp9D59V3mVt6yY
	1m70HQdJs7AYe0vI/K3DU+Lf/dNXnF0YcIjnYaefHdCtZzrQVWwGsFlKFKHUYlv8
X-Gm-Gg: AZuq6aJjMBTXbsB4SERJTNMirSLL5slk6koyt240Z18HAGIz87Lp8MoOhbNb1Iz+3ri
	7FZaWfZGqLymRajwer/sFrcPIpG9o6Ic2wKhdtARXJL1ZZwTsnjEpv4R35RlUFynFVw9QbPOJA+
	nCaIuJKEylnCjOHfqwfzRrWDOv7Zy4IIqnB15Is4206FflA7cYdEU4oVn/HH13jlv3LIpAlao87
	6qxagqvOdL8XAcNpbqZ1xztsVRPFXZiswYRD9U03veOW7MS8AVw+uhnPl4OX8NxO/degXTC4XVl
	Kj+JMKJy8nSoXVYSMtm59dYKHV6iLwOxxJFzAmHaCf4ECGsgVLLXYfd+2Qe5YWqvNmxnHHezx4D
	UFIDO9OlWisx3VkfYPzF+IFHVn5K+jrJV1YITAUgXE8fuBrF7LBk+df832wvTZsdsO2E1EK6it4
	ndSY1wbofpe91Jz5NudJ2QW90xUL4kKA==
X-Received: by 2002:a05:620a:390c:b0:8ca:1c0:95c7 with SMTP id af79cd13be357-8cb8ca97272mr273408885a.80.1771650344534;
        Fri, 20 Feb 2026 21:05:44 -0800 (PST)
Received: from [172.17.0.2] ([145.132.103.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0461dbsm135725385a.3.2026.02.20.21.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:05:43 -0800 (PST)
Message-ID: <69993d27.050a0220.3c7be3.bdd6@mx.google.com>
Date: Fri, 20 Feb 2026 21:05:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2978850013069772304=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, git@onitsoga.com
Subject: RE: Bluetooth: btusb: Add support for Quectel MT7925
In-Reply-To: <20260221045130.19653-1-git@onitsoga.com>
References: <20260221045130.19653-1-git@onitsoga.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2978850013069772304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:765
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2978850013069772304==--
