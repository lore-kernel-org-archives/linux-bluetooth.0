Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CAD293C4E
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 May 2026 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779503072; cv=pass; b=uv0KdE++yYhA2lwESXlW1S0b/bhmKElBRAEMDiKt/xdhwYpinI3eD8LJwSTeK1Qif2zVlV+xmCwkjjUqwm79+T4B06Q/AEuXVyc6jSrhpObbcvUWJWjm1XQCyNIWQpQJgbeMeY2illrDW5v71g4wK/vse8hOP7RGpjXaGYRe5/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779503072; c=relaxed/simple;
	bh=BKYGb69A+pwRlpQVDYGcmpXNHof3yFgLOrFM0HOTXcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPZ8vgIJ6uhpCZySFdW/U+WIWcWcgEgHOuN/Hwin0Igxz7szJWsskPX9SXeGlcBo63jz+WYcAP1ihvGPcuPN5yhTPl6XDshO4qDYwKQNFhUv/XjWIAZCnrz/YzpcZ7+PgA6MNc4p8K3up2RrgeF1GLYLdB3qbvv3HndSTIB6V5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBNaNg8S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tOBeJvyI; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBNaNg8S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tOBeJvyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779503067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFuOJSbQsMnTGbLho+4AwXl4b5zy+mqJxesPTTpm8x4=;
	b=aBNaNg8SCh0nd8kBCKB2IkR9lRyVi1had5mxcWaehno91huEeAPDFmQoBtWF76nXhoixYs
	ZkCu+MCV9tTn5GEIHaylsKPYSL5HxmkTKdn3BJ/ALOfQKyGi11L22d5lMp1Ake1Kc6/mVp
	ddQbheIi/zXbflSUKI23NjxI3Ewy1hg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-rwWktZ9eM1Cx8Few0kGWyQ-1; Fri, 22 May 2026 22:24:25 -0400
X-MC-Unique: rwWktZ9eM1Cx8Few0kGWyQ-1
X-Mimecast-MFC-AGG-ID: rwWktZ9eM1Cx8Few0kGWyQ_1779503064
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd41a598d55so100349466b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 19:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779503064; cv=none;
        d=google.com; s=arc-20240605;
        b=JYaYDh07jOFKigbyGhDd6FRE+dZwx/zQBK1KI+adBZ5jTBaaRrXqbHABYGNcQiC9Ki
         1v55xhW6TdE9d29JG1dvBg79k9te85pIecW40IhY+qzm91l0UQ7VBEbOIpydeNTTnMJo
         dbIcZy+LgTE+KJmgT6/mEcIZr4u9m9/pj20QTWl8MfyG2LaFwQ/4EHRj6u6p/m1d6Fgz
         FcT8rIwh57xw3Tw0vbUlHYFzE7BdJVWKvPvxhQJxHvL+wotmDHd/IfDtH4Ft0DR2kg07
         aVsTv+vPtIiC9hsgoLZYuEcp2NDPGA2mNsDvrhiCeFjfiysVifd8WxVY1Wu7idaQEdeL
         B7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dFuOJSbQsMnTGbLho+4AwXl4b5zy+mqJxesPTTpm8x4=;
        fh=GZeQZrTu8nJdeKv6qxT11S378wMPcyrwlWIPPObGUlU=;
        b=PSv3WI26OqBwIBzNeduAD/YE21es/EWRa3B+TVjGL8imhOECeSylenuPL3jTYk+H0u
         F8vFXimpuWh8sHEfGewjIWc4Qlds3bj2kRQd0dNOeK/fmW40ieknqVXLz7FnmjS2uxSI
         Vt+H7JDHZkmcvwv+X6t/o8F/j3ljCBTVFJSn35VXzRYaV6+nCXTf/wH31rh/nQ5vg+2y
         fxFHSP/o2SEet4LXqM9VKpXwIRV5zYR56U/i23lOO8viCntsNcoLAOMUTz9x99teLxfu
         SpL0CEXbE2U/TksluYWXkqVpiwBlDHdK+qnNAtab/sbWsuIivq3kUYsTmtbyemiNhodA
         UGgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779503064; x=1780107864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFuOJSbQsMnTGbLho+4AwXl4b5zy+mqJxesPTTpm8x4=;
        b=tOBeJvyIbeiZTNDTKQCgNQjxSIpUamhTGz1R2KFMC+BWAb1Dx/n1Gz3mxlSYx9KX7q
         WEBpMStIs78a3MR+QFsqfwyTLjV/GmaNXCKuq52UM04reM4wU3udspoalQqEdP2LJHBN
         wCSGEqPKNLVkCOcTHhZZit/cS6CjfoL+lNFRndHhLlbr2k36yroBi7Uro/IEQQ7a5n55
         vYOW3WHwNJNyenirgTmiL57WiN3vwijo1Ok89oQkB51FMHiJTj+92Rf7/+ClSpEjd3PA
         4ewIaKen1hJm3x45gg0+27vi355zih3CNdURQTB9hxQDoeaM2newLASE/PjmzFHmk3Kt
         H9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779503064; x=1780107864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFuOJSbQsMnTGbLho+4AwXl4b5zy+mqJxesPTTpm8x4=;
        b=J2zAbnnqxiM/FLG2qymBG0h7LfXrry2YrmHKuy2G1ODL25/JeDT0dM+WPHsMsw9+Uv
         zakGxQ+MDWiwAT2PiIXE/nZPi8bcNfGjyVkpliWZJKtJfkhk1j7P6Yk34xY2wLZVOK4O
         7+en2KJl+mldqyjkyTsLsOuFZ1HquPl51sBWiYh170OE1cJNYBubfKViBJxm812bpd6F
         IregeI+ezvLbA6DXalUkfgdcC4efC1IjAfeeETpX14AuODG+E6RGZbcY/J6zdEi0GlYT
         WL73qEKAje7F40FnlKCa/rxicfI7f9aeE8cT3Wrf+5KyL1X9prYuhUR2g9sCe0fDvWVe
         vdPg==
