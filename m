Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF67450904
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520944; cv=pass; b=XRBHxOFBN9I6Pas/w4VDYOKfC7xUh1ctDv+BdlatVXZH9CYY11BlXxRwbWA9vc34eOyl7oayTv0mQpvOH5ahGIT1AgML3KokRxcbk3kT7PQEObFiaRxRzKrqj+nhL8zQnR6Fu7SkblY8NR1bKUEPI0bgtDUGmArPY6XnJ3Zey7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520944; c=relaxed/simple;
	bh=PrHitHZsoYkpOMvbmxI3GoouXwZw7Mpx8RnnPHK+sF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exY8IG9+Y/5UfBVUcGV9zuua9qVcQ74b35an3F+nBIK9XATpu5Pg+7wqJJ4gR2q0Uh/NrW3L3Y+fiZjp7am1eCc8IHLKQzZOuv5ee9kGtYyZUpyZIrGFYQVWmqaWCivEyvsjtGgPHOOgdoOXdIciQA/XwLl3cFmgiTjFoFXd8/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc4Hyq64; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc4Hyq64"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c364b893aso4437196d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520942; cv=none;
        d=google.com; s=arc-20240605;
        b=BjyZnUmQwHAzI2Q8vpfbERe2aY+gwMBMzNbgAB2aj4uWVBw9gMAU9NgkPkxiAQIPFh
         0Lhdps9EQMsCPa/YkDPUtqG8LmIAWefdvtuciOk5ulTI6xAG16OIGP1fk4OqpPMQIYc1
         3Y7qnjgX3XysPBpejNA6ZyKmXU+ZUDpgIAhhQNHC8NLJt3YeNnP4F11ueaaNnGhASCJi
         ZI8FbwEqvAbu/YN0Kuqb6SU9HbDiMyTAPd/4E9WRjz/ljjYjpEUw0CdR5ERYcfranZUs
         eoaedlMLvWdbeRMakfrpnahqF9x8dIEaE7Utax5MJH3pI6ai+rvErP/47Dy/8jr3qNzV
         YVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        fh=KVfISlVZd2xZgbfwvv2Xziebuy1KOvcrcayY3iKofj0=;
        b=hDKm/ciqvZhcZ7U4xKRkyHKdgiN55uZaoErngydNeNS8VfBfKMsbbF5KSTX6YTZUbR
         2JDkiDd+iWxt+iDAVQIySAz+/1xJs8QeIQWUBKiQCE7VEngYuNJwnYksP/SRKB7ksxJe
         0TmQwv9craubTsaWSt3+wy3Ki/sV0IrjmDoNun3o0c+AER4dJfw5sUGcLlQiUBLSQkDc
         yDlD3maA1ktvQlBdAKCOqN2iWBir0DmB9C3fjVcwTSnU/QFqcu2T6yIRqRQDA7adMvLr
         +MpBOs4/NBxnQ9IU/y60JxrawUzlKxlisVjDvlBQ6XcV0/fO4HnXx3MdJ2LxHwUWwEu9
         CLpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520942; x=1779125742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        b=bc4Hyq6422T08nEavjrv0nDDz85pVXB3eTqJKoNwnpdT8bP8Bcl4KiEc2T32rsGCnR
         rQBiLxpofKw27UTTEer8HxQMuuFQTNtybfmTHLOUcjFC01b2futXIZnJkpAf/SxRAe5T
         4IEBJR4+6A0JQ3lmblaixA6Xavv2Su0YfU2Rxoiszu/K1wy8M1QdSJGMbIRL5xLuddKT
         olhNLsqOa2ZxCDocaVSA3GDhEbP3Axifd2YAiQnkt5xF2MReURk6aZ9vftmjn0Zt5k5k
         WnR9mEMats8f+i9zBxTrDwuT/CA4g0+RXlEeN+f5nGBaitZynX1AK+/iRbTkWQEqi6Lk
         hCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520942; x=1779125742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlz/dzPv3rXYhFqA+0mmgm8FDTZKSNmwOlN+ACRup7M=;
        b=SWuFRbbFqSiZyTqsFdsZ0kG/lW5u2ijjgQW4cISGKmA4n/zTxs4uyzq9COi5Td/a25
         DaZNNfa6O3hjW3L+ONDKdVkuX5HHV9pZszhSWrnTQyry9qeSsnCk551P6z9SBnkelB30
         TCz3J0F26VyNfI1U1CQ09uNFQJRKKIYgG/dVM2AHo6BTViu531BjP0MJuSbC+6a1nwGC
         UDjzVHIYcExoieeC8WtN/nSv3IKZ7xs5W8ry6pkG9imNpVLu1yDJlN1krnjtT4JZRMAF
         QFsQm9sn36wFKV21VMN8Pn1DeqndbLKlXG6yw9IfAObQVC4efGmZSoAH4bApxqzwJtMd
         ubkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/cCqY3e5/HQsgDVhevdz/vDJrypcdUeTC7OsNx/HOUiYJ7dFt7vrif0vuY6+nHOv051NNUj58KfElF+hgpcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwctkYg/El4EjOEd+jkeDqVEtENOrmvhKkONCrub9uro2QlcN
	ze6YWlxeIHJrl7CRBZ/lhARWSdhMEk4kLvWzoM980004GyzKEgw57JXJxyDIa/Wm3U9BoGGIQT4
	6POXHz9zHlP2N9Vqx5ZW8980nsrSZB2g=
