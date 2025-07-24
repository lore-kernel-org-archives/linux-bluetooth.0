Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E43217F31
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394029; cv=none; b=jyJYx3uoSfdKnVmEqZT+3iAWc6AAygddi0tufMVxDhf8zwDOqeP6B0Oi2Z1pqeN7nGHd2oJhsTaogtGIohRbC7HnvAHgHw4E2edy9m9y4d3oDN829tUkeilQ0Duu75SJIRL9C8yJcuAspPWkn2ANcTw+RJVzbotiOlLOiDcVRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394029; c=relaxed/simple;
	bh=7AwI/Dtv4uvlUcf7Dt8xvKqHFJiqaVYHO6bjIuZixYo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aC29uOGsMIumlpvi3X51Kg31PWJfwcQ3qr2cH7ZPyht4NZl3uUwx7lqMsk1t5A363Pm7J6MFI47UOP6zVTV0lelMrTdR6YyDzYSPeIl+9hI4YY716rPBty4jkSp54SczmLNUzja4SD5jVmEr36hNKs7CHUYmUExNyWmtQJtHwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrn70Khv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrn70Khv"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34a71d9208so1206940a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753394026; x=1753998826; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7K8uk7s3GxD49XFn4Kgj7RU9Z04zJo7PYpBtPZ4azGY=;
        b=Hrn70Khv6XmlNUTxQFJZJwma/ybDTj5JxE+Phkjv/xNQ54q/qGwd461A27IiEg3ndO
         b4DSyAznbdC/tKC9XEd2NR8ESVPKF9IcqkxD5kL8V5E4P5Isx6CgsZrOEU3eb0no1fHs
         D3cW0ClyFzFsQMh0uyurkez4fVnTz3WouzEsb51Qe5o6gUNzSUZez1SzSjO+RR0mStJl
         A5lUU+OQpq/rMOLYLjL6eL7RwAdGzSFCG9rr+0ZaEYoiCBemHeOQXjLGTbJTJBMMhKV5
         AXPGw7qL/sLCBC0JqoRxS01j6bfDYRFfHe65yK2yReYt7ii6FYDkNrcuGyE/AqURd/52
         Es1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394026; x=1753998826;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K8uk7s3GxD49XFn4Kgj7RU9Z04zJo7PYpBtPZ4azGY=;
        b=u4IsyBv4Vf5k5YhkkeRy91cLI+U/wkOLzaO9s6xjg/QHCc/s+z9ihDHAlwfzZihk3O
         Ra7FggWDh7TJse49faoWOTq0rkzFoaEwApE/2rYQdwbiBBw9Iq5aNJR+XFsTBUMBd3qR
         KcICfmJ3Wivp7MC94pvg5ZNpYziyy+O+st42CvvEfg6/070a5xn8eHb+FY4gycuxpz42
         fzh60sCGGfjC5CKii6Qx785VvTubj8V2iCwVl67tiWImnqjd7MiWHr9HhodUIVrP+V0h
         I0LUFzSMwRxGZqa6XSbKvANYLaR5IYdERXEu022WlHAZtSN4G9njx3b4/E+HMjHGiRUB
         N/nQ==
X-Gm-Message-State: AOJu0Ywxg5+GOTGugFoAF2l0TWi5JgCd7W/DVqlO82Fw3d8Ki5iih4Pd
	DqNQh2+gEH5KlHck+d4+dFgWNsZaIy8MZyzQC3TnkLOHQdX3ZHcAtyNpP7vdeg==
X-Gm-Gg: ASbGncsQcwdsX9uUOtA8c0tAu7/wmtF530wbOqvDp0UPXYGWrZucmmPAXh9caWsQa2p
	Xh029yzIerVkhMrUEe+xwBmws1SqS/D6YoFBLGxc13PEsUJJeMfnZ9XqjXjn6u3Mlb48blvzA1d
	ZlKW1RgDWic7g6AdsirGqqEpWGvu8VQJOMdouTpe+TKDqQKd/j7mGI1PE0HX4uQtG2MiVolr+zV
	rzb+F9jawaH3OZvV9AFAL0Kfas9BwPvFKct2T0aVMF1N2iDvZGkmpyO4RR3MvssfbmzQM+6pszS
	d8sKX+t/n7ZO7kc7notOy/WVqh9pmawalWS0eZsIbnVd0wTSqDm9ZxOrfLl54V87Ls7JLb/+y4m
	xgJoBlm/hKGdEpmfGe6MHPxk5sIneGg==
X-Google-Smtp-Source: AGHT+IHxNkfm1RIfqREIjQKXkRd+n26w5dqu4oy+Qsgfu2tFf0qTgU/IvAM8yUyb7Qe3UY+6NstxvA==
X-Received: by 2002:a17:90b:5242:b0:311:df4b:4b82 with SMTP id 98e67ed59e1d1-31e5078f52bmr11151878a91.4.1753394026464;
        Thu, 24 Jul 2025 14:53:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.203.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662dd1c5sm2088937a91.29.2025.07.24.14.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 14:53:46 -0700 (PDT)
Message-ID: <6882ab6a.170a0220.347385.f6c2@mx.google.com>
Date: Thu, 24 Jul 2025 14:53:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2638058294162696388=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG
In-Reply-To: <20250724202424.6978-1-luiz.dentz@gmail.com>
References: <20250724202424.6978-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2638058294162696388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=985699

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      19.93 seconds
BluezMake                     PASS      2510.46 seconds
MakeCheck                     PASS      20.00 seconds
MakeDistcheck                 PASS      185.67 seconds
CheckValgrind                 PASS      239.22 seconds
CheckSmatch                   WARNING   307.46 seconds
bluezmakeextell               PASS      128.05 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      910.12 seconds

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
emulator/btdev.c:456:29: warning: Variable length array is used.emulator/btdev.c:456:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2638058294162696388==--
