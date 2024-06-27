Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181946B83
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486509; cv=none; b=fYsletF0vP2x8aJzApWeV2nFbaB0TpbCp+ctFRITcKRUHv25k64S1k9LkQ+sP/BP4yU6vAQ9CLSgXcFvCZn3C7IC0Ji9BfrSQMQjKAeyaFtWyS/s1QuS3FkjVRyLp8j6VHov9r9vw3ZimZ1g1av8+a5ixNifgeKKQBKm4c1PhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486509; c=relaxed/simple;
	bh=pvThKjUlUFYV3/luUkkqWdDcAwb6OGtxJJb5ekm/kCo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qIfFG/fwkiz5ul8C/8ZVgcO8ymSeTpjlJX336C12skyIel+21Qo772a6zl+VKuLnL61npP09ynA0vGyKOL1eJ4av5uveIRW2ltjjYi8wnsor1juny/Olg/aotugBZPatGO/b/vLXTXTqFC60HUxQdbMLiEr7mXgkaKXzznArtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLh4ZrHv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLh4ZrHv"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f3d59ff826so48601639f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 04:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719486507; x=1720091307; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+UXJm6CSvLvPa0WoW1mpIJ/uZLnilGizeUe4fD+5xrg=;
        b=XLh4ZrHvpDw+p7059UOxkuGx/5m7xJex3UGIpskZygXUQjgGY7d8VyD8h59aAbysAE
         3Fw2indzDdWSLayTpYGFVUldwLQ2krrls9gvmXZaH8Q/CDqkD9QPKEKLucbhCnPiQVZo
         63hmv9S0tgvBufVQ2eyOYvmi6E+S57bBA8DGHH83Luu8KUYXuU76Q+Iqa4mu3aeP4wXY
         TlSZam2JWh4EKK3vCujb00QoaI18/pbieoqe3Y5E9dbUBuj9wdd++lH+6BzF/2CwfQds
         ykJAafoMaUxYpiSpnXCVpIBtCX4MEvM775DjuBos+D4TNlHIr4q1T4DQ12MoqJnOpYeb
         DKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719486507; x=1720091307;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+UXJm6CSvLvPa0WoW1mpIJ/uZLnilGizeUe4fD+5xrg=;
        b=ODMjpmzHUC2kcaf4Iv8EuiR8oai1i3rdUJiRWIfT7bzdoK6VmJRVOrJAUcihCIZAVg
         FTGabShVIcgJ8b7X1CHbLOaKG1GtanTCXvRoceE5hGbFpVt/fhZvEF9EA5nKvmKs2wI6
         jBkG4qkzgSfd6R6WbhptDi2JK6OVevAxg8hW+deRETXfIHptBme4JfZSNZecYYc1EvPc
         QmdVZG1RVHTausecigTUUBn5CHtd9bUnribsyGFZbGDf4L9zC3dN263CSmwiOEM9oSwS
         3Dz+iG6kl86A/leetzuFzvZyPu4dSNfGwNGgpK03tVciUOWyIV77FI5Ka6NgXQFymkTC
         8ogg==
X-Gm-Message-State: AOJu0YyzJk58UwTx1m0AXkYkuXvkWlsObKRUJ51fp7QofO8To2VaGh0b
	SblhGJ5gXc+hOAb5pLXwdDjiMy6/OQk+Tm4pmp64blAmwl8YBqxkrWNTIA==
X-Google-Smtp-Source: AGHT+IEC5xTa8LRO1J2iJFbhcp+67JcRwydvdYq1aobli5FJN8x4qxK+Z319iWxFz1axgkdqhJOAAg==
X-Received: by 2002:a05:6602:340e:b0:7f3:d731:c6e5 with SMTP id ca18e2360f4ac-7f3d731cd37mr315004339f.1.1719486507417;
        Thu, 27 Jun 2024 04:08:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.123.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72745092964sm884423a12.5.2024.06.27.04.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:08:26 -0700 (PDT)
Message-ID: <667d482a.630a0220.e13e6.1e52@mx.google.com>
Date: Thu, 27 Jun 2024 04:08:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6651542882500657547=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ] profile: add NULL check to ext_remove_records()
In-Reply-To: <20240627091628.46304-1-r.smirnov@omp.ru>
References: <20240627091628.46304-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6651542882500657547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866066

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      25.09 seconds
BluezMake                     PASS      1786.27 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      184.71 seconds
CheckValgrind                 PASS      259.64 seconds
CheckSmatch                   PASS      362.96 seconds
bluezmakeextell               PASS      122.90 seconds
IncrementalBuild              PASS      1668.12 seconds
ScanBuild                     PASS      1065.72 seconds



---
Regards,
Linux Bluetooth


--===============6651542882500657547==--
