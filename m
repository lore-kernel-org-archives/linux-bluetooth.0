Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944CA1474B9
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714590777; cv=none; b=aH3IwpWSb7dhuiam+eOZyJ41dcRA9vHCi3KnLCyifF20LzRhKsDePtjdwOiHYGLCxS23BnForm9iRsjhpMz5cOAV3Ah9UfZ/utUhPuZfAK0jnPB/m2nYq0AqtLROh3i+4YHxXo8txgZUZSWOLTqLhWr7SRpiee62q315ZUoxe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714590777; c=relaxed/simple;
	bh=EwKEuDLSOMKR1jV1lR+1TeGQ2t/97k23NvQ/j0JLcjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTz+GinAzBhyjqRNt39xJXpW4msDz4zk+n8v6hx++B/xH4X9Dt0CT/viEyHKPitH5rFwZfUb9x8b8afrceEqazkXnT63WXe77cMgjlXeFOejVSTbGh218nMGiKNsSam6Rm3X1m5C2qlrjrS4I0QULEcezh2GnaZQnBJ12Xsn7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hq7yxo+N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hq7yxo+N"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eab16c8d83so57948365ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 May 2024 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714590776; x=1715195576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftc3aqw2Fz5Res4OfCV1JsnJI6jUFRSYvKQ/iKjV0XQ=;
        b=Hq7yxo+NaW7Cm+zBacnYar2Szf0QA8VfyMW+IOmQUfLN45/uoanAj2i8NwL8Au4UEa
         utNBUAvm5B6gN+k/8J00l9BLYDh9Xl3vcNIJaTEfpN1HymUNSc5K0ImUjsYXpm3sA7HP
         ed11wZ2ShTkIJEzCAH3pDCA+75X6iuyCS5S7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714590776; x=1715195576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftc3aqw2Fz5Res4OfCV1JsnJI6jUFRSYvKQ/iKjV0XQ=;
        b=P8oX9XqICh5g5/CPS/8D21HcAyfp9MrPYAZo8fsMqRbTfJJ2E3OQFcFkY1R7x/chbk
         8VreiFQOKV6dg76QEAduEiCBv/JpeIkuyJVW8lcA4OzFwKQtzNy6WIjJSSo7IfIKCSMa
         LqH3KrB4TopSHtd/oUbT0zBB1fvP2FkW9+gJ019W8hRa5tbP2AJLtR9ZC6k7ur8Vp8AH
         aFYriDD+82xjxnvVblUBE6GMYMM6Jfm8kHY4qD2kTf+wzakXquOR0hzgsu8nWwREB63p
         7LSE6oYg+iLF9VWsQwf3z9/Sg6r4qof9ScvvQ9+PWKgKZ0SeMiXBbrpP5k9NTm5j6NVT
         L3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWzNmsRuOqeX4xs4a4mCU6Q+Nerq0I65MauB3W5lmXJp64ScP6M8C3iYp3BQmMrKOjMOm/LonfWi0D4tX+utNq2cNZwmIh8nKcachuf4h1c
X-Gm-Message-State: AOJu0YzHku0IieYRUz3S44DtHamLRqrt8YJG19WlhCn6e05eLemGS0qw
	YVzUBq7BSOMN4/4VEPVCtm+zc3KWzOIAIeoGYsG6c3zCpMbUdboeK1w0XjAIWQ==
X-Google-Smtp-Source: AGHT+IEiiv4rwNYFZ12Yp4KZFEplJPkRZSFlARmbW5OqhUN1DFUPbsYrXnx1y8Mx4Z+i9AF52A722A==
X-Received: by 2002:a17:902:f550:b0:1ec:659c:9604 with SMTP id h16-20020a170902f55000b001ec659c9604mr3860603plf.50.1714590775996;
        Wed, 01 May 2024 12:12:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001eab473021fsm10057496plg.168.2024.05.01.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 12:12:54 -0700 (PDT)
Date: Wed, 1 May 2024 12:12:54 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use struct_size() in
 hci_le_big_create_sync()
Message-ID: <202405011212.4F3C0C1D@keescook>
References: <ZjKFWg0f9uU5jxaI@neat>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjKFWg0f9uU5jxaI@neat>

On Wed, May 01, 2024 at 12:09:30PM -0600, Gustavo A. R. Silva wrote:
> Use struct_size() instead of the open-coded version. Similarly to
> this other patch[1].
> 
> Link: https://lore.kernel.org/linux-hardening/ZiwwPmCvU25YzWek@neat/ [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
