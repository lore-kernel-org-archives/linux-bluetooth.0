Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53481EA90
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424091; cv=none; b=s0M99wKV8vz8WZ1eSm1pY4fol4QExKe6NkaYNhO8FEY7pLgLPciGq4/b7Ix+64czNshzi8fNTBb+rpYDVGX1TS6uWCMqC2CKxmLQiE9aPIrX+VsD2/IYaxmnlDEDghOkRA2s9f4PN4Q/DuIBsgZ5LtihG15tMNyvvxYfdbBvlGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424091; c=relaxed/simple;
	bh=/hYQIFN5eLsEw5ZfLn9JjnNAr5fEBGpJclbHobhz3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1bv7kjrTPV7A2SkG6+M98lfhl7/QQsKjal7H7oNzbZCMc/0q1QrlIktY1XoMrGeTuUctx4yFWDZ1tI1ppVmps72vmRmzprmh1hX0doX/ck3gaMiIe+t1z8zLz7ljRkPJ6if/4JK9E0+s6ql4MQ9ehPrEYtsZiAzVWe1wzKdH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elJJ/cjX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elJJ/cjX"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7d58aa674so77241566b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 21:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739424087; x=1740028887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=va3y7gaOp0Y0VVUn/Hp+/Cra/1Ee6/x5n3PcEqf4xos=;
        b=elJJ/cjX6mjaLHai5BjUv/rRdfKGiutFiWmvn7dhnYuqItegLFqm83YR1jd7guwv3K
         Tmldjo5Rv5Sd89qf5bFOmafA/LE+eC5GOGCcQntMakRBPtWTCVFRYE2TY75XWrb23GXy
         KP8q22baKN7BmTQA2RlvjP/S6gddfNEhgBa7O452nXIv/rJKLyOVMK6lg3CCIOWoUIi3
         WQnLogajR+NLVK9U96T+YQp3moaZkAECBByKBJer42//oUafgLbwYXD19fMnWVyhwXI7
         u+o2FQ+N76me7gC7yxBbGXRwai4qxYNPXm52rwKLc9/e0+LU2jYedteUnUlZxtI7PFkS
         muAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424087; x=1740028887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=va3y7gaOp0Y0VVUn/Hp+/Cra/1Ee6/x5n3PcEqf4xos=;
        b=qpAxrhL8Qd9detfv2PQmYrvWOStNueWApzWzPF7zZ2DO4M2Gyu8bBnR/vBMb8HZNV6
         J8I2z6HWV2uh0ulYlflZAVVsRW8UJncba/SYFMigrJv9NQin6bDDLJpyekKYapg/ELo1
         yDLiUNdSrg0EO3C6PDQHsn8tMaUZp97QRphiDatAWDO/bsv04KoGdsVlVB+Yl3PvMW+C
         omtrOyEu4nrasP+toi45kgZQjJg1JAF20r5XUR6TBz89w2kFbWHvfsUbOoi/SknIE+6D
         WCBYZRTmXbxqpKN+GT1H5IM8s5jzxHhNMZD5qjv6m+YtnXBgDYAzhY2Aro8K4mg/YEJI
         0rBA==
X-Forwarded-Encrypted: i=1; AJvYcCUprYHMLpcvn/gJ1au7RIH+y7uz3bB/ZMJ5iGcqeWCjb92O0L8qoIRp2PGJmzWJh5CS+GxpE2Mi54JXbDzSszc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisTRvV+Pwv7jzmtbBHhQqXk9E1UHVzTXmNlMwsQtNVn8SglHM
	mnvkExQWR3O0VVgKt3Y/jboXZs2amEfMTUF1ZwpkN2d2IvIUc7HnvH5pwRT+3+TEV8+DQTYfInq
	b
X-Gm-Gg: ASbGncsftwNFoncayQ4Rwj/MDUsibj3SJk/nPc17SMslmK9mrdp6dNimz4/MCdZoDuw
	M3h/4cyeV+f6sp6gxQiEhzZWSfuLdg9li/KF+sfyt2NkruvypWNqQxy2SJ2+hQUbXOyNP6GWUh8
	pGP62L0MGMoOWoArxEHrLNCuFRPOP3UgYT/pckJU1Y+JOAFsECqQX7LHeC971XTC+CLAscKuYVA
	wUXcubOd//kZG+qv6ntcGhaP0p63FtpH+AW+/xck+lobuJjfuQYuD1KbF9WercQUPvLDgdltZla
	Xg/MvOpcN8zFKk/p2T2s
X-Google-Smtp-Source: AGHT+IF++tzvA4ozNyZQfnVkn1og7OUT+54+YHB7mg9npVmHLsgg4X/HxYxaQJ/l0a+CyHudxXqOAA==
X-Received: by 2002:a17:907:97c5:b0:ab7:d4b0:9254 with SMTP id a640c23a62f3a-ab7f33f5f77mr528766466b.26.1739424086964;
        Wed, 12 Feb 2025 21:21:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba53376713sm53891166b.108.2025.02.12.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 21:21:26 -0800 (PST)
Date: Thu, 13 Feb 2025 08:21:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] Bluetooth: L2CAP: Fix NULL dereference in
 l2cap_recv_acldata()
Message-ID: <189055ae-a400-46b3-b265-a93a23f0d715@stanley.mountain>
References: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
 <CABBYNZK-ibR-+ri_+FFiorLkEvT_1tD2YKSOeSuTsyoS4dM1CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZK-ibR-+ri_+FFiorLkEvT_1tD2YKSOeSuTsyoS4dM1CA@mail.gmail.com>

On Wed, Feb 12, 2025 at 05:23:42PM -0500, Luiz Augusto von Dentz wrote:
> Hi Dan,
> 
> On Wed, Feb 12, 2025 at 11:40 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The "conn" pointer is NULL so this "goto drop;" will lead to a NULL
> > dereference when we call mutex_unlock(&conn->lock). Free the skb and
> > return directly instead.
> >
> > Fixes: dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  net/bluetooth/l2cap_core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 6cdc1dc3a7f9..fec11e576f31 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -7456,8 +7456,10 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >
> >         hci_dev_unlock(hcon->hdev);
> >
> > -       if (!conn)
> > -               goto drop;
> > +       if (!conn) {
> > +               kfree_skb(skb);
> > +               return;
> > +       }
> >
> >         BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
> >
> > --
> > 2.47.2
> 
> I went ahead and fixed this in place since it has not been sent to net
> yet, I did add your Signed-off-by though.

Thanks.

regards,
dan carpenter

