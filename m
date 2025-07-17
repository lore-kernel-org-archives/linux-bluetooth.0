Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB03191F6A;
	Thu, 17 Jul 2025 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752723341; cv=none; b=tnTB7q6mu9DK4TldENYBecyhkZT9xFWIxTUhA9V5nsvgi9oAK0FB/vbPmd6e3xYj0wtoDZUrCdrKR1HyQoOExt0ZJ0LuterJUGRbHGBSBwqey3Gv1bqdTip9XFkqjX1xbHf10X5R/SWzB1DC52fU+sNqGcz1WwtOr/SQjMFheiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752723341; c=relaxed/simple;
	bh=mzhA7EbSRIBbNCg+6GeIlKr98W0p9lx2o+bn9shylpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgxlI0fzLFwGoDFhd5Nx3CCChMlWJHyxa+vm1O2+0EWOVC0bFgNJbAzKAJFk+xZ8hrm48c5TrNtc3wMoRVUjDQcywX1iKqiyfZ3ZpJ+BSbEXQyaywLJbb3rWIlcZx6hcT7d/nx6zHP8PMNiT58sUF0A3dTIS1YVze2O+usIlHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQr444RW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQr444RW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b31c84b8052so500849a12.1;
        Wed, 16 Jul 2025 20:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752723339; x=1753328139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dDjDASshMt30PUyM8j2g2T++HJNHOblp1J6mLnbcWk8=;
        b=LQr444RW81rfpz/IiRf0IeigfiFdYdNRjSW/IRzAGMTOK81/OrLxwBRNUriaZrbiEx
         Mkkx8zudWSeXQcB9416a4Vl8XNnwATTlVWqq6foql3qzN+asZ5mbAWSIhrrmIoF3sV+o
         qsZP6txFCZtYioXgDRmxELHsZujM7vEQ3e/vVIrXBUSpieFHthz0dPMQ5pRA9cuhsCno
         9U0PFyhPqFZ98s5pAO+DrXyXvUM0YkiBhtCZ8nsv/lPyOI8ujJr0rhXSJ6VuGL2J6TEx
         ZbswkjNz4NOvwv5qbZy0j5TdaYLDnX3ynq9n6HCkCoWqeawQZpGdOFVGby3QOpirfKPp
         Jk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752723339; x=1753328139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDjDASshMt30PUyM8j2g2T++HJNHOblp1J6mLnbcWk8=;
        b=hnLbjH/iDqPUWMstFzo9GdAfsaEmKE2fySiTnaGGBc4dzq80vOYvO1vhttC4rJ/PUy
         QGct5T98tF4poX7f+Z9dv2bibNJaF84Zq7rBlw4iYOWL68CesQ4kxjrovKVnU8I34yXH
         yYy3cY43yHWlVeglV3bnRrkBiwmHTtnBlsjkK5mTWwiloDs9hjl+B9ZvQT03DCHBUhXG
         cGeHowxt2C2Fb2qG04QOrTBzx96ArYoasXxNMi/YVUHq6nYWzrIDZ37e4SxVS7LV1Xgc
         5RDfjG28fLkJirZ9UUpHpg1TwG2HTfkp4MRGUp+oYCAJwipEDabLM3IZkRzVBru4pxp7
         +btA==
X-Forwarded-Encrypted: i=1; AJvYcCUOhCF/ass/C2RRyoxz15bdTGKFZnLLg0ntC22yE7L7rQcCnERjHJ2aEOCTH3+854r5RiM2e1mp3R54nEWcC58=@vger.kernel.org, AJvYcCVhOKHnCxfkcihpadV0xdHvVqPogQmCBS9Luyqls88/WRZDmMebg1PIot65GFDW+a03dTPq9wu59yumZzwR@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmzLNiw6vXB8rnbuUOxBCgB9PUfPuc9wvcam7Rkk47UXSIt4b
	D9kXfQzc//dSIPalV0qdn5qsobirr0hCxYTH5C5s6tWgdzQkll9JaNN7
