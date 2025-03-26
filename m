Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA36205E0A
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010879; cv=none; b=Ak8NvlHTVVO1B6GWRYJ8afPZtOEBmuxVRvxoL2wOp3j+xUcjByi+CbQCC+BIoIc/mme77/7v+vHloGGxEqX6rCN3vYf0hUpti+rciogiMjMFSzSMe6i72yoOD7sjRQKPmBQDXWvmWiSreXRg6op5ZUlbr+FNhgUrClLQd57pyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010879; c=relaxed/simple;
	bh=4jgx+hBJbyqUGv1EcQL0UUr/l/BNm8qGGdkBqqmUdGU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mDGWHxjiupxyivYbG8mAKuwTggmwaHa9gi6iunxnS57hil0CZAKXLMstDo255K/G/1yur7k1Dl2qJrSUPC6afSHjKtEyc1bXcYKfBjQ/yz+gCM8c9u2kfWOWvJPU9aqheHkSRMkJy/oHmCR9mFXw/LjTp6LnQvbWlwlg9L6J/Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqbKzURy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqbKzURy"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c546334bdeso11902685a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743010876; x=1743615676; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4jgx+hBJbyqUGv1EcQL0UUr/l/BNm8qGGdkBqqmUdGU=;
        b=EqbKzURyGNkOnYGAsJv2E+FrQ8ST8a7YSINO/KBUSuTghDMqPaoUZ0vDSyZKO8abRF
         TtfH7XYHSHI9wAvveLH3P9tV32DBo7o+q45gpIq1p5QxVn/xOu6/7xV/Biz4+NKDIjlN
         8sCTys6vXcWnuvMAI1bPMf0ImaAOj0tLCEv3M80H+zZ8ndP6YOY3XMCAKsolfrrabspj
         ykCFORN7tL9hyOBcMoEzg/oz9TLOK7LcuEZMrMTs4xUsdnyBCyVz45qdu55T4OxBvAFt
         rGiGHAuMh4xHrAVlTlCVUO8Tzfuytaj+5ybvGErwrp8FHrtpUgms7k2U+LhN80SrS+iH
         ycEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010876; x=1743615676;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jgx+hBJbyqUGv1EcQL0UUr/l/BNm8qGGdkBqqmUdGU=;
        b=d6wckySwC94ImNAjuLjN14Qd1CWVBWzujfFaSrzmpYRQhSYJpXGE7h85GU1uuHgA4D
         EPrgPzmij9ygSs5MRrgx0omSVrMH8pc4sT3B7KyRARHbsS6oiCKc/1f3+Ni+UmK/GDkS
         db/sa36vxYNTp+4IDSJ1lsuE2NxxiEya5Ccvg6y4OKOySUfRamsw+SWp0O9/W4rWG6xg
         rFpcC5MQaH30YD/O7Jc0im84pVRlvL1ltfM8edI7OalveAPxVPfsonywXIXuMo6T3v0T
         0OL2g4OGEZHMwubjeqoh7gcSmBlB4j39ZV0yYKUo1v7ZOwG64c8px19Pcgltykpb8osZ
         QVmA==
X-Gm-Message-State: AOJu0Yywdm3NHDv2kECOmyC1JZiiN0sJ/5XNPfqa7xGSH83cMLvWvUbr
	ciNgGGBQ3GlIea+73ejLTDRfOTs1+Syl6iDiO6aLsNKaZR9YQpmFQ9d/ng==
X-Gm-Gg: ASbGncs51V9qnU5EsYIf/SrBNoSfO7DZ6rl8RgFWQUV4nAl8TW7bnjfrrlZk5lRmH7w
	cQUo2Llwb0E0EV3AeR6097Dn6nwfh/D4yaognGuUF0pWOcJTkFabvVJicbiWBLJhxRGlrG/EcmX
	CCubz/eMKJ8iKAMUBhykKQrm5yQzLwrSAmFVuBK1umnzQeXo75taUmJGmLDXIyuKvGQGY16Dmng
	eItD/bNNDuBra+bnx5oH6F1P5LVc2+qDckwjyR5QH/D/FgSVhPDmQfRRjFcsOIItzanNbuVb2q2
	Tsu0sy4Fbh9J+pai1piWD3gsl8X5kPSG1cZpR16++boUNPeTlQ==
X-Google-Smtp-Source: AGHT+IGh0Un8QeyvrE9iIuaart+ljhHfIg2k1rJ/E/brMJiUiH0w6hagTItl5Xn0hQKwH0EZTERxtg==
X-Received: by 2002:a05:620a:6002:b0:7c5:af76:c827 with SMTP id af79cd13be357-7c5eda13645mr85984585a.30.1743010875862;
        Wed, 26 Mar 2025 10:41:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.78.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b935596dsm780936085a.107.2025.03.26.10.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:41:15 -0700 (PDT)
Message-ID: <67e43c3b.050a0220.1c2a52.35ce@mx.google.com>
Date: Wed, 26 Mar 2025 10:41:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2196802902853837458=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mhreh594@mtroyal.ca
Subject: RE: added support for PRIME B650M-A AX6 II motherboard network card
In-Reply-To: <CAF3zC4z36GuA+vZte8TwLSfPEe9tZUUbT+=GRAFtZvt2g_Jsnw@mail.gmail.com>
References: <CAF3zC4z36GuA+vZte8TwLSfPEe9tZUUbT+=GRAFtZvt2g_Jsnw@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2196802902853837458==
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


--===============2196802902853837458==--
