Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCB1350D8
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261225; cv=none; b=LKJrOTQOOmhcOcJSwdvrtoDrAI2+CsjrNck3nsF9lUjtbohyP2K7Yi/UuLul7SNCR4Ky7axtSzMatfU5doZboVE4JKIsSG4GKlVYrVWY9CDqYy/f4Aee80/HvWGjF2fLB0uh/CEShlHlPwIhi71j6G25KWCY/sEVyfmHTZ74dgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261225; c=relaxed/simple;
	bh=FSfKHLPVDddaohGefRnaqnEkuD182G37YoH8nShUirk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SIjwbygI9dwLg8tScfw77zqrZqlPFeYqHEKKmQa5LqLtVoqg6c2sR3FTUTq8whBS6JVQgqYnavi6bbmUMDEYEpGfi0Qp8s5CJMO9DJtY4teApUF1qYdXUI9hsIfzJJJ6QiAP2fykjOWDZnsycAs4mNBjtOJgduRGuK/+K9pPMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGgZjR0F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGgZjR0F"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0f2798cd8so13049235ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712261223; x=1712866023; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=88m9sbjtR+/wmyhjNUIje3YWvy/BWyCuBLuxqAEp8Ps=;
        b=jGgZjR0FjbuF1rfvYIxsx3as5UAUl2P59ltrxszJh3dQDOoSHvSoIZNbJC7ijD2Tzl
         p0z7Hb7uNhFMYfcfwEqJAD2avcm4zVCmdkjJhNEx+/CftVRwFegc2DyOFYrySTt6KUZZ
         wvdzCYDlFIxbIcnIXF+DfCIE5x8BZXsa41g+JAve3FKGw3Cro72f0fAZy898lPLEoPnR
         dlJ61bSn3b3+8rVx9bnbPLPUjYFsS3oXYJFYi7HYDmeuBLzuSfu4lHyl0TvdSp8Fkl5L
         9a4OJvy6AcO7HeSKLP9hlSvWta5yCiYNGjXvE0WwOHnWpQslbeH1+1Fw9iK2FLcCKJQG
         cBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261223; x=1712866023;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88m9sbjtR+/wmyhjNUIje3YWvy/BWyCuBLuxqAEp8Ps=;
        b=kKRzhJmyhddt13bJ+uew9PSiq492EraowIIuV/261YAdbX7G8NbQfMJ30EjHtQb8T6
         aLBjjmOIgtrsYI5iyC0cXhO3z8SKiI/t/NA0zkl6IsFs8TUzj75u2i6Its3fAooppIbU
         Bkj3BP9p8D+dqMhziq9q8I5Etbta60iWIK2GVxKbZQlTzpTB4vid7kpaeny56qh0y4te
         6XbaN00ITog06sJ2fnwXx5ja3eG8ZtchNKqDnIBXEVWk2LYujMRjwUCOWBY4R8UHjOp/
         oMFqWVeKEVAVQx00M3+oVaNrFN+qCTIM6uykzFDxb+cborwMyyFwnawimjqpy+c+x17f
         M7kQ==
X-Gm-Message-State: AOJu0YzfKyU3YDktGdGwTWxTd6jVs0urowMHlsTUJZ1iYOTN2SDvaQBc
	7gvWPG9ALlJ7qYrlb89DTJRJz33HyO5FjF7fEcWlHX1kr7j+1mO3yrJwBmxf
X-Google-Smtp-Source: AGHT+IHg3nX/Tm1vF2X42HdJrZEkCamo7KPLi2oqHNRs8VkmqKdLB2r7eJkDOU3emXLx6xqvjVrovg==
X-Received: by 2002:a17:902:d2c4:b0:1e2:23b8:9885 with SMTP id n4-20020a170902d2c400b001e223b89885mr3961983plc.53.1712261222821;
        Thu, 04 Apr 2024 13:07:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.14.168])
        by smtp.gmail.com with ESMTPSA id jx9-20020a170903138900b001db9c3d6506sm3102plb.209.2024.04.04.13.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 13:07:02 -0700 (PDT)
Message-ID: <660f0866.170a0220.8b888.0031@mx.google.com>
Date: Thu, 04 Apr 2024 13:07:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6720521577780193901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dimitris.on.linux@gmail.com
Subject: RE: V3: Fix busy loop when disabling BT
In-Reply-To: <20240404183050.334414-2-dimitris.on.linux@gmail.com>
References: <20240404183050.334414-2-dimitris.on.linux@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6720521577780193901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841538

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      25.69 seconds
BluezMake                     PASS      1667.53 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      178.45 seconds
CheckValgrind                 PASS      247.55 seconds
CheckSmatch                   PASS      351.41 seconds
bluezmakeextell               PASS      119.51 seconds
IncrementalBuild              PASS      1690.57 seconds
ScanBuild                     PASS      1063.67 seconds



---
Regards,
Linux Bluetooth


--===============6720521577780193901==--
