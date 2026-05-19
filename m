Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67C223DC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151392; cv=pass; b=IMXKRJqJ3aKOtO/irkJDEGI+hgodl59ixxuuJXh4A1JSpAoZC+bUO4aYiuuHZ/XT0Sx1otyohkAFcZDQeG75sipcqhKOMf/3ppdNkMpbOAKz2FlypVViXWFjb4C8qe4ruig+kvWGsmyQxeDLlyg1wYhvb2cceg2wbdxaEKfRNfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151392; c=relaxed/simple;
	bh=q6U7zK8TR55IUlOheY7qKEJ5AQ9wRgH18GYizyYvtI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfMfaOlnthYT3oDa138IQBZpnX64v2OoRoRzGZiHSqWrK7Weg9jG0mo5wsuPH/Lhi9EP1211rPq6RompvkiR/n8Jf96b5gMxUdH3IE69krivjjlBzjF2gUaF+veePnc7efaaLf9z2gPzDaC4f1ciHJcYz7wv6SYfD+KuJCkAkSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzmNK/44; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzmNK/44"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c364b893aso3272775d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 17:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779151390; cv=none;
        d=google.com; s=arc-20240605;
        b=WQ0lmOYrcO+cdXwokJQnIj11D7fIf7t1Q0USUCF5XCQZWphy3rN6nxM2YoKYliBPmk
         2KwiO2+Ew++R5NWwNwsJEZtxW0RBfGrJryk3Wzgsbn6AEvfvgkq/z0kqo/Ze+RR4XRop
         NGW/CpcdBDFcXZxtJHxo5qwUBCUmNZiyMIJ/vJ81vNLcbDzuJKnVeYphmJ/AcTNHcL8U
         LZ3Eu8WIxCWbfQRYjV2sVjY+6THu5AnmPfikUsll3XabySKGKL3ZbR/sSHD6Kqof7+oz
         pAs5z+1thfD3A23IhqARtemf+zrV/mDJqQUtvFxvIrOb8e+NRdHhUPk+eIVo+I/ZpZYI
         MmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyRXgQlFu8IpTFqTcEDtOQPYxHtrAYUbWzV7kYTVIbU=;
        fh=76qJmZNqQrinCAE3d3lW0tXwtlFUgXuQbwsc76gT790=;
        b=CEYfYYwOIoHFO/ARrkWqC/lgO9EseIGWn0fSQVEPFTR4h/eGW/OZcDLsrlgUgB0NLS
         3D89o61T2+nhkIB9Bcbk/L4QAYr8nyN6oGFcRLB7RBGXBa3Hs2m9IEj9Avf+d5T3sQi3
         YGb/gD4kn6tBNoFB4TyxdITUYULPu1ehKU+pouk8NCdT5dq55XlhoagoLBYmIyL5LIcy
         3mFR0Kj0Nr8zwmy+9qjGTpeT+JRyp235v6cSa/uEzwA7nAkrrT0uv6XDYNOylccpeppa
         b6Fedj+x+W5xWXz4KrQ7ra7tyyA5lrDQ1b30R8+bhDLc/OY2vHWo8YU63kLvPN+ACSKo
         IftA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779151390; x=1779756190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyRXgQlFu8IpTFqTcEDtOQPYxHtrAYUbWzV7kYTVIbU=;
        b=dzmNK/44Mss3BNSSEBx5/PjfnusblX/3LKvn3wrv5W1mhXeS4ooPeIvWAZ9fsTn8cR
         6lfg8xHXMBjnSa2bFV4zNQJPiL502tXuUseL1DZ8r34nkzabf6y7owzy4zhWKL2DoU2o
         dCPGKDAl4fn+VoM15E8tX0eJkLU1Hl3l1fAfnPCOt/MJoRrb85jJYcbfnBVXoYQwUhFS
         liGu/1M/sRqweaOQ0XILJkBMcf3b0XAsCuoAjd8E0EzJRSsO8ZfIqaAyGJkUmZ4T7cxw
         WFSdmCPIlkl50kaNMt6j9qUsguZljidU3oNcMjiC3j9TapeQUOfaXLZbyDh2/50SOg2h
         aU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151390; x=1779756190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyRXgQlFu8IpTFqTcEDtOQPYxHtrAYUbWzV7kYTVIbU=;
        b=giFYsAYsR+1xVTYR4K2mvS0+tyJtpG9Q8X3atYGMpM0osxqIWdhffa+d2IAoBux9OQ
         6+XU8O9C6kLOLDmNiLZIfS3DwEG+l5N6gPi48sai9ybp+01mGm31n1MB4DLlTW6bB059
         Xxvn0uT/w8tV76LoS7zODnE8tLDrr5/5Q/xNs4wDxxQ/i6xogR9Xe/a2gDs5+dKxWxBy
         kZ1nDJJhvvGh3dseAluKXjGXho2YHAzmahoITA1MEWd+ZPFEdr4SEneiK9pk/45ropjS
         RvdHhHpFOxCxry+03V9vhxjk8szyyniqJx34OtiRbLqXMamRbrpNxl5gG353NkRr93CI
         RB8A==
