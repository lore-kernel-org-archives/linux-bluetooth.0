Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2328F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834812; cv=none; b=AHSFzsKdSAUa5uEGIxc04hjIFpvP8RzQYcJf/HhlAq6xgeEIGfv44pUu/yTXXbCOytFf7TtH1DX0AOPHGSBhtXD/ONajTUmeaPnSOieZIkukE4dMqp2yEibksP1V3dCbYuoXdAgbpEnbhTlBakoAsZp8Kj4P0q8MzzmQCLKn4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834812; c=relaxed/simple;
	bh=GkBxS1FpalIzX8aAMQNjWSswIJ/lBoMgRhcrPcFG1T4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RWWN90E9mCcCGoqY4lnoXXCdGZRUCscpc3vnpUCxFNjula2a8LAD3mDZbgyf+UC4WLM5Imvy4jbAO3eRIhGuI277/ZiRNPdbm8AslYOGFgrizwJCePBTd6DFNGnOrL+gX7l5UeZgunqZqN8LLSeviJAxVEVzdeZxCzfULL70fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHB9H079; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHB9H079"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25d0d16e38eso1740929fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719834810; x=1720439610; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJhlK71Q+3/Ls2MBC1xZZR1+7be9HQ6v8j/NJ2wl77M=;
        b=BHB9H079DEtpyRpaqCb5YJd1iaLpN0qLewk8SQJ8hOuyHGJhYTdkfa5Kn780OmP0aW
         mxm5fvPu+iypkw/Iq8ia6pd4enu5dITuerhKWDnQtk/2i8CXyqrpqeR0jKC7INZbnZtQ
         QUP2fULAtMx9KLrtcK/vHMVmNG3yldBdmrZk/r+hvem8ntIR3N62L7iAfuW7/SOALLRq
         emXat40Hwy11GrRe6xkXB6LYzPsrpOMXl11V/yKhvZ/BoACp0POsA+FA2e11Ve9QiNrb
         3cpA2v5jbpEMER8/YBRo2KC4NIBCmOISDz+FT5Ktzvcf+zvO+hLW+9SWVuHH+PzS2Bzt
         ZilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719834810; x=1720439610;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJhlK71Q+3/Ls2MBC1xZZR1+7be9HQ6v8j/NJ2wl77M=;
        b=lwDSuUMGwB6efkIluSv/X4/YbWhQA9ZDHDy1eZH514cxx8KE9O+QnQxpK8Xb5Axszo
         SI59tPktaUEzilZDeFvGiLM2alHVtU6VC4Gwhc0vVc6a74G9JO/et5YsoBIJgQFCUX26
         C1btd7OOqAcMr/JPekIVfkX3ecrkwBqDOhni5Dr8qPA6VYAEKiJnCyhu4r7lHjBbYdRn
         HN+6ywIvjOs/fnscz1YeVVHC5rQ2vybfkxFwrCm10X9R1Yc5wH9j5RpLitETyGiabnf4
         GYqaAAsxd/RO5ftGHTVbhIc7XBHfq9aAbQkFUO5jIDL8gTwHdOnapZKA+xnfqGmI2zEd
         Uotg==
X-Gm-Message-State: AOJu0Yx9KpZnZwOSX7yQHN/mBU8g6ZankvDu75OVSaFqouz8e9sUrjx5
	KnAKtnJRtLSGQX808SSDasLhEwsv7rAs2mhQyo2tK7FzcAJlNPi0KE89pA==
X-Google-Smtp-Source: AGHT+IF8pfiISuFyTOWAj9SHyGV0gQPH5lKAuf0lLR/S8JuzlR1GOrnEcR5j3Z/uL2ynuNR0mnS/ow==
X-Received: by 2002:a05:6871:71e:b0:254:783d:aeb4 with SMTP id 586e51a60fabf-25db34cd3c9mr4576398fac.35.1719834809884;
        Mon, 01 Jul 2024 04:53:29 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.114.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708043b7145sm6512445b3a.148.2024.07.01.04.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:53:29 -0700 (PDT)
Message-ID: <668298b9.050a0220.739d8.1fd3@mx.google.com>
Date: Mon, 01 Jul 2024 04:53:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8514475016493006825=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhaochengyi@uniontech.com
Subject: RE: adapter: Add retry when bonding device returns connection failure
In-Reply-To: <20240701101243.2902-1-zhaochengyi@uniontech.com>
References: <20240701101243.2902-1-zhaochengyi@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8514475016493006825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867072

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      26.68 seconds
BluezMake                     PASS      1941.59 seconds
MakeCheck                     PASS      15.25 seconds
MakeDistcheck                 PASS      186.76 seconds
CheckValgrind                 PASS      264.28 seconds
CheckSmatch                   PASS      369.14 seconds
bluezmakeextell               PASS      125.03 seconds
IncrementalBuild              PASS      1689.38 seconds
ScanBuild                     PASS      1091.47 seconds



---
Regards,
Linux Bluetooth


--===============8514475016493006825==--
