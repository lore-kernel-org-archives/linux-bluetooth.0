Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD97E583
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579572; cv=none; b=A6G19gRmEApPuFR8OIH4PvEifjT9PG8PYNNZ/cizNEqCft1ijsjEZfThB1IdcsjMu6C/y/qKk0q8WFYmYayhVNcnPky+8acaM8fQO8nUaxmz4iK8rw3Uow6wriMkeZv5lvJF1OtRiXWBANZnLapg+evUf9dEVdbIpf+3X0JxTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579572; c=relaxed/simple;
	bh=yAoVq/YxZhndPy4/8s/jj8+wdDPL3H2P6WkHRRsXN5Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZbwPWUvGg/5H2SkxsLjFth/F6s4B3ViK8jGNqhu7k3xH1dNkFYyE7xET/x5rxrkf3Poa8PfGdOVkvv97s4exn+6QsTeb98z18ZJAk5jJAFb3jW3QCT/eKEDMNaFQ4PgPUap0toub22aFDRzh8qGfdChzJ8Y0fNltwq9jxftw4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSUsZncd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSUsZncd"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ee984152cso11496981cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579569; x=1710184369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZWBRBJT9uM2FRq9heGNQnPJ29212ctsfp0ASnnHC9w=;
        b=aSUsZncdPnIWg9uIkSd73R3IKre20qh6PvRLtMh8BtTp0uItAecBaGtzlWCor9gpB4
         Bvy+cPoXz+F9KJiAnSVekDnvq3EGEum2E7NzH7tdNJKiePr41xPCFwQE6EA5GxVQFxu3
         ewI8TQL4g3YX7BQnMyq7pNmCcNstc4CBdvNNNa/MlhJWNUsJMPmMRBRE58vsXCZEk1Vu
         +CQnimRUg7WqlJoCfigR8B+taSFGE72+bqmtOTG+dk7J12DNkFzS7cDVhcWb1jIIztQb
         XdVvzKsDUCOgqKadOiiAkGFxfFGioxY9UW99+fO7ys6V3lnn8MJCm4b/DMkWvElnWgZK
         Yt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579569; x=1710184369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZWBRBJT9uM2FRq9heGNQnPJ29212ctsfp0ASnnHC9w=;
        b=Hnt4NuVtvNv3RUCjXYdVecL5YNyYXZQCC/pebfclXObzKpTmL6m8J0tZ3OkIqe54o8
         PTAZCmz2ieROp4QbA8+S7DcWmCK5GdaupeNFe0AyzAK5gQtakgArAI2sYKt82YtT9dws
         OSe7Vm0cNLppjIMvVavEBOanOYqVgj5qoD9oDSikq7FzjdTDvgIKtfDSL75S5IQIvePJ
         wevbu1367Z08+2RPbD8sGhXo6NHIsfgnex4zoQobUHsINh3KhJg6+bkoos6Oqof9XOBY
         SivrmUAu6WsgDum2W7eeupIr5Qhd4t9G5qBtTCBc7SBtZCLlO1LXebMk5kos5IsuMOW9
         tspg==
X-Gm-Message-State: AOJu0YwNPMUx3itkBZJbC0yZMSl14vnW0MzezfafddqMQBRNp92Z4YlC
	xQGiXyDQoSU+XNBcvE1eB+O+MLQu0zzfPZ5j41DmNts2sk/PIClms1m+4/d3
X-Google-Smtp-Source: AGHT+IEDfwvuC+OARM5xb6hzkwsteg/hhnevQBBq795k1m2oWFo64Wfjeb0yCHId8X7wGXohOS0P9g==
X-Received: by 2002:a05:622a:15c5:b0:42e:5a82:2965 with SMTP id d5-20020a05622a15c500b0042e5a822965mr13350240qty.34.1709579569455;
        Mon, 04 Mar 2024 11:12:49 -0800 (PST)
Received: from [172.17.0.2] ([172.183.107.245])
        by smtp.gmail.com with ESMTPSA id i12-20020ac8764c000000b0042ec42c0ba7sm1609271qtr.97.2024.03.04.11.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:49 -0800 (PST)
Message-ID: <65e61d31.c80a0220.3aac3.559a@mx.google.com>
Date: Mon, 04 Mar 2024 11:12:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6252554731931369198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Fix distcheck
In-Reply-To: <20240304173503.3049383-1-luiz.dentz@gmail.com>
References: <20240304173503.3049383-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6252554731931369198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832173

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.35 seconds
BluezMake                     PASS      757.25 seconds
MakeCheck                     PASS      11.98 seconds
MakeDistcheck                 PASS      166.66 seconds
CheckValgrind                 PASS      230.72 seconds
CheckSmatch                   PASS      336.95 seconds
bluezmakeextell               PASS      110.00 seconds
IncrementalBuild              PASS      705.60 seconds
ScanBuild                     PASS      984.88 seconds



---
Regards,
Linux Bluetooth


--===============6252554731931369198==--
