Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668861F8BBD
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674086; cv=none; b=TWJ/LezaO94jq5KgWefmHwgL05ElKHs4j7Xr2JgE22nib+7aSpivsLE/5D11P+pxCmur5mbqJHXyWPPtCiR5ZY6FbL78FZEmM11M8/OHvvDV2EuWMHnkBHGVD+TFncg6bpwZ+AEHy0cWdszYA5O/2a8Mgwla/P4fASq/1T7MrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674086; c=relaxed/simple;
	bh=CadnOnqUrP01j9sf1g6sUWHOFqKProxbSycYgQcVmxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7xAJDNsFmCTL6aR1gN55d3PkwscA7Dqq/7ImDrqYetXxhn78qSwGtP5wjEJ6Pn3XJwiXfVkrVxtTiVwHNypkD49j22IeRFyd2V/xDr5gVkV6QBf36CXhE0gNiHWqT9wYlXPfhu87BKyeouj1XDToy6HgDFIZTT/sxdX1jxHZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MeIChkIN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MeIChkIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750674083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lgw/bD4SindaQDwTXpeWQKLQPGV/k/mx1XMIx/reNQ=;
	b=MeIChkIN5mc9k0qLQ4zz/42LFZIUspwtuzfbWwT6CVQrEwM+5hCN8j5uDPLN1PsF0W37tJ
	SOUsdn0eclikM/i7IOyx7+jMyYYfClPQpCMP+488KxB7UiFWvoRa5IftHbyvPoK8P+qhmU
	pe+02ONbknHgKmx9lxQ71m9/DV0TeQA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-gNKHK31iO4SJlEl6JRpnHA-1; Mon, 23 Jun 2025 06:21:22 -0400
X-MC-Unique: gNKHK31iO4SJlEl6JRpnHA-1
X-Mimecast-MFC-AGG-ID: gNKHK31iO4SJlEl6JRpnHA_1750674081
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71111a7c31cso58080577b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674081; x=1751278881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lgw/bD4SindaQDwTXpeWQKLQPGV/k/mx1XMIx/reNQ=;
        b=tz5YqF+9MYh06qGUI2KzVDOdYBP59Rx6pZvOA6b6sj8GJuSq0DlVdK/0P86ix18BZP
         7jqxvDupX8IkygSsgSpLsZo9k1SLlYD65VdkHhb0Ot6sb8OQPdsl5TBudTQCj/4NFgen
         n6zDOQdskbTO7F8UZEgm4Q4oyCVIslxoGANH2wNVtUOOsZT1zf0dXBJ5Z1hINOZgfGZR
         0tnQc+vunoA3eaCHkZOtByx8TybHsZDc4U5xrQ7eJUBNE4BC1yuEx+IM0U/TirFOGX43
         DErWTB2WrAeDJDDn0odmROYd+KqisnfcauCyP93+9GW8Nht7ARYMwJPGg2px3C6F4Cw2
         wigg==
X-Forwarded-Encrypted: i=1; AJvYcCXNM/nf08O7rKLAFgEyA4ikAbADZpYhvbAocfOI4IkvSz+u2NYTuxKRIldI1VCOr0VgrDxKejAiTNh/H6r7boA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dCUJTRFYt9wSEF4SQya7ZbkMKDByLC5V44PJ5vIV4z9zlyqo
	oXaIc5Js1sabStRaRJjiuQW6K2++o2Z9bU2aQ2DgPFuhf8963BMIvlKDCwWbIgqlOBUyH+WL3mU
	Cf9IoZ4A/Q9Fr4zWgz7dLW5c/1KA0KHcIsmZUP2NaTtg06IYEjxR+BdIe6Y0Yr75JxEZ4AmqGAG
	tE2IZ751XIzh8cuHJwIhsu8RSiZNhKlCp136RUFJLwXiQs
X-Gm-Gg: ASbGnctiPlt2McdotNt+x5sITU8GG/h3enFau/tGdKfy995GDmcIZQBE3w7p5mFGQtB
	NxB5BsOeFBim9OCrGrQguo9+KgKaghKhjDk986BDdwas41R4kxS8BGVgM/eAFU2gVtL9SpSajtY
	szToI=
X-Received: by 2002:a05:690c:6f93:b0:711:7128:114f with SMTP id 00721157ae682-712c63c5613mr173777307b3.12.1750674081368;
        Mon, 23 Jun 2025 03:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFiDnn92RagGTfufzHsxHhTXMUufsWyR4eKoIQO45W2ta/mlkrX/GRWBBKswWX0hUbhvXY3gbxHPfx0i3Xsoc=
X-Received: by 2002:a05:690c:6f93:b0:711:7128:114f with SMTP id
 00721157ae682-712c63c5613mr173777017b3.12.1750674081105; Mon, 23 Jun 2025
 03:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618114409.179601-1-d.privalov@omp.ru>
In-Reply-To: <20250618114409.179601-1-d.privalov@omp.ru>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 23 Jun 2025 12:21:09 +0200
X-Gm-Features: AX0GCFvydjAk0H9SdIviYpopwIHMR0R5bzlGmZzRGrpaLGnO5vBQo-A0rDztVy8
Message-ID: <CAOssrKddunTkNzY1ydgg-rpi1aTuq-ghgJcVuQOXnK1GH5HCtg@mail.gmail.com>
Subject: Re: [PATCH 5.10/5.15 1/1] fuse: don't increment nlink in link()
To: "d.privalov" <d.privalov@omp.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 2:00=E2=80=AFPM d.privalov <d.privalov@omp.ru> wrot=
e:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> commit 97f044f690bac2b094bfb7fb2d177ef946c85880 upstream.
>
> The fuse_iget() call in create_new_entry() already updated the inode with
> all the new attributes and incremented the attribute version.
>
> Incrementing the nlink will result in the wrong count.  This wasn't notic=
ed
> because the attributes were invalidated right after this.
>
> Updating ctime is still needed for the writeback case when the ctime is n=
ot
> refreshed.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
> ---
>  fs/fuse/dir.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 4488a53a192d..7055fdc1b8ce 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -807,7 +807,7 @@ void fuse_flush_time_update(struct inode *inode)
>         mapping_set_error(inode->i_mapping, err);
>  }
>
> -void fuse_update_ctime(struct inode *inode)
> +static void fuse_update_ctime_in_cache(struct inode *inode)
>  {

Backport is wrong.  In the original patch we have

-       fuse_invalidate_attr(inode);

And that line comes from 371e8fd02969 ("fuse: move
fuse_invalidate_attr() into fuse_update_ctime()") in v5.16.

The fix is to not introduce fuse_update_ctime_in_cache(), because
fuse_update_ctime() is already doing that.

Thanks,
Miklos

