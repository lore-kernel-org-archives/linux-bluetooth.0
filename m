Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360323D280;
	Mon, 14 Jul 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509426; cv=none; b=r90wlZM8klJ8+YIlf/WRv6KuGXazhn9sk3nu67NGheL0Dz4chvGzo1JCsuUW0e4DdHkLttw8MVORtqsoJSFZvXS8Fk/+LddoQPV7rUNgWfM++27T5/DYExEqqDllaHpI3myRkEGxs//y2EveKmbTagK/pF4e0pONhqiHmaZ9EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509426; c=relaxed/simple;
	bh=INOeSI1G96P3fbLeYvwcOfYxU0fUNYZx8hlSoEK7Ve8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=JaZBISPXR+oprnnlmYL4naV9h+b9V3dBEZU5Jh5r9Oprdrzc+/xKuxxTwaFR69wlwxMABI3b2wC2xyvX5xgmSlxfiPlU9McRJe+kecsvCYJ1co2Nxmzz0U/VWIaY7jcYmu5ewEnUdTKhoRygmQPYUcvMpmAWnsgo4Tkvh5ZcIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Aauq/HO9; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Aauq/HO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752509415; x=1753114215; i=markus.elfring@web.de;
	bh=yGFL3CsKlUx5mqQW7FrhtJ6qimxNivY+M0QIT0tgJXo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Aauq/HO9xY7xhv+j75kFry4IOUh9jj+yATM96V6zP3/cvHvOFYGJo9EcHn7/UDyH
	 6Jc+gOxxNIEqH7FkXKRIDJTmjBjsOZBs1Ry34ySwAByK1XD4qnfkDrxlmdsicAxUd
	 YHqytN4ftfWL6WfjyuBultktmINtnu1OA1+GoM40fg81Ew4Jot8p+LCYTH1GzAp7y
	 AcCaWOgkVjh74rIwD2b34b2YGauTPCQj8L7GUJEgWHqrEmsWSzZDVsOlx4z91S8lR
	 OvFny145uoTgCjuEJrqVeG6H9tt68NkRcC1Z+3LT2RJfmTzAeM/7dATxUaaPoJBnQ
	 o50ZDpmnN03RHRBH1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2ggd-1uciXC32H1-00GjBd; Mon, 14
 Jul 2025 18:10:13 +0200
Message-ID: <4dd92668-7e8c-45a8-ac93-8c5a292ab340@web.de>
Date: Mon, 14 Jul 2025 18:10:01 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yue Haibing <yuehaibing@huawei.com>, linux-bluetooth@vger.kernel.org,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250628103105.211049-1-yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] Bluetooth: btrtl: Fix passing zero to 'ERR_PTR'
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250628103105.211049-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rQxJSUL0Umot9Bag5/IhKzd68d2nZk0ldw5WqEsuEVi3ny1P5bN
 XB6wbp/HbmTU0SvJfGR1QOrYwoaq86PfeWZRINfs65ZwIZgolFSH3imzIIeIkxVDkbUKfJt
 fB4lPCW/fpqyNl7dRIvmwvc0p53XvebrUwAwdZcyoTC1tXcfiYSEOpxowFhg3S0kY9fF6XX
 lQLatDXdmksufUCH8pifA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Z5/FKDsJfPE=;yY/QF+hoprFUvI029hNfIkaicCJ
 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
 fWOPb0YGaSFEJyot+kU1XBVZbC

> If bt_skb_alloc() fails, ret should be -ENOMEM then pass to ERR_PTR().

You would like to achieve a more appropriate error code for another case.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n94


=E2=80=A6
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1137,8 +1137,10 @@ struct btrtl_device_info *btrtl_initialize(struct=
 hci_dev *hdev,
> =20
>  	if (btrtl_dev->drop_fw) {
>  		skb =3D bt_skb_alloc(sizeof(*cmd), GFP_KERNEL);
> -		if (!skb)
> +		if (!skb) {
> +			ret =3D -ENOMEM;
>  			goto err_free;
> +		}
> =20
>  		cmd =3D skb_put(skb, HCI_COMMAND_HDR_SIZE);
=E2=80=A6

Will it be a bit nicer to perform the desired variable assignment
after an additional label like =E2=80=9Cerr_no_mem=E2=80=9D?

Regards,
Markus
