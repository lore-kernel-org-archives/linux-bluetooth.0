Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8703B71A3;
	Fri,  5 Jun 2026 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654951; cv=none; b=O8utQREgSy6JWLCrkw1ncZ0Puu9Vm/g0s7nIq57mwMe5aH0NyqgAE8sHHdhRsL8xNjng5z0SCvgK9z9+X/qR1orvxoJIonwvmnPQuKvLaKvLKOMFAa1oSPd22DUKQn2T6Ag+Mf11az3DlP+0F/vZ0645bJwiXJStWgYoY38RZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654951; c=relaxed/simple;
	bh=CQzlsXsq2QTxeMkI4/rHAytNOxX/FSbZiLlL1ByDTz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzacplXu7mcoaWXclqoiGm1ppcSXbz/GBrpkPYFDzd6vptudvYWpYRE4a2yf+QaPs5/hGtzq9Ss9UNxwqxqLVZtcjCOsMdle6/7iib996HScF5n+TvoURc8+TXhwdnYH/ysg0tPcPVs1g26PqWMNTuEGbREIcZNOU0jiU3xQOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CF8354C1A2597D;
	Fri, 05 Jun 2026 12:21:34 +0200 (CEST)
Message-ID: <8def22a9-85bb-493c-bd37-a299285a8f79@molgen.mpg.de>
Date: Fri, 5 Jun 2026 12:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: Add SPDX id lines to some source files
To: Tim Bird <tim.bird@sony.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, jannh@google.com,
 kuba@kernel.org, kiran.k@intel.com, chharry@chromium.org,
 gustavo@padovan.org, prameela.j04cs@gmail.com, maxk@qualcomm.com,
 linux-bluetooth@vger.kernel.org, linux-spdx@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604170633.730139-1-tim.bird@sony.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260604170633.730139-1-tim.bird@sony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Tim,


Thank you for your patch.

Am 04.06.26 um 19:06 schrieb Tim Bird:
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

Could you please add a note, why you use /* */ in header files (suffix 
`.h`) and // in files ending with `.c`?

> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
> V2 -> V3:
>   - move Signed-off-by above changlog
> V1 -> V2:
>   - Leave different warranty disclaimers (which is most them)
>   - Remove files recently removed from drivers/bluetooth from the patch
> ---
>   drivers/bluetooth/btrsi.c         | 12 +-----------
>   include/net/bluetooth/bluetooth.h |  5 +----
>   include/net/bluetooth/hci.h       |  5 +----
>   include/net/bluetooth/hci_core.h  |  5 +----
>   include/net/bluetooth/hci_mon.h   |  5 +----
>   include/net/bluetooth/hci_sock.h  |  5 +----
>   include/net/bluetooth/l2cap.h     |  5 +----
>   include/net/bluetooth/mgmt.h      |  5 +----
>   include/net/bluetooth/rfcomm.h    |  5 +----
>   include/net/bluetooth/sco.h       |  5 +----
>   net/bluetooth/af_bluetooth.c      |  5 +----
>   net/bluetooth/bnep/core.c         |  5 +----
>   net/bluetooth/bnep/netdev.c       |  5 +----
>   net/bluetooth/bnep/sock.c         |  5 +----
>   net/bluetooth/ecdh_helper.c       |  5 +----
>   net/bluetooth/ecdh_helper.h       |  5 +----
>   net/bluetooth/hci_conn.c          |  5 +----
>   net/bluetooth/hci_core.c          |  5 +----
>   net/bluetooth/hci_debugfs.c       |  5 +----
>   net/bluetooth/hci_debugfs.h       |  5 +----
>   net/bluetooth/hci_event.c         |  5 +----
>   net/bluetooth/hci_sock.c          |  5 +----
>   net/bluetooth/hidp/core.c         |  5 +----
>   net/bluetooth/hidp/hidp.h         |  5 +----
>   net/bluetooth/hidp/sock.c         |  5 +----
>   net/bluetooth/l2cap_core.c        |  5 +----
>   net/bluetooth/l2cap_sock.c        |  5 +----
>   net/bluetooth/lib.c               |  5 +----
>   net/bluetooth/mgmt.c              |  5 +----
>   net/bluetooth/mgmt_util.c         |  5 +----
>   net/bluetooth/mgmt_util.h         |  5 +----
>   net/bluetooth/rfcomm/core.c       |  5 +----
>   net/bluetooth/rfcomm/sock.c       |  5 +----
>   net/bluetooth/rfcomm/tty.c        |  5 +----
>   net/bluetooth/sco.c               |  5 +----
>   net/bluetooth/selftest.c          |  5 +----
>   net/bluetooth/selftest.h          |  5 +----
>   net/bluetooth/smp.c               |  5 +----
>   net/bluetooth/smp.h               |  5 +----
>   39 files changed, 39 insertions(+), 163 deletions(-)

[…]


Kind regards,

Paul
