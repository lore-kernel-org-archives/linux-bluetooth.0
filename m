Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BE310777
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563389; cv=none; b=c30oAR/uwxjual/HBj2iw4NBIL8ncr1jj22RMMLqGOS5a6D1tNu8NcRwpxioybmlrnC5Bn5z8EFZJTJp53sVbSN56XXJkfwHsKBD2UDCnoZNdjb8Rj4UgxF+PtCsQUy3JZ9vXVlXhJ3dvhEZ+MzK2YOt6EWWyUXcCMdWicpdsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563389; c=relaxed/simple;
	bh=4F5TBMXar4Cc1GJddDqJOtbvhaXI4D/VkEDBimDiBxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEgUNrWIeGkaDT4nMkNiQvHuy5dR/8s/EhI1lLDrcWjMzydc37BJobVa/RzoKSHOlHYVKRRysN8JylFiO/h0G4hZGl/2mpBoOMnzR7k40zkzq8iy4+YpXSttHLHiN/3yrm9GnBkN4d5FL7IkD6Os373ZVGD5ZBBC89Ibv4AiN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7VO+2ps; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7VO+2ps"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-ea5d7191a64so2572038276.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563387; x=1759168187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4F5TBMXar4Cc1GJddDqJOtbvhaXI4D/VkEDBimDiBxs=;
        b=f7VO+2psOx36TL6KkXgOmnUeKDmKDG4QQDNEhGmYJFJkfz2OyCV6xKG/PZhHXH3RSz
         KaT22x9M47KZa3OpH208e5lVJCWvWVHcKgYOXTFjBUAZ3VxOnlbfOyrpstuYSy6hcYqe
         B4GL7DTianrGVE84om4ubZSq+LJu+BQGCRTKGMEKDXLVCYArlDwsZd8D71zzthqPB0Xz
         TvrW6EnTN1kxgr6AHGFJ86LmD2++H60HuXEs4Y4rIkBo+8XFGPl3j1dlV8OFUIVurPBA
         kk8W0pi5+/bAvnKVQS9Pv8KdpeqGy/sZV/g1fnOIr2TzFnhtlvun712UJCS5D0Qokgzy
         5xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563387; x=1759168187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4F5TBMXar4Cc1GJddDqJOtbvhaXI4D/VkEDBimDiBxs=;
        b=L14gD2IRx/VKGYmtPDGiUuWELUo0JKXoIzBgUmpOdani3G0Aw0AEdiLx8y63nDy7zT
         bE0n1DauqXWzRG7VCxQcQXD25Zev8ug2CVJyoaCH02TveGr44jZR3d1lihaB5CBb6ZI1
         WYsTRSs4zZNQg0bmVmfsQwxOo784gVGS1ty9xwdMfCTTX+Alu0aaxv976HW0gk/xNqKZ
         XtTIMqjtK+KQZMoiUSU794fEIpEXadnRUtZOLwmRjQwLapanY0r38UU5zGkc/XeBGwzc
         Rv8nc3HgP72q9H2kMedOmP/yAGipPZENuJZJ8AtiK1mliOcW39YITMdoNx/xFwYiP1Q7
         GHeA==
X-Gm-Message-State: AOJu0Yz+t+JyHEdS1od5zscjzl920DAKDsTnFmomC7vAycQY4w0EyMI2
	sBPlR08s9iblWVaQx024rxNmL7DVddY31zM6n2TsGqFfUL9wE96AK1aoZBr5K3ZatNHILoLbmf8
	apEVt4hQ0N95bBOT9fi6XKo0UpbCv1HxIvaVu
X-Gm-Gg: ASbGncu0QnVfFDz5dxcgNgj6Gps34A6tjPJQfo6PVOcU9kbGoD7Uh1NukJMb56w738q
	DKCooJYZCjTqXX7yNjTv1iyDehfIcNZK3IY120OelYyMeN07RCK9qGI23Y2HgrHmnrMqsvi/eY7
	yZ94Xz7IsUZT0FidD05G+ePaZnca5vtmVcdI2q+BBOWZgh4q2xMCKMWxzuY8sJE3mMxSQxR+G42
	fEFubsH
X-Google-Smtp-Source: AGHT+IFU9WoU061b33DEC5U1jirUjgFnWb2PizopyLlO+KNFuTnY1PSQh/CMP5gqF1hJQTvuMUU1TvIiqw++0b4Qf2M=
X-Received: by 2002:a05:690c:2702:b0:74e:a5d3:d95 with SMTP id
 00721157ae682-74ea5d3206amr47625007b3.22.1758563386556; Mon, 22 Sep 2025
 10:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83RZ2T.A5U3789G2QAM2@gmail.com>
In-Reply-To: <83RZ2T.A5U3789G2QAM2@gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Mon, 22 Sep 2025 19:49:34 +0200
X-Gm-Features: AS18NWCKWt2s_MKe6oHqjA3RjEB4m5T1he6JAVhQtA9gFyK6dcpy4CrwUGTScl8
Message-ID: <CAGFh027M9zaPu6Z8n+YNcEbAz0+emMEsAwSmiKVBcSv3NAUg0Q@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Check for unexpected bytes when
 defragmenting HCI frames
To: Julian <hattshire@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It initially froze while scanning for more than 30 seconds, but after a
> little bit of USB Hokey-Pokey, it works better now. However, when using
> headphones, there is some choppiness in the audio during scanning, as
> if it might freeze again.

This patch is only for the dongle initialization failure. There might
be some other issues with this chip. I guess that when this patch will
land in the mainline (if it will) we might see more bug reports from
people trying to actually use it. It's rather impossible that this
chip does not have any other quirk :) However, I do not work for
Ugreen or Barrot so please do not expect that I will fix any of such
issues. Anyway I might submit patches fixing things related to my use
cases (if free time will allow).