X-Gm-Gg: Acq92OG+YPWCwfAYL5cNr+dCj0qr41HatsILIlc8yyfVauIk+mstNJGxuCzpXthYCg5
	nFGsyxwLU8vjMbMKh795fQVLF8SOHR3WVUOFcTvNNn4fRUnx+dS3WPZF1HeJZjBhuaeUuwQwYA2
	okGqRTvDmdAE3VJqTHtV9giZZ3KUJiny3buDBqLsQv9N5eB1tgrBqRMVuN7ISiKLv7QN5Ek++u9
	pIoIDHhWhpZfOYifv38CGVOQdTnG55Gq3qzTPpmsiOGgnfxS+lOT5HrAl+Iz7iFhQVMkPRF7BUL
	eowEmQRe4laEdtsbL+VKsx1yW5/Jz+7MZN0SH/upqWHBBcrsHwaePoPfCJR02sRy+OI0Ig==
X-Received: by 2002:a05:690e:120d:b0:65d:8123:25e5 with SMTP id
 956f58d0204a3-65d94afdef1mr13964872d50.7.1778520942181; Mon, 11 May 2026
 10:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com>
 <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
 <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com> <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
In-Reply-To: <CAJJ9bXxdm6LRW-5a4a1eDyZSQjNkJ4PNF+aERHkHe9EMQFX8oA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 13:35:30 -0400
X-Gm-Features: AVHnY4L-7jwHCz-ogOtNC6Z8VESGLPAPWW1nNwcsCVS7lrb7wnAJ7aIMYilRan0
Message-ID: <CABBYNZ+nyk+hZ498373bLJ0dOkDbNqP0PyoH5MWsPerHhBSfLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, May 11, 2026 at 1:01=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Id suggest we dropped the once at the end so just hci_cmd_sync_queue_co=
nn.
> >
> > > +                                       hci_cmd_sync_work_func_t func=
,
> > > +                                       struct hci_conn *conn,
> > > +                                       hci_cmd_sync_work_destroy_t d=
estroy)
> > > +{
> > > +       int err;
> > > +
> > > +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn=
), destroy);
> > > +       if (err)
> > > +               hci_conn_put(conn);
> > > +
> > > +       return err;
> >
> > Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above,=
 so
> > I don't think any caller should require queuing multiple procedures
> > for the same conn.
>
> OK, good call.  I checked the other 10 callers for
> hci_cmd_sync_queue_once and there isn't any variation today, so that
> seems safe.
>
> Do you want me to wait another 24-48 for others to weigh in or ship v2 no=
w?

Just create a v2, anyone with comments can add them there as well.

--=20
Luiz Augusto von Dentz
