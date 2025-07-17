Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4B2F2E;
	Thu, 17 Jul 2025 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752725481; cv=none; b=XPlagRdkzBEyHaWRwKwkXO3VJBtX2pbNKM9FAYPkDFb8q+w3aUpO+/UwgcRylBXjefwzXoJlld1J1hq5Tee4uIJkTeeekHX9vfH8H1lpOoWRVvYQD99mWmVdA1bkS+/nbUOZBjj1UxoFAOZluScIkZ6UTjTGTRFGjI8nBrGWSEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752725481; c=relaxed/simple;
	bh=39Pt0NTeV/UwJP2/5cioo4wFTMzR8hQUlPmzkpreB3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIT7npcgUIXurdFCN1miy3hxqxOkcEr9jF/CYinxu+VEXYH6iiWTJBIbgmiLeqeso9DUe3cNT7xZL1RfGvksjf2r1dM+a8iuW3odR9CKtVWs058ii2549tVqPrfgbqXD49Xs5PCLM53guVYfC9y5Xwws94w414EP1Eb7VWvvKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRrvr5/c; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRrvr5/c"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b31d489a76dso413897a12.1;
        Wed, 16 Jul 2025 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752725480; x=1753330280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rrYQ/3+JPFvH19zEzj+teGZGBu3oIm94YH1KWI89ul4=;
        b=FRrvr5/cwFm4gOwiZAVllqosMhVM2NRTejGAuwtwAZbm2en1z+DvQbyRY+H5ghCXdJ
         evOqZrIuJreoyhR6JqLLBd9pHMqtC+VDmuNx7fZOCRuYKcNHI2Ziy70J9GX2UwSci8Bx
         gz7m/wco8hCvWfvIw5duAQ3pvHu9VB9K7YlsjOQSNwJSAGCFgRhT8Y4xG2cWrS397i76
         1apgdouTWQSWwAwgCoiIgwhoGiykxczw5x+8DU6rOU81STodxeIunvK3IZTYq8joZVaW
         XzwT7mjVPyqRNrU/vfHSHrchOSgUPhJzytZYzl7rf4nc1FYSJtXsh1eda6hKyXrSUkIQ
         LT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752725480; x=1753330280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrYQ/3+JPFvH19zEzj+teGZGBu3oIm94YH1KWI89ul4=;
        b=ZiBkjhT6mYcFZaypQ5HMkZJ2nhQ5pjdYG3HKhkqSNzeNU8phrDriqnuZJyMeHMj9V8
         BCvWq8iWMebMytz7L/mGWLej8a3FCM/qwqgJrTSNFu53Ee/C3xH6CWgyg3yAja2o6vL5
         UYtkgqQerLYQmA4wZSDviOnfZy2VhFaFkxuLce/dnQd1Xsxvw+dao6/C7Wn8vtXPbs61
         uLknojC0/00wBTF93CzRu2Umiv/9aIX868YUb2E2NsokfbvxyonfH9UMeFNalX1bd3N+
         f8XYMQ3RUbwH4u1rzLS2shRoH34rzlr4qGu9Uzx62NHB2YbOoII4H4RsO7rqKM6/INq+
         3I0Q==
X-Forwarded-Encrypted: i=1; AJvYcCULthvoiSIcPt0pEfk2IEPXcfex3vPHuQQJxaN6BjDmznYHniZQr5ST3dxh09adZSCHNmbhQdxO00AREYEDN6M=@vger.kernel.org, AJvYcCXfQBWe3+0J59g+rWiXxxxqtHkRF8Tv3vtH7Nf9tYotDCywWVAsJVOi8xkO+ikHYNtu4hsr9bvnDPhZyjLD@vger.kernel.org
X-Gm-Message-State: AOJu0YxobzPD3Pt+ghgQBKgV+CuM5KkgqyT6E7f5nJhP/9uSdOR6VqAk
	0xJeoL09zHc898KmrNJjxSJvCgnVfApLWyu7van6FAUiHhvZYmjQUuADcdfOyFzD
X-Gm-Gg: ASbGncu0pAzV/b6fF5eMnxOw98gV9xECJxpE3NCJ8044+4x/kT9q5EuW0DFy7sUHh6m
	aKiUI2d+9hgsj1EClJ10K1/x0RdSJ2Iw/0z8HS6VubLGidv3/bAq0nx4VrnAH17WZUtdYMCorP7
	b3+rnhGCLmb5HEcqcaBcoKCUPzwXWtPm1aez6mk3F7kjuudBZL0GHMLhhkfxrEbWe58gZz6fhX6
	LcCeL0zbxlIcyErga5XONbKJR9qUpRERw3FKlCnlMr3HD7kdXZu7dOujc7yJvrZ8aasOveC9Tsp
	wXWvpYnCt9HSVp05RB64Ocd/K2SY8lTMeJmqoR76SnfQwmlpItVFo7GGPqOhdWcsMW9BEs1qnYZ
	MZ7YWGTLMOTl47nuXMd6Ixz7kulXRxmOc+Cla8v4q5NaAsiSn
