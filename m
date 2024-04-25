Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFE15534E
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083142; cv=none; b=V6+yMemaOXz3dr1g+CjmLsH06X4402JML4mTmZ7a3/CkTymZXvC9k5dI4mH7VxHcNNo9x491WL2+LzTijW+gmYVRQ1t4MzT5t5pG8QApTYebN2ImbrxMU5Kj69lUKBnW/uKnIAxJWREUK3rk/MM+xa2Hq4uXUEhLot1ksxqA1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083142; c=relaxed/simple;
	bh=ntuqGqOU7qS50GmBcVh2+jsYFATq/o1n6f+LO0zlj2A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Fl5LZ9gE/4DL3xQbdbeWbld/xetPQ/GWqBFjbgVR7OapJq9TxxCZhpkQ94GI5rybzlGiZDm9wvJZ1wUFVljcdH8DgDIloTrM0ECNNI8BRoWhUqxLu0WlZGPoF9p/XSPx1sNgKHcjFQ+vM/3dMalXq5C/YyZPJ/T9TvYpllgx1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct6+cWIP; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct6+cWIP"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-437610adf96so9902751cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714083140; x=1714687940; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ntuqGqOU7qS50GmBcVh2+jsYFATq/o1n6f+LO0zlj2A=;
        b=ct6+cWIP7AGhPIlq8Vw346bo4dAVFKcsDO+UpW/L/Ap7oB3U0UeokrOKe5sojwHfRt
         6Jb6ruy2M6a2WZM8G1DUohc3trm5s0qDdQnIXCJ7wXMfTZgjuVRC8hzM6WjmRUuI1B3K
         8LauOI1MxGZ1mK9e8yzfSfaMa7Vi8rmbbf9ebjFtohP7YTMLdaibvpa2BBm6FDApPzRL
         Jsy+x7Nu2wkMWhVNwANXVh1ssI5fmMvf3NttUhGEZ667QWxqwfaSmuYPAPWDdp5NMOLO
         HeGcCaj1+DCHMKyDn3NfpQzIs6L9iLgQrWkScmEFQYDIX/By0DvtyjnCX0tMfiIOkdlC
         nmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714083140; x=1714687940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntuqGqOU7qS50GmBcVh2+jsYFATq/o1n6f+LO0zlj2A=;
        b=SnPYfAYSkiawsCFRWk+9JGY256iBfE1MEtguW0G99ce/Ib8tq5X/wB2bJ1JukuBla7
         1tkjr5KGfm8zt9rVk00e+FgtvfDsSMfCM4y0Vl65yLRn6ctEsmRCyYnNuzSGFhm6dOL0
         pUHlryRbpr6dKTkHGNdFUpvY2U5nuh+lwtGRNhMRm2ynQtuvSMKxxVvo14InAOXmLXdC
         dEZLSprb/6AQtAsRS9PyokvkJlaxsvdccM6mBBN9FvGYg81n4eyrN8Q+KLCerUFtv5O5
         j2OW94YqHrueBGTtgyoD0UvaqGGe+SwoiVdSzeK2aA77TgMaNBDMVHI2O7gnLGY8Hk49
         DTww==
X-Gm-Message-State: AOJu0YwuEyM6mCGNaTQhO76TT9K5QJkH3ckJdK19vA3E8SwgINf45Cnk
	n16Rc6Bt7QVT5e+XZVELJhtV/nRyZ/xQ1xP0kgT3uyZmUBPb89FETze00g==
X-Google-Smtp-Source: AGHT+IGZVa29SXBA5HTYKTYaunrf2AyMijerb6u+I1JQ/PepzwLQfD7Ki0Q0NV8ZHSg9gs2OCU/xOg==
X-Received: by 2002:a05:622a:107:b0:439:8c32:c43c with SMTP id u7-20020a05622a010700b004398c32c43cmr1203163qtw.40.1714083140258;
        Thu, 25 Apr 2024 15:12:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.71.163.65])
        by smtp.gmail.com with ESMTPSA id b13-20020ac8754d000000b0043718726f76sm7282118qtr.90.2024.04.25.15.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:12:19 -0700 (PDT)
Message-ID: <662ad543.c80a0220.534ca.52cc@mx.google.com>
Date: Thu, 25 Apr 2024 15:12:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9179748969490204184=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean.wang@kernel.org
Subject: RE: [v3,1/5] Bluetooth: btmtk: add the function to get the fw name
In-Reply-To: <dfd3a5830333e9b59ad1a1458aac8ac2fe28027a.1714082459.git.sean.wang@kernel.org>
References: <dfd3a5830333e9b59ad1a1458aac8ac2fe28027a.1714082459.git.sean.wang@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9179748969490204184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:3123
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9179748969490204184==--
