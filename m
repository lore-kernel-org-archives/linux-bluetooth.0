Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE32179
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jan 2024 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VThWpyfc"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7834a91b086so199606685a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jan 2024 16:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705277953; x=1705882753; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W0FhR02vn2TatuF8lMPBy9Htfrv3wUNzn7uSXTmu9F8=;
        b=VThWpyfczzMMr5rs4/gZmrrsWUwL8CIneAtPDwO08MNcce8AHei4CRaPhIbRjJe3fJ
         wqDdQxNUemtazIt6ACcJK7yPX5X6I8epDVw41rd4xgxujjQVeTps8f5KX+LG7nE4ynJb
         c21zaGxxqmwS90+cWTKZMt55xdaaYSFOWnqTsSKuNpEGodH1WbzhcNVQiYkkOR6bBCwm
         tNpzNAnA2hJ4pnLe9H/sz5bpPzJCfjxbCh6TNABB7+FVgNRqxRaBFsobKRMNrzeVo9It
         LhSQC6uo9lvXNAiAnkBekPxyQNcXwS7IB1FfGSQws0iQWNDECDCxvvsF9YavfOP5CM2H
         QkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705277953; x=1705882753;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0FhR02vn2TatuF8lMPBy9Htfrv3wUNzn7uSXTmu9F8=;
        b=Bkr8y/ziTzvxluSo+qRFmStkoC2S0pW1ozit7MrfSRWGs90PAXPUXSLv8GIzePn7qc
         FmBRI2+RuYSY8gmk5reNCeOxlx1cOBqtmiG0k7fOdkJpb2wcAPFz5+jvCXCURLRyweeY
         Sk+0UEPN0oLnKH+FrqQEt3QIAtYVBIQmOoP6deqNlahh1dL/sCjj/hqoc4n7VyY62Hh4
         ZvgyFUqDzxghih8f4bW2i787jEvNzyva2pjafJtmV8SJEqgO4at9ah+rOzq6uwV19u2a
         VFT9KQb//U5Jb/5D67nSjrOmROoT8MmmulpCBkN+u/EjSnHvenFcmGKCgZ2GrDG+2pWj
         a+KQ==
X-Gm-Message-State: AOJu0Ywwn68pZzccC8ZUDyernf5gKf6Gb00Va86bR5Bg8vukV7qdtwDA
	BeuU8Tny4J1vQoq8Lyi8TLN122vPgHw=
X-Google-Smtp-Source: AGHT+IESg6iKjrU4ULUHHPJiuPsZghsttnx5ZM1YO5LNfvDqa7WS+yFxWasVCLcw+UGaJvRceCzC3g==
X-Received: by 2002:a05:620a:4005:b0:783:56c9:9581 with SMTP id h5-20020a05620a400500b0078356c99581mr3155964qko.2.1705277952982;
        Sun, 14 Jan 2024 16:19:12 -0800 (PST)
Received: from [172.17.0.2] ([20.57.13.208])
        by smtp.gmail.com with ESMTPSA id vr28-20020a05620a55bc00b0078199077d0asm2573919qkn.125.2024.01.14.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:19:12 -0800 (PST)
Message-ID: <65a47a00.050a0220.49457.b20e@mx.google.com>
Date: Sun, 14 Jan 2024 16:19:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2759216716966137280=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add code to support dynamically generated BASE
In-Reply-To: <20240114224104.37716-2-silviu.barbulescu@nxp.com>
References: <20240114224104.37716-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2759216716966137280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=816773

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      24.23 seconds
BluezMake                     PASS      718.94 seconds
MakeCheck                     PASS      11.92 seconds
MakeDistcheck                 PASS      161.77 seconds
CheckValgrind                 PASS      224.61 seconds
CheckSmatch                   PASS      330.37 seconds
bluezmakeextell               PASS      107.24 seconds
IncrementalBuild              PASS      1328.07 seconds
ScanBuild                     PASS      960.58 seconds



---
Regards,
Linux Bluetooth


--===============2759216716966137280==--
