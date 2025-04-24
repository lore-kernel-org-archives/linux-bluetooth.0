Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982418E20
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459383; cv=none; b=EOfJ8MqycHz+dlsMKEATR28c4tN+bMr9KCxJM3kJMwHqHAwJkgySv5j81X2IwZzg1KloMaFmgBImPt/LY6fa3R7mpgsBCGLhvb5OaYgseQX0b8z5n0zJnWsqiozmxYoR3HALBCGpX2u/xRB71h6h2qUPxr2ku+JMG4PPhRYULJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459383; c=relaxed/simple;
	bh=IowWVH3K9iwpNQaMTGXZkfw0e/2BgFmZ3Z26C9QIL3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5zincNzls5H1tpQs4O/wsJixEEBAff4lZz9IceOOII6RCPu3/6eCd2qSR+I1zXjxPBeBxOWC9adOx3mYpx4sxPC4up53ZcOY1pXGDpVfKWFZE9rwB2kBEkEJy/IrpxC1iTbMdTLE8tsCkHKNn9C9mRuEzoPanQt001DDNGAcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cBB36X3U; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cBB36X3U"
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C3DC23F5BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745459378;
	bh=73Jw1LNaTTLgW1MT9gMWZl9x5ym9pdlC9TvxDPIE/eQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=cBB36X3Ubce5M5Nb3TLqQ0ENGdnYwdvmue1C23rMaaoovPnCRb1kinyOMY5qBIOcJ
	 Y6zfCywuoUvCgghJOSjz9SYOtesO1TlRL7JH9LXFMw8WuWcfNenfOODNaqSxTeEzCI
	 S4g3fRmanPYU9by4IjcwstVPoy7tCU9UaBUTCOEuuAiWXUdqUiqtFOwp8OpuIZM/1l
	 oQAcdvmfel9TTnqVRN8Z78x06fT9X4UMIMaLjvK55rWWbZ//qeGcJ57v1HZqmrp+nw
	 AyENZM99t7FBNJ2c6wor7BqeMxOib/SOkTAXkyTR/8Uz8Al+7zJVhG6uLzeLdv+/tc
	 0jjVcqlwhML8g==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so1874185e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 18:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745459378; x=1746064178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73Jw1LNaTTLgW1MT9gMWZl9x5ym9pdlC9TvxDPIE/eQ=;
        b=cKpWv1BMlkjAGNG9Qk4UXRDurlIRQnGtgkiqh0qFJR25lRIQLc1V++mpz8FHf2Eb3H
         TF3A8fdzRB4/QerhW+NAxIqDDmTOyt7m4NGrIgzr+nW63XFlckt5j8tthjyXY93ZLDmZ
         Hle5tIuSdrZuzhKuIx43WaOTMmcuUQKLA7oU31aserPnxEc6i2XTncwCzesqsJwptLS3
         M9XDFa1gqD7oEm2IpjC7WPJhBXeDgmN5l2wX7qnI+3o9yNuLx8AQRXwe8sLdgTdk+dUY
         BIXT5NuZHId7s1dio7TtrLzQjloMVHGCa03RJ60lRAyXJirVribaLv+p4d5ENjQ8YsZv
         VyKw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ubbfdkkvTI5xvOO+1IwdwZT9rhQ+Ydh0kiAyox9X8pK2aAITDMP2alqgg2NVD8nppaFm7yuEu6DgSgeLlkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyP8SDO9HybyElxnSmJ4mG8UrABjosJHMajCm9aFtuJrPmsjR
	/1BsBO3ha/Wtwxe2Sf5MS/PH8AUDE7TLilQu3XmCqCZJsj5+lJsa7KY8/KffEtbN18g9nYOUc5W
	XaW/TmHCC+tcSIFYUno3lgkIRIOHSLX7/A38l9jpb5k6oACDWiPd8tkFZB6lCgWJjcJoTk4VA8n
	N416AL3ywlufvRGsaloNmt0b/ggVI47P84NixTfcI8HSJCu1o1/TlrcdXV
X-Gm-Gg: ASbGncujFLK8w+Lafz4bT/oD4VjswUdQtMEApR+0iYg+rYSQgznwIVvFuwNGpgG6jnZ
	rLbovPlTwD1emANZsMdu+03kRN8BYHqDpkIfgsD9Cv4d8gGm8U2Cu/w/mERst//4aypOrhA==
X-Received: by 2002:a05:600c:4e42:b0:43c:fd72:f028 with SMTP id 5b1f17b1804b1-4409bd906famr4209625e9.29.1745459378409;
        Wed, 23 Apr 2025 18:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3EKQfq6rxDlZcEmm7j8KdrNoJE5TKKrB64pg/6U3nUr3CSHLcJfDNSWAf3SuHHChaArnz4uX27aU7cwSwOOA=
