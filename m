Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14152373BFE
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872974; cv=pass; b=qigVHRfcM31AD8DCOyBvQPbwvC62Gpk+d0B1Oc2xBbK3LtruFAB27bFweuUdVCLo3eys5TXcWI9SuRRVuGd0LhxP1bkuhJ9FsY6jteQFvwarnu8l6qoP9IWpBZBBersG8bHOjDps6e3ga1OlrVCWcq9D5UhB1Xf+O7kQKerF2ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872974; c=relaxed/simple;
	bh=KnzZfTAlMqHbtdHn9fFlGW+0k2wIDpBQ/n+z3Vc85HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0qxFt7gSMoAZJ2HheVFLtaufBSH78QVplZY67L4x0ae4j0JoQIeaBRCJvjWwRHzAl3y9bUyn2FvViRTsdFFjDIUSif3jE5sLZtQtV0064zfFfM0LobApdYvUofF1Lz0L03EiDX8EOb6rwuTCXO5hqRlLN0dFrFiA87hFbYvtj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFtDC9OD; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFtDC9OD"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501d242e3fso5435031d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776872970; cv=none;
        d=google.com; s=arc-20240605;
        b=YO1WmZVaPZr5rgjMZ/0oiRFH+EasKrzYcDy5m7vsc5bKxFQoJB874WL4HaqhMKxztA
         azR4oEtl4wm+GAPJT/5ovBwZhFrZbeq50VfJxP9X7JemaEJ11UHxWIdLBoFZLG+4q6iv
         xMW9/oVpFP2wjIq7x7j0BgYYyMM3wHC9MuiyKSH88hIC0gt7dQYhPV/9lM+QLP4LjAVp
         9zzS+1+H0WNbnAuBBWQ2vhT2Ae3X7HwuwAj4I3w1u9KUuvgoq/nuWSzYxUr4YSAfnkui
         DavTiN+7OeenODccmMIteZlNuxHyj64jRZZ/zmBdaHvtIQYwRUeFdbpoXm23mPuyeTdF
         5YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rufkI5LGRKmOvIFyELaq/2dGpVFdO11QVYlsd9/dtoM=;
        fh=VGBhSixYSFnMiAftiWPyGVZlU5frZf9/FPlhYax0HHI=;
        b=PyG/rfaNa50Zqm9OEENU8uFXRzBIkK0Y6XWnP3gCAYBuvNcKkMBBUZUbo8vybA+DA0
         9NVENLnrEv9l/EUoQ3Ea7IZiwASVr7u/AGTwcqIa7n3mPwOXDrb2MK0DxF9ThIECvbkF
         5Uxs8/gI7nxuVownfPo5UVJDNQliBsFlCp76NJWBWmavR9df+AqXHC18I0UKOt6n+mG+
         xNJFUWmWTaqzBDb1XsRbxLVsVBPyy3hOI2JJHl42V6YV2IjI1aRHZy7lWRtTD7d1GODz
         MJiN2ybYc3GwobH3WP0vc3Q3Hplf4QtDPIM6H9a0kaNwFetkeSyts+azHkIxXAtQdE4f
         YbMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776872970; x=1777477770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rufkI5LGRKmOvIFyELaq/2dGpVFdO11QVYlsd9/dtoM=;
        b=MFtDC9ODGNhmQq1AYhU/dQnbRLOsL+hZyKnTLgb0bNtm/EL2sGx689TDxgte9VnueO
         Gk4/TgP8GIfL7cpeLshkfSfBDqx9qGJ9E8twRv/2T4Q80djhVVfRk0C8+ZmPpLoPycsn
         yY3/TDRx5CinOHLEwOSRpd5mwOSCeNq4+5hYYt3fyBsrkx+w9TmgBkFT1hQPDVlM8dnW
         hcffzB2UnNHic3Vxwu1YBkGU2v4hFbHGlbaAOz8/AeORNburyDoSRkdByUwB0S7sUb76
         Li3qkDdNAaf8ApNhCQ9hh8GdrBzm6lMNk7dV0jCxTzarcCWPovdeue8HTE0v+OyTok3O
         4qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872970; x=1777477770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rufkI5LGRKmOvIFyELaq/2dGpVFdO11QVYlsd9/dtoM=;
        b=oNCefQHOnQTtkBFWbPgDWRPf6cXmXwfBTJy5pQf9lbPFdapF+TOVqrrQ+bNLcx+M2i
         i8ewnonzqWx9cQg/fkYEowLZVhsSV86sMujLQliHqxx2lswpoy0+LMsyxeB9V5l1P3RO
         ZYXZJQxJrWmc8MrP1KXHVYqTCoG6cyFF9TURmsGuqrLjSlCtHAIBrcqY+5/jB7MqY0Z0
         LDd2qXXDfOqp+0erPnag4FNVu0JaqG9ubm0Xt7xn8PDj9MAdWRWUMJLPMK1j9RABXNL9
         shdrv13fjObinJtMUj9JMgNRMDNYgtU2ZVuEFGZmq9GIz0B+38w9UGy524rgJJ49eH4C
         0mMw==
