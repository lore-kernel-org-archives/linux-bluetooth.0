Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C62749E6
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 May 2026 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499733; cv=none; b=aS9TiFdqhovLarZsApNUzFiV4TIHjkOyx7QFxth6cWv3M8ceYt20o4DFXawDW19nLxE75HWeOH6zYOdGEt0R3LxgUV1OAfr8XYyyoKWrXmFio0waT82txf1o7YkkeLyTrIbvep9d0hbRW7E95WSnBmZNyFaKhqdZBU7Gnn/KNNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499733; c=relaxed/simple;
	bh=7EoS2EOF2ovaUagbg+4uxh7OsiY0KqQFBQw1z3/OwSU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XOOuoFH0/JuvLP4ZGHtagheJtCMpe/X9yKj5AolF0rWniXMzgK0LVjWzFaAG3ycDLEp19ihzvb0XJWiT4PQNl4vkIon7A3FX9WFD8a0Fcyba2l8K6SFSjosDpKCbwkajPHe35yEOnHvKFfA9XTdVnrrdUL1kGQWrxUqLLvjDwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUit1tuB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUit1tuB"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ca12973e15so107491606d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779499731; x=1780104531; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7EoS2EOF2ovaUagbg+4uxh7OsiY0KqQFBQw1z3/OwSU=;
        b=LUit1tuB8ioSXBA88TUQ3zmtJJbM8gVAmtIlPr5nHr3hB7IXP2LXbc5dtY8QT/Kmts
         +OdocFANL10osP7VkAJESRHynRLmg848NUo6Mk7bfQEIFnlZXL6qY1ztcze52V1OiQ5e
         oXWflXW9nwHwdwVueuget+L2bNAKhjw9k6hVdSBCcaEWuykPNlC96BScLtlbN+yKguSJ
         kEp//v/pteRjXL5sjEmK7Imc1BPnxZPfg24sAexeUKoKQ9U3jaPQim4OaNXRrKhS/Esy
         ttven84L7ezooD07z8mWXWY7SVobzTu/8aDLBzp3U3JPP5/wYog/LBG8AaBekVXBHEBI
         TgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779499731; x=1780104531;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EoS2EOF2ovaUagbg+4uxh7OsiY0KqQFBQw1z3/OwSU=;
        b=Bd9OpeYIEqfWri4LwDr8qhK60ofe4DAdLJ22jCjEygdJ7XBbPEYRFgcgilQo1BiCrU
         sUY2vhAocB62BVhKFhjIrFtBMIkmeeTELHhaq2ipK53vflpSV6l/NxkIqxO1iz+0VJn2
         kkJJwGruws9+Pa3HYvSAHxDAy95AJUfTFoTdojMZR+j4qoLVgBdDRS2B2e6R4YN7FWxU
         r3EfhRInXGFroqFe2bnsTSpa+Wl86nuu0Fj+oiFRtOPhS3ANJD/2B8XkOURiXwKOj3mQ
         8YidlnC7CDkL/TAJ5xuwKYEptESOEeoPYzEbjBr3UPc1JuvwyAHzEIh37YsES7RFu9dN
         tFrQ==
X-Gm-Message-State: AOJu0YymwcJQlKOmr8SyQuwRdgWv0uTNTb4bZy5Vx6O52Y0eHFRADRGk
	er+h6kbbx/QspWZ9EogqZ92vOjEIQL1wZ9UKN74P3JiwiiitOthFOJez9dfV0g==
X-Gm-Gg: Acq92OHQThafMhDZG0yMfVbvHPMFkmniXK85n6hr1WYYMYvVcF5070HH8oQtIkNepK+
	XD2NiL0+yZf6nxr5+ami5TmBEucZeWJEcJBWlgHHft9SZY0LUAWDMrcVgT9qhq5P33MQ3L9kd/Z
	CDAAA482P85vk6vSIR3gP5fdi+kOVF++cCYjBBUhVePwVhOZdAQwb1r8cTmyiZS0AUEieRdN6G4
	3z0l557GU+0Ujc/Tj1PxjVW2ZumwbyxEyZToy2FxBl9d7C8YWTI/3eMqvmbXHYVFHc4LiHwsLqz
	08YYZK+ieas6UKseZHQxE9497uqWdHXeq/MPbR4WcXz7gz0WHTciEUVhTYg3KBjEoc5brQ9Cmt4
	4DtLmfTMCnMGll0wlnGqlgHlrAR9Zda9epuWf6YJx1pXc84HhFWPxNam9zWE7A+dCvIyG4cyMRj
	IdV3A1wtj2q9C8JXMghMcj+vL8OsCK
X-Received: by 2002:a05:6214:2dc5:b0:8b6:7f3f:5286 with SMTP id 6a1803df08f44-8cc7b62d286mr106716366d6.20.1779499731245;
        Fri, 22 May 2026 18:28:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.23.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm38149826d6.24.2026.05.22.18.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:28:50 -0700 (PDT)
Message-ID: <6a1102d2.143d05a0.140c35.441f@mx.google.com>
Date: Fri, 22 May 2026 18:28:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3743325041689829417=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, Tim.Bird@sony.com
Subject: RE: Bluetooth: Add SPDX id lines to some source files
In-Reply-To: <20260523001337.28134-1-tim.bird@sony.com>
References: <20260523001337.28134-1-tim.bird@sony.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3743325041689829417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: drivers/bluetooth/bluecard_cs.c: does not exist in index
error: drivers/bluetooth/bt3c_cs.c: does not exist in index
error: drivers/bluetooth/dtl1_cs.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3743325041689829417==--
