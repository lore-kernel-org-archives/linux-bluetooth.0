Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544C1B21B4
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983922; cv=none; b=kwIdhl+k4MDY7wkG0KzHem7G7KQukmXK5JjW3NDcWE8I0nZ+HMNq0D8x/1kXyUMR/ImW0ZlcQtA9AbptE2yF1ongHsAJyP0lK52LTHh7dC7dsRpHlainKJdLmeCHQxBfWFys9eZK6xhs//yFE+OTPASpsXZblkG/8g6kPiDE6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983922; c=relaxed/simple;
	bh=+9OmNvqiRVXgcv+dvaWaQ0P34o70i+P8dgFD1bm8RPc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qSVHp6rqSwBAzOHLEiCDxwzLGph/2Lj+NwHQL67dzwa091RSP9xiMJaudefRW+fZj3WEtqkwJ39ppz8FqB81qP7m412Ak6twirxALCqz4uVrtytQ8iN53KXBYZw/vxHC2kxMk9Nz3xnLGzMhbGAKirXO6ADEBQt9HLVYzRttnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2mfS6ix; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2mfS6ix"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227914acd20so10819725ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742983920; x=1743588720; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OBKekiMq1fEWzexzXfAj9cqUrNpd7E9BSgE78D5RrlY=;
        b=f2mfS6ixzNetCyqyehTSFs+4Q2TvJZ4h0vykHFSDQ8SH7Ytpt9CEe3DIXH5JaQ+rQV
         hkskqgmFGvsfCQHJJs52dQ9TpCldokUbzJGv6gr8VWyoaVkj1VAY5EzvPmtsqnaqKxfu
         vaaMbdbRHoTcua1eLM2Ck0zAsMxGYLrVdJJKYNBd3J9hz9ndKCVZNe/cZ4As+PPT3lhr
         fzznEgvSBxyzIHqGbzTxhBdaFBQXACQL1Y89jA1KNvoVBnA5u1CaBb2WinRKjElq9wGe
         eC+zBLlS8w6eDUxVaXqi2UA4gl2hO7owePwEXGRNssUKMIl5Ksk38Xv/iBqsrb9B9QYl
         swqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742983920; x=1743588720;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBKekiMq1fEWzexzXfAj9cqUrNpd7E9BSgE78D5RrlY=;
        b=LJnP6iNmvvMt24v1JDzLhLcuyd9t2UC6FvsKEPMpy8OghDvDEUO67zw+xaqOdgZdrE
         sDiu4n0ewWAKXOgfgHi+SjPypRQaE8P55Ss4PYaDUctkgnjzFvwr7BbZUSKSjufFCEHq
         /dbF3gJ5yuS8UwfNfv//6o+vGA3Lq0XgcXd/44qw1aovqm5J4dlWK54GXb118fHVMli/
         V3vyva4MUU2AEJ7azYy46DORjUAzkEMaS6EKK0y14rcOfFdJhYCC4f02SxoENnYvRLgE
         0wDgMpOvk3KJYaV5ui0AVO9IAesiGB6Hfv133y7kPxufkS/ahMxZhWxxIfr1jn4Qea6/
         0MCw==
X-Gm-Message-State: AOJu0Yz39uF4Hti2VhB1UbMzTUWV0BXn4oUlWB6NZxQE0WnwY/MNbp/b
	LycYzVw4V1JmVJ/pnB6gOSzzv6yow0RxKHcU5nAGLkYACo/knneGe62wxg==
X-Gm-Gg: ASbGncuFD9mdQySZ8+Ym6stlvZX9GkSDv55JK64Kw/Qz1nEbhSn4wMsTE7WqhZsjkEm
	3zQG7ULb2zUZ/2g8jSLzRT+yWdmHLfIbvu70idCrHLg7P4zTUALLoMozdVYfkvDNVl8+6LwgAzn
	5qAlLxD8F6TvEre/egyof+h8xkSWLEBUfRNAfLC4aRqWOn2DEjMnGuN3+RAO1+7Rh6jCBpqraBY
	DNZBMX7DsUURA68N2vPKwxiPmpATUjRoSRWtoD1JlpMYI1sZTpFwjZDGhH5yOYm1xDfmf+lp++F
	RyUrLcNRvQACPBu+Xc/DQYBA/cbcQnGvsdEGQif+UcIhpDDubA==
X-Google-Smtp-Source: AGHT+IELQUlk3D53QEo/CTlyjQKmY64VfTjA7x/y4zjKkBjK7kURDk4ox1s35i7S+jD14ZRk7EmG2g==
X-Received: by 2002:a17:90b:2751:b0:2fa:30e9:2051 with SMTP id 98e67ed59e1d1-303788d902bmr4737112a91.5.1742983919819;
        Wed, 26 Mar 2025 03:11:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.14.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f806fb9sm11984827a91.45.2025.03.26.03.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:11:59 -0700 (PDT)
Message-ID: <67e3d2ef.170a0220.1635dd.b6d6@mx.google.com>
Date: Wed, 26 Mar 2025 03:11:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8323999861762993620=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] profiles/avdtp: Fix reply for bad media transport format
In-Reply-To: <20250326090712.171313-1-frederic.danis@collabora.com>
References: <20250326090712.171313-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8323999861762993620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=947397

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.47 seconds
BluezMake                     PASS      1487.29 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      158.22 seconds
CheckValgrind                 PASS      214.27 seconds
CheckSmatch                   PASS      284.62 seconds
bluezmakeextell               PASS      98.90 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      868.30 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8323999861762993620==--