X-Forwarded-Encrypted: i=1; AFNElJ9d2jvPPi7b7zfbIC/NMi0iZzWBwbp1cHtHjZKgFnCU2tkzvGjNZXRCHXzxbjA7d1u/jtY+gzHpQr5CzhtNjjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVZ6S6ffUKdexU8ZZTr42RsbVygCeioZld4S7cJjYO8gv1PtX
	Zb0M2iNnnDo+ko4RZDLjrUEe7xKYYnlcvq3lexuug2u1wamQivTmWSkauUKKXtQRr+g02KN9Nes
	/V3BRPB9VvrvCksKB4LXv7aLzwLl9yZjxqAuSrwr0riJiAwKETQ0I2T6WBckR38alcikVtEn/jJ
	Lk3JrndSL/VtsaF/h2rcCAhi7qF7oCKJV4pKeNlxwJ4k+R
X-Gm-Gg: Acq92OEUQRNkQxW1AEGqneMqhuFBm7H0n/CdNlevQCzIwcz/lSpBCcu9Na7Curia9n7
	AkxhA8f/EmPpuyJ2tO4Z92EPfjGZLE3kQHfRS0U55w8npjEiQxEbV84Erxhe8pMsy/OeJJAzdel
	NvHoyFjS4mLkRYLCnKGxAiH/W1+IwrJzRc/eJefdISkpNAydsJpJ4z5kJB1t8H4Zu8Ve0vSajbY
	lkVzmDP42LIeP926jIEbjXQPoa8YVQzog==
X-Received: by 2002:a17:907:26c9:b0:bd4:f3bc:c4b3 with SMTP id a640c23a62f3a-bdc0132e8ffmr531794766b.18.1779503063693;
        Fri, 22 May 2026 19:24:23 -0700 (PDT)
X-Received: by 2002:a17:907:26c9:b0:bd4:f3bc:c4b3 with SMTP id
 a640c23a62f3a-bdc0132e8ffmr531793266b.18.1779503062631; Fri, 22 May 2026
 19:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523001337.28134-1-tim.bird@sony.com>
In-Reply-To: <20260523001337.28134-1-tim.bird@sony.com>
From: Richard Fontana <rfontana@redhat.com>
Date: Fri, 22 May 2026 22:24:11 -0400
X-Gm-Features: AVHnY4JXD8EgQkcB3Iu7rSkYiToDEsC4r5iaVseH7YwK-CAWyvv502A0A_8ar9w
Message-ID: <CAC1cPGzmKeonuzjA2xzn6qXrT3Bcj=DGOfkq_BXUSMXJ7ZHY1g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add SPDX id lines to some source files
To: Tim Bird <tim.bird@sony.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, jannh@google.com, 
	kuba@kernel.org, kiran.k@intel.com, chharry@chromium.org, gustavo@padovan.org, 
	prameela.j04cs@gmail.com, salvatore.benedetto@intel.com, maxk@qualcomm.com, 
	linux-bluetooth@vger.kernel.org, linux-spdx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, J Lovejoy <opensource@jilayne.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc'ing Jilayne Lovejoy in case she doesn't get these)

