Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC885624
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996159; cv=none; b=HgWUn/6qas5Uzpbs7JKHxceZgb2BTdIJanPeZetmMtGzLAjuCSsNu3+wWH1o8UUfNS1JbZ8X2sVvku8UD1NX2B1XIG4Io5bMvtx/v1oXB555yQdyo1XJMZo7+1P7ZWPHxRWGapaIOClMDQcj0R0GqMZjkewinHKRhDnuufT1NoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996159; c=relaxed/simple;
	bh=cePSrVQ4eQGZNL6H++LpZh0xvcfLdnroZ9J8IIHlWEg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pEpjJGHDxX9w1I3Oomc7T33mCNHEJQ5l6z5KcLcw930QihzEN7Xgh4wUuJ3FZrAEZjGzhaO8ypt8FGfVCQi1EI/ga3Z125P5rXq/yMib/CvWdNxri6XGnS3qOGCa2i/uJPMOodb2l6P6P98DS/URMBSNk0Y4jWXDQt0SzHB871c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyTZcqoe; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyTZcqoe"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6325b04c275so51917037b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 01:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719996157; x=1720600957; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u7LSU95VUKNJ5eRALPGMzVPszQLBcVWhfrHurNRo1FI=;
        b=MyTZcqoepfc8+isejhHAmav5tH79yqoYZHP8S2zinWfkY3Vb0/j5vQXV9KL8gY/5Oy
         f1HftL4ozhZGZdQcA6ZL3t00fsKGBQIZ3BIewgzYr97YqyuEdk6e24/Y2a2a0gOYE8kE
         z7n7YgzLVJJUpK3ZhbvtYvKR0kvKQJskTVN+gOdPLCZZS89kVFWjad5NW2xn5TmkpoIG
         KbC/KGmx13sooAiYe9TqThto0GOzt0SLHfLS4Z1PdcYq25fmGjl0HqSuvgb5TPFstjCo
         JuPwyw6HNRFLT+F75E/AIlpaKcwwAaXegEJzRbTbSuPMlvpIESS5X0UsV23DyOcV55sR
         61Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719996157; x=1720600957;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7LSU95VUKNJ5eRALPGMzVPszQLBcVWhfrHurNRo1FI=;
        b=fuOaYGFUU/y5HAyuMVzJU7G0rl9egyX/vygSUBdH7raGv3FwjZnMW8YX5oxDQLixRe
         2obokk4urLhH4epQu2UzVLUopfXyVj37axKZQKvmqtp7O6zrE/dwEBaoZsot3ypN+Ztt
         Bzx+psCQIUabK0tmNeWLBMus6LomCqXUk/ap4x+VIFOylTlfPykoGhnHuu15ZvaVMzxA
         Nn7P49QHcM1UFPF6hYPcRUqO3/rrDS8zyQXrsG4yJAw6reeAM+s+WJp6JsQxGr4eVOaZ
         MPK8zEnjv93fAb6uvOTA03OAIiaLICqk2goQBhwS6Bjc12i5nscZkNksU1J/zqMl16zS
         3ccw==
X-Gm-Message-State: AOJu0YxhrZv7h+zbGeq82UZ14wUcBk6x6zLn6eu36IfLsGw6QNMMQWuW
	fLCHznCbKrC8kRw02sDAhi30muHJXj/QOMmxHsQdm8NiYwyGaDMd/9LqYA==
X-Google-Smtp-Source: AGHT+IE3B3Kps6XZTqvEKm40Okw1VSm7tThFTc3BecT5FBZAQyzQhPyu00zwUqfmDFN7gWcKMvh+7A==
X-Received: by 2002:a81:431f:0:b0:63b:cb86:1168 with SMTP id 00721157ae682-64c72e42139mr105766227b3.50.1719996156725;
        Wed, 03 Jul 2024 01:42:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.98])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9bf32b6bsm20475207b3.108.2024.07.03.01.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 01:42:36 -0700 (PDT)
Message-ID: <66850efc.050a0220.5f970.d788@mx.google.com>
Date: Wed, 03 Jul 2024 01:42:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8511597092743413871=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_prathm@quicinc.com
Subject: RE: [v2] Added BREDR not supported bit in AD Flag when discoverable is off
In-Reply-To: <20240703070220.15246-1-quic_prathm@quicinc.com>
References: <20240703070220.15246-1-quic_prathm@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8511597092743413871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867858

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      25.00 seconds
BluezMake                     PASS      1764.21 seconds
MakeCheck                     PASS      13.46 seconds
MakeDistcheck                 PASS      181.73 seconds
CheckValgrind                 PASS      258.05 seconds
CheckSmatch                   PASS      361.46 seconds
bluezmakeextell               PASS      121.69 seconds
IncrementalBuild              PASS      1504.55 seconds
ScanBuild                     PASS      1052.02 seconds



---
Regards,
Linux Bluetooth


--===============8511597092743413871==--
