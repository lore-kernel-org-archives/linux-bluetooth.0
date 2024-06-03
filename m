Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8013BAFA
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450576; cv=none; b=Jfo43DuoDMfWs0mdvpM8pW7cVClrHWCSfvMQVzIWnQ64khDYoV/LpyZDt5Cnk8UPm3x1IkXQn9FlqAsZZVxtUlY1RHHVTSfe0a4/rmobZrOJYZN5p661kr/DCX4n+ZoNXQuIfHuhHWPT5sciIw3Clkt2hJWUydGYBUbnerhS9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450576; c=relaxed/simple;
	bh=CA2KyKdEEaK4+58r3PInxZv96neHWuddrAIsZUBoyFw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nZ4CmbgxJJ9KM8gFahi9H//OTkwPGinnVhjsWfbyb892S9HlkO2q3EZaWJiXWRBopBQtoA/lQ94jdgF9gLw60YWr95e1st4CcSewIfVpROvqX9U5L0Jii78eyf32fTYSbP7icDpAIuv1iRRlxS6JG1j15At728jnJGodBxoMUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ura0LvHE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ura0LvHE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-794ab0f7214so219872185a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717450574; x=1718055374; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yMBnWlnnGsKjOR2tIcFTDHEJt8jHPleRYlCSGdYt4lc=;
        b=Ura0LvHEq603HLN7ivvubCKM2+iVTnH9Ag+QOprZJTiO6PSTmiC2mASm85MYIpiw5K
         iBq6CK1L+tolzAlIW55anfCsc2VKpfTHRUsPYbxxD7FlBRVfuGlvCOd5n2kqaSAFdLu3
         tMEnjHGiJpYrcb0naHwhHRE7FmZsHAvL3JNH7pJp1G38Ik63Ajx0yA9YrqvC/I6dDl5t
         8nZflwCyuxAohmO9YWSCw1i48ryYMiHNh6UAMQUv3QEiOjaQSYHoGg9iduZiNOJc/cBI
         GcqzwfH1cTvc9mLefQpfySMCW5kvQmkGzyG4/dhoU9j4l6rNSggIQamU7hTqWON5mWW+
         IqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450574; x=1718055374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMBnWlnnGsKjOR2tIcFTDHEJt8jHPleRYlCSGdYt4lc=;
        b=FiGD4Jup4iloGml4l2zZhtFUQPq0rPaNyCjgeTQSPRXaljvygMR464fA4ws0ZTD/TK
         fm74HkO5lgyZj+HjF8Ltxqk8jvJM5Bmr+glS3rfxrgyuJRGsGSlJVaG8l9EXTOTNLO8O
         APYrIe0GMNfLPHrgQYD+gZck0gFIVgxIVnCXa1YZGwddg6X0vaJd2nOBm9etJTsvW6WC
         G2thxjKg3UUt0leoe2cCWdrZ7H7TS4a9ZPlYVS99NykGcubw97TiePMy0pTurSvjYhUF
         ipPswpLr1b6+vUH343Uwuz6pUuBvPXawtFqRRZi1rCGr9mn7r6gflpd+0MVj2kjOvYME
         38QA==
X-Gm-Message-State: AOJu0YzL/xNnhMhH2xLUMLENEEDnOuc/x7GR/M3HwJ/JfJbMEq9duC0I
	hECVylHqDUqfhN9vgSuKVqwBl/s/YnOnw3FUJiGYYCRB65M69M+ACuaYgA==
X-Google-Smtp-Source: AGHT+IE9OGjiV4v+OolI2rjkJUQue0x80SYmW0iGjdO7l4e5x7sqjm/zgW2MDnFnxKZKJoBA7Ah6Gw==
X-Received: by 2002:a05:620a:24c2:b0:792:bc48:cdab with SMTP id af79cd13be357-794f5c6699cmr1402170485a.13.1717450573707;
        Mon, 03 Jun 2024 14:36:13 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.53.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f0419fsm313516685a.14.2024.06.03.14.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:36:13 -0700 (PDT)
Message-ID: <665e374d.050a0220.884bf.df95@mx.google.com>
Date: Mon, 03 Jun 2024 14:36:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1678482121696191628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] shared/csip: Fix memory leak
In-Reply-To: <20240603185312.162337-1-luiz.dentz@gmail.com>
References: <20240603185312.162337-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1678482121696191628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858380

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.90 seconds
BuildEll                      PASS      25.26 seconds
BluezMake                     PASS      1737.95 seconds
MakeCheck                     PASS      13.43 seconds
MakeDistcheck                 PASS      183.16 seconds
CheckValgrind                 PASS      256.79 seconds
CheckSmatch                   PASS      361.66 seconds
bluezmakeextell               PASS      124.04 seconds
IncrementalBuild              PASS      4783.17 seconds
ScanBuild                     PASS      1055.55 seconds



---
Regards,
Linux Bluetooth


--===============1678482121696191628==--
