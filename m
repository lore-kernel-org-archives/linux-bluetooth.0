Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A76386C10
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717500; cv=none; b=L5Uj6pgmzpMG+hpoUO8zcKUlXswe0nHY4TNiei2mklDHOtMML/G+OUaXXZ173jJNxBMtWyq498tcycIR5KxXWPZSX7u0rd5vDoc33befy/kEMXhJZVHUF4srFH48cBtrpw4MrkIdXuPLqub1L2ZDw6dFgPiUXr0VcabQOHreM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717500; c=relaxed/simple;
	bh=cMwRIGvIt09o6/tnYHncBK0bTpYmYXJsIjtwxL2ZovM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=BrYhynfWoLFmJCVI6oajhuIT0rHAMErx7JC/MeCqGOytRTrlJXy9RSzlB87J8D8bKYXqMasEQd7k0CF+A5QVFtvIoOZk/RyZCnEck09ChIhAT+f+LxNdGOnuAvYf1pu8rogNa3lrupzGdPrMrCDDGuO0IqHIrXMVsbh4KUS2dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=OxyKopo/; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="OxyKopo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Subject: Cc: To: From: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1779717492;
 bh=ZeLnFp9m+pf5y3QIUl8+WeK1RXHgtgz8teGgBVub6X0=;
 b=OxyKopo/LmgS6clVYlhdALv+otjqWjPHdc1EplRl8o0d2oWcMMAfUg9bqYdP/dO9tRHc/ye13
 2VTRZTq13PaGMxoMBB0fCKsmt/wKElzlrY+4Zq/CIRd6XPgHJ0tHCDartDlVwOaSBssxgnMEPn+
 go+Ixb95U5oeBbvOkCmFwQr/N3G9b/0orCI/SzorojTKyHCj2hRW1C2zmb6RyngPGTgcdPm6zJy
 ja97WllEmtxOBaWbK0Ndpks1Y6MJXTkjr5VM9dbuWFBycxOtOoF4oN+tlaSobe+E2FUWg2wWBSG
 zogQb0+27F0dKlP7DnNMjH1DqCnDKVwalbC3iry+RlBQ==
X-Forward-Email-ID: 6a1455716744e73b78d0d539
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.15
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Mon, 25 May 2026 09:58:06 -0400
Message-Id: <DIRT7260SRQZ.1BFF8CX3FJ57G@ubuntu.com>
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Sven Peter" <sven@kernel.org>,
 "Janne Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Marcel
 Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <asahi@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-bluetooth@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: Add Broadcom channel priority commands
X-Mailer: aerc 0.21.0
References: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>
In-Reply-To: <20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech>

On Mon May 25, 2026 at 8:11 AM EDT, Sasha Finkelstein wrote:
> --- /dev/null
> +++ b/net/bluetooth/brcm.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "brcm.h"
> +
> +struct brcm_prio_cmd {
> +	__le16 handle;
> +	u8 enable;
> +} __packed;
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, struct hci_conn *conn,
> +			   bool enable)
> +{
> +	struct sk_buff *skb;
> +	struct brcm_prio_cmd cmd;
> +
> +	if (!hdev->brcm_capable)
> +		return 0;
> +
> +	if (conn->brcm_high_prio =3D=3D enable)
> +		return 0;
> +
> +	cmd.handle =3D cpu_to_le16(conn->handle);
> +	cmd.enable =3D !!enable;
> +

Probably a dumb question, but worth asking - what is the purpose of the
"!!"? Wouldn't just passing "enable" be sufficient?

Also, currently, cmd.enable seems to just be set and used in the case
of boolean conditions. Would it make sense for the enable field in
brcm_prio_cmd to be a bool or does it not really matter?

> +	skb =3D hci_cmd_sync(hdev, 0xfc57, sizeof(cmd), &cmd, HCI_CMD_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	conn->brcm_high_prio =3D enable;
> +	kfree_skb(skb);
> +	return 0;
> +}
> diff --git a/net/bluetooth/brcm.h b/net/bluetooth/brcm.h
> new file mode 100644
> index 000000000000..2290fc6cf798
> --- /dev/null
> +++ b/net/bluetooth/brcm.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, struct hci_conn *conn,
> +			   bool enable);
> +
> +#else
> +
> +static inline int brcm_set_high_priority(struct hci_dev *hdev,
> +					 struct hci_conn *conn, bool enable)
> +{
> +	return 0;
> +}
> +
> +#endif
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index c46c1236ebfa..0e74bad496a2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -46,6 +46,7 @@
>  #include "msft.h"
>  #include "aosp.h"
>  #include "hci_codec.h"
> +#include "brcm.h"
> =20
>  static void hci_rx_work(struct work_struct *work);
>  static void hci_cmd_work(struct work_struct *work);
> @@ -3696,6 +3697,9 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
> =20
>  			skb =3D skb_dequeue(&chan->data_q);
> =20
> +			if (skb->priority =3D=3D TC_PRIO_INTERACTIVE)
> +				brcm_set_high_priority(hdev, chan->conn, true);
> +
>  			hci_conn_enter_active_mode(chan->conn,
>  						   bt_cb(skb)->force_active);
> =20
>
> ---
> base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
> change-id: 20260407-brcm-prio-b630e6cc3834
>
> Best regards,
> -- =20
> Sasha Finkelstein <k@chaosmail.tech>

