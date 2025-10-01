Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05D17A2FC
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306540; cv=none; b=qgK0WJY5x+S2kmYhcQXu3k3w5a7J5V1jwevfCVxGlZPrBo6Sz1l+35Oxye59VYozfEoUOsgVP6Ik9m4OOHh4NkEDvfXFQsB6gXYjDF0mONDWBOqU4uMO3Voi4rJHay6DQs7A67EblCSJ4TN72wVYuHzzLl5wgbjuLIhSInxLZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306540; c=relaxed/simple;
	bh=cUeWGe+IjNsYbvkTmVv8Zt2sZjQVOExKQJLgX3CjDu8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HnlOP0HhKWKq5tdxQmCAGYY5U/12JmSUFZqEvC/9j7mkgcwNVVPP8kdIPYSSuzCjXRLqOZN5bzPYZCb2N2hbih02NMdUPxHgHgLXW9XPip0VzQRP+5g0jO5e51XqcSMCeEM9rLLFMPa7ptcyiF5mO7MBjRK0RMduKXupNHelPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4gPaHaJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4gPaHaJ"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so182948939f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759306538; x=1759911338; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dW6MopSUnTSwKAXTnW2Gsh/T5TQwOtFcPg/zxJY/s78=;
        b=J4gPaHaJhpIyhKHo+vQgs4+MWJ6AyhJvv2CmW4PzqKVXezD4vlyWVZtz9pD9PgaCcP
         ligON2W61TpDlwy54W998tkaOo9EI2UKf6KsYOyefQ7Q3SRNhIfBwMvAbUoYMeDsK9Ys
         bs8QeefzP+R6snLu7nb2F/OlQOmVzSrmVhhPyBBFLUXPlWsyFtprrBcHGnAD69uxLbx7
         xEhphnnEj/mrkEu2XA1q03aFF/dFs6Y9oZQ2Qz8bh0/uWoy6PvbXdr+jEB0r+kzfxcEC
         R3kSUm1oFws/owkQyjn/qOgkcVPjRL+jHLqjwdz2iuu5iRbkYMOqIZichtRx+7dlFICg
         I1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759306538; x=1759911338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW6MopSUnTSwKAXTnW2Gsh/T5TQwOtFcPg/zxJY/s78=;
        b=MpwOWI+7aiHkXv6o7naCK/9sgYuKZXR7k07MOLKeKrQLtdO5m97Idnbt/v74zOlOTr
         VQSNL3t62dcN7xzLJR4rm9F9d/XD8RvULRaNfGZY+2uy7aHn3JRJxI7/IDRPen5ofZqY
         t7wD7FB7RXEsioeWNtnEZjuV1IyZCWgx/h11q9orzMfuXu42sG+NuSngVbpsfptfvZCY
         qdQmP1EyUqwqulJlnMfpmuIsDHucdYGK0e63QGiE1ZGr3ySttBTomhOY3WQ2ZpszrInc
         uAPbwG/N3W5xvl/qwyeM4DM0c4Pdwu7iGJLhf30cxIlxxLCZad36MV5/CL26hFNC91Ux
         lF3A==
X-Gm-Message-State: AOJu0Yyk9bQe+YoX269unqMIjjr0XPgdoXSqIdO5WS5bapU2SGXcZKlA
	8hiXHfWK9Z41HsFfbIxosOFD+Da4F1PDy7uGt8/WZ9abTUFKxR6DgH7M7b2+uA==
X-Gm-Gg: ASbGnctvl4MfN0bChEQIw4fSXecJPZ8sa1T612dby1SvOwGFvjrz1QCC+h58xtBwd/J
	i2/XWtkl4sRsLCnbui0dbfqgT5jgR9tB8HfOD4ApTw2fOKDXDTQ4KsK1i5eK1JzLW/rWQVBwr11
	3gZ3pqtwlgMPT2XNMFuoQODL0kXWz1yDFGdNP/i3teJEpOSosytLK4w+Jo4lPf8I+fk/IESzPc8
	3hbVeFWfjyr+oLPaIAGnp9TSDzMxw+ZA8INbaUDI8ZSxlNxM44KVvQ8oQLsfmYhm95qY83tFlCQ
	BxovFBg/Lo5yhkQ9G0Qapwu7Y1AnNfzWYf8w8ITLlCIYHoWDlhYdUWekR9N0oWzHAxxIfwhHx7w
	IllTsZp6m+cHxPOwWlo9kEndiW9FOhx8px0W8VmsO44RrviSP8RqW
X-Google-Smtp-Source: AGHT+IFDerfTP025P/X2bDzclSWcS0ytSMaYtp/gtRleH0c4bEvUgeh2JJShtyspcBiqpMzx534NVA==
X-Received: by 2002:a92:cdae:0:b0:426:dc47:c8cc with SMTP id e9e14a558f8ab-42d81680000mr38195215ab.23.1759306537999;
        Wed, 01 Oct 2025 01:15:37 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.169.97])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-575e72881b9sm2167573173.47.2025.10.01.01.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:15:37 -0700 (PDT)
Message-ID: <68dce329.050a0220.35d3ff.4116@mx.google.com>
Date: Wed, 01 Oct 2025 01:15:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2427730388649830816=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/6] shared/hfp: Add dial support
In-Reply-To: <20251001065429.268068-1-frederic.danis@collabora.com>
References: <20251001065429.268068-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2427730388649830816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1007578

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      20.64 seconds
BluezMake                     PASS      2607.64 seconds
MakeCheck                     PASS      20.42 seconds
MakeDistcheck                 PASS      185.43 seconds
CheckValgrind                 PASS      236.93 seconds
CheckSmatch                   PASS      308.63 seconds
bluezmakeextell               PASS      128.56 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      922.76 seconds

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


--===============2427730388649830816==--