X-Received: by 2002:a05:600c:4e42:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-4409bd906famr4209495e9.29.1745459378022; Wed, 23 Apr 2025
 18:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421130038.34998-1-en-wei.wu@canonical.com>
 <CABBYNZLXd3EzMhf41wJg93jNp7DWQK7oHOnHGv_ThZJ7yMXTGw@mail.gmail.com> <CAMqyJG08e=-7GTmJjvFi_=YTFupabDBAnSGNmhG+SX1F9z=PTA@mail.gmail.com>
In-Reply-To: <CAMqyJG08e=-7GTmJjvFi_=YTFupabDBAnSGNmhG+SX1F9z=PTA@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Thu, 24 Apr 2025 09:49:27 +0800
X-Gm-Features: ATxdqUFhdo9dw7YGzMzeJhNQ7sjkbm5WN0ZON30Zhv-Xu9WolTcej4DLeYT4VdA
Message-ID: <CAMqyJG3TRRP6PMSzcaUn6=01JGnCjzhGFqtsKy4bxVO5Hr+y1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] btusb: fix NULL pointer dereference in QCA
 devcoredump handling
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de, quic_tjiang@quicinc.com, 
	chia-lin.kao@canonical.com, anthony.wong@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [PATCH v4 1/3]: Move the device-core-dump logic of QCA from btusb.c to bt=
qca.c
> [PATCH v4 2/3]: Fix the original NULL pointer dereference as in [PATCH v3=
 1/2]
> [PATCH v4 3/3]: Use skb_pull for safer skb access as in [PATCH v3
> 2/2], and use skb_clone to avoid directly resuming skb->data and skb->len
Should be [PATCH v5 */3].

On Thu, 24 Apr 2025 at 09:46, En-Wei WU <en-wei.wu@canonical.com> wrote:
>
> Hi Luiz,
>
> > While at it, please move this logic to qca specific file, there is no
> > reason for this logic to remain inside btusb.c
> I'll work on the v5 soon. Here is what I plan for v5:
>
> [PATCH v4 1/3]: Move the device-core-dump logic of QCA from btusb.c to bt=
qca.c
> [PATCH v4 2/3]: Fix the original NULL pointer dereference as in [PATCH v3=
 1/2]
> [PATCH v4 3/3]: Use skb_pull for safer skb access as in [PATCH v3
> 2/2], and use skb_clone to avoid directly resuming skb->data and
> skb->len
>
> Many thanks,
> En-Wei.
>
> On Tue, 22 Apr 2025 at 03:17, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi En-Wei,
> >
> > On Mon, Apr 21, 2025 at 9:00=E2=80=AFAM En-Wei Wu <en-wei.wu@canonical.=
com> wrote:
> > >
> > > This patch series fixes a NULL pointer dereference in skb_dequeue()
> > > during QCA devcoredump handling, and adds some safety checks to make =
the
> > > parsing more robust.
> >
> > While at it, please move this logic to qca specific file, there is no
> > reason for this logic to remain inside btusb.c
> >
> > > The first patch fixes the logic bug where dump packets were mistakenl=
y
> > > passed to hci_recv_frame() and freed prematurely. This was caused by
> > > handle_dump_pkt_qca() returning 0 even when the dump was successfully
> > > handled. It also refactors dump packet detection into separate helper=
s
> > > for ACL and event packets.
> > >
> > > The second patch adds bounds checks and replaces direct pointer acces=
s
> > > with skb_pull() and skb_pull_data() to avoid accessing invalid memory
> > > on malformed packets.
> > >
> > > Tested on WCN7851 (0489:e0f3) with devcoredump enabled. Crash no
> > > longer occurs and dumps are processed correctly.
> > >
> > > Changes in v4:
> > > - Fix unused variable error in the first patch
> > > - Refine commit messages
> > >
> > > Changes in v3:
> > > - Use skb_pull_data() for safe packet header access
> > > - Split dump packet detection into separate ACL and event helpers
> > >
> > > Changes in v2:
> > > - Fixed typo in the title
> > > - Re-flowed commit message line to fit 72 characters
> > > - Added blank line before btusb_recv_acl_qca()
> > >
> > > En-Wei Wu (2):
> > >   Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
> > >   Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump
> > >     handling
> > >
> > >  drivers/bluetooth/btusb.c | 120 +++++++++++++++++++++++-------------=
--
> > >  1 file changed, 74 insertions(+), 46 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