X-Forwarded-Encrypted: i=1; AFNElJ/knIICOD+7a7wkwpAlgr+oJJRr/RYvzk0mZkIr/A9ZQXc/qJcjLjGFT6ZNGG6qjWev5DvKS2Iu/AbAwbFsNZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWUa3KA29vO2Cv5K45jD+2B7TGH9zuQEeFKO1ySWkEHq67z6X
	VwQWc8JMv22Lu1Xrj+FIrpdZMSHnOxohRWwa5y9e1TH2+8n3epIEyZfMTduHzhK57dyfQxwjwAS
	Mw66y/uNQ3FwWzQyU4UuRbp/0LiL3dX5ayTSOjPg=
X-Gm-Gg: Acq92OGh2w+dFqrnrJopz7Dzi9knA51afH9y54MC+muvj5ithqZQM/uOzRkswxUUBDq
	S9YE9oIeIeNbjHCZwkF4MSV5XhgeQHD8iVqYgmPrmN1NK0F37u75NMDsAD2HwZvnUX54GdappDa
	dof/AJ/IDD6KVrNIHGLeetpLqDLOlEJ9bYFSi0e+rPiy0eNFmpd/dljqJO10jAyRm+fvuUJfV6t
	RS1wmkpKifVfsD4ztEx773vZf9/hR46sLoavKtJUc/s+VkheInkU7dm6FKz5JtjdpJO2R7eoBOa
	j3ST6YvwgvpEVjeIYLmeCIHF19YesDToblgP
X-Received: by 2002:a05:690e:1552:10b0:657:1da9:7b36 with SMTP id
 956f58d0204a3-65e226dcf95mr13908727d50.17.1779151390349; Mon, 18 May 2026
 17:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518002800.1361430-1-michael.bommarito@gmail.com>
 <20260518010019.121323-1-meatuni001@gmail.com> <CAJJ9bXz-Or+hQnCGYi9AD9+deQQHKewipU4-17CSgrS-4i-uEw@mail.gmail.com>
 <CABBYNZKA5SUNT8maNVzuAvxqaWYt-eU7F+h58oe8e==QsH53GA@mail.gmail.com> <CABBYNZLMEH8D+fZp_xfu665-E0QxNaefcVEsku5wnUQrxQjKBQ@mail.gmail.com>
In-Reply-To: <CABBYNZLMEH8D+fZp_xfu665-E0QxNaefcVEsku5wnUQrxQjKBQ@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 18 May 2026 20:42:59 -0400
X-Gm-Features: AVHnY4LbYFvzCsQFKml1Aauq9zS2IR3HHJ_XtR5fDLqt_I9Ef4rweVBUNlU1IrY
Message-ID: <CAJJ9bXxVeO6a-gi+7B_FV0tciZA5-iLt1600=Fmweh850EZg8A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: rate-limit ECHO_RSP per signaling PDU
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Muhammad Bilal <meatuni001@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:37=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:

Two questions on this:

> > Implementations shall be able to handle the reception of multiple
> > commands in an L2CAP packet sent over fixed channel CID 0x0001.
> > [] https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTM=
L/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specific=
ation.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d
> >
> > Perhaps we should define our Signalling MTU:
> >
> > Signaling MTU (MTUsig)
> ...

I went to add the constant in l2cap.h and noticed that our const names
don't quite align with the spec names.  Do you want me to call this
MAX_MTU to be consistent with the const names or SIG_MTU to stick to
the standard?


> So we need to reject with L2CAP_REJ_MTU_EXCEEDED.

It looks like this would be our first use of L2CAP_REJ_MTU_EXCEEDED
anywhere, which seemed suspicious.  Can you think of any other
locations offhand where we might want to check for an MTU guard?

Thanks,
Mike
