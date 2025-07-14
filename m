Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890271EB5DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513292; cv=none; b=I1LFuKMxR+yUGl3B/PyizeO2fibOxo1uytc1AtaC07Qiu8u6KxUoMiIZ5fa9IraPJBMJh5rKU3eKVW6UzAEnt0Bb3DPggtHpNnRUDuWGdZXp6+WFIZVXs2cbtStFOWxWEo0j2zNni/SzUBmEQnp5UfJgrr8QoPPYObKn5SXyZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513292; c=relaxed/simple;
	bh=mX3J5Mp10cXCBAJnAUe1tlJyDJoO4IUBD0uoxHTMfoQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bx2nUjitFyMwaLHq4KHgMu4miSo42FpfTGDqlJuTyIHF4Iceipe0UDpUfZIB2BNc0oQiedDUtntvypCVsFO/qOiykF1rwYFhOx1uTfBWh3Z/1v65VA1OmIlnxuNOXTQwZxNXoYWPyZt+8SfduJH2b9HuAXPYGC+hb7sH6YWTlAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZnFiKiF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZnFiKiF"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7df981428abso493448785a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752513289; x=1753118089; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yegcnbFJ2I3eC+O7Xd6bWhr8blbfptntd+W5u0BUrGs=;
        b=lZnFiKiFKCtu5ti3XRzfL6NoErGrgpLclk6xSyjvdqFdI6dwaBvzwMVQG6VTxM6cCE
         fvFL20iJV0h521IBQqYJWasfr+LcOhZo3Tj/DwEBqmQWq9kASaVMPSNuosPRSGhTVt+b
         FjSQdd6hWrI2l4PyU4D1akA9Hv1gsuYJRk/0YUN9v/iEET+LHQpAo9psRg3I41I7fmEf
         lzqD8UydXuQuPb/nbtI6/A6rutrQPrKBw/zzAyG8KESSUGHTnDAdF/F2V5HZ4FoSm0jQ
         LMSKAPYKYmUITyw+hu4dV84yCST7C2al3S4W9E3dV/d5hWhmjGXPKZxyFSXY+QtfUcf/
         Htqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752513289; x=1753118089;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yegcnbFJ2I3eC+O7Xd6bWhr8blbfptntd+W5u0BUrGs=;
        b=YKAfYG2497VfkuKjMqU43TcLnMY7AYBh8PDva/3D8woWaK+MWgw0xVJb6c8925oYX4
         lCWB0B0nn9++9hL5fu9qh5ZbqcnZ9w2svwKnnmxXUyITXIUBlwbBfSs4XIqeXX8wTc5t
         IlHzIQtsFZQgZlKG+ugD/TaZ1IZqbJJ4h+JPzwiuTdHmcv0r7CfcC15z4e49LitDAj8N
         U02Z6tJzAiZwnyqJYZCCc+IMIRqoMwhW7KO+JpfYC10y8HYCAHdHHmxwfUGy4ujPyZQa
         uRYKcpK61Kx8Gkgqpze+cMH763xVAjuZJK1QuA+YX+iJYd4AryBQJTzsXH+6/nWuX2AC
         zmxg==
X-Gm-Message-State: AOJu0YxIa8otABb19EbrUFuCl3ilb8yatzJ2E6wjs2N9rGmlxWn/a563
	ipgdb4mrF943M3gHaguvjTty1bhDc3IJpp2L5t1o8E6ihvJqQKeXINOPfrahLA==
X-Gm-Gg: ASbGncu1BlzVh3etX5c+l8Fhp9KFlhw0Ch/WBjJAk6tTGIyFz7n3YtbWLkiccgJq1u+
	6bj1/RwpzbSuzOO5t2HEPWAoS/lY19L4W1vgjG6OI9UAqcRHhqdu6bSz5OSO3pWZ6NP6hDBvWpy
	Hfu6LLPbRfdsU/TgeIUJWiOUCPSJGF+fSTlTte9G0lmcrC5ui8wxBXjrdJzoyBYy0kIyYb67YkJ
	wytXTBSlnU5HG5LoGKe8sNy6Fgz3lfMwq4lyE4E6kmv96lYGed9Nva/KvPghXB8xXtN6E83glSq
	Adzny4uTRFK1WhmgHQfxXKMM06W6pVyxn/hv9xjJLdsiqjN+p6P5MfHlF9ruybAgVpaYhHu6tRy
	1Q9YOWjc0Qp67ESflVv61i1uOVz4qzg==
X-Google-Smtp-Source: AGHT+IF+jxXiMX8HV2WHYlJDCHmGHTxeYFzox4jK4gNq2pUthAXMRhkIwaWP+ItOp8JFAduhpZpGVw==
X-Received: by 2002:a05:620a:192a:b0:7e3:3682:6dea with SMTP id af79cd13be357-7e336827285mr89120485a.15.1752513289170;
        Mon, 14 Jul 2025 10:14:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.170.237.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3973esm49281316d6.67.2025.07.14.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:14:48 -0700 (PDT)
Message-ID: <68753b08.050a0220.2393d.2e1e@mx.google.com>
Date: Mon, 14 Jul 2025 10:14:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2499880756408525348=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] monitor: Add sequence number and SDU length to ISO packets
In-Reply-To: <20250714153623.251489-1-luiz.dentz@gmail.com>
References: <20250714153623.251489-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2499880756408525348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982133

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.95 seconds
BluezMake                     PASS      3160.57 seconds
MakeCheck                     PASS      20.24 seconds
MakeDistcheck                 PASS      185.29 seconds
CheckValgrind                 PASS      240.59 seconds
CheckSmatch                   WARNING   305.79 seconds
bluezmakeextell               PASS      130.22 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      934.23 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1918:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2499880756408525348==--