X-Google-Smtp-Source: AGHT+IE1zV4FIHu9LihPhKv0Yx0RSmp2GUCmrnL//JO3MBQgg8Nk6xFNGQXPyALMX7UGmm8JPjOqIg==
X-Received: by 2002:a17:90b:3f08:b0:312:e91c:e340 with SMTP id 98e67ed59e1d1-31c9f4c507bmr6805679a91.35.1752725479544;
        Wed, 16 Jul 2025 21:11:19 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:9da2:46a5:b508:3b9b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f29e313sm2295018a91.35.2025.07.16.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:11:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 00:11:16 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
Message-ID: <tdj2vssbhlth7gxggbnltssux6r7kzhn3guloefmieboszejo3@7yrut5ygk3yq>
References: <20250716003726.124975-2-ipravdin.official@gmail.com>
 <CABBYNZLOTLVz4kCGMK7kw1RE-KdWciOYwkn6tN_=GZUk92ySdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLOTLVz4kCGMK7kw1RE-KdWciOYwkn6tN_=GZUk92ySdA@mail.gmail.com>

On Wed, Jul 16, 2025 at 10:11:01AM GMT, Luiz Augusto von Dentz wrote:
> Hi Ivan,
> 
> On Tue, Jul 15, 2025 at 8:38 PM Ivan Pravdin
> <ipravdin.official@gmail.com> wrote:
> >
> > Create and use new vmalloc'ed buffer with dev_coredumpv. From
> > dev_coredumpv documentation:
> >
> > `This function takes ownership of the vmalloc'ed data and will free
> > it when it is no longer used.`
> >
> > As hdev->dump is used after dev_coredumpv, create temporary buffer to
> > hold hdev->dump data.
> >
> > Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/67eaa688.050a0220.1547ec.014a.GAE@google.com
> 
> It should probably close the syzkaller issue, which I assume is this one:
> 
> https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c

I will change it in v3.

> 
> > Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> > Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> > ---
> > v1 -> v2: Changed subject prefix to Bluetooth:
> >
> >  net/bluetooth/coredump.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> > index 819eacb38762..1232c9a94f95 100644
> > --- a/net/bluetooth/coredump.c
> > +++ b/net/bluetooth/coredump.c
> > @@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
> >  static void hci_devcd_dump(struct hci_dev *hdev)
> >  {
> >         struct sk_buff *skb;
> > +       char *coredump;
> >         u32 size;
> >
> >         bt_dev_dbg(hdev, "state %d", hdev->dump.state);
> > @@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
> >         size = hdev->dump.tail - hdev->dump.head;
> >
> >         /* Emit a devcoredump with the available data */
> > -       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> > +       coredump = vmalloc(size);
> > +       if (coredump) {
> > +               memcpy(coredump, hdev->dump.head, size);
> > +               dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
> > +       }
> >
> >
> >         /* Send a copy to monitor as a diagnostic packet */
> >         skb = bt_skb_alloc(size, GFP_ATOMIC);
> > --
> > 2.45.2
> >
> 
> What is wrong here the is code that attempt to send a copy to the
> monitor uses dump.head _after_ dev_coredumpv has freed it, so just
> changing the order shall make it work properly:
> 
> diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> index 819eacb38762..720cb79adf96 100644
> --- a/net/bluetooth/coredump.c
> +++ b/net/bluetooth/coredump.c
> @@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)
> 
>         size = hdev->dump.tail - hdev->dump.head;
> 
> -       /* Emit a devcoredump with the available data */
> -       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> -
>         /* Send a copy to monitor as a diagnostic packet */
>         skb = bt_skb_alloc(size, GFP_ATOMIC);
>         if (skb) {
>                 skb_put_data(skb, hdev->dump.head, size);
>                 hci_recv_diag(hdev, skb);
>         }
> +
> +       /* Emit a devcoredump with the available data */
> +       dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
>  }
> 
>  static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev

Unfortunately this does not work. This was my initial attempt but it
still reproduces the error [2]. The reason for that is that
dev_coredumpv takes the ownership of the buffer. From the comment
above dev_coredumpm_timeout (which is used by dev_coredumpv):

> Creates a new device coredump for the given device. If a previous one hasn't
> been read yet, the new coredump is discarded. The data lifetime is determined
> by the device coredump framework and when it is no longer needed the @free
> function will be called to free the data.

If hci_devcd_dump is called multiple times, first time hdev->dump.head
will be kept. However, calling hci_devcd_dump second time before data is
read by userspace will free it, leading to uaf error like the one
observed in the report. 

As hci_devcd_dump need not be called only one time before hdev is freed, 
calling it multiple times will lead to uaf, no matter in what order
skb_put_data and dev_coredumpv occur in the function.

To solve this problem, a temporary buffer should be used. Such buffer
should copy data from hdev->dump.head and be surrendered to
dev_coredumpv without any possibility to be altered or freed.

For reference, here are some examples of using temporary buffer with
dev_coredumpv in Intel AVS driver:

[bluetoot-next 6f40d15c70bc] sound/soc/intel/avs/apl.c:183
[bluetoot-next 6f40d15c70bc] sound/soc/intel/avs/skl.c:147

[2] https://lore.kernel.org/all/6845dc6b.050a0220.daf97.0af4.GAE@google.com/

> 
> 
> -- 
> Luiz Augusto von Dentz

Thank you for your feedback.

	Ivan Pravdin
