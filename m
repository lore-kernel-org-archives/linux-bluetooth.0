Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34613DFC9F;
	Thu, 14 May 2026 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770455; cv=none; b=Wk5L/ijuLGUaYJG4/iO2RJJaE093a9iu/8TI7UDJ43sMMI64bd4h7eal26X8Sm/39PiXe8Fvsx/+8TtQz/17PvbUfaBxgXsTSBaGmPxTFT6N3PRyX3M34JLc2gDKypWyOJD+AaQt5YPYEirOJo+R4OIa7tu56v/30NImtjClrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770455; c=relaxed/simple;
	bh=IK06vLegn/mVfp/X4lkkns3qtLm8ShFF9GJQ2WwXEdQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EZFKcdg2SG/2kOFk2Hmp5opRf2zwDmwlIG+wVDUrojgvH/0uEDiei/7Wo5TjoMEiXit3yr1fK7NtwHfHUoEZkSsR4y9rH/F+6gnOs3oksDmJxkuU16MGUnr1R7YeyCYBNYDX5sZawKPH3hNbVGGZTWT8yRp+s2gi9c5/1g/lr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=c1orZlMu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="c1orZlMu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:References:To:From:Subject:Cc:Message-Id:Date:
	Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7M44/6sGyiRepzvAxplph8nNpoUbaAZFmb+wE6bfiPk=; b=c1orZlMuekoD6FTRzhCLXaeUEv
	wrJwuzX/1Biz++M/NBr4bnjaqMO9haPmLXIOODftqjS3EaN/c9s/hsGDmz242FzNiqiFPBnkeBwq8
	IwjBH9se2/nbIupCINL1yhB2oxmWtZlhO622N+/BY4Sv27GnIDJor/nbnZ5WVPuRRl0tieVbTXKE1
	DdGmp/pSlVQz43leFLC5BFI+0bYFKl8R8PUK4fCXzHNRcsBr2yIRyRak11/9Gv4BWr9jGqUWjZFRP
	E8ra+xHT1ee96tEW47ARBBfBu74hPMwUDZ+Zh0yOMGDN+7ppH07zP7W1PlCapiX5jS/U0bnxvVeEz
	ninv/M5A==;
Received: from 177-136-93-131.vmaxnet.com.br ([177.136.93.131] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wNXRr-0007FV-T3; Thu, 14 May 2026 16:54:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 May 2026 11:53:58 -0300
Message-Id: <DIIHHUJM2CZJ.2OKA9PGHEHBRP@igalia.com>
Cc: "Marcel Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Gustavo Padovan" <padovan@profusion.mobi>,
 <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>, <syzkaller-bugs@googlegroups.com>,
 <syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: Don't queue tx_work while draining
 workqueue
From: "Heitor Alves de Siqueira" <halves@igalia.com>
To: "Hillf Danton" <hdanton@sina.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260513-hci_send-v1-1-ae3eef758280@igalia.com>
 <20260514020446.639-1-hdanton@sina.com>
In-Reply-To: <20260514020446.639-1-hdanton@sina.com>

On Wed May 13, 2026 at 11:04 PM -03, Hillf Danton wrote:
> On Wed, 13 May 2026 15:55:23 -0300 Heitor Alves de Siqueira wrote:
>> Syzbot reported a warning when L2CAP calls queue_work() on the hdev
>> workqueue while it's being drained. This can happen during device reset =
or
>> close paths for hci_send_acl(), hci_send_sco() and hci_send_iso().
>>=20
>> The workqueue is drained in hci_dev_do_reset() and in hci_dev_close_sync=
():
>>   - hci_dev_close_sync() clears the HCI_UP bit before draining
>>   - hci_dev_do_reset() sets HCI_CMD_DRAIN_WORKQUEUE before draining
>>=20
>> Add these checks before queuing tx_work, and free the SKB if it's not
>> queued for transmission.
>>=20
>> Fixes: 3eff45eaf817 ("Bluetooth: convert tx_task to workqueue")
>> Reported-by: syzbot+97721dd81f792e838ba0@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3D97721dd81f792e838ba0
>> Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
>> ---
>>  net/bluetooth/hci_core.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>=20
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index c46c1236ebfa..5d5f8ad7d1a8 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -3278,6 +3278,12 @@ void hci_send_acl(struct hci_chan *chan, struct s=
k_buff *skb, __u16 flags)
>> =20
>>  	BT_DBG("%s chan %p flags 0x%4.4x", hdev->name, chan, flags);
>> =20
>> +	if (!test_bit(HCI_UP, &hdev->flags) ||
>> +	    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE)) {
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>>  	hci_queue_acl(chan, &chan->data_q, skb, flags);
>> =20
>>  	queue_work(hdev->workqueue, &hdev->tx_work);
>>
> What you add is not enough, go and see how HCI_CMD_DRAIN_WORKQUEUE is
> checked in hci_cmd_work(), and in hci_dev_do_reset() for why.

I see, I missed the RCU guards for the device flags. Sorry about that,
I'll add them to v2.
Thanks for the catch!

Best,
Heitor
