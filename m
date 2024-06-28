Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE113FD9C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567902; cv=none; b=orZXJPEC8cqHdgiH1IKnBruGkjSkHcxjO2Q126Aw4Zgdh8L6BZPEN/ybXx3q0WRqZezI8cyJ7Ou8Z4N/+WdXfK2UXVrpmyxRFVVkXSMyC6USRg3VCVUGX/dTgGRZGwfI+9CDDu2tWHHEPmtcM7oP3FICUVFBJakXnOW0yLPQEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567902; c=relaxed/simple;
	bh=3njgp0rrxoVPIiDlfrTAbO/tnzmxsDylz7g1PQKzT2M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pIFcqPRtGReL1yTcQbX1sT1/TsZaGkkI8HGzjVBCAPoHvA6bww/RXmZZ0X8s14ItDupEM25E4Co2GB8GYUb6LbvapXTOq028nDS8r9q27Yqf49JeBU4VyOjDjogUa7c/rnQczjav8cdtqCJH1SMsTwd5l3vIOiAeUcaBqsF3YUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHmK12K4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHmK12K4"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3762c172d93so1770325ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719567899; x=1720172699; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C78hCiCWudjek9M4J1BQjJHAZ6d9iP0aRgim/pcscTc=;
        b=aHmK12K4kle7FGqWoBN9YTGU+5No5ZFIKwgP9Y6+YNBFgVs2RskBZ5NNXehXWvrtRq
         Hz/EA9eacVN8WtQRhP1pPJzn07EE7yCVoqB7tLoVWMiIJ/nCIGRYA0G0PHQn4SiQsAmT
         Tz6ypWUZYv+9wWBrxGBwsN6h27zRlXZxpPJS64gIP1V6gMM0gbAtAy0lSJJOZDz0i7Ou
         MFt18gge6FJtzfMIUbZJRaZMu7E/m+0NyM4IPWk+pm58AeVjcbxLvULUEir68aZlZUse
         OP5uUqn31diAcE0hACRj82kmKnwu5onoLntL/tnN9zc9UTQ7N2Ragd8V/Vj+riguAez7
         5yRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567899; x=1720172699;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C78hCiCWudjek9M4J1BQjJHAZ6d9iP0aRgim/pcscTc=;
        b=Rw8v11v/Tkt9s7zmTEGp8j6jhmQhSG1ZXhHeEwmwW3ROkfNE8TuJilcPm+Txqzp5Vz
         toRMBcvnXC9UJEI9uHwRCixH1+Sx9PVv0WquSG00KUdJ7rESvY5n76BpcTqZnGQx5AlO
         8ua30bQmxi6i51wuJc235Gh9UgWNYWysxB8FXbBb2mPZVmVWhzeHJ/UBIESRbR0ZWuhh
         zrgaPq4rA3UgWVGqw9IgHJY4W3B61l1oJvv0XqKDKRVm76C4Ahib8mlLquItOf+Fo9ET
         tHAq6Q+tkrJzXKJaEcCDmcB2WIwidGPo0s3hwlNPj4s1v0VA1zssKPYuW2kJLxRfAgtd
         BOkw==
X-Gm-Message-State: AOJu0YyVH6h/z5H/Z++iov3EfDuzMo0YhF9PEzS2K1ag12HPyKUW7CNN
	jxaGVXb+k0NY26S/lFSt9Efr12hayV0m99U4kFkNcsmQ+nT0KTOEvU3/+Q==
X-Google-Smtp-Source: AGHT+IFoYM3k2gljerhsltaRbGUne8FwmOkTIqo08NkVMcgbhYCnO7ZLNkZKYlJ4Ojbltj/tNi1Alw==
X-Received: by 2002:a05:6e02:1d1c:b0:375:da94:e46b with SMTP id e9e14a558f8ab-3763f5ab591mr201850005ab.5.1719567899616;
        Fri, 28 Jun 2024 02:44:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.25.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53e3dsm999991a12.9.2024.06.28.02.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:44:59 -0700 (PDT)
Message-ID: <667e861b.630a0220.54de6.3149@mx.google.com>
Date: Fri, 28 Jun 2024 02:44:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0912401835064636588=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] bass: add NULL check to bass_bcast_src_free()
In-Reply-To: <20240628073542.20896-1-r.smirnov@omp.ru>
References: <20240628073542.20896-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0912401835064636588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866446

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.28 seconds
BluezMake                     PASS      1675.34 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      183.04 seconds
CheckValgrind                 PASS      257.89 seconds
CheckSmatch                   PASS      360.58 seconds
bluezmakeextell               PASS      123.47 seconds
IncrementalBuild              PASS      1527.30 seconds
ScanBuild                     PASS      1038.10 seconds



---
Regards,
Linux Bluetooth


--===============0912401835064636588==--
