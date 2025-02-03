Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14631209F4A
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597277; cv=none; b=gWHf6gRu7DBCrkjsSOiCffJxhXpuSu8tnNoPIaQuqxIwZY8j+boruySVpdsX0O5uABxY0jQ4xqtMn75SsLtR+ribQFerJ4frZOj/GAT40GrHCdVzW4BalvHKmp3jfBjaw2m5F1/rgLRA56XBtHpR0Z1ewF6KmAUr9sPGJfnRb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597277; c=relaxed/simple;
	bh=9QA/xhLCsp9xxPb+3NdcgCkHGZNk4+BB+4Yg7W0rYiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecyzBhOx2JEfB4hgXsfcI1fb3xev+QsOPYb0F16dBSoFD7W5d7kQyNW7jZ0XN0fhIpRcEnNzECOPI6RlwzlVmcRTZ0H9owQopwY6KdjFipnFCq86Ww5Ty95i00g2jB+ZrvOLWB6QI52ipqOkR21b1IltwRzZAENdsAy7eYURl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=yNRd3RUA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="yNRd3RUA"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so4831995e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738597273; x=1739202073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lDn/bub6zcLTsqoNtplntaYNg3dSysdJlvHXxKAXMU=;
        b=yNRd3RUALWCo5NIdaXbuZtcdHw7yXFIOC65LGJQi+cEr7iMuEgy47G+S+tWI1lIrAp
         qVLHNYs80v/9rzOlUcvJ7fR0lzVKruh6HaurBQdg/n01Ryal3n6EB/Wr6+uqqTe02AQS
         c6v8eunbZN3nbcosbriYlJXVcA6de1x+wxhbRDtmP9+8IRtBJE6YXg1r7REXvqHhIgV3
         /ira2+obsHgqhg2oypQs0TzGkQ9NRCvk6EzT9V9L4hgR+sArugQx5bXDDRHV9qMaI0hh
         Jq5heQghQbTB96W0hmj30iBezcGo6M08odqD5rDAJbQMCbX4hb1IQGtV+H9ZTnsC4r2R
         jtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738597273; x=1739202073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lDn/bub6zcLTsqoNtplntaYNg3dSysdJlvHXxKAXMU=;
        b=gvi4KqP07W9rdpQJmfSnp76vLTUrVeVpDcLdVmP6zQ/Ooy3M4GWPgTE45jb5zmgDDk
         rKJCBBp4oVYZnfZFLACLxCFP7G4KnuVH5/O2LqVJfJcA6gy9mO8e6bSYYUojMq/4jGre
         gpom80zSq6co/qYLy8z0YiMW3hjg7M27xRmsqx7QXacwOVP/5kO04SYZZSVC98tvqpA6
         E/og3FH1NgbvF84yyTeZCZksbn002Rn6mzO1eulFsM8OIJcktRHAhS1xpQGD7jJSx0oL
         1mNWEFMiLNy+j9IBA6WYR53ToVaIzFdfvKTcD1fB6TBVK/lleUDHE/naI9Q9IqWAXun8
         VCGQ==
X-Gm-Message-State: AOJu0YxhVAealhjXi3Uzzku9/6ZvApiNyzjB8qpq/4LzMJbbVy9A5fv8
	VsF87pMVeTrlSzSDE63Iq2Jl7DnYYFj/udU9U/8I82jE9nfvWzNOi7vZqgDxRWOUzRJM9uzgju+
	plQNI3p/aUYSXIRaqkAo/7nNNPrLL/Xk4jefc/cAjRAxbfk4dR6c=
X-Gm-Gg: ASbGncst7OvbIp+i4VJmDSDt7XJsjoxdS1VmPFpJKCRqvl9D6kAo6j2F+AS99csDc+0
	dAE0Cv+BuySbxxWNWaVB52sMBmp5y50CZW5cS9Cytc6UXVPWef3VcbWRYXSuhjf7ZjYJU6aI=
X-Google-Smtp-Source: AGHT+IF4bXfPKN88nME1JjaY+h6KZF6fHydpTR8FrUv/CpfDrLSzequWz41aAoVjeu2pM/uSpgKvBA5bozQlNaXBZ1c=
X-Received: by 2002:a05:6512:480a:b0:540:228d:b8d3 with SMTP id
 2adb3069b0e04-543e4bda7ecmr4883380e87.1.1738597273030; Mon, 03 Feb 2025
 07:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130090158.266044-1-sanchayan@asymptotic.io>
In-Reply-To: <20250130090158.266044-1-sanchayan@asymptotic.io>
From: Arun Raghavan <arun@asymptotic.io>
Date: Mon, 3 Feb 2025 10:40:37 -0500
X-Gm-Features: AWEUYZlCFIhua3029ocVVdX_eUGh7NzCHosqe8a89GqgpZM3d058TDzL750T7wA
Message-ID: <CAN03qa8Xe+o5L5G35gXJbD1XvEc_hdsp80ZW-2UN6opP5DMLMQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/asha: Add support for other side update
To: Sanchayan Maity <sanchayan@asymptotic.io>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 04:02, Sanchayan Maity <sanchayan@asymptotic.io> wrote:
>
> ASHA specification requires that the status of the other side be
> communicated with the start command. The status is also updated
> if one of the device in the pair is connected/disconnected after
> the other.
>
> https://source.android.com/docs/core/connect/bluetooth/asha#audiocontrolpoint
> ---
>  src/shared/asha.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/asha.h |   8 +++
>  2 files changed, 168 insertions(+), 3 deletions(-)

Reviewed-by: Arun Raghavan <arun@asymptotic.io>

Cheers,
Arun