X-Gm-Gg: ASbGncvbZQQhHPMJhB5C1Vyf7kpusYCq80c93amCH/SEOVNOIhnN7bCuXfFELpSCH5W
	XMIrXw9tNYlc7ysO9uut3+5ucSZ4u8Xq+6ftbmR04wxHXq3hAMZL7MXbLpPvoTxpuiCzqOCvHO8
	cSlJcTBokdwpe+uvKz7M3ClH1H3R5GhrjSKvixHjOD4Y40DXvdUxo7Vt9A4TvqrX4VCm20s+hi+
	JLpaspJKNtsbHcKndeF1PprFMCTrXQyBGxcPBX/xxust3jub6PbBCtpZdFJ0gQGJiFaaOPSvYkw
	EjXF8ppGPzOh21EGoyAK/NtSNwd3usytZdFWXozedTAISZJGBch4uFp8iUrJznLHSvcEPEcHp6c
	CGqoMiQn7GWaHJGGuvyVQ3Ko4wSY3KFh3glXuKF2oNT0O/Luv
X-Google-Smtp-Source: AGHT+IGWUL1VrwgZB2BNVbQzRsynv2opMkJ09dqcEG956Ez51zeCFmBxvcxcYGE1p2sv1TL4Hj8txQ==
X-Received: by 2002:a05:6a21:7116:b0:224:96:bf63 with SMTP id adf61e73a8af0-2390da512a6mr2164040637.7.1752723338830;
        Wed, 16 Jul 2025 20:35:38 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:9da2:46a5:b508:3b9b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe727fdasm14552159a12.70.2025.07.16.20.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 20:35:38 -0700 (PDT)
Date: Wed, 16 Jul 2025 23:35:36 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
Message-ID: <r44coidqefd66owzl7fwgbtpjkfgwbayd7irzpbgcvifklwrjf@rimfqjmffdae>
References: <20250716003726.124975-2-ipravdin.official@gmail.com>
 <d8a85b98-4c70-4fcf-9d7b-bd1de2d780c3@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8a85b98-4c70-4fcf-9d7b-bd1de2d780c3@molgen.mpg.de>

On Wed, Jul 16, 2025 at 05:06:38AM GMT, Paul Menzel wrote:
> Dear Ivan,
> 
> 
> Thank you for your patch and fixing the report.
> 
> Am 16.07.25 um 02:37 schrieb Ivan Pravdin:
> 
> Personally, I’d start with the problem description.

I will add more details in v3.

> 
> > Create and use new vmalloc'ed buffer with dev_coredumpv. From
> > dev_coredumpv documentation:
> > 
> > `This function takes ownership of the vmalloc'ed data and will free
> > it when it is no longer used.`
> 
> You could use email/Markdown style citation by prepending the lines with `> `.

I will fix it in v3.

> 
> > As hdev->dump is used after dev_coredumpv, create temporary buffer to
> > hold hdev->dump data.
> > 
> > Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/67eaa688.050a0220.1547ec.014a.GAE@google.com
> 
> Add a trace excerpt to the commit message?

I will add it in v3.

> 
> > Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> > Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> > ---
> > v1 -> v2: Changed subject prefix to Bluetooth:
> > 
> >   net/bluetooth/coredump.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> > index 819eacb38762..1232c9a94f95 100644
> > --- a/net/bluetooth/coredump.c
> > +++ b/net/bluetooth/coredump.c
> > @@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
> >   static void hci_devcd_dump(struct hci_dev *hdev)
> >   {
> >   	struct sk_buff *skb;
> > +	char *coredump;
> >   	u32 size;
> >   	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
> > @@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
> >   	size = hdev->dump.tail - hdev->dump.head;
> >   	/* Emit a devcoredump with the available data */
> > -	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> > +	coredump = vmalloc(size);
> > +	if (coredump) {
> > +		memcpy(coredump, hdev->dump.head, size);
> > +		dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
> > +	}
> 
> Should it be logged, if allocation fails?

Right, I will add it in v3.

> 
> >   	/* Send a copy to monitor as a diagnostic packet */
> >   	skb = bt_skb_alloc(size, GFP_ATOMIC);
> 
> 
> Kind regards,
> 
> Paul

	Ivan Pravdin
