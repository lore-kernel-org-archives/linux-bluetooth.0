Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9A1917CD
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849140; cv=none; b=kOz+fCDbwbr9P9FG6dEWDowuB3pcOH4/8wn0+PqOi8ibPM8dVgQ8BuwK1naJkKS7XY4PPeK9CCBVOMppXGxFMtxigBz935JjDSTZAs51L3WCRsHZKnGNqf/yip0UvA2G+QMua+YpsV7T7a9K6VVD6bPlzuu3TDXlHmGALzBYTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849140; c=relaxed/simple;
	bh=M4S+Dg+eFHre5oIvhwj6ZR6m/nZoU3/NjQcDtPn2Dpk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZNYY5M/HpL95b9udib8YyWVngpo2f7olrPa/iBjCinajWbtc9mYqUJWgUpU+XEim1GwRH/VrLakv27/s0ZHbtMD+Rf+JTbUaaSpAV1nOM4ZTftqEBstW2+lYk7FmGDjyRiqG7Km8yqXhMDK0sIyOoYEUxWHcfHHxkRmvF30a4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9xC7ees; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9xC7ees"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4a4cb36ae00so3162262b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Sep 2026 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788849138; x=1789453938; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M4S+Dg+eFHre5oIvhwj6ZR6m/nZoU3/NjQcDtPn2Dpk=;
        b=K9xC7ees/GhkOeIUkI/VmQOoRvowKmN0k8IkD7ZhocmNwd1mlEeRt9diaalEcmZ1BE
         WeXsyFyIiFXUoo7ZPQPT0NyODEPe5Cm4bU71WQMQYcPxOFJ2WwvqjV47W855hJU0p1W5
         zdBWyf+ZmkMfHpYS5MJN6ZboeBac66gRqVK4X1wFgmNglaHuqObt2bmDr6AIIqmP+mov
         chrKskqNzB/W0ROnAOkTsrrIiPbmLCIyxj0VlJU08SYx4vXbnOM3SldyUoOuQ5eUkkV3
         mEEcQGW90vT8h1RXsYsTfiVYBXkvSj+EH6425DMI1J0Ky+/RQK2sp+fCG0xWckO7l83k
         9s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788849138; x=1789453938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M4S+Dg+eFHre5oIvhwj6ZR6m/nZoU3/NjQcDtPn2Dpk=;
        b=XH4trq/zE3IZro2YuCgtPkq3xiaHg+WWsKVxneXCDDQMdcmHgzxU9zQAlvZyWRd1GW
         P8KdMtFCyde4T03LLwxaYvQwI8jOL+MbVTGU8AdGu+IVcoNT3PN33Efr8FltZ5ZmmXPr
         0sW2ZmoI74zTbGRWY/HDBoHiGdfAkh5VDCgMPmdD8dB3Q38e1jkYA7yMaunNyy3sj6Ql
         Y5wExRsTfXAAsmLwLn7gB3YZCnhlx4HEP8jxdwpPbpL86+fzwmvTJciTEtajB2UMw6Cb
         dbfbOil8Ja9pR5rE/B9Ntt5WUrMnIbPRNeP2RhqDpfkYTqLMoQYC3Qzo3pzp/kJ7g9W9
         EzHQ==
X-Gm-Message-State: AFuF++mUnGDmk2Ymwi/yMZM1AL/puBFOav/QfV20rgyGTc+RgL2wMC3g
	+AWKWmMESHwI0i401mJSRVPlW7Ilow4ZrFCt4vHHCChRPXxqW9N0I0vUtznbtg==
X-Gm-Gg: AYBFou1HpQV8bC3sGtK+eEEFuZzlRszFyHAOxyinNEs5xxM+YqvBBX0GZz9ezNPbn9z
	vSy5IE39myxJaMR3x4Ls2aoF+2pYyIXT7EEdz5WLPNs2CAyRCJIIqpFLOWrY5OLyflhVVcBoPLD
	+dJQimFoVicNO6MCWtv7OlojbCKJcLuwIPcXDN/FdPasBNYNOBLpVpvUENPjKE76HR0u99pO1bU
	ibIErGuVyV4IhivfqUHGWY9xqU7qRWeIZf6pRpaylTEzfwjZ7V3IWNfIj8klxP48JanWw8nf02L
	UhrqNsiJ87MOR+vJCwpQ6irN8/guGjBN1/3EhZ7dlsOyj5tmv6K91JYZdYulONzdTmClKQIb9RL
	t5u/Ri2qJirbnY+pnJ6cwdDZYLKJPlmGQ6w2OAarxGrB5vYWMeojEzPyOkYO6FaLNaJoW/LEo39
	dmFhzNQ+0lMgJ/q7VtSmpUxJuetBAJAXeh5o5seSkd2ZpTG/lbVfKsyknr1c9y/jY4I1GqwA==
X-Received: by 2002:a05:6808:6c8b:b0:4bc:fbd4:2a43 with SMTP id 5614622812f47-4bef822faddmr1660007b6e.41.1788849138019;
        Mon, 07 Sep 2026 23:32:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.209.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm30108579c88.13.2026.09.07.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:32:17 -0700 (PDT)
Message-ID: <6a9fabf1.0f490953.6e3f5.a497@mx.google.com>
Date: Mon, 07 Sep 2026 23:32:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9064226713151942181=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v7] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20260908035627.579073-1-hildawu@realtek.com>
References: <20260908035627.579073-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9064226713151942181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9064226713151942181==--
