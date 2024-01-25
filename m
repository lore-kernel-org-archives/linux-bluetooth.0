Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EB5B1FE
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190585; cv=none; b=a3MdfwyopnhvOGvTP98kF/KWbS0xoVMxmUaPnKDPz+EkS4+hLkjcwf+HJypF3UGmC6CeaagoLVuaXb2/tn3xDXZ5U8hMFycIaZc1/PBDvXGJAbP1wWHyNxCLA+1Hsv1crzjp5t8aEAr8UH/t9A+GBEDrG736pSxdAv7k0tJIHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190585; c=relaxed/simple;
	bh=/Obqk8JIrAYzZeGj1ojTYLasI4ftNgrJDtUeUqpCwZ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FEuz+8stdCbaeXNF4HnNqu/9I7voNPCaCKBdiiDskpDCXYhBWHtEn1bKbwsEmM68yZRK8CD3mc69JCwsZW1AwGo60GV18no71wE7xvxzSggm/idLzyE83rJibBPo3PBU4beDnq7hFrmuKn5w4qDWOMl86F3JiVWtl1rDTrJY07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAn2FeD1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAn2FeD1"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783137d7fb4so453913885a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706190583; x=1706795383; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XFBIY6imzZNhIhl1sq8zV7WFBC0Dm8nYZ9SVMRWZnGY=;
        b=KAn2FeD1UuPI4kMT5UeVJHRfLVgEmnyIlzj0SHXfkhtNHcJpzcic2TZJf+7zME0uoq
         2e8gz3RRZc4BvNtkXYUbdfGWjEotzwGBSA9Pz6I1t25Q99JzyyuO3e8DGs4taMZEpDKv
         xgfMafljZOhG2LnSAZLCULuGIU0owl4tAlTEDAWBnWLu7mDP2wsOQw+wUTAKYvk+VNC4
         zTPjtFiDdAQInZCIUuwdSKjU6CmlMbXtKSLP2b5V+6V/D6UMONSzFfrzNBSdrEZzWUZq
         6i2ujDxLiXJM0fcmMimLw2iZDgR4a7VbMdy+0lcT4Vvg/WFtmA3YYd6nVjjcpMCONHuq
         2oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190583; x=1706795383;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFBIY6imzZNhIhl1sq8zV7WFBC0Dm8nYZ9SVMRWZnGY=;
        b=m2gML3KR8tRx6JMM0lwARGG7LOYr7Z1dKXpQ1DCEjlZYdn3Lh0XReEftIiHrzmWE6g
         RzL1riEYHzHmGny4zPT+2CKwxPqG8FyZGS1qvz/g2153EbAWwjfNHq1rCZm6c3kt+D0M
         ZvB8V2yDJvN1CcL5yiDOg5bqPD6R3Accqix/2EuYAXm13UDd1zSXDjRGOTTxK8JxKHN5
         VpIACrlm/n+J+L4foEQ8/ZIv5zi22dkQUx2IeWyAX225CaQ0pInSFedO2Yje3W+rhorm
         ECg0McRPq0fVZ94FzsbIYs4MIu5KTBeihX/qRDovXiw1crWm1TypVUpeLh8qNIgC8Ifv
         0M5g==
X-Gm-Message-State: AOJu0Yx9ZbY/b0TN88GqP533YTqGJVjwuJ3lSjn6DJi9rsZKnlrvJCbY
	Rwe8+DlI5snd46zn939kvKyep26N44EoHWSbL22ox+YUWo09PGstqh/6CSsj
X-Google-Smtp-Source: AGHT+IFTo8m/fl0nV4yr36k4FfUrhoMpXOIIvDl66AGCNND5u4dteRnLVdWTKBXy2Igk1afikdClsw==
X-Received: by 2002:a05:620a:36c4:b0:783:2c5b:8843 with SMTP id cz4-20020a05620a36c400b007832c5b8843mr975999qkb.128.1706190582836;
        Thu, 25 Jan 2024 05:49:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsZNXpTYHgjM4oOSbBR3+LTtyNBSZBR6Ju/fjrQ8qQLNnHhLMN2BK1o2E8Xc4cof6rOqyaVQmF8tNYJnB8CY0UrQ==
Received: from [172.17.0.2] ([172.183.91.32])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a136d00b00781bdb17d8asm5068267qkl.118.2024.01.25.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:49:38 -0800 (PST)
Message-ID: <65b266f2.050a0220.39d3a.6d9d@mx.google.com>
Date: Thu, 25 Jan 2024 05:49:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8622161306716993215=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: bap: Fix update of context
In-Reply-To: <20240125125156.1679513-1-kiran.k@intel.com>
References: <20240125125156.1679513-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8622161306716993215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=819846

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.79 seconds
BluezMake                     PASS      785.94 seconds
MakeCheck                     PASS      11.37 seconds
MakeDistcheck                 PASS      166.82 seconds
CheckValgrind                 PASS      229.85 seconds
CheckSmatch                   PASS      337.73 seconds
bluezmakeextell               PASS      110.26 seconds
IncrementalBuild              PASS      716.31 seconds
ScanBuild                     PASS      990.50 seconds



---
Regards,
Linux Bluetooth


--===============8622161306716993215==--
