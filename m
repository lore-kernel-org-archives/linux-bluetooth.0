Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0057137C5F
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237393; cv=none; b=j+4HfynSY2n1n3Iyj8FgbMt+OEYQdaarcX54zN20h0BUBB2aLjg2aQ1JNO85crsd5Mjv0DFmvjC3J8ekCE7WInKZDWDblNSYqHX7mPPoLbZNH4RyESgunwbvasr4lUbYrUVZB5pz2bKmh9YUpp0cE5s6OxzelVfBMdlq4LASLJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237393; c=relaxed/simple;
	bh=6Yu8b/M93kqaxKYYJxyilT0sMx8xSryYUSDpVlyMmns=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cCw+CPlC7q5oNBrCcMzjoPm2ljJnyTy+dSAVLR4faP1cHQCVFgBC0qFsjzXP4vGd1csF1p9v3d/8iWGbWJyo219yL0VFs0RNkDOtX5hfv4xIjJIbwm2C13N72ctSFtgbax3Vjm5mN44GoxEBXoCrwbYYYNYw9S7Z9kY0DCQTsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbQ5Y/uZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbQ5Y/uZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792bcfde2baso270110785a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716237390; x=1716842190; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9fI4wABJ+LcTyn5W819LRflDyS6ayYeH7A5INfMeew4=;
        b=QbQ5Y/uZhS1p6eyfQezSyGqVzAAWhVnuE1GooXelkQUWbUpdCWPnNXHWBO4FUlx0Hl
         GOkj4wxJDFuUe8E8ct/0qlU2KuCo6xrXlIhvSPFMdxvNPixYIx0uq//8XyMagA0gKOKW
         CXo1hUW7Bnw7kNsdMvoOtOFz51ac8Bf9O93bxkjaTU2/tbr8OpM/KjQtifJdvW7wcc1j
         k9EFNUzv/7cxT6g0XeLpTtynaOPfAWtJ52GRBNoJl9gnL2CyCbw8LC2+n7s55qFOYdkk
         Uu2lOpJ0uywNK83u+n+OlvBt6DXvdg1cUK9mwsSMGQIvj6GxzXJtTLW7WExRXo8JoZvI
         I+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716237390; x=1716842190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fI4wABJ+LcTyn5W819LRflDyS6ayYeH7A5INfMeew4=;
        b=GMoNbxALGwuAaSsc1mizVynCU7T/yGlcdZAGvaZRldthBh6DvsCGPZeXJZBqaGjFBk
         rz0xDQs9tRRlnyXSZrQT1NOuTbXEUN6f+co5YdG2Mk4ro0w+0eX/Hewt6v+i6tk8xowc
         oReBT609a8gaq4iuSCxbfKwAujWCNeN+Psnqw2ec5E/UUWjcnH06eONLGNT1mgh9oRBR
         kABX3AnUqMi4kD6CzZdFbfFJWR7LgiNelNz6/r6D3X7eIVu1UQlLSWvicoTnXza/LQkP
         0W/jP2vJ9MLEEx/jidf3KgRI+Sk5wKrHXweAHF1SxN6O2JlK/jVLrc7SDwjnrJcp8qRk
         KkmA==
X-Gm-Message-State: AOJu0YzbPakjkvzsTwTZ03mQTw+atgUY5SU9tAe8PUa9dwnAMQc6i9d0
	skTaZBcwZiNlrTahpFJvpYab66s+TlIVK4V+OO+XaLNG14YcytjmDyULmw==
X-Google-Smtp-Source: AGHT+IGCa9Kl5ubkpXjCvo5rb3DsaROtblqbynOTTocyLXTaSerFuf1/YZVQzZxqbHIeQ2CcpWVq1g==
X-Received: by 2002:a05:620a:4008:b0:793:19a3:6f8b with SMTP id af79cd13be357-79319a37525mr1111571885a.74.1716237390500;
        Mon, 20 May 2024 13:36:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf278026sm1216076985a.27.2024.05.20.13.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:36:30 -0700 (PDT)
Message-ID: <664bb44e.050a0220.f56ca.73ff@mx.google.com>
Date: Mon, 20 May 2024 13:36:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5161490156971733442=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] device: Add btd_device_get_icon
In-Reply-To: <20240520181439.1407634-1-luiz.dentz@gmail.com>
References: <20240520181439.1407634-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5161490156971733442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854479

---Test result---

Test Summary:
CheckPatch                    PASS      2.04 seconds
GitLint                       PASS      1.00 seconds
BuildEll                      PASS      25.00 seconds
BluezMake                     PASS      1721.03 seconds
MakeCheck                     PASS      13.21 seconds
MakeDistcheck                 PASS      177.47 seconds
CheckValgrind                 PASS      248.07 seconds
CheckSmatch                   PASS      352.51 seconds
bluezmakeextell               PASS      119.33 seconds
IncrementalBuild              PASS      4586.72 seconds
ScanBuild                     PASS      1004.39 seconds



---
Regards,
Linux Bluetooth


--===============5161490156971733442==--
