Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0B56742
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177775; cv=none; b=L5SHhV8DSqx8n+EgwjW4lQq2rZP/B5C8a2ZemQoXdPN98EK0A70Jd5+lvLCS1GRGD+CfksWJ3LBmL22H4z/enbC+Z9RHa6nizo5ztVQvc51ZzTFFY+222El/XsE5jda4AU91uBKUMm3dVybdIe4oYOulMJmdCN8+7K3jH3TE9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177775; c=relaxed/simple;
	bh=5l/1qZpr5HERskV24d0zuIi22kZSkIFiAVk8ON7ip6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyhabsNWrhINvdxXXnKTlwQkC+khpMzbGVc5t2s34SZVnlJbGNoHUE1u4LL0p0RbOgrpVS54MuSjE+bvzxw1shAWoU9+ztnicXhLHB0H36e/kJP7EwHPHtDlBqQiOYK9yfnLCx2stH/aH1GEuqSSu/vSVyT950JDF7mlYe1Xxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loIgEGgy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loIgEGgy"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so49880331fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715177772; x=1715782572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFaZjtuMgm9nkwoIXg1V2qasf+e6bnD8xZS/pyhQjN4=;
        b=loIgEGgyi7XbKePzHgF++7SxO8fXznSL/W3Nzqqcr2JtD7a4Ws3uLnokfzyKUa7gvR
         8HcX/FtJDfVNOl49HnXkpvFENfO8KgjaNZZWdZG3LTd+Z4d/3rjBPsunrnR4v2RaHtKI
         wg+7j7PplNavsmjqEn+4gDroJ4hLPGu+AD0VkUj5BPXFZWj3+zhUWvJkLThwKScVoyZe
         EzMFaFCOKvJCDBxvL/4zGSFi15OPLkKoISFFUh9y4PhJWp47xzG6ZGmTM5IFy3HfYMWF
         YVajkpBnZUo8QxWqn5XNt4jEooVGCR04T+xWrX9FY2oPbx8E43pUshsXo2fSB/zR7G62
         rldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715177772; x=1715782572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFaZjtuMgm9nkwoIXg1V2qasf+e6bnD8xZS/pyhQjN4=;
        b=NE4lWo5cMfVkwj6zvhJqE9aRO4AAapQ/gwQvQJXWB8NrwtUysN78AFsVGtsTRlP26O
         XSUty/+O7/SB1SfWBaYvdJiRSpXGzZiuKmn5ASQh6PrDo2SOhRUpF8EDFGV4g3vwqOzW
         UzleLRxGRfoytHi/PtlnGTESyuYYKDr/HLjx+JxkLQgZc/cA+D2tHaWdhYz8wfc2zAFP
         0q48HanJnZyOHGMUrVk/O6Rz7hvFvgK6JBlvQbIviIkJ0imUD6IRTqCv2rGNke+LuBeh
         8NvqezjZ1/cSjveyR3Kpti40xZYzhGzRPzCVzGxFom0dT7UDoUSuNF2zoS8QoUicqZiZ
         N/0w==
X-Gm-Message-State: AOJu0YwhBpBAOd+qdQdFDy+3M98A+oadJsGJSOUxUXsZ4kkUyJfDEsg2
	uaVsOmxploq2He7sGZZdMRFq00kLNa3LWts1KyQcSzE06mBp9wsR15qWLgRzfeHJJPXP7Vy5Swz
	0VQpxSqVPVK3VbH46voy9bS3+L2mgcr0/
X-Google-Smtp-Source: AGHT+IHXtfrgru2SQ3oaGZkxjxlpMXvv8xyOGb2d1wd14XPY+/yx39SReRBSG4M/lJkZ7T0gYjVl9pDMxRoAoGLQmRA=
X-Received: by 2002:a05:651c:105b:b0:2e1:b0e3:21f with SMTP id
 38308e7fff4ca-2e447699a5dmr12781861fa.40.1715177772108; Wed, 08 May 2024
 07:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SA2PR02MB782004DF03924528761D402492E52@SA2PR02MB7820.namprd02.prod.outlook.com>
In-Reply-To: <SA2PR02MB782004DF03924528761D402492E52@SA2PR02MB7820.namprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 May 2024 10:15:58 -0400
Message-ID: <CABBYNZK1XfX+ug9+ktSTpQKG03LBK2_h4UxUuF3w14-8k4t3gw@mail.gmail.com>
Subject: Re: Query regarding BlueZ Stack Certification
To: "Naga Bhavani Akella (QUIC)" <quic_nakella@quicinc.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"Mohammed Sameer Mulla (QUIC)" <quic_mohamull@quicinc.com>, 
	"Anubhav Gupta (QUIC)" <quic_anubhavg@quicinc.com>, "Harish Bandi (QUIC)" <quic_hbandi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 2:35=E2=80=AFAM Naga Bhavani Akella (QUIC)
<quic_nakella@quicinc.com> wrote:
>
> Hi Team,
>
> Could you please help us with these questions
>
> 1) We are looking for some information on BLUEZ Stack Certification.
>      Is there any existing BlueZ stack certification ( we are using BlueZ=
 5.65 ) already done which we can reuse,
>      if so can you please share QDID ?
> 2) If someone has to do certification from the start,
>     are there any tools or apps available on bluez which can be used to r=
un protocol/profile test cases against PTS ?

You can find the previous qualifications done in the following github
discussion, we are also discussing how we could establish a more
generic Host Subsystem listing so feel free to contribute:

https://github.com/orgs/bluez/discussions/817

> Thanks and Regards,
> Bhavani
>


--=20
Luiz Augusto von Dentz
