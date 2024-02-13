Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0057865
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833440; cv=none; b=jw5z2xgBaiCEHfXhFRNZN47tcNorOY8yzSfrxnZ0XmAwfCeqNOtveW9iPf8+zPrb2VHZaM5S6RP2yP9/OEoVv4vsIMvCpO2mfdL7xVBRVVdH6vdXBjFs+eH/zg++jG5tSNXaijqqC8SCofq4cDDWIJH6mhU7um32GpLvst8dFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833440; c=relaxed/simple;
	bh=tz2GxDG7Wx2p4BGuyuTfiEy5c/VRF2X6X+9Mj3kjrxc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SlOiKm850LlF1et9DEGKlkPd49NMI0e2HonbTtjLHoU47mPGd5/ie9WJJmDv6vqH8bk9h/PnQKh7JKlDf3wOcMi5K0XH+IUlYDPnUsN32rHizp6Fey3OLGgH1TYt8Lywo6xxYDBCbe860mlw2WuS+VgKkFlAEUP8seNXKnkPSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVtr0hE2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVtr0hE2"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42c7edb8870so6033211cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 06:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707833437; x=1708438237; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dVY0gTfvJebneorM+UhD7GeHWCLEVU7Cq27JR21QIqo=;
        b=PVtr0hE2NSdxohcx8eggLvPbLcULCQgkC23Vf1AojGrrbbo8xETRq5LtqQSRWjFXYJ
         nGUjja85BnCVUOYm2Onzxixkg3s/6MDok0vDHRDKb6iVC+6uoUZFCfDTXW+qc8cXSOqV
         eU5rw744cYUIwkoJbyT1eTmNaBkpcb75JcZ6Wb4QA+kAbrljsOWuJY0oHb2UBwe+dINr
         Rs/K0QfyU1biraDhNte1SsDRzZMJOM4y1umZvIi8PV5Xj7yu0HLd68GiEPT4JVaaarHM
         I8MI8kAtcMa9UoK7O8ZIrnafudEY2YDL+ASnZp+VzihUBzPdRPabwnlteOxFcxgEdDVx
         IbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833437; x=1708438237;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVY0gTfvJebneorM+UhD7GeHWCLEVU7Cq27JR21QIqo=;
        b=MBcM56MDqf8wr0yFddTQNWcNDPrraVNLP/rUlWd7hhpqLR1KciiP2rdiJPxn9qfQOP
         F78ytbjQwwEBDS84loeXFIGUFPY3v6g39h5yCwlTT/kpnM22Mjly0gZYaybWtpbCWWhH
         iG3QlDE6jTGb5D18cnaxRlFtfEAMTw+CTcxwGhNZ33Z8tLfnjf9My03Ibe60K8lRv9vO
         K6jPVMP2tCBjIFVsEJc0qq7yg4RP+tG+ewytnDHFZKAKkASJnhhhMsZZdvLMsehqDk1E
         JxqZ7c7puCz4iN9qCRBA7YSyGhaD+x7ImO5KP6hBNXN4RNzOS02ZNBRNqf35TtR306lx
         NZoQ==
X-Gm-Message-State: AOJu0Yxz330x3295gpo7vBz24GBx09EwdjreV9nYzxF8CTFqF16b/HZT
	Fxnwv/F00xN1tecsFdxZWGmSnJeQIa2uvOYhd6ndcNLf1kx+RmSN+BTxCE38
X-Google-Smtp-Source: AGHT+IEgi+9l+7rBIfUio3mXEK5VOb8tZlUIdSNjhDz8AxxOZNhdq9m6aPfTyo6xz4xauTmouiNrBA==
X-Received: by 2002:a05:622a:60e:b0:42c:60b2:10c6 with SMTP id z14-20020a05622a060e00b0042c60b210c6mr11742623qta.35.1707833437253;
        Tue, 13 Feb 2024 06:10:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWp9t8Uia5KdOCwytdxgdRBxx1pstY+a1s2G+eVEyxuW9UcKILpiPECsvPkC3FDIEycPr7FpHhHWsNZiPF/bJ3Xu0Jjdu2xrlztuA==
Received: from [172.17.0.2] ([20.97.189.16])
        by smtp.gmail.com with ESMTPSA id ju2-20020a05622aa04200b0042db245d609sm279509qtb.86.2024.02.13.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:10:37 -0800 (PST)
Message-ID: <65cb785d.050a0220.92313.190c@mx.google.com>
Date: Tue, 13 Feb 2024 06:10:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5158091229934449297=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] advertising: Do not set timer if DiscoverableTimeout=0
In-Reply-To: <20240213131205.28250-1-arkadiusz.bokowy@gmail.com>
References: <20240213131205.28250-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5158091229934449297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825610

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.19 seconds
BluezMake                     PASS      737.22 seconds
MakeCheck                     PASS      11.86 seconds
MakeDistcheck                 PASS      165.19 seconds
CheckValgrind                 PASS      227.24 seconds
CheckSmatch                   PASS      328.63 seconds
bluezmakeextell               PASS      107.30 seconds
IncrementalBuild              PASS      698.83 seconds
ScanBuild                     PASS      974.22 seconds



---
Regards,
Linux Bluetooth


--===============5158091229934449297==--
