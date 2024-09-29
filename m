Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4917580
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Sep 2024 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727582831; cv=none; b=RcNUcU9N9Ptft0bRTDHJdSVsXzeZvEz4X5ALvYOsHaEy2fF/2C1UAr4DAtQtbbp1J3ntDd0Od/UEeOAqtXV0pOaYH0xBO7iQMsq6HdFcCDvBmrDEb61H2rfTL7XwExzHBRlpPfPkcOw23Ez4RVshGtvLz15dvqp1IzCXvhCtUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727582831; c=relaxed/simple;
	bh=ehLdM7KEWSes/9jSGKbqtl8bL6EWzNm5bgoJzcxvNpY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SdjW3nLIiJWpHvJ52a0mXLn4vsc0l3UnJiK2UwfNjxEpnAhd9dO0CBLLfF9wRbT5NmrcPhL7Ch8FjE4xyTiVvWXcStBKwKIpQuuXoIn1D4mhSTKzk98Ce+yisFeOPu6jummkOLQDo5uiZQeljq1fuGnhDmtkMAyvdBM7ezW85tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN+gyqm3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN+gyqm3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cb25aad5dfso31416076d6.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Sep 2024 21:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727582829; x=1728187629; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=apgbluiKhOnD/jHuVRJQL0QtiueebQqdHv7H5Q69H+w=;
        b=JN+gyqm3Q0dGgqkbKN8X5bXzkjYSFCy35R6jNp8fLZWmWnErteUe9OK+A1iK7eKT3T
         DAP8h6UjbHiNTmBAFr2ATc0Fo16J9CH6ZLjBJxUZBWKREYcn2yW/u9fL2gsGffrSZLaa
         f0fEXxDqJfjL/rfJX3o3FH6ms5eoL1GMvDIr8gAH3UgHS+fObRxF23S3qClW69benvKD
         YiPW5yx7+TkZxKgZTg5FUNYfKGQhKSu5wBlhZ1UatZlnt6fosC9RzTmDR6ufqeBITBes
         ryr06TQlpkmI7fAikC9EtJ7++kbqhdqDKIEDP95z7CZFkQHhOyGkJ0wKbQbeJzk3zjM2
         y5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727582829; x=1728187629;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apgbluiKhOnD/jHuVRJQL0QtiueebQqdHv7H5Q69H+w=;
        b=RUURt19WnDCoHkkuANdGOgHPv/MZfWUHl5vzFrRTphC/UlB2oaNmMrEFzPBB9CBCrD
         ncOzN/JkCgwziHtD34z+HwLjZjVvpPMAe8yHhrqHMl8Q4T3szlnPehXSzX3LGev9OWxO
         EUyoezyNZiDgt3jT53/V8F9cyOpB2uNUBwvLiOxuH+J7nugZsYRE5sm/jHxyf+U4AdlR
         yDj27kA1s4w5kFysSkCRstyV+gwGfcaFbn8hc6tALuPWDk99ZUtfLLtzHcvlbx8ZIgXl
         1s0EzFbRJQU7WkpxxZZQdk8ifWzu+4tLE0Frz+3k7HOj3gZfrgVYmSK8maEWmG050qlK
         Im9g==
X-Gm-Message-State: AOJu0YyGnNKnTMMecZy/2noHiiVcvTg03M63Ie8HyNSO0SeP8CEngwGO
	xHnXQo5jcUXwgolWhh+bqnTBANNrQW1Eer94E5M//lnO6TCRuTwj5xbOqg==
X-Google-Smtp-Source: AGHT+IFz/uG9QiMEFx1qImyDL4ZcAlAvp8WIeLFf2Z+x2wT7qFo5YYgX6aLJmvGijEd2B+5ZZORFWw==
X-Received: by 2002:a0c:f408:0:b0:6cb:320b:b670 with SMTP id 6a1803df08f44-6cb3b5f1c45mr125323576d6.22.1727582828851;
        Sat, 28 Sep 2024 21:07:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b67f5efsm26073206d6.110.2024.09.28.21.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 21:07:08 -0700 (PDT)
Message-ID: <66f8d26c.050a0220.f297.8e28@mx.google.com>
Date: Sat, 28 Sep 2024 21:07:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7669024806739131489=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v5] device: Remove device after all bearers are disconnected
In-Reply-To: <20240929022256.3271298-1-quic_chejiang@quicinc.com>
References: <20240929022256.3271298-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7669024806739131489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=893665

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      24.01 seconds
BluezMake                     PASS      1596.11 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      176.72 seconds
CheckValgrind                 PASS      252.22 seconds
CheckSmatch                   PASS      352.81 seconds
bluezmakeextell               PASS      117.37 seconds
IncrementalBuild              PASS      1490.21 seconds
ScanBuild                     PASS      1024.31 seconds



---
Regards,
Linux Bluetooth


--===============7669024806739131489==--
