Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F273033FD
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586947; cv=pass; b=I6ywTtMgps3hybaVKwrPLaUsf+S73fLtBcaiSLrsCfdescF7Q8cgat/68uJbuY+A3DAUOUQ4ADGOlUeXUymalMuyGJwYAcAfr5msxMMbEmfiTeMCkZoMdU67vQ4Yr0qX43XhzgfL5sD55Q/xddMpxViaDLFF3K/1f2s7kENqlAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586947; c=relaxed/simple;
	bh=FyBcs4oD3m+JmxUfsyfqRf29z8vrn8btybQTM7eBUz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pziqk/xst9YcpN5CHbs6umhBgVKFIHD3e1nTkb5gFvWbL5HHVIh2+mF7U1BUswAgjsS/OgkEc07Khh3R5w5ApVI7bw6iD128w03RiAVkuzSx9+OdgzcaO65RcE+tN71KTG+14mZQz/wZ+6mXeIXybe85+16f1YPO86IFyB0mjcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhUoZx2e; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhUoZx2e"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e0fc8ead7eso10122617b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 08:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780586944; cv=none;
        d=google.com; s=arc-20240605;
        b=OZ9G2QPOECko4u4difBp2CDM/pLJOhCFE4hs3pgB30LmLuFVMVmEOSSbCuM9oeH9L/
         pyKIiZsKgclmzZXCI4dygm3HKa3iT+rZ52jiBC/aUd4kDKzV5pL7sZQuHSW9Z9aG8Vr6
         D4PXOIdDtE1q5EV64MkfFZfazgoqDmOZOL89pCmTPawb9dxtpAuRU9mdawrfpK09FDqK
         UrqzwtUYhwm6Q+3wxv+x2axNkVuCXmrkhtVD0miXfI7oljh2+w6/s2iJPSluuu5c4axG
         hOYU8c6Q4dcFq0geozpe+TmJH5xA34zZIclHSEnXfxoS4Lh6FK0a12ERMtX5a9ZJ6SOv
         pZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fwq8d5ZjGfpbwf1XGNW+oqsi0fut8O7SeHjDdLAL7m8=;
        fh=Ntyp244vibcjaRI8iHmMQOulhxsa7cA7Ey4tJ4U1U1M=;
        b=VsgrsUKeenIqszo3RUCXxwHDHUGRAtBs2X1YTX4c1B5FG/0qSTW4scJ5GB3gUrwE2t
         hN6TMWWbt/k23rF0mJ0eVlQrFiTzuxVrPv74TYzPl9pYb9TSNrqh/8Uw93qYaQ/lLy14
         clKFUxrdv1zz19m55u86xWA2vec8UqwY0Po86e4Y7ARchtAbhKBH73MEFZGa7AvVa22H
         eGGXn/sd3JxhKVUDO/3A7QD8oemY6nabl4UC9ys190yKpC56N3R8lrnLQ0ReI7FM1FLp
         P0Zpg8mccPpx4T0Q4USoUBOA3hEUAI+sPYIgh6NEvoYLOIpxXQ4iMHmEuq+bddug6qVH
         h0Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780586944; x=1781191744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwq8d5ZjGfpbwf1XGNW+oqsi0fut8O7SeHjDdLAL7m8=;
        b=JhUoZx2eXL4BAfSftoma6IgmOjosAuv+iz1/qHFopL/GhSsR0IihxqlGAvTOSAHqgP
         OwtVuNE4Aoq6ZzRxfP6OUUHM4O8uIQQF5o/G9Fp9EhD2XgorVJ84KSOQ1VMJWVLXfpc3
         E2ePAzgQeBd/bRk+2ToZkZg0Arg8mZCUy/Nc9P7FfS2YAuic0wRHnzI1O6VI7mu69rmi
         +FOo4bcuxDpMxNZffdGVyF7BMQZ+hcVeXPEcd0QmVWz6Q8+zLFLCMc7p5rf0XEtifMP0
         m8VrwDqTTLxMtOeK0Xd66a2qjW8TL+HMzX2ZQP4ClF0HGNIh6QD3PyTYRPlBDWrntWtF
         9KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586944; x=1781191744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fwq8d5ZjGfpbwf1XGNW+oqsi0fut8O7SeHjDdLAL7m8=;
        b=mW3ifOIP8h7TK4xl2XI/OA5ULPpmDiI5GCiCO93dIgzmfITYfUVKh5wDIhpoiZDatu
         O61FqtOSlxM7slxzHRXE1nPEE1X/W3l1RWVew3GNR72zlw2YWj/jGAbTKyRj4+Rt5J/h
         aIWPukRSTL0pPuO8mDyS15k8DWw0EO7Gb2ge+O2t4V4iznzt0P54sGbKy5391sn6GnX8
         hjVuQ4Zotu542CnuoD0vmrfdqqgTIDJSvPp/WqLwJAfkCFunIxOJBb4uytdCQpuQ4FaP
         aN9+po3jE4qCxn/CknCuY0cA0ow4UAZ9HaTeYKi8zFV9l4DHEiGtn1pBQ40nYiDZHkTU
         NAMA==
