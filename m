Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1447A60
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121947; cv=none; b=niN/pNiooqMmN2yqYzomOw3267NZv3dQsrSM6zDCr76ZcHo64jwGMFMm/WiDYDY64tfG95gzxeg+VjPkZhyJ3wY90K376mtBnhtHV+V62HWZWKjb3Tzp1IrcktLw6zUGy8T2UAFXkuKD85MIjU4BfLp2nFoV4Vn0BJZwPB7dF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121947; c=relaxed/simple;
	bh=0kgyuEYdAFJTa4Z3Pk9F6twIFVa+TAE5A2BQzfWuQks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mtao0SjTnBaTr1yknXVusI3fArhqx5GQ7qvzxCRs0Zy5DBXP3Eo/vqI1D+CVMqtZ87x900OAwKqCgfJV4eUuI2ZYNiUMDryvDUB6yitV0FJpLMLrJA6lgFe+muUsgcms760tyMTp3CjP+GEFMhBqROuob4fFnGmWysyA/YFCGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT8Jjp4v; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT8Jjp4v"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0f43074edso1217375a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711121945; x=1711726745; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pfrZi2Vt5TXZWkblOvm400jhNOZPYG8U5A5I4F7/bDA=;
        b=OT8Jjp4vfdk5kfsgqHRNzek0QWikldyhJrskQakz5kuyli9Eqn7LPikyf4ihzIlRfv
         2t/JwEK3hbbwqlNczlptgcYzZWWw5PDUAWzfp9i4zdDWZV82OqTCdXsB/c11SuKyV+Q8
         BPR4nTcLlPvyTSD5hm+4baBfX+tNACvwjAn4y1FQ9mL8MVkOMqvmZukHyBlxTqKKuE5f
         sPGT7hOj6X3NeFvESVYlpeJbScgXZelS6wUC0KNho/z391JcNf/mV9ghMn6APfLZqxN/
         cu14r6vQ+6geZsMDte1Zy1Qy8Czg0c9Wp8rqDmTnR1nZN4YK/3U2bQEpM/UBrIoF3dxS
         wRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711121945; x=1711726745;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfrZi2Vt5TXZWkblOvm400jhNOZPYG8U5A5I4F7/bDA=;
        b=Qz3YsH7v0t7dZcoJS3PSJPk0EEhPTfMRR/qRQO1EufEkALu9YYilWwaD7+vNVpymH2
         eRnO0pzhcGpVbV/PraDDAzh4sG90C0PR9Cs0sp4oBxzhNjuDnptSLzG9qKVVtPAp5vkb
         hydT0aTQIu4rPtd5tcSCn989q6Q+JszE8vIv8dUB1gytSTAz8XAFAce+ws3huxjb8jMA
         YMAcboquiE3w4eXlhzgRlwNJQ5eGt2vFBIdSuC43sqx8j+0HxpvWW1v+hET4hnlYy4hH
         JMU1aWi4ClCn72doPPjbxjvnVP0E18DTiYRwkMgucVynqBwvWjxisNAHT/TPxdvoZ6lN
         83EA==
X-Gm-Message-State: AOJu0Yz5pfev/7eylPP+dj8GKJcitzKF1n5hSRtjsdle8GmXOCC7I/Yd
	pnTQDIJtkkAqMpcooZ6jMzzbRvx5OXeMERB+afK4ZtgxVkrhwupfMP47g6bf
X-Google-Smtp-Source: AGHT+IFq00PtZD7iS6HZa6IEBb8zGm6u5/ga/TdgiYy4Cr0PHF0hckUnBjgSJbhHnSrh0MxGCwekyg==
X-Received: by 2002:a05:6830:1bc3:b0:6e5:210c:5e53 with SMTP id v3-20020a0568301bc300b006e5210c5e53mr2706779ota.33.1711121944512;
        Fri, 22 Mar 2024 08:39:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.147.197])
        by smtp.gmail.com with ESMTPSA id z21-20020a05620a101500b00789ecd8e2absm857645qkj.5.2024.03.22.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:39:04 -0700 (PDT)
Message-ID: <65fda618.050a0220.d263e.7571@mx.google.com>
Date: Fri, 22 Mar 2024 08:39:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8372250768912923723=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bap: Fix not setting adapter address type
In-Reply-To: <20240322133603.43620-1-luiz.dentz@gmail.com>
References: <20240322133603.43620-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8372250768912923723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837373

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      23.97 seconds
BluezMake                     PASS      1677.34 seconds
MakeCheck                     PASS      13.71 seconds
MakeDistcheck                 PASS      177.31 seconds
CheckValgrind                 PASS      248.26 seconds
CheckSmatch                   PASS      349.49 seconds
bluezmakeextell               PASS      119.58 seconds
IncrementalBuild              PASS      1488.70 seconds
ScanBuild                     PASS      1007.54 seconds



---
Regards,
Linux Bluetooth


--===============8372250768912923723==--
