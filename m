Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0DE2594
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719698602; cv=none; b=Ne4qGwA9VdcNM2oBAs7iaZQOUqU77lfAYzKLoriLvjgAjrSFqT86ePFxsGfgQ78ngpFz3S5G9MkUujMjbvnr/fmhz28GjMUky+g/cdN2K2Lkr8ydZIQDvCQfI2VhwTJssHF3/pTC+j8gzXkOl9EJ3nQ7JnoiPlW/DuqXHLIiJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719698602; c=relaxed/simple;
	bh=Q8gv2/CMLQ14KKV6UXQ/nY0d3V0aTK6uAaypFS1eE4U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kMQwpYz8i6EwVOzyMJAhZgmE5gBAD2312AZtHsq+vn9HmLhcJZX6434nBYeJF/9g7Ztaoa8CHqGjiF98NwQJpfJwo7N2SDUir6m1XX8GaZIlXPFdLaKX4Ku+7/lYxkWQyKjfpTnnsVMM9DXoGr3Y9fx4zwzAAk02lgmAEIaI1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPDd5Bmw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPDd5Bmw"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b4f7541d7eso9119886d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Jun 2024 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719698599; x=1720303399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yBLAiMDPJ2hfYGSd8mKUzPnOrYPfYOBoi0OImf4Lb8I=;
        b=mPDd5BmwOth/VJ30SIRp3c4J6jw3zty6+pjsvV3jZEra9qVQY2pXM6sVEjUnujlWsv
         dyV7W2n7/NdzMiukZ4CZ8HKdDLsIzA84LQrjwPVlRH//ocNTr7Drh+L4b44wyGNSZlM5
         EbFEGUMXgRwhXxE4Pn5s3GVpolDC9seVm5EBnfWOZT3/QUlz4xmJNnRlPz8lBLVydqZv
         wN2j5TLB5mUK7HWqN4yV1ELxAdd97hpys/+3m+6coBzECc0yjKVhUYieqoRANJA5n7sG
         MhFOXQkAJdUG+w3XwZfsLSET9P2ebyPU/vTtWQYKqEF5kZz7rjGodsnRyAECENOG/WY0
         K+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719698599; x=1720303399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBLAiMDPJ2hfYGSd8mKUzPnOrYPfYOBoi0OImf4Lb8I=;
        b=YaLN676Y73l1HiNLr3MOOcyN0E7PH2y8kkYKt16WlcKYBgB+C5LU6sYkfqz5PHn6he
         BEk6QDUo5GcS9tZIh9QxOxN5zzO3EeBfKnlB6/bSE12Jm33XjVBls+jf3jeJwNK2XvjZ
         BoisvXXM1nRoz3Tkck/o6JcGRSq6o8PuCGL+nCtFKifee67V25qtBLIwVCCCGMVtLiDG
         CpgZIadeo8FjJ2tAZbLLQr0hymACgr9Lue0F8fQeWxpuF6MOf75Y3r+Xmi6X2j7R6yHO
         XCKXWR1V2i/1cg6Wyss3bCjjTxyfcmwz0KCtHLCE6kI/M8SaZmNXB+uGbMW27+iqSici
         flSg==
X-Gm-Message-State: AOJu0YwDjiVuYyEB2H9WD8ygaFzxg+L8VTSiHqjnFWaamc8PUhXHlkeI
	FqwsVSJjavaKdGJ7hmzqFyHU5D+n5g2HLSiX1lqkr4MAb+W/nJcusrCDhg==
X-Google-Smtp-Source: AGHT+IGWowFuxuWze+HLjs4jQSgEfWkDhuZLIpCOeV7BYrFFdzNHFcVnt2hmczRPbVLNsAxUpbfwpQ==
X-Received: by 2002:ad4:5e8a:0:b0:6b2:d51c:f5b3 with SMTP id 6a1803df08f44-6b5b70a1491mr25621576d6.18.1719698599368;
        Sat, 29 Jun 2024 15:03:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.67.133.159])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e576915sm19835746d6.58.2024.06.29.15.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 15:03:19 -0700 (PDT)
Message-ID: <668084a7.050a0220.db00a.95b4@mx.google.com>
Date: Sat, 29 Jun 2024 15:03:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0409674048999848637=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@arnavion.dev
Subject: RE: [BlueZ] policy: Fix AutoEnable default when main.conf doesn't exist
In-Reply-To: <20240629201632.1356542-1-me@arnavion.dev>
References: <20240629201632.1356542-1-me@arnavion.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0409674048999848637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866862

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      25.27 seconds
BluezMake                     PASS      1642.43 seconds
MakeCheck                     PASS      13.64 seconds
MakeDistcheck                 PASS      192.64 seconds
CheckValgrind                 PASS      251.68 seconds
CheckSmatch                   PASS      354.58 seconds
bluezmakeextell               PASS      119.82 seconds
IncrementalBuild              PASS      1548.90 seconds
ScanBuild                     PASS      994.67 seconds



---
Regards,
Linux Bluetooth


--===============0409674048999848637==--
