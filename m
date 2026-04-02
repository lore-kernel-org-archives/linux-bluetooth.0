Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C1378805
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126944; cv=none; b=QosPkL9F7cUUHPyIxTHpkXr9iqzEWWMHw6w1raZKVJ5HsDyNUxa/xFmCyfg6OE11bfYw7owLOuSBVkbK8Re2LCRtKlF4l8zuFiJ+HgXjWNTzCTGg+r1zZfG1UTHs3WDLjRuQvp6m4l7BLFNULlZ6jlRJgDHkhPdOkbPr3P9ilJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126944; c=relaxed/simple;
	bh=7yLSRLpUUAkheudIDhWu4ZEIsZ0TVAF3ReXrKVMJBjA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QzVsGBVESd14E+y7XORhNmChTaPGyZua2T1t4iq/pm257PIW/6Yah5MeNmT1bpyt2GCgNOo1AnxhUXq8AG/je+fDQqb/IhIErKE/ZQzVWibA8fGtL+5lgWgWnM/37JJPSQPV6Cn0RjMbD9LKsR5gUIPTesKPjwBwCjT55VhQpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D71VVRQ5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D71VVRQ5"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc5941028so136706085a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775126942; x=1775731742; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yLSRLpUUAkheudIDhWu4ZEIsZ0TVAF3ReXrKVMJBjA=;
        b=D71VVRQ5X3lO3ExtsSMvNbWBdSCKFv35IfTo+p7Ib7foFcUO2WnfMn8aF/iSZ+7zf7
         S4Ty9z1SFC31c75md0P5XQQj0lHlvNb5nN4K0XLcpEqQspKhXERc1jrGL3IJkEnQkOKA
         RIDv8ctUOejPCVxmS091i3uScSouw7/wDeMxwyt/7h81AdDSH1/CYJxBN/gSE+ihnCIj
         ka/ie1hjeqbZXa5ClZW9nwmah8O1LiR+CmozC23L6oMVxS7wBP3WHhhq/mg9VFc0Jnu9
         HKonnOxo0gA+aXO9Cwf0Jjg1fArXSbc6dhi7Wf4zP51mpOBTppCKelgdME4aaQUYVoNQ
         OqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775126942; x=1775731742;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yLSRLpUUAkheudIDhWu4ZEIsZ0TVAF3ReXrKVMJBjA=;
        b=jWjV0pICv9m5XR42iaGD15x/aiqmglGyK8lWjNxLqChk+VHRbGmkSkWL0YtKOhw4QG
         vqOeWV6x6WSyN2qaOoqzNSHSp14FPtVcXLAT02vrFU4E2XTF6v9cSHx37WiWKuDtZX0L
         qQCEpfLAQ2Amao+YFlwJhkI2UeQGD4svmsnAQQiYmlhhA4qAERtEsrbBf7P7akGPsI1t
         ui6mXBWH1fnF0JTMu40Sq8BGd4judh8aP0/FP96rwxVxXRq0Motohq3DcuuvO7XxzFHo
         LyOkwSxY0wCrQB90+7/nRDZXqhdPzrHP4fz0PuuVWMqWeBXaOeiGORVYKfFBuFyURoXT
         9ChQ==
X-Gm-Message-State: AOJu0Yx7+Md+g8Ay3vrNg9neOfz82YvcfN3TVUFJddDq3QhLZGR3RgWj
	WbwbZ+4pFP1c9gad3s3b4xrYQVCuX6M1w5fxzRkQaM57t5nYkdI7okiAaQCgGg==
X-Gm-Gg: ATEYQzxr6J+X9YBdWGM4DQo+Lqse/Rf4hLqaTOJ9Ax31ck9DcISfh53yQC155Gy9DMz
	ygz6DNqw0yyJbnou5dz8InzZxPjA+1JKfp8/uu+5RDBrrMc7HaJ2p9DVZFmYFmqvzdS+JLD+Ki6
	jYeyh3s0fqgQBX67a4Iqf3/9rzQ2JG4221OV1Jl7Agb7L5UO32IUe/RVQOHdz4L7Y+45wLjfDk9
	sJRvYSTZlRJ1CXawqg7lnm+DSUgGfQ9hCYQBqCgZkmq25YzazKbxsv8+AS7DTOUs0kwCrc0i5Au
	pTFtWBCuZAgXs5XyWH1T0Ig+0rXY12QJ9y71f1eTkFTIlq28B/Bbavg+drNKfZujDUw7kPp79cY
	0PbPd7CxAeU3iR7JXJVcXlX1Ex058HpaPHnaucYSAGIeehmgydxFFqsNncmEPUKoaQziKbPEuuF
	ZX/9U7oN8G2gJkGhDWOoAM4CANixHL4kr/k93lGzY=
X-Received: by 2002:a05:620a:2590:b0:8c5:3869:3f2e with SMTP id af79cd13be357-8d1b5b9523bmr1027601185a.42.1775126941847;
        Thu, 02 Apr 2026 03:49:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.7.49])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8647b4esm186279085a.32.2026.04.02.03.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:49:01 -0700 (PDT)
Message-ID: <69ce499d.050a0220.b2460.0f8d@mx.google.com>
Date: Thu, 02 Apr 2026 03:49:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3977173026065964685=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Bluetooth: Add initial Channel Sounding
In-Reply-To: <20260402103900.310778-2-naga.akella@oss.qualcomm.com>
References: <20260402103900.310778-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3977173026065964685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: src/shared/rap.c: does not exist in index
error: src/shared/rap.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3977173026065964685==--
