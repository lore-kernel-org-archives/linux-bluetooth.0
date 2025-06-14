Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702C1F941
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749932235; cv=none; b=la2sBCIVzs8QB+Rv3hkeHeGesNDdDr9IP1LlfTDaN5tzLT20GFVdlLOmTK854a/VfAaHLc7LWFZxZ5czk7lnzGmGfVRXpzZx0PydU9ylcKoN4qRGzTJl2lr99ERefX6Tvkm8CSPjFKrSTHRDGr6xt+KgwlbcYResMezpu2UJo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749932235; c=relaxed/simple;
	bh=3KLWdCGg0JOKswW01BMvqtrHzNqEzIr8DKv3TQdpObQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gn7Hk/MuNa8uOJuDo5l4tVEJkFlcAMaBiRyhkSHDGd6dTVxpE7QAyrQyVLD1NXGhZzU5WSCYW3sdId6VQjW2iMAOt9px62nt0rwIZjASte6+3GZQ+sB1Vwx80BmM63nz44xJpT69fVClYE4RJ9eJo8Cx4tQ8qFBFjqi1LIaS9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoCqZteO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoCqZteO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fabe9446a0so34519946d6.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749932233; x=1750537033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3KLWdCGg0JOKswW01BMvqtrHzNqEzIr8DKv3TQdpObQ=;
        b=IoCqZteOx7yGLdHzNqgiit1Vs0OX8eKpXV2xmeTyYVU6GzE3dBUriddV7HQSdsDreo
         b/Z9PxXWhL8FK05ZteYYXL+GMY2fmacyjnXxk6NK4XgcjzTPm9KLKcp5OL5+4u0onEz4
         wJ35OCd2Cq/EsLYA3u5fOwULWUxBeIQUkBNkO9gdWy0hTS1scziR5CLutIEIIyX5FLdm
         y60r1BuxqLQNCqYircZAoFSxxfxDw8c151zS53xLafV7wb2cR2ytFcJF75uU+n5KlBnx
         VzdevHrsvjUD6bzJXJhSUY+FCKhqinxrGvVeausUzopB+AmURBpiHj+70+0cSQGMW6vX
         AXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749932233; x=1750537033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KLWdCGg0JOKswW01BMvqtrHzNqEzIr8DKv3TQdpObQ=;
        b=Wb2SfT8d5oD/h1FVCLofHW8qty1Fg9Me6hFmyYyzVj02S4qGEM8ZY4LsyUBUSjcajJ
         ZddAl6nACencMjWrlOqvnYeybNoE2DyYwT5CwlfVVuPvCwWHVc6Z+7rbubTc8W487uAQ
         p4+zcRrMTtjg9JihEK5UpbYqPE9zSY8ep3OSRNCaBKwByp8pH5+3QGe3X+yy5FkprXMH
         teI5E1qaZhFjJXlvwRAUtK/RvFflZy44hhlx5DRwd4lit5EM2ooqlV5SpCz6uOx/oxIi
         36IHeSoO46opbXbKV4cqy9ISRR3UaUtHORKtX5oOxGEHGTBD4XDEI3tlVg1wG9less/d
         dCcg==
X-Gm-Message-State: AOJu0YwO0Bs4p4zUPNpZbyvCXdKeKUojsT9IwiCDdkaBKcqQVdaE10Ok
	BuxwOxYA1gkuL1/PC+yDjvluD48ah4bcirPctL+KuiNuQsQ4Fkl7UB9hPzGUPA==
X-Gm-Gg: ASbGnct8ghIjEn0tCbDthkUW6oBOy02kzPnB2+MQNhVBa1Do+d84ZZ4gWOdJNld13iD
	9rgK40HL2FXZV3COOCGnKXLzd2olCjkBn1YbJac1b9eogrkCp6k3s/56LJmSH6eRTN7iYZ3Sm/i
	GnzX8f5rK6pOTJGiqOe84mWPpEvJNoC+9Bpw8763SsHo3H/Q0tY9m062y2kIWUoFAYoedrN6Pup
	r+I1Kv3iwRpGO0QNeUoZCOIvyvYY91b++f/TlvWhCXfdEWVPygg/Ckmbtmh4in6p9scoob7o+Da
	X0ZCj6J0dmtr0RhX1AhVEpkIzxAGbYBrURr/Fua0FOIplPXHrScRiluNV5izxw/lUL8=
X-Google-Smtp-Source: AGHT+IEN2RErcO9kDyOp9vr4GQ7WzpSU6IO2ncFTaa1myYFlmpI1xw9EZDu6WgZbFKOEUzLJ/DxxsA==
X-Received: by 2002:a05:6214:3009:b0:6fa:d8bb:2944 with SMTP id 6a1803df08f44-6fb47626dccmr60006986d6.4.1749932233152;
        Sat, 14 Jun 2025 13:17:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb4cca79bcsm6126136d6.6.2025.06.14.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 13:17:12 -0700 (PDT)
Message-ID: <684dd8c8.050a0220.f4524.1722@mx.google.com>
Date: Sat, 14 Jun 2025 13:17:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1364199688765273011=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [v2] Bluetooth: hci_sync: fix double free in, 'hci_discovery_filter_clear()'
In-Reply-To: <4d554466-f862-f465-f0e8-e4b749050319@salutedevices.com>
References: <4d554466-f862-f465-f0e8-e4b749050319@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1364199688765273011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:29
error: include/net/bluetooth/hci_core.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1364199688765273011==--
