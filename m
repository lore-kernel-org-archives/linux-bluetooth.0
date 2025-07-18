Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABE1F17E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826439; cv=none; b=kGyYdvLJHlq48seoynMaIUSuwyvR9q/b4vZ8kz+EHc7zscd3xhP0O35vJDCoNMd7hGcKP8P85Phpj806PpqaaciAvDxhjcpgnMuILlbUy6gHQiq2rSwlkNwtgbcHWJoefWOUJFuyLY1fbJ1gZp4tRJ2pukHKgDrHiSaJ3rxKd6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826439; c=relaxed/simple;
	bh=2XxJMxqvE/Cjfusd0XxjbthJPfpvtef/UFrkblBe79c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gaug8ay69fd7Ry/MpQbqHy/eTDjXEBnLmE74pFvDNIQpVbSfzEd3FvC3FoJy89X0nr2hbpbi/VfFM+Lu8m2wPbK8p6inDMB5WUw+VVgyY6sm7Ke1K1SiDCaJqQ7oGv+C8fgUmE71l1Q+w6mcAcO7T/uusX5Nl8G6zoA8fMRfMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=SwrTJZYp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="SwrTJZYp"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1269124b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1752826437; x=1753431237; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMPeAL07/lZrKnUkmH8nVJ8wh1GwyumIputOyztfgS4=;
        b=SwrTJZYpL9BW/5AE1sgr1NXM8fBoz3t/1IYRep4VjasHeMWV8VuVpZ8M/zqGANLyDB
         oSGqJJMkt4QM82e7f5zleJCHzPLjQyShvTC6XZ7YX8gJ8uG1kdBLOXK0C3l4XMYxl0Ej
         Ml15xPwaO0fq05wz2sbC34Kn9xNDfrYLOpX/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826437; x=1753431237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMPeAL07/lZrKnUkmH8nVJ8wh1GwyumIputOyztfgS4=;
        b=ssduezNyhVBoe5jtoujrJJT/S/BjOVo3ZFcy9bKPvKQhfDTcPS27Mu6Qw5iUUOiJX/
         AriLw2ceiUUHsRp5yIWgFIpxUACwjQcFmj9r+9e9NXq01l6ky3MEZ0EnCFA+zJ4qiDbx
         hdQNJJuDn834Gc7c1WzUNLpsWhX9anKr6VJKDMnBXGbxfWalbiDwy9Dl8u1uEHmDY0fb
         Xk6LPX80sLvGKODh0k3qeYY5LGsnbrn9eUnQFWQx/1LOwvdlCf0YwU2oTckmy5HwMNA+
         DFKSVbQQ9KZsn7Ce1G9CynKvUsSZSWA3kdw5fUj0qH+BcGo+ifbmoF17FFa6F2Rqq3+z
         f2Uw==
X-Gm-Message-State: AOJu0YwkR+wGQNc/BIaAI+MofQus2bbyHsBewVcwwye6PX6tmOUuLvo7
	+l/sv8kPm6p5mj+HpzkFxddhIM9TaU8LjWqrkMzkYibM61joFfQcXCJ9v6sdP+Ka3m8=
X-Gm-Gg: ASbGncuk0+10B1HF8hXf7/cGxk+7L7L91WAG5KqTdmzN0in9LxlqKM14Ts6RnkYX6vI
	3wixGW+rnKETj4PN3gBULH6KGiQMtAAStlfjX7x1VG4VAk3NQ68+fCb2uEUNGnZm2jfb7V8wKKw
	A+vWOCYsAzQTFTvm6ec38byBF8wJCkMY+sf8Gr0i0a8sYFfzTKuGH0R90GooEeO88Ye308+2NBI
	yDlterEDxyxHMCUG0A94wBWyUDkUtmIIWoIIUSKij239/BzjAt/EQo27enQOlQY5yzyYd/y72Ex
	4oXQ/z5x+s8WSXACdqHraO2gNfWX8RI8DT+QbaNE88dVDMo46e3wg9Lc5kBxojSVP+fIusRHBXz
	P5hI4kpyCTVacHihUHsxnuccr1vL4Kg==
X-Google-Smtp-Source: AGHT+IG73zCnFU9COboaEFW/fs2gtFK6dqDUiJYlBGv5r2t2tuOfTRYElrNJO1jXi74JhoPkFbTRRw==
X-Received: by 2002:a05:6a00:23d5:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-759ab639668mr2324482b3a.1.1752826437509;
        Fri, 18 Jul 2025 01:13:57 -0700 (PDT)
Received: from localhost ([116.86.186.54])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-759c8eb0e98sm763432b3a.66.2025.07.18.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:13:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:13:55 +0800
From: Chris Down <chris@chrisdown.name>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv
 reports
Message-ID: <aHoCQ_RfBl5Zm4oQ@chrisdown.name>
References: <aHfd_H6c9MheDoQP@chrisdown.name>
 <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

Hi Luiz,

Thanks for the review!

Luiz Augusto von Dentz writes:
>Can you include a sample trace of the above?

Is that with btmon or similar? Sorry, I'm not a regular contributor to this 
subsystem :-)

I mostly have a personal desire to get this merged because it's a particularly 
noisy case where I happen to live :-) These are all with 0x40:

   % dmesg | wc -l
   3815
   % dmesg | grep -c 'Unknown advertising'
   3227

>Also it would be great to  have a mgmt-tester for example that attempts to 
>generate an advertisement like that to exercise such change.

Looks like that's in Bluez userspace code right, so what's the order of doing 
these things?

>> -       if (evt_type == LE_EXT_ADV_NON_CONN_IND ||
>> -           evt_type & LE_EXT_ADV_DIRECT_IND)
>> +       if (pdu_type == LE_EXT_ADV_NON_CONN_IND ||
>
>I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, maybe
>just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
>actually a bit it is the absence of any bits being set, so I guess the
>only invalid adv are the ones for legacy which seem to require a bit
>to be set.

So are you thinking of doing this?

   if (!(pdu_type & ~(LE_EXT_ADV_DIRECT_IND)))
           return LE_ADV_NONCONN_IND;

Thanks for your help!

Chris
