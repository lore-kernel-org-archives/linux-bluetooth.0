Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CE1EBA0C
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jan 2025 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736460668; cv=none; b=nBTC5lUXAXnfvbgRrc9uekgz4YFy0jO5BN3EGVLV/dHmK9nPZUDIUO1M1wAM34JYUE8csCL8dSXCNQ1p1htAF0cfOj72RHUj/iED7whFW6OzN1uJ1UX5NvKBIJlasSEXHI0fyDGESiPo4PCirkDEVam7pUTqIQT2ix0TX83VKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736460668; c=relaxed/simple;
	bh=n2S3P40xzOwTXZP5jx7WocSkkbqS5Qaa9dkQZzHGt8k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UOW/XOCyZgY+1NQToPlhMEEa/GqB36LE5fGpep/kvUrNZBjAydej1xe28CTRjF/SidN1H2oYzO6erqZWF9ECl4sWigTuBkWbmlgYJNkmE/s9gX9nYMIkpXKnTEvzdG6l2oTfjp//39LCDFNPuPcLuAlp2Nr/ijBND7Q1MEZ4OTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCRwQl7i; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCRwQl7i"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6df83fd01cbso6307226d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2025 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736460665; x=1737065465; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UXrBJMSpDKuRx51Z4+tCQN+euECXlB9paD2GPS+1ihc=;
        b=KCRwQl7iRB4T+LlX5TxIRKhdg/xqqm/ykI6nO9AedUkIr5vqrDtF5ojUpbf4xTXsbK
         kS+NgDAXA3z+8HJ5WGNPUQCySNPXwuC3hOZNh8xrKdqDV+3RNYGJ/cwNbYFMEmy/1DXg
         f3mVrMFnt3h5iWv6efVHgh+4wKy81n5qPSINYCk/6JeyIqdZvguoO18enzDxK4NGvbGf
         86I6kl2q03wVKtDO0iklCZFMFOBut6SUgwT4muMxVszf1XxrvOlVDWph0w7i0uZV6ZnA
         w7nlAFtRzBS4QiIWiO07vXcKbKJQclcA9YpRrTKQUvYP3LVn5cIJ54md4S2irO7aezgi
         pqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736460665; x=1737065465;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXrBJMSpDKuRx51Z4+tCQN+euECXlB9paD2GPS+1ihc=;
        b=HxXN6ztwe6oKO2UkknWKMAJ756VcdY4pGO2QQ/15hwn2VnYcuycnfggzJlY7Z2JSEK
         xNXyOWdUGWRB6h9oi+GImaNy4GcHGYQl1j1mR6bOy2Lwx1TtNdve8t3i4qm7CmldpMSn
         FL2zCn7o9jYLgMC2Ig6lNSOHW3I9zaAQfRYAPEiWqbInJ3nZkfA36dXi67nFrF+UWfIF
         WvxQfE0NGmTOginR9hAWHDMH8QZQcwUemBB+jXK+U6hHxXXpnE8WtT2iu5U3Uj0iswV0
         YOaGeTwLVT8xkKn344YkU1fazqUMWUDFJZJiXfaM6OHY1GVQQQ4iPuYQBIcN/1ymlsRT
         ui0A==
X-Gm-Message-State: AOJu0YxuYCDfDdmASbICfhzrLxF3tbjd+so2XPuTNXYDVvUYPW8p4iLV
	pWtpfm9uDjLV286MjADuudwO4jBf75G/P3AHg6FhKzbzf12obNRN/uPL2g==
X-Gm-Gg: ASbGnctImckAXlD2jcg5VkcATvbqn+nd7dTlAYwefuUDROyNeDypR2s8yT6LAuFNjcU
	BK83yUYVWru5G8kF6Kx+eTWP6bcLCUn2AxX0U404BXHxmUMdgsSF2cd/auagqN/xrsufazDPieF
	ebvDLQbtKbG52DnOD/7TTkP8Tqdr7cEPiN2qBSup93I2ibTcStFJvP4DR1uqvRwf1htRHl7d2S1
	TRUsf5APRBw/NqsCk2T72r3RBRWqQf58joWBhk4oBRUjS0+fpvALg/M7xpt3dJt
X-Google-Smtp-Source: AGHT+IGY4xYh+LhO17BcTjgqCSBZ6a7nWM3Bg8pMz62y81B0zhGjV3kgfDTtOXiHtt2wiYAJoeHVHA==
X-Received: by 2002:a05:6214:dcb:b0:6da:dc79:a3c9 with SMTP id 6a1803df08f44-6df9b1d220amr153472236d6.9.1736460665235;
        Thu, 09 Jan 2025 14:11:05 -0800 (PST)
Received: from [172.17.0.2] ([172.183.155.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade8ac96sm2676896d6.114.2025.01.09.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 14:11:04 -0800 (PST)
Message-ID: <67804978.050a0220.0733.1876@mx.google.com>
Date: Thu, 09 Jan 2025 14:11:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3771187211160579142=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] build: Fix --disable-avrcp
In-Reply-To: <20250109210500.2324501-1-luiz.dentz@gmail.com>
References: <20250109210500.2324501-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3771187211160579142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923917

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.68 seconds
BluezMake                     PASS      1674.84 seconds
MakeCheck                     PASS      13.49 seconds
MakeDistcheck                 PASS      160.75 seconds
CheckValgrind                 PASS      216.12 seconds
CheckSmatch                   PASS      273.86 seconds
bluezmakeextell               PASS      100.11 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      853.30 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3771187211160579142==--
