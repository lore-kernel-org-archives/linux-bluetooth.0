Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381C42AA3
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782077; cv=none; b=BZEuTeho+Gmh9Dj4FQjr8WW/C9BtTvp/LZbl/lq5yaDcZ9g5dszsk352OS3srrD5IoFU9NhgNh/pbQu7CYQfjROgyItxCfF7STIdzoJRIEwtN73+7xMFYtupx00sSljfAUEXySrTyWgUtQp72bkWLtnD+I8UVcej3LHpGymG2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782077; c=relaxed/simple;
	bh=EKv8VVbvSZcLUyqgUkxMl6p4FQZp96Cnv9VmaIOKm3Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Wk2vIcnm82+avhT4YTOqZ+v7ls7kZxXOSRf/y+THuQVvbs7c6kpuXONENNZR5LDYrZbYluE1oJM/SHxPFemSf2dohx7en3gZYIgXcTTBIas4hyqn20Q1iHhR0n2NERymwDb4xxg8s0au445co3WE8hiPUEN8YJGXC5mh5I7jAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiNvd7Ow; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiNvd7Ow"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6869e87c8d8so17000156d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707782074; x=1708386874; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nnGyZz81zHkrAIqP9tARpfVqxq3PAPjhEx7hnLZLz8=;
        b=fiNvd7OwXzP9aEXr4laEcumh6HacPKuEtxaeR3UVuBNjPvAtHlwQHJhYbc9Ch3up6G
         bb0SYSpIORoaSIFZyrTG47aPveSIK9TVxa9/BNKTf0uBasi3wMCy75HZTcbmqN//mtWq
         z+Ja/Z+KghoVweoGTHQeEUaUU2svj4zJz//xwkhG/wtAceX0Vl8G/wMYkaMD5SZHe2Zd
         FwjpHmptzVeaWZ7jA+KcLYUxbTxdVYpQZTdL//sjqLSv+yqkH7cdokLyChBBKkfusiHv
         XEnpQL4Yba6dCoS6UgHUqxggYKIBs1SBqCPVOh9grK6tBC9jehNm03rnNVrKfAa/z7kO
         4mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707782074; x=1708386874;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nnGyZz81zHkrAIqP9tARpfVqxq3PAPjhEx7hnLZLz8=;
        b=A79CclKKJHqt+AKjB7N7bqfvs1pWOF4XhyeKtJ3E9XqAhCZvBsKHvaFVshbH9wwYK1
         CggwB/4KJw7EYGY3sBAgC9EsrQqfb6w0eNDnA+kVjIvlqeOesB2qhQMJNAM4LTFMaRsk
         sG2i8pXe+qKpCvaqOqylBs5r2uy6AixLjgpOqF5EJEF8VDJRon+mKmwzu5yRuUJLUby+
         26LukWx382YTcYKbmZlEDA91HX5gwzBh6NfeG8f+UjkUGngr9MopqsLRHvcN5T2M52fP
         tQikmmhKFttBh3vdpznhdevkkLNZ6Pkx0PhXisiKoqAmOB/PJGLnU+2EroosSn4Qi9Hu
         DVlw==
X-Gm-Message-State: AOJu0YxpmCLs3Ei3KLMpWy8XoRa2J17/5PkHrHF/ah0Oh5DwQxXBxi3H
	KqV77T/JVALQxVzCFIoIrHVia+Kbp2nEfD762Nlv+bMEkVnzEqjcRCltWJ0G
X-Google-Smtp-Source: AGHT+IGmOVZgniQUqMX6sCzz3lTDERCDcprbae56xKCvVdEeGxlNXpt4CrkMoLhFPKuJQTFqLyxDMA==
X-Received: by 2002:a0c:dc11:0:b0:68c:b635:e597 with SMTP id s17-20020a0cdc11000000b0068cb635e597mr7407809qvk.16.1707782074353;
        Mon, 12 Feb 2024 15:54:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHpSHZwOCxuvJsAv1uUgRGYlBmLfStaCHHPx3J5cCY+TrPyeldzFSGVLuQ9SWLRJj4xaYuFl+1jTh8+ZChH7U/I7y/AA==
Received: from [172.17.0.2] ([172.183.51.116])
        by smtp.gmail.com with ESMTPSA id q11-20020ad4434b000000b00686a4f9312bsm687593qvs.50.2024.02.12.15.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:54:34 -0800 (PST)
Message-ID: <65caafba.d40a0220.d2834.5314@mx.google.com>
Date: Mon, 12 Feb 2024 15:54:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7541376088255669713=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/3] hog-lib: Don't destroy UHID device on detach
In-Reply-To: <20240212223146.4142264-1-luiz.dentz@gmail.com>
References: <20240212223146.4142264-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7541376088255669713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825386

---Test result---

Test Summary:
CheckPatch                    PASS      1.23 seconds
GitLint                       PASS      0.97 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      716.54 seconds
MakeCheck                     PASS      12.07 seconds
MakeDistcheck                 PASS      164.05 seconds
CheckValgrind                 PASS      226.39 seconds
CheckSmatch                   PASS      329.25 seconds
bluezmakeextell               PASS      107.19 seconds
IncrementalBuild              PASS      2018.04 seconds
ScanBuild                     PASS      959.03 seconds



---
Regards,
Linux Bluetooth


--===============7541376088255669713==--
