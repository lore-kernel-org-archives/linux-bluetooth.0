Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC544DA00
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719657595; cv=none; b=F9uctpW83t+kuRPtRrpxzmutK1RhdSlzGI0wDHATayl/IPkkaXx95ayHzbEIh7eqaAWNYGRv8nHTmzYwmWRoGZ8M0s/0BK+l0ABAUinhu2NOh9DDQD9MnvL9h9k15z3pb4lH2/yh9u8jcqBMO3eZlNTWBEEiYbtYqWmbY5sWBvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719657595; c=relaxed/simple;
	bh=xz2j2zJE4YPkRRPhhYyT0jv7SMNKqJYkdCuaFDNqRCk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eOxs59HwCdibJ24V9UY017ZwcU9A7yFNrZBmrVAPFNaTQweS5K+03FDIdqvV6W0t8mwhtiFd4mI2AvUbAYT3KhNsWrBP/gsOV86mTd7wYmBHVxWUrkhXiCKq3QzsoUciWcwUWQgW3zUdNVXoQxnHYOOCsyN50nrQAH2MAKY8Wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU13E34V; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU13E34V"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so956534a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 03:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719657593; x=1720262393; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CEzVuNOjQOA4XwNl3LYT3605CZfvBJQPLS/qNkjlaOU=;
        b=lU13E34Vzy/KFby4F+QQZXr3r48SolQWcdOdryT9icaBSVg1oHEN062gG7rP+4h1G1
         fo90D6A5Ws60wiC5VpS+lojXCSri2QrKfndt/gWFmn4FbTeQcP3XWLULHWl5BBO3ZZ3K
         YaSZTzMAr6CfyyjDox9l3jXe4kcFLbqMT65nqqh0a2d8p0B6BRqackKpW+6KWPzeCzab
         rZSBrcqOLSyfQjjVTKHXXKfoI54fZUtb9qAdW4HxkoMIYEe00QDcLIcthfH628Fwt0nG
         GvKl+P76Dn/2xRzpXmUAVqW8SKuwtgulNJ9rXB9mn8Sk6fZW82NroZVxFHc432R2+7nL
         nEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719657593; x=1720262393;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEzVuNOjQOA4XwNl3LYT3605CZfvBJQPLS/qNkjlaOU=;
        b=NeZMd506xTyEuW8z+Y+ly4zEkmbeFoyl1qr+z6ehIPOnJnaTu//vbVk3esyUnp7NlG
         fsoCXJLmMAHXUraULV6w7bLLdKNLXUdTwgusrpIXWw25Hk4y3Lz/uJdrXsZP+Is81Q9x
         hnQO/6Ek46RWVyz1owI24kEuENF0v+lUTRjKdSHfYNQjAy/Iqsg4A0DhfKFTKP2N8gqL
         Qdq+kssBUYIHfBRF6qB/1ugGHaV42cgWuvv+j0B6kVQbf7ZQhSds0gJImnR/z81HmNC/
         Ix7NEGysAjAdh9C7xz9RWQgpM19TwTSdyoWSBitQu5wtEUfTOGUWZzHFghR/xpLt3S54
         uiyg==
X-Gm-Message-State: AOJu0YysSuO+xPcLe4asqpOya0Yeqh2Jk7jUL86h7N11LDucNeikAH/N
	32uHXzfnKs+yT6OPP2rVr8cm0EHYrdzjglWwAftD8k/py8pIg3X2koJIgA==
X-Google-Smtp-Source: AGHT+IF9uS7wiCr8Jp6G6It3jKRKpsE+283hdAwBGUNVu894OWlDXtHw1Id9IbYiFzEVCoAh4PoJdg==
X-Received: by 2002:a05:6a20:cf84:b0:1bd:2d53:35d8 with SMTP id adf61e73a8af0-1bef6216e09mr931956637.49.1719657592783;
        Sat, 29 Jun 2024 03:39:52 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f04sm29775565ad.13.2024.06.29.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 03:39:52 -0700 (PDT)
Message-ID: <667fe478.170a0220.eb1b0.9c39@mx.google.com>
Date: Sat, 29 Jun 2024 03:39:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0654053275153846726=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] avdtp: add NULL checks to avdtp_has_stream()
In-Reply-To: <20240629083619.11804-1-r.smirnov@omp.ru>
References: <20240629083619.11804-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0654053275153846726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866803

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      24.32 seconds
BluezMake                     PASS      1685.08 seconds
MakeCheck                     PASS      13.62 seconds
MakeDistcheck                 PASS      176.12 seconds
CheckValgrind                 PASS      256.04 seconds
CheckSmatch                   PASS      351.98 seconds
bluezmakeextell               PASS      118.74 seconds
IncrementalBuild              PASS      1385.55 seconds
ScanBuild                     PASS      988.63 seconds



---
Regards,
Linux Bluetooth


--===============0654053275153846726==--
