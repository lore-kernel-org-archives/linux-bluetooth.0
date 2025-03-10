Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186C1DF72D;
	Mon, 10 Mar 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741641860; cv=none; b=Wtge3bMIcZoUOLODvXoa7sI44txqGeRPVXlercVuDT159ooMVroT5VB3mvOmgNRMEK7S0hxsRjNL2cv2p0pkcwvSqkUmuZQNBTUt7YoHG/jgS0ktlN5s4VylfC4dY26NGtn2/z3QB0hTVcMoxPjozG4nVDp60ZUtDm2RuL23DCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741641860; c=relaxed/simple;
	bh=CFt/paSQU7dgCa0yrsvLFB+VTEpR0s2rImGV3fEz/ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbNHfHhUovockkKejwetIaHjAX6P7XdkluUVjTNLFVfPGdlDHFisIGBk2Iw36DuAHWJi56GCPoEZJjuhTFRcnKcSjSsMbrQ4J/+sScrrPXbgVsW5k5V7kZ0c1ddEkZIO1US/e3yzxfI1fpY7rTrR0o3g0beTa34kssSgetCevXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8uJGTLj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8uJGTLj"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso7099206a91.1;
        Mon, 10 Mar 2025 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741641858; x=1742246658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEM1fJfmSNBl0Zxbi+hT7quH1QPEhdMr/ICPim9GEWI=;
        b=Z8uJGTLjj1VmZ3v6JTdzwf8rpQRP0xdo1Ii0YdU+175xynWHkpaV/8xlOMvOmDB8uA
         OcfPowNDkHJ/hfpJa7+wOuS/7yEObcakONJqjEsVy+Erc2u8qjVTEkH/BvHsHMcGS86r
         NRvQq6mQWFjVsEUXqc+UvZ4/Yp7oIL8xTaAMRR5AbmkfK7LlMp/4Mplczz/UODHx6Z8u
         MW+hPAtfYHKnaw++uVUuTf7DAu5vbuF8/Sp0OcPVdTP92s/IYivhO+EF9BXxEkAJ66Bu
         NMo9Z2PeMIJtYUSIXfBRoLXhtFcbcrG/ypGL3uaefyEyTRumnIeXRvgiY+m27/VTzPCN
         VyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741641858; x=1742246658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEM1fJfmSNBl0Zxbi+hT7quH1QPEhdMr/ICPim9GEWI=;
        b=EE9uZJyHJ+zdREsNKO7+ULX7P3sHk6IPrDeIhavW3e1tj0xt2NNdbV1bk2YyZz9tTf
         u0SQY1JPXDgBg5uG+1PyiO2ffb2fQVWblLL11qF7CyMdaJ7p1RrY0jqjdiRcg4xP8T0T
         Eq3q7LfevxVKZsOL2b27KWP67yGJI4nxc5pMqvRpftHg1qVRLA4DqFQLbtXdLYkcu66F
         2Kxysfpj3chf4geCbpUp/OD1BFT83ygtQ+ThZ/tsWhr/eGP/cfQFA7lLMIQFkajYaLrd
         wZk7IeaF5uDqdKCWbPfTKigabzif/pOMQsJL3BRZ34/3Gy/m12W0llup3MxmLbQfWQ30
         WJqA==
X-Forwarded-Encrypted: i=1; AJvYcCVUn/s+sabMm0mechAXqaESkLnKtiboAh19R92IkLVPlwNTJbndrtznVo2h5aUoBdZcNuf5HvG4QN60/Cs=@vger.kernel.org, AJvYcCVyuogCIxHO/OpRdDRIHVlf14/qSXRf9eK481WWfmc3EpPp/HSiXCkKB34nHyYtLw7zNqOACzgfqyZt+0IlOFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78953qOCMebWZ+LFbq0lNbNuhYsQX8CFyg5Y+9htyEKPN0W5h
	XgvmFafbt2CxlBSzDMgzynkrkGZ5oX4odnqj9HphdE0ph9eHvECB+P2Pox8qbYGBMD9i
