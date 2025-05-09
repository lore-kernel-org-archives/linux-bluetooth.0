Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74442AB0
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827244; cv=none; b=HfwufKho9greE7JuJPDUMZNc0beOw3azbLcv7nbznvWketoOfLN1GAtSSEMEPvf0bS5G7GnIg8iBywKobjgi0iHaHqyhtfCcDU2JuxdFcoRJnTtpajjT4r7OHKP4y4QR/cVy53QVRx72piJcmJ7gS4f15P/edJbeQHL+RCZjJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827244; c=relaxed/simple;
	bh=tlGctvsZqp/DGmOb8mJrj6hLyBvh859Ckd/AhD6r4xY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PzM7caufCYNFOlf/I7+xYFfgKXJ0X5n4hA8gdWWN7fPLB5qVSlvm39skHw7DAkUDvkJJXvZvEFdRG/zoy6cvKi1gJOgcZWd8+Xqo7RAdYpqvRXqzCt4NS/9ScKZnHtJmPG4B6W0ZigwWcj10NVtP2ddgX35mUQVkBW/KA9VXsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPsAR4uD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPsAR4uD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7418e182864so1905303b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 May 2025 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746827242; x=1747432042; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aEnF32uh0YnbeiXYpjANli3Uws6D+h5rEq6VDFEJGmQ=;
        b=nPsAR4uDRyuWt6FYF694nZPLKQkhosPeUBOVyNR+7dDnDzCAIg6rNCFKgs4Z64tldc
         lYvG/4nE1XCME+HjCVf/OSoUj9n+oX6X3Rs93HPBUHphEmu5neXx1MSTfJt+Vv7AD6Zt
         ollBTbb77kot2Vd7Sc7o2aG3xZ7WTkKpzf+jt+bhNeCPBX9YjkJgOYO60brNtP79HzBh
         u23QnrUULYv2WUJfpPktqtfZ/2VknNiAvhcH4YLNouVLOMM7eZ6XXGnUNkGbl+CwbZdR
         gnkWaqASI2v9ozBdqE88/AyG82BR7F24tJsfmEy0lLoweNvjnomJcavUqfRuCbV54IDP
         auaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746827242; x=1747432042;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEnF32uh0YnbeiXYpjANli3Uws6D+h5rEq6VDFEJGmQ=;
        b=cSDfxrvp5tXN8fb6zHiKrLYtpjFb0DFhac/WSrhBBBTDoa+4uUCn4D6MU/5rTWgp7J
         0ReeiEGNbLHOlUhSV/iB6E4gCgSp0b4UZK0XPs62I//Kvdhg/0DJm5sgcFnyZu0+NhuD
         8Rb2YU9g2vULislJ86dEC03V4wHlqrbfyl/BCO6I9IE/HZT6xOuNSN7XCP4NWAiySJBk
         PrFloelkvK6nHD4GCQFl1uCWBuCgHDlycMHOlP0dQtOsUZX2/vq9oyQSlx/JNHJHKwZm
         D1Me04Tv/YNT8EPlIqH9j8p/XTsi8q4hLc3JyOWxEKMrOeW+L5ITeoYOkBDVywmdswYs
         khpg==
X-Gm-Message-State: AOJu0Yw6pL76QyECawKpOXRYY8oXrwwKkh+zuRuLHsXamLwAc1neAICM
	G5uLpoxTb9GRPCWSi62D6IaYSiWjfBXgsMnVI3EMrTrCsSW05e322kahZw==
X-Gm-Gg: ASbGncu61D6aWc2EJOjw4vHjt1dXfl2AQBPnc+EjXs4wIzBK1oC4V++OK9Es9A7kJc8
	niD4fbn8334TxmcQRLUDDbOmKdYc/PCyCHOBSqllD88ckhr8RwZ0SftX/7Tr4wQCTiovhSJ6bjm
	oJfafYXbiC6hon3U4lWWFBwJ+MiCUXzTP7Lez9NztcTEBFz33vJtdKYprcOMbWvMttAXcqcdCcQ
	jsU3+9oLnZP8ae0Dh6rdIGriT1lctw/n18SWp/TE9CisX3DUvX54l6Ybhm0odgfSANiagjNvqfq
	b4YUUiLV3KORVCXyqXOBlQLwY9Ie6Zf1dAWMOUeVq/IHsF9poFTrBaw=
X-Google-Smtp-Source: AGHT+IEQV1ojyZNjjq0c/YW8gr2Gw4LFBI6OrZtXSZeSdEWjsX5Yj6RMLPkZzjSld9Oq+viTU3pDvA==
X-Received: by 2002:a05:6a00:3d13:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7423ba80629mr8012694b3a.3.1746827241624;
        Fri, 09 May 2025 14:47:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.7.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a408bcsm2277336b3a.149.2025.05.09.14.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 14:47:21 -0700 (PDT)
Message-ID: <681e77e9.050a0220.211d4b.e1a9@mx.google.com>
Date: Fri, 09 May 2025 14:47:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8848251627083724571=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] mesh: Fix possible null pointer deference
In-Reply-To: <20250509201806.643057-1-luiz.dentz@gmail.com>
References: <20250509201806.643057-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8848251627083724571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=961526

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2594.54 seconds
MakeCheck                     PASS      20.16 seconds
MakeDistcheck                 PASS      200.64 seconds
CheckValgrind                 PASS      276.55 seconds
CheckSmatch                   PASS      303.96 seconds
bluezmakeextell               PASS      129.47 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      914.93 seconds

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


--===============8848251627083724571==--
