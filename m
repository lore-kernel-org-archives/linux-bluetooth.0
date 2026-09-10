Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4C583ACC
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062152; cv=none; b=LSjT6w6U5dgsrCwGGaw+zs1J5xeemothk6NSD5hO2DDTF9K7d5AeoA9jcS4IWXxjGmxyX/MTN9/XpF7UqSSMMiqHUVhQ9rqzI8hNOjumAg7C10ilfa3D04yjGOnSfGNml49JcugfJBuBDiRX0qMXYILDpu8zb9KMNKk6icABilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062152; c=relaxed/simple;
	bh=bpwKIvIPo0RfCyEvl663Y0zx+h9zRuzUbQfIvqiLYE0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=J0+hhhngwwizDMPkch2wtOiTPMZ2WIdz12FwyOwPtrtJ5o6+l9sMLwbHrRQJDqGtqwUAQwnD3WY3tb/Nb7ctTFPmWPLgaTV8yE0OTDqhiMBH+0lDVoNpr2YfdysT7x2tqPOSFfHajuPkufuB4mZLG269zatwYpfmCKKlfimmeGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYIMzV6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYIMzV6"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so1331711a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789062136; x=1789666936; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G8OLVGVm+xg5+ROAr5+3W6r8oO5V4tBAmQ9sfhW8sMg=;
        b=IKYIMzV6a4d64eo5Y5oEnMYPJNEp9eE2mk8k8FDKXogrRYtQB1/vfGe987Wai/WOfG
         WoF+pHdBI5kG1sjznOUAENGRwtCS7j7gJCPs4SnzvAJNxK16hTnGfpaRdk15kIKAin5l
         RK+QXdbRkLMJvjWglwCeXs+ocUn8mKTDA5oeGn3ZnlyerGsIr70plcFEY13adVua6k9C
         LKw7Ocry8l+0U1ZOQA2LmxgPEYdpbuMisV+0XxZgTSxSSAN46uC90sP6qXWbdYmDoI3x
         sGnd6I/VFS9Sqz2yavlYjTGFt7qubcfyWn6rdP82Tuz78bWGunxBaYCl1lfnH5DSVqyI
         WS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789062136; x=1789666936;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G8OLVGVm+xg5+ROAr5+3W6r8oO5V4tBAmQ9sfhW8sMg=;
        b=f1xIugPSuZfpVTfDsIvJar53GZtfVI8IS9TVgUFJfrsEWHbT7g9n+qlRUDWnZ0M6uQ
         CSnTSfNokZSFDvsktthvWFgRh08Fp3SBLR8hlgabJ6xRAkL2SSzm8bKnjwnYBwCPIIoU
         CRuHHj+XNodFILD4miwqmfznljMMnGhemWTtBWdVtYM3eECIFCZmQCK7z8Dy1Co9n4cw
         e3M4KaQxTqf6d70Qq7uzkxSOm/BTYLmNO6uTbzMXQ1DvZZTgky9AtOihU7lWmN4qt1Js
         DVdmOfPHhoc4Y9iScrXIJ0HCLq+68jZwYY+jB6n2r90zqkBgRFI2K54Luu9H/L9TEXiy
         XNwg==
X-Gm-Message-State: AFuF++m6bupnvjyTDsw0ndf/VQneSwe/3okzdueaJi7pMAbbR99rgqCt
	jMC8bx4w9PMZuND279Chzh5K5zaj0qOCe1QNGPc7/fEH+JprOzoj0asf76OFIQ==
X-Gm-Gg: AYBFou12mkblH8JjuiJ6EYgV8ZOxgXPfmVs0roXEt2jbQN7c+gbcnP83Sgw1cwbIoFM
	DLPQAKISmAoRKhlVl3expqZbLU1vamF8NZzn1gK5nqlClIIhC9J8VPQLi8YwIS4wHFspl2wkhTe
	7TWzLvtSqtHe5SrsoTqU6kfc+j4mhaV/Te/3us9vRY3vAddOAFlepLd1wzT7Z1q2l7JHdZTGRBX
	3igHyAgK7M9n+wxYjxxC9zGYjOfsz45OOaG5FLKB5sQEIX3tmeskbBbZ5V989dkGBdJFgO9R0/C
	enM9vFfXOLlL/Vq7Cc8g7mB5afrUcx6IT7Xuwd2O+KNWcMYi6cWbnCZTsG7BUqgoHA9Knhekd9J
	HIR1T10GGEMziKyfol/k/Cu/O7j5yvX3Ei8j7lorsh/H8aKliYN4KEI9KET/lUHeC9/wopwwbdO
	QQakrEkgAimi/w0/1XIPZ+F04YOZsBn9TAaX31pHU4VUjy3TCDVXr81tHvrK+uzj8C6NGxY/f02
	e7ONw==
X-Received: by 2002:a17:90b:498b:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39d70c55164mr14634544a91.25.1789062136220;
        Thu, 10 Sep 2026 10:42:16 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8137fsm232856c88.9.2026.09.10.10.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:42:15 -0700 (PDT)
Message-ID: <6aa2ebf7.8a95a640.18415a.4ccd@mx.google.com>
Date: Thu, 10 Sep 2026 10:42:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7845849332494704216=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: fix wrong argument to lp_get_uid() in avrcp-player
In-Reply-To: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
References: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7845849332494704216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] media: fix wrong argument to lp_get_uid() in avrcp-player
   Pull Request: https://github.com/bluez/bluez/pull/2405
   Created:      2026-08-15 21:17:07+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7845849332494704216==--