X-Forwarded-Encrypted: i=1; AFNElJ9Zxi1WckbFVBkDlhfOf5W26ni00Yr7mWLdfn1im5KFvb/Aoc/HeFMtz+FB0bCjSWsjXOOw36TP9jDDh0Ia0ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMUM8lAhUqaTC6C4QZ2GNelKmn5Ht1hrDkhzVDu7snhqp+dFh
	67oXgxwMpRbhnn6jb4U6bDxfma6gnVEpXfrTUWtUAu0m2grmqX68mUBJLXYvKBSDnEcZHqTcC5B
	OVifA0hhzAd5pJgvcd9a/fuimnKDv350f17nOhVwFew==
X-Gm-Gg: Acq92OEhGz9G97nrT6gq9ird2BTcbaQK8xYP9xVH/BEXUU4/PaHl17NTICUnaZU/Oa9
	+C2YDmX3qHtFceBFRilQZ2/Mp8LSTX2gDXp9GgwPnPOisOKy4b8AWFOE9aIIjHWprfGfNXDXMiz
	+MW6HwC/EKI5LnovO5KexwApsK+ulD8qNtpjNMws3NMMVWuzn+UVcusn77ZV/3oC+EJtfgPkIMk
	G/ddrtHh73bzHq9O0JMSSCMb5Spkef4iX8acXYK5Wecx0YO6ZXAfgjjNqHg5TrDMYcoCWEpa+hh
	Hn/Z7BLbgiMH/iCEZIFtM/bM+R7AoFQi/1kAtmFkslgJHf1pEHZtYlYVlDPcHNijdWaiaDxlzuf
	ngosW
X-Received: by 2002:a05:690e:d86:b0:651:e0cd:5877 with SMTP id
 956f58d0204a3-660dbfbd3e0mr8244696d50.18.1780586943313; Thu, 04 Jun 2026
 08:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604004125.715884-1-tim.bird@sony.com>
In-Reply-To: <20260604004125.715884-1-tim.bird@sony.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jun 2026 11:28:51 -0400
X-Gm-Features: AVHnY4In9VQ4p30nYJWJvbT9P3PVyy8EyRyJu_Le3nljCeLoIh3siTSDMpxuyaY
Message-ID: <CABBYNZ+j8M4LrG1V0ESrtG3sWR4vgstHGjQQauekBFf3B7DD6w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add SPDX id lines to some source files
To: Tim Bird <tim.bird@sony.com>
Cc: marcel@holtmann.org, jannh@google.com, kuba@kernel.org, kiran.k@intel.com, 
	chharry@chromium.org, gustavo@padovan.org, prameela.j04cs@gmail.com, 
	salvatore.benedetto@intel.com, maxk@qualcomm.com, 
	linux-bluetooth@vger.kernel.org, linux-spdx@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Wed, Jun 3, 2026 at 8:44=E2=80=AFPM Tim Bird <tim.bird@sony.com> wrote:
>
> Many bluetooth source files are missing SPDX-License-Identifier
> lines. Add appropriate IDs to these files, and remove other
> license lines from the headers.
>
> Leave the warranty disclaimer in files where the license ID is
> GPL-2.0 but the wording of the disclaimer is slightly different
> from that of the GPL v2 disclaimer.
>
> It is not different enough to cause licensing conflicts, but is
> kept to honor the original contributors' legal intent.
>
> ---
> V1 -> V2:
>  - Leave different warranty disclaimers (which is most them)
>  - Remove files recently removed from drivers/bluetooth from the patch
>
> Signed-off-by: Tim Bird <tim.bird@sony.com>

`git am` doesn't pick up your Signed-off-by because it is after ---`,
it seems to be considered a comment.