X-Forwarded-Encrypted: i=1; AFNElJ9Vi4xgJBw+abafDKlz7dP/e2YwDz0/12MsjkxfNaG27LKz8FJs1281TrcnFtjFLlYFImY+oAFAGQM/PlRNiZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCS1eqHkzdVf1U238NPOp1NsDoJlOlR9oUeeCIkz2CWQIJUmPf
	yO0mk7EhTjIajMptwcehw9lP3q/SKuvWPE2tsm4NWLPENPD/PEZb1lq3FzEW2ehQb8M9VphEMZo
	vp0iPJcAULhvTPlpSkqXvGLbjeIkQJ9mh2d0Y
X-Gm-Gg: AeBDies2lwqE+whOxWnpUXVw6Lt7erEYOcYzfWuTalOEclCdtWKCxktyFxMx24F5q2J
	JkexjwAgKXaxKvZdiy2bSlwO2wm77jEB5BKFqY4oNhwgZPQTp4EGRRz6hbmxNiFeY1r9QhrECm2
	tw2dk8LoO1KhuuN3EQxp+90Nw0vKmHKWJrAlV91+yQiX2LXf+qV5B4VDB4WiI5t9Z36Q8cSoQPr
	+0b8y1jpKVaY3LtQ83JtOlSx8naKqJFYvAtMyWFOIN/5IFkmBzSAR72H8t3XyJGkXGg16MNI6rl
	wa5B9vH/wWRr+fQWnE0LnjsNlixzUbIslKFkD3HdU0PLCE5DNEgJRTNIVK+7EmhsRpmSp6mr6dl
	EM6Xn
X-Received: by 2002:a53:b64b:0:b0:651:bcc4:c1 with SMTP id 956f58d0204a3-65310a4ba78mr14162786d50.48.1776872969769;
 Wed, 22 Apr 2026 08:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306023155.554597-1-luiz.dentz@gmail.com> <20260422011437.176643-1-michael.bommarito@gmail.com>
 <CABBYNZJu6bGZadWc10g=ZJPHoDZ_RKDosCgasow3oRpQchYZvw@mail.gmail.com> <CAJJ9bXxCMVzVASz64obn78Ob2CDKBZX3r4B5iE_=+hbnwXDirQ@mail.gmail.com>
In-Reply-To: <CAJJ9bXxCMVzVASz64obn78Ob2CDKBZX3r4B5iE_=+hbnwXDirQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 11:49:18 -0400
X-Gm-Features: AQROBzBCMI7I5dkCdqIe2vqDSl3e0S35tv6TT-Al8s0OzTANYBAL7yPUfB7-VTU
Message-ID: <CABBYNZ+i7shh3NjOzmrsHTgS-O06KDwZFuixF9i8By3Ho3U4cQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HIDP: guard session->conn in hidp_connection_del
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, Apr 22, 2026 at 11:09=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, Apr 22, 2026 at 10:55=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > We might need a lock in order to access the session->conn:
>
> This one is a little easier than the other txwin_size issue in terms
> of blast radius.
>
> What pattern would you prefer here?
>
> Option 1, smaller but ordering questions: hold the semaphore across
> check and use like this:
>
> down_read(&hidp_session_sem);
> if (session->conn)
>     l2cap_unregister_user(session->conn, &session->user);
> up_read(&hidp_session_sem)
>
>
> Option 2, more correct but more cycles: snapshot the conn and use outside
>
> down_read(&hidp_session_sem);
> conn =3D session->conn;
> if (conn)
>     l2cap_conn_get(conn);
> up_read(&hidp_session_sem);
> if (conn) {
>     l2cap_unregister_user(conn, &session->user);
>     l2cap_conn_put(conn);
> }

Neither seems completely correct, in my opinion. I guess we want to
use option 2 but set the session->conn to NULL since it will call
l2cap_unregister_user.

> Thanks,
> Mike Bommarito



--=20
Luiz Augusto von Dentz