X-Gm-Gg: ASbGncvi2syUyakgDTUAwAL8TJMC1GRZkD/4s1Ap8cFfr8KcpfKcyg8h1/LLJFl9Rxt
	UN+2u4ZbFHUROKliB0U4xCrPFonQM6tSsTexHhae/JhCT48wn31EuMOcDKj/peQcYkHGw3SGEK1
	H06nZY4ZRpepD4V88lI9CmfPD/oWWhXLhy7uzW2tJGR6UBNd1KNh4RP4ZkDjbomNVmAKf93MpXR
	z9x9D2Flozg2WSWPE2JiSrzwODCyhzDVyjTZyjI3umzQywj1DwpWWS7cWmRHq8/0pi7kvMbQ/zk
	hFT0vdajhhykzmQKrlZJfZCFh8V4Bc1c
X-Google-Smtp-Source: AGHT+IGSV1Fe5cveveYK+mz4lqU4NpvE9kJ6PipN9d6HgulrQo5nc9KLpj35Gc3085hWEPfC/rqRnQ==
X-Received: by 2002:a05:6a20:9c91:b0:1f5:8e33:c417 with SMTP id adf61e73a8af0-1f58e33c5ecmr953924637.2.1741641858185;
        Mon, 10 Mar 2025 14:24:18 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5195::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cb9aca5csm3946433b3a.102.2025.03.10.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:24:17 -0700 (PDT)
Date: Mon, 10 Mar 2025 18:24:02 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: "Geoffrey D. Bennett" <g@b4.vu>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Hao Qin <hao.qin@mediatek.com>, linux-bluetooth@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>, linux-sound@vger.kernel.org,
	Benedikt Ziemons <ben@rs485.network>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] Fix for MediaTek reset affecting Focusrite audio
 interfaces
Message-ID: <Z89YcqoED633dr_M@geday>
References: <Z8ybO7DfeP3Ag9wz@m.b4.vu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8ybO7DfeP3Ag9wz@m.b4.vu>

On Sun, Mar 09, 2025 at 06:02:11AM +1030, Geoffrey D. Bennett wrote:
> This series (choose 1 of the 2 patches) addresses an issue where the
> MT7922 Bluetooth controller reset added in commit ccfc8948d7e4
> ("Bluetooth: btusb: mediatek: reset the controller before downloading
> the fw") is causing Focusrite USB audio devices to fail to initialise
> when connected during boot on kernels 6.11 and newer.
> 
> Reported by three users here:
> https://github.com/geoffreybennett/linux-fcp/issues/24
> 
> Two users confirmed they have an MT7922.
> 
> I'm providing two possible solutions as I note there was a similar
> change made in commit a7208610761a ("Bluetooth: btmtk: Remove
> resetting mt7921 before downloading the fw"), so I'm not sure if the
> reset should be reverted for the MT7925 as well as the MT7922.
> 
> Option 1: Revert the problematic reset behaviour entirely (MT7922 +
> MT7925)
> 
> Option 2: Remove the reset only for the MT7922
> 
> Geoffrey D. Bennett (2):
> 
>   [PATCH 1/2] Revert "Bluetooth: btusb: mediatek: reset the controller
>     before downloading the fw"
> 
>   [PATCH 2/2] Bluetooth: btmtk: Remove resetting mt7922 before
>     downloading the fw
> 
> --
> 2.45.0
> 
>

Hi Geoffrey,

I understand there's no apparent nexus of causality here.

However if three different users suddenly reported the same problem and
the fix fixes it, we should take the report seriously and back down
on the problematic commit until we figure for sure what the heck is
going on.

My bet is this is bona fide bug in the USB subsystem, but either I'm not
looking hard enough or I'm looking into the wrong places, because
there's no way I can see in which way USB bluetooth driver from
MediaTek could cause clock detection to fail.

No point in pressing this harder, but yeah, take the reports more than
seriously, because if we don't understand in which way our own (Linux)
code could be causing this, at least we should take cautionary measures.

In that sense, putting Takashi Iwai and Greg KH to Cc: in a modest but
sincere belief that this issue is more than real, even though it looks
like anticipated April 1st. Takashi can help with his expertise in clock
detection and Greg could help pinpoint if this is indeed madness in the
USB subsystem.

Hope you and them don't mind the escalation :)

Thanks,
Geraldo Nascimento