> ---
>  drivers/bluetooth/btrsi.c         | 12 +-----------
>  include/net/bluetooth/bluetooth.h |  5 +----
>  include/net/bluetooth/hci.h       |  5 +----
>  include/net/bluetooth/hci_core.h  |  5 +----
>  include/net/bluetooth/hci_mon.h   |  5 +----
>  include/net/bluetooth/hci_sock.h  |  5 +----
>  include/net/bluetooth/l2cap.h     |  5 +----
>  include/net/bluetooth/mgmt.h      |  5 +----
>  include/net/bluetooth/rfcomm.h    |  5 +----
>  include/net/bluetooth/sco.h       |  5 +----
>  net/bluetooth/af_bluetooth.c      |  5 +----
>  net/bluetooth/bnep/core.c         |  5 +----
>  net/bluetooth/bnep/netdev.c       |  5 +----
>  net/bluetooth/bnep/sock.c         |  5 +----
>  net/bluetooth/ecdh_helper.c       |  5 +----
>  net/bluetooth/ecdh_helper.h       |  5 +----
>  net/bluetooth/hci_conn.c          |  5 +----
>  net/bluetooth/hci_core.c          |  5 +----
>  net/bluetooth/hci_debugfs.c       |  5 +----
>  net/bluetooth/hci_debugfs.h       |  5 +----
>  net/bluetooth/hci_event.c         |  5 +----
>  net/bluetooth/hci_sock.c          |  5 +----
>  net/bluetooth/hidp/core.c         |  5 +----
>  net/bluetooth/hidp/hidp.h         |  5 +----
>  net/bluetooth/hidp/sock.c         |  5 +----
>  net/bluetooth/l2cap_core.c        |  5 +----
>  net/bluetooth/l2cap_sock.c        |  5 +----
>  net/bluetooth/lib.c               |  5 +----
>  net/bluetooth/mgmt.c              |  5 +----
>  net/bluetooth/mgmt_util.c         |  5 +----
>  net/bluetooth/mgmt_util.h         |  5 +----
>  net/bluetooth/rfcomm/core.c       |  5 +----
>  net/bluetooth/rfcomm/sock.c       |  5 +----
>  net/bluetooth/rfcomm/tty.c        |  5 +----
>  net/bluetooth/sco.c               |  5 +----
>  net/bluetooth/selftest.c          |  5 +----
>  net/bluetooth/selftest.h          |  5 +----
>  net/bluetooth/smp.c               |  5 +----
>  net/bluetooth/smp.h               |  5 +----
>  39 files changed, 39 insertions(+), 163 deletions(-)
>
> diff --git a/drivers/bluetooth/btrsi.c b/drivers/bluetooth/btrsi.c
> index c68dd2fba01c..59ad0b9b14c3 100644
> --- a/drivers/bluetooth/btrsi.c
> +++ b/drivers/bluetooth/btrsi.c
> @@ -1,17 +1,7 @@
> +// SPDX-License-Identifier: ISC
>  /*
>   * Copyright (c) 2017 Redpine Signals Inc.
>   *
> - * Permission to use, copy, modify, and/or distribute this software for =
any
> - * purpose with or without fee is hereby granted, provided that the abov=
e
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANT=
IES
> - * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE F=
OR
> - * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGE=
S
> - * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> - * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT =
OF
> - * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
>   */
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 3faea66b1979..b624da5026f5 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -5,10 +6,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 572b1c620c5d..a8b2e8781054 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -5,10 +6,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index aa600fbf9a53..7e15da47fe3a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
> @@ -5,10 +6,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_=
mon.h
> index bbd752494ef9..4b2a0af4ed58 100644
> --- a/include/net/bluetooth/hci_mon.h
> +++ b/include/net/bluetooth/hci_mon.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2011-2012  Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci=
_sock.h
> index 13e8cd4414a1..16f150b861be 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -1,13 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee5494..b1039ebdf06f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -6,10 +7,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 8234915854b6..08daed7a96d5 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -1,13 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2010  Nokia Corporation
>     Copyright (C) 2011-2012  Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcom=
m.h
> index c05882476900..feb6b3ae5e69 100644
> --- a/include/net/bluetooth/rfcomm.h
> +++ b/include/net/bluetooth/rfcomm.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ)
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index f40ddb4264fc..214409527b35 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -1,13 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 1a6aa3f8d4d6..bcbc11c9cb15 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 0de5df690bd0..b18e1cf28bb4 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BNEP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2001-2002 Inventel Systemes
> @@ -7,10 +8,6 @@
>
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
> index cc1cff63194f..ee1e39a3daff 100644
> --- a/net/bluetooth/bnep/netdev.c
> +++ b/net/bluetooth/bnep/netdev.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BNEP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2001-2002 Inventel Systemes
> @@ -7,10 +8,6 @@
>
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
> index 00d47bcf4d7d..f3fe818d0e4c 100644
> --- a/net/bluetooth/bnep/sock.c
> +++ b/net/bluetooth/bnep/sock.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BNEP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2001-2002 Inventel Systemes
> @@ -6,10 +7,6 @@
>
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
> index 0efc93fdae8a..1938e5559d88 100644
> --- a/net/bluetooth/ecdh_helper.c
> +++ b/net/bluetooth/ecdh_helper.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ECDH helper functions - KPP wrappings
>   *
>   * Copyright (C) 2017 Intel Corporation
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation;
> - *
>   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>   * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/ecdh_helper.h b/net/bluetooth/ecdh_helper.h
> index 830723971cf8..9d787d3c8797 100644
> --- a/net/bluetooth/ecdh_helper.h
> +++ b/net/bluetooth/ecdh_helper.h
> @@ -1,12 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ECDH helper functions - KPP wrappings
>   *
>   * Copyright (C) 2017 Intel Corporation
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation;
> - *
>   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>   * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 54eabaa46960..c335372e4062 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
> @@ -5,10 +6,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 28d7929dc593..243d01069a91 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -5,10 +6,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 99e2e9fc70e8..0635e4641db4 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2014 Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
> index 9a8a7c93bb12..92365cbc922a 100644
> --- a/net/bluetooth/hci_debugfs.h
> +++ b/net/bluetooth/hci_debugfs.h
> @@ -1,11 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2014 Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index eea2f810aafa..e588c744ce36 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved=
.
> @@ -5,10 +6,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 0290dea081f6..c81852411250 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 70344bd3248a..0e24c5e2955e 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     HIDP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
>     Copyright (C) 2013 David Herrmann <dh.herrmann@gmail.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
> index 6ef88d0a1919..959b745bb770 100644
> --- a/net/bluetooth/hidp/hidp.h
> +++ b/net/bluetooth/hidp/hidp.h
> @@ -1,11 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     HIDP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
> index c93aaeb3a3fa..b75bea3cf422 100644
> --- a/net/bluetooth/hidp/sock.c
> +++ b/net/bluetooth/hidp/sock.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     HIDP implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2003-2004 Marcel Holtmann <marcel@holtmann.org>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 45b175399e8d..ad2f26d935ca 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -8,10 +9,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c138aa4ae266..e3eda309f1b3 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
> @@ -7,10 +8,6 @@
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index 305044a84478..cea21a4c49a0 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index de5bd6b637b2..a732b586979d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2010  Nokia Corporation
>     Copyright (C) 2011-2012 Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 4f19654d41a9..6ea107c0e054 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2015  Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index bcba8c9d8952..20810cf06e81 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -1,11 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2015  Intel Coropration
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337d57..593583c694a7 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index bd7d959c6e9e..bb7cf98f85cf 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 91bf5274262e..4b9a699ec59b 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     RFCOMM implementation for Linux Bluetooth stack (BlueZ).
>     Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
>     Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index f1799c6a6f87..be5614a6c5ee 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2000-2001 Qualcomm Incorporated
>
>     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
> index f49604d44b87..ae5b44bb9d3d 100644
> --- a/net/bluetooth/selftest.c
> +++ b/net/bluetooth/selftest.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>
>     Copyright (C) 2014 Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/selftest.h b/net/bluetooth/selftest.h
> index 2aa0a346a913..34d684ee84fd 100644
> --- a/net/bluetooth/selftest.h
> +++ b/net/bluetooth/selftest.h
> @@ -1,11 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2014 Intel Corporation
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 98f1da4f5f55..ef464568b9c7 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
> index c5da53dfab04..eac27bd541bb 100644
> --- a/net/bluetooth/smp.h
> +++ b/net/bluetooth/smp.h
> @@ -1,11 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>     BlueZ - Bluetooth protocol stack for Linux
>     Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
>
> -   This program is free software; you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License version 2 as
> -   published by the Free Software Foundation;
> -
>     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
>     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>     FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY R=
IGHTS.
> --
> 2.43.0
>
>


--=20
Luiz Augusto von Dentz