On Fri, May 22, 2026 at 8:14=E2=80=AFPM Tim Bird <tim.bird@sony.com> wrote:
>
> Many bluetooth source files are missing SPDX-License-Identifier
> lines. Add appropriate IDs to these files, and remove other
> license lines from the headers.

 So the subset of patches I've quoted below, most but not all of which
seem to be associated with Maxim Krasnyansky <maxk@qualcomm.com>, all
feature warranty disclaimer language that includes a disclaimer of
warranty of "NONINFRINGEMENT OF THIRD PARTY RIGHTS" (and furthermore
states "ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY
PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF
THIS SOFTWARE IS DISCLAIMED."). The GPLv2 warranty disclaimer
language, and the abbreviated warranty disclaimer language in the
FSF/GPLv2 "standard" notice often seen in kernel source files, itself
does not refer to the warranty of noninfringement (disclaimers of
which I believe did not become common in software industry licenses
until well after the advent of GPLv2 and its predecessors).

Several years ago, when this effort to replace bespoke license notices
with SPDX-License-Identifier strings got started, an issue was raised
around what to do about license notices that included disclaimers of
warranties going beyond what's recited in GPLv2, or those GPLv2
standard notices. There's an argument that it would be inappropriate,
and contrary to the licensor intent, to delete them, as you propose to
do here (without permission from the authors/copyright owners). I seem
to remember Jilayne making an effort to gather views from lawyers in
the field about this topic but I'm not sure what if anything became of
that. It's fairly likely that such language in other source files has
just gotten deleted since then without anyone noticing the issue.

Richard




> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 3faea66b1979..e921ade2f61b 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -1,26 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>     Copyright 2023 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __BLUETOOTH_H
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 572b1c620c5d..0aff0220a6f7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1,26 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>     Copyright 2023-2024 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __HCI_H
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index aa600fbf9a53..0977f6076677 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1,26 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
>     Copyright 2023-2024 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __HCI_CORE_H
> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_=
mon.h
> index bbd752494ef9..ffc8769ab8cd 100644
> --- a/include/net/bluetooth/hci_mon.h
> +++ b/include/net/bluetooth/hci_mon.h
> @@ -1,24 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2011-2012  Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __HCI_MON_H
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci=
_sock.h
> index 13e8cd4414a1..99d768811a95 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -1,25 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __HCI_SOCK_H
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee5494..2a1be65b1cd1 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -5,23 +6,6 @@
>     Copyright (C) 2010 Google Inc.
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __L2CAP_H
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 8234915854b6..52ea907b3d50 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -1,25 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2010  Nokia Corporation
>     Copyright (C) 2011-2012  Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #define MGMT_INDEX_NONE                        0xFFFF
> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcom=
m.h
> index c05882476900..6cf517a2055b 100644
> --- a/include/net/bluetooth/rfcomm.h
> +++ b/include/net/bluetooth/rfcomm.h
> @@ -1,24 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ)
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/refcount.h>
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index f40ddb4264fc..646b2a49800d 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -1,25 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __SCO_H
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 1a6aa3f8d4d6..cf9607336bb8 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth address family and sockets. */
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 0de5df690bd0..ffd9772a8c69 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BNEP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2001-2002 Inventel Systemes
> @@ -6,23 +7,6 @@
>         David Libault  <david.libault@inventel.fr>
>
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/module.h>
> diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
> index cc1cff63194f..a2d665a3c157 100644
> --- a/net/bluetooth/bnep/netdev.c
> +++ b/net/bluetooth/bnep/netdev.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BNEP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2001-2002 Inventel Systemes
> @@ -6,23 +7,6 @@
>         David Libault  <david.libault@inventel.fr>
>
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/etherdevice.h>
> diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
> index 00d47bcf4d7d..a8ed5429f31b 100644
> --- a/net/bluetooth/bnep/sock.c
> +++ b/net/bluetooth/bnep/sock.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BNEP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2001-2002 Inventel Systemes
> @@ -5,23 +6,6 @@
>         David Libault  <david.libault@inventel.fr>
>
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/compat.h>
> diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
> index 0efc93fdae8a..cfbce52eb4b8 100644
> --- a/net/bluetooth/ecdh_helper.c
> +++ b/net/bluetooth/ecdh_helper.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ECDH helper functions - KPP wrappings
>   *
>   * Copyright (C) 2017 Intel Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation;
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> - * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> - * IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> - * CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> - * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> - * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> - * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> - *
> - * ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> - * COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> - * SOFTWARE IS DISCLAIMED.
>   */
>  #include "ecdh_helper.h"
>
> diff --git a/net/bluetooth/ecdh_helper.h b/net/bluetooth/ecdh_helper.h
> index 830723971cf8..84d1fd7a7ac8 100644
> --- a/net/bluetooth/ecdh_helper.h
> +++ b/net/bluetooth/ecdh_helper.h
> @@ -1,24 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ECDH helper functions - KPP wrappings
>   *
>   * Copyright (C) 2017 Intel Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation;
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> - * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> - * IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> - * CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> - * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> - * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> - * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> - *
> - * ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> - * COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> - * SOFTWARE IS DISCLAIMED.
>   */
>  #include <crypto/kpp.h>
>  #include <linux/types.h>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 17b46ad6a349..c5693b2158f2 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1,26 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
>     Copyright 2023-2024 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth HCI connection handling. */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c46c1236ebfa..e15bb5267646 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1,26 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>     Copyright (C) 2011 ProFUSION Embedded Systems
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth HCI core. */
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 99e2e9fc70e8..04363e47b150 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2014 Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/debugfs.h>
> diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
> index 9a8a7c93bb12..6b2e472b1c2d 100644
> --- a/net/bluetooth/hci_debugfs.h
> +++ b/net/bluetooth/hci_debugfs.h
> @@ -1,23 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2014 Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #if IS_ENABLED(CONFIG_BT_DEBUGFS)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index eea2f810aafa..a03ce6bee6cf 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1,26 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
>     Copyright 2023-2024 NXP
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth HCI event handling. */
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 0290dea081f6..0b41e116857a 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth HCI sockets. */
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 976f91eeb745..a1ad607d4ec3 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     HIDP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
>     Copyright (C) 2013 David Herrmann <dh.herrmann@gmail.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/kref.h>
> diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
> index 6ef88d0a1919..ce6bab283093 100644
> --- a/net/bluetooth/hidp/hidp.h
> +++ b/net/bluetooth/hidp/hidp.h
> @@ -1,23 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     HIDP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #ifndef __HIDP_H
> diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
> index c93aaeb3a3fa..27b2965e850c 100644
> --- a/net/bluetooth/hidp/sock.c
> +++ b/net/bluetooth/hidp/sock.c
> @@ -1,23 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     HIDP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/compat.h>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fdccd62ccca8..52d00e1f5258 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -7,23 +8,6 @@
>     Copyright (c) 2012 Code Aurora Forum.  All rights reserved.
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth L2CAP core. */
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index b34e7da8d906..b8941cfb798f 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -6,23 +7,6 @@
>     Copyright (C) 2011 ProFUSION Embedded Systems
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth L2CAP sockets. */
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index 305044a84478..8009d3071a11 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth kernel library. */
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index de5bd6b637b2..c5972875386e 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2010  Nokia Corporation
>     Copyright (C) 2011-2012 Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth HCI Management interface */
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 4f19654d41a9..afcf5b1caacb 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2015  Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/unaligned.h>
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index bcba8c9d8952..6c3b720e3dc2 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -1,23 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2015  Intel Coropration
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  struct mgmt_mesh_tx {
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337d57..c02b7027eb76 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /*
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index bd7d959c6e9e..b2b31e4e0212 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /*
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 91bf5274262e..13561f298aa3 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /*
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index f1799c6a6f87..7071c7028126 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  /* Bluetooth SCO sockets. */
> diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
> index f49604d44b87..134ad0b77ba9 100644
> --- a/net/bluetooth/selftest.c
> +++ b/net/bluetooth/selftest.c
> @@ -1,24 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2014 Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/debugfs.h>
> diff --git a/net/bluetooth/selftest.h b/net/bluetooth/selftest.h
> index 2aa0a346a913..15b85414b6c6 100644
> --- a/net/bluetooth/selftest.h
> +++ b/net/bluetooth/selftest.h
> @@ -1,23 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2014 Intel Corporation
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #if IS_ENABLED(CONFIG_BT_SELFTEST) && IS_MODULE(CONFIG_BT)
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 98f1da4f5f55..1eb8e640306a 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1,23 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */
>
>  #include <linux/debugfs.h>
> diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
> index c5da53dfab04..ec2f0f0dd99d 100644
> --- a/net/bluetooth/smp.h
> +++ b/net/bluetooth/smp.h
> @@ -1,23 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
> -
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
> -   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> -   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
> -   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> -   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR=
 ANY
> -   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAG=
ES
> -   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> -   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> -   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> -
> -   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
> -   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
> -   SOFTWARE IS DISCLAIMED.
>  */

