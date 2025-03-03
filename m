Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2892A1CF
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967728; cv=none; b=Bfv8dMSYEQ5NnpMegv+NDYg/4ImexMv9g8VA0kBnvs+FzpNJJ87xiMO0YvHTDIKb5kEDwfq1CM1qU3jd0PGcvJ7cunmtko1dTjtnypG0hheJpRmPV8q8De7oczMHb05L7rUihY2UukB8KBLPyuse5WG+0xv2y+t4eN0y0TrVOVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967728; c=relaxed/simple;
	bh=zbImhBAUeUoKRNnib1aRriUOh9I2yVMbdvgcqItiVbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HgAB6XP9Okc4i4Q+H3PLD8awG6+v+I0+ynSpUqeYEkiGvO7Vp4PkypjVvd89trx63TM/TqeLK77w9ts9zyBqIk7OUbZ7UOiKdfscS18ONici9EEHIsWl0qVx8ZjNtR5+idkleHm7mx13YjjFKtqn9sr/SAMldzKSHDOoNnfiHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmJbLH2J; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmJbLH2J"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6fd4dcf2df7so17674287b3.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Mar 2025 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740967725; x=1741572525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbImhBAUeUoKRNnib1aRriUOh9I2yVMbdvgcqItiVbk=;
        b=XmJbLH2JlYBfKzadCOx0LVSOe+oiCPFsNpkidGEB4tmXMGH2xJW/3Vlrc3dmM9QCt/
         sy0PwVPbfDd6pLBvr90bjhv4wCPUOOA5lnW0sUpIyWNrIColujyBYCUArBAWhI5aJwPP
         baubckZ/WGZeU3ImVTtRx9WKs5+oyZiHURhkLwZ/N2zZNU2Hcz9VJmzKYN9cYYNi3l4f
         SjM/W8spmVqErgFVtcGEMo+LZMBRUMrjNNys8+0iJ0l1ycvI4CTlZdp7M1f8wiOJUqeG
         AA0VxgT7vs2UQFO2f3lajkulsL7baLQ6j72UkuoprcOvbsZRnkzdtxs/hAdS/UjjYZWn
         gB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740967725; x=1741572525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbImhBAUeUoKRNnib1aRriUOh9I2yVMbdvgcqItiVbk=;
        b=Lqy/47BE07kjgDSll87nuQU21Vo3gDbi0Nl0tt6yMdYv3Fi70db+wwMdQdAPEvEKpX
         Moy5hSuSQYA8sWiV7KsXIkLsmdggLwsjFriZLnMqQnXW/WPGzU0VMKQmiiXS0NdmpPj4
         /PLuBkx2mQMzf+Nv7g63nBjKnaFRr4og8jgJD3naqgp2qtdq7uoWRb8vYrdYKtyoPVqc
         BOONdVNT2dj355OGO10JF4uESh2WLY53RkRTuAy/sEcylnrPeDrgDNsVMcUrxiQBCxl7
         fOonbRrC/zOrnYZtJc43BoTJVih/vh68B2nhTeXjd1DMDBviGNNHfl3tihhpBZ4WanhP
         6vwA==
X-Forwarded-Encrypted: i=1; AJvYcCVAO/CsSyyBqjpHOccoOVfCdwHL4FHVEPexTtUopOHY646uJYv9f1P4X/TZt0sspsiAWIVHSyvm+Ni/VADf0ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2TYEud5gjPHhBA67BO2KgG0iGOZHHvfJUxdmh0ivxTmXQKeX
	+i57VfR9H4vnhKafE7x1faM6p/2PsiR2nddTcGzYXV78f+rhntMQQ69T/I/JkEWFR7mWMqkJJUE
	9VoyxcgT8FW1BHgEcEzEsd6nkuebJey1hzjbO
X-Gm-Gg: ASbGncuAXOts4If5sFcRG4CNALM93Pc7YteSdGI7AAwhnoqfktujcP72MJCSdli0g97
	2HP9XNR2d+rET0OmqgCiIh/147Ql6udi1DoG1wfhZ42X4rouBztuzY2yEI96SJXfzK0kDbJThxs
	b+p5gJYnI0xJSicnqRKcgdJVhlb7M=
X-Google-Smtp-Source: AGHT+IGZjYIIWf7s5pXC8snxj3XOzQzjufc19B4hEx+E2T4lbHQFAHQsUuKAeZzUIL9D6AQWGfkgzTgJbRGf+rb2rmE=
X-Received: by 2002:a05:690c:3349:b0:6fd:41e1:83d8 with SMTP id
 00721157ae682-6fd4a03dc9dmr174051087b3.6.1740967725351; Sun, 02 Mar 2025
 18:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
 <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com>
 <2025022407-polo-disgrace-9655@gregkh> <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
 <CABBYNZLhR+OJQnYZ5vN5HjgiWwKrXvOse-pXhCcTdFpJrrzsNg@mail.gmail.com>
 <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com>
 <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com>
 <CADg1FFdKfoJLxD+0A=j=kSLtMPLL-JptcWP1qH0Oo0SttN8k2g@mail.gmail.com>
 <CABBYNZKJUnhGXJEsExCdWNaE448QhCeiymLm9yS80k18AeWqoQ@mail.gmail.com>
 <CADg1FFeyRa8rGkJXb+4Ymeqn+3XLJ3ZEpBnQ_F3WvwrS+u1KfQ@mail.gmail.com> <CADwQ6b63Z3HXCx=pXrhTDAXhqPO7-fSvgE7=TiTMTvc4Y+-mNA@mail.gmail.com>
In-Reply-To: <CADwQ6b63Z3HXCx=pXrhTDAXhqPO7-fSvgE7=TiTMTvc4Y+-mNA@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 3 Mar 2025 10:08:08 +0800
X-Gm-Features: AQ5f1Joq2TEWL0SLESXtDYHS5W2nMxhIZw9WuQ_9W0PUknn_tWxgl_01QZEW3FM
Message-ID: <CADg1FFeEQVmYD1NnCbZi6v9Jsu7gVzWcFA8VwZuuOL8Cdt=Z6A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Ying Hsu <yinghsu@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-bluetooth@vger.kernel.org, chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:47=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> wr=
ote:
>
> Beyond power concerns, another potential issue is USB host controller
> scheduling fairness. SCO data is transmitted over isochronous pipes,
> and if the alternate setting remains non-zero, the USB host controller
> reserves bandwidth even when no audio data is being transmitted. This
> could reduce throughput for some USB 1.x/2.0 applications, such as
> file transfers from USB mass storage devices, when sharing the bus
> with a Bluetooth controller in SCO mode. I don=E2=80=99t have a Chromeboo=
k to
> verify this theory, but I suggest the ChromeOS team measure the
> potential impact and follow up if necessary.

Thanks for the input. We will measure the potential impact.
