Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600737B017
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707048; cv=none; b=CMHVeqJuYHCQf3uKN66wMQOYZIf4IiglUCcoMeP1JDwnvm4sBSqI+utheKIaQXT0ZyvIr3pt9PbrsYP6JywpC0e5Cp4BtqDlCJ3uq6Gnukr/hUmaQNUiwZjJFtg0+T/AQ8na/FxKiD4oXE0Pr9VQYjVRS07WBp221ggf5RC1Wl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707048; c=relaxed/simple;
	bh=Qwf3wytIp2Rz6KwQYLdyoyvUMKhM8VoKPbR1VcnYO6o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iUKOQjt/88G+5y1qi2v5eGvyHlVW9gNXMwtZcbgI3X0G5EncE4g4lkqcSYRjTcspdDuCNZOzE9m7wv3o4Ezb1i9+NxvTazjHTgz2DLqNRzOWR5b5sBq2TvOxFvIvRJ1GUoFgYaLbqymvqYT5bm4uHjUdgkxEC3y9bUk/10uJq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4O7Iw7o; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4O7Iw7o"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-90ca6f20872so1223500485a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779707046; x=1780311846; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ovENKfrvTAdz0xnFh2Jyp4Wz4cnuMsGAJYJ9VS1Oqtg=;
        b=N4O7Iw7oq1lmqlXik5rS66VXB4yqhELexE9+w3ZLBGiKsCjIQQ4CW7BKhov8PDRfIl
         OIVyR7h2iFBITOrI9NS3Fmd5qWRL0Iv1+h8Uyu1RwsuL5iKAiDqsnvxV2e2B7U/Jpafn
         CtY6dHc2c7KleUT04y2S+QksEekTfx2s5LXoqoFoJ5AlPImBoZCuGaZBVAdy+wkSm+fT
         kCDB4GOeNZZbunO2rZJ1xjE18d5HPr1s1+ro14jIR1NOAdQKyYVuWY/izXT5uKrSYANk
         f8wy4yaBELw4IHMpUuyhoUeM8fC4evHNCmCdYHowirGPNHWOkMNNRSFGkZTu5n8xBB3C
         4eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779707046; x=1780311846;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovENKfrvTAdz0xnFh2Jyp4Wz4cnuMsGAJYJ9VS1Oqtg=;
        b=oZFRh1wAxzjMh7rV6bPSXqs/lkNiZdToA+6Q16FzD+h65vt4w8eiX56oqXuI3nf3ll
         7Fulxm32QwLdSmCTKMBgH5O6u8gmnB9eUshi5b5sNOGT4O99+jmjSeQTdc5pA8kPHfY+
         ww8DgzTypSnTmdvrAJgGirNSXE4qXlriiPqljBYeSklbGYHCW5sYo/QQM9pJ65+7QDKR
         Ba471Lw8HxruXQinmD6dnAThctTIXN5DIr9XFOQgxJVn8GQk/gh0eD5dR0KGM29MDtkV
         E1IMx4qtyJdwJmRs7guQtv4wfL9vLCSWNlgt5hyFUDt7WMWrwWLdLYqtIi+j984wDHRX
         7oIA==
X-Gm-Message-State: AOJu0Yz4cZogiXi0kmnkBgYQjNXquk/QVnZteH3G7DFb+sZOhfsd4nec
	j48th/POGXZyOxfme9kpkx0/yYSkkxqiG7jRwrFIQpVW3LjvrOOSPT8bXBNULQ==
X-Gm-Gg: Acq92OHvzxhrqlxmGDwe2+Yz+2BG0mhjfiDSF+/VJiaEA/+se59MULAUND+N5vIuByE
	hEG30gMT4ipN1zgD6aSX5l82pqWRdylaFr98H+MoSKDs71QrxBYnQJfiv2KbjN+7nXOdU+7UpJF
	twlUkcQDups7XSKnha8P04n1xPZyfvT1FsjkBdfJsoMtgDB5dzAvBGBtwbcqiDCe0trFr9CU+Ri
	KYtpvu4JQx9h2ra3/PuOz6hDBZSHYABpBZ2RhQnnG9oEs51P6chnhBCckBfgTd9fqbsIIN3c2vD
	QwxtjXLMSk2IOoxa1sGmRcu4aZ8nM/q4GCKyixBkLRRcdyutzYQQgMv6N9mYhPvHkUguwDoQFL4
	nmrXxz3XtFpg4Kgn9K18Xc0Tql+PD3+TISmuRLS+3wAgNvp5vv4YKNThMh/G+B+1S7rS4lOkXYl
	akU5LCUPoGH+HaojH68qnfhBNyiSpNnA==
X-Received: by 2002:a05:6214:242c:b0:8ac:a6f7:8a6a with SMTP id 6a1803df08f44-8cc7bedd3dfmr188113246d6.16.1779707045772;
        Mon, 25 May 2026 04:04:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.44.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd3f4sm106348536d6.5.2026.05.25.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:04:04 -0700 (PDT)
Message-ID: <6a142ca4.0cbb8811.227de.9201@mx.google.com>
Date: Mon, 25 May 2026 04:04:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2318326198004684885=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, tarjeib@gmail.com
Subject: RE: Add configurable default LE PHY policy
In-Reply-To: <20260525065045.27375-2-tarjeib@gmail.com>
References: <20260525065045.27375-2-tarjeib@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2318326198004684885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1100262

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      621.23 seconds
CheckSmatch                   WARNING   323.73 seconds
bluezmakeextell               PASS      164.72 seconds
IncrementalBuild              PASS      622.45 seconds
ScanBuild                     PASS      920.21 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2150

---
Regards,
Linux Bluetooth


--===============2318326198004684885==--
