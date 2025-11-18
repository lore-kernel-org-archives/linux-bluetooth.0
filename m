Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8782EF64F
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476978; cv=pass; b=h1q9/sll/c7GTGtQPucIM+HQwBy7zFl1nAP4Xdj/uS1X+s6wFh29+qz8qqHQ6oYcDj1G8ITMCpAbQxz6oDbYSzvpi3XpmWzgW0b9IYSII45GcDr4kudgNSeIDuyn3mQW0emWnYV+mS2TMlfmviDddYpdnlK2gn3P40R8BX91Ezs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476978; c=relaxed/simple;
	bh=UDbmw/6MMBidkvgxz5ZTADv67h3evHT6pDNjARFWJ30=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KpQwW/AW5D0qIIbxY2kMGDxPegcw1hS1b3mMK+F7bL3UNM+xBaQc4t4T+FXqKGOoDZ2C0W4qVbVdLYPdavbXECm25bDP++eerEd5mLzFtD5D018XCOPLn2vRavl3a0WFVN+8gW4iKcjZ1/DwSVKZoseM17Rlnh1+8LR3w6phW5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZXym2+mg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZXym2+mg"
Received: from ehlo.thunderbird.net (unknown [193.138.7.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d9nQg4ltDzyNV;
	Tue, 18 Nov 2025 16:42:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763476972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xre3tDaLc4LyHbnLZ4vWLamWfrNGsQt3gCPgLxCcjKs=;
	b=ZXym2+mgOQamXCP1Luei722dFGsDMXZxlrhRnqnXn11hvRHhg8SPgC7WHnRI4PNWg7trJp
	pfXSllkI9bawYd7CKUmxeG6IpHds/Vvxs5P70okZL0C6THuoVZR4nmp1b2LnsIu/A4fsDy
	8uxRgdAfon0icCNNtIdzgxp5KG7HIhU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763476972;
	b=hJuoUZaZD75JwHSOS1uPStCiBLwORU+yp1zxshE0OKLAg6T5RI1x85SXN5R6vLWtPxun0x
	xDRJClrY6poD+mW+Du1Op+QDWVxqDP3ylYZuesykwb+Xue68IpP73JnK0LiSGXkaZMYPyw
	s64LoCOS2I7xnqjBz35296ZURa7PGz0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763476972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xre3tDaLc4LyHbnLZ4vWLamWfrNGsQt3gCPgLxCcjKs=;
	b=mbqsI+sPTzi5EAUxKSxJBaO3FEcIG5/0X8X9IQfixSBLVOJ+Mra9V425NxLuHCM8lNDjt5
	Yce76IZC8tnoAuaeg0NH+olS2Bsofqgc7akOpRXTZtiIx04+CXDywtk7f/ERzDpRGHjGJ9
	wdDJh+s8KKrhW/qWO5dMUDVTyNCKd4c=
Date: Tue, 18 Nov 2025 14:42:50 +0000
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_fixup!_Bluetooth=3A_hci=5Fcore?=
 =?US-ASCII?Q?=3A_Fix_triggering_cmd=5Ftimer_for_HCI=5FOP=5FNOP?=
In-Reply-To: <CABBYNZKmb5riJmos9DCmw5L0fDXEoqUJuvMn4afcAmKYRcTY9g@mail.gmail.com>
References: <20251117215103.3990708-1-luiz.dentz@gmail.com> <CABBYNZKmb5riJmos9DCmw5L0fDXEoqUJuvMn4afcAmKYRcTY9g@mail.gmail.com>
Message-ID: <32981F81-6A15-4F03-9C15-3C1C461A3992@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

18=2E marraskuuta 2025 14=2E16=2E42 UTC Luiz Augusto von Dentz <luiz=2Eden=
tz@gmail=2Ecom> kirjoitti:
>Hi Pauli,
>
>On Mon, Nov 17, 2025 at 4:51=E2=80=AFPM Luiz Augusto von Dentz
><luiz=2Edentz@gmail=2Ecom> wrote:
>>
>> From: Luiz Augusto von Dentz <luiz=2Evon=2Edentz@intel=2Ecom>
>>
>> Fixes: 486a25d25a4b3 ("Bluetooth: hci_core: Fix triggering cmd_timer fo=
r HCI_OP_NOP")
>> Reported-by: syzbot+25e9c406cbd26c66c417@syzkaller=2Eappspotmail=2Ecom
>> Closes: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D25e9c406cbd26c66c=
417
>> Signed-off-by: Pauli Virtanen <pav@iki=2Efi>
>> Signed-off-by: Luiz Augusto von Dentz <luiz=2Evon=2Edentz@intel=2Ecom>
>> ---
>>  net/bluetooth/hci_core=2Ec | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core=2Ec b/net/bluetooth/hci_core=2Ec
>> index 9f686e5903a1=2E=2E1920e3d62bda 100644
>> --- a/net/bluetooth/hci_core=2Ec
>> +++ b/net/bluetooth/hci_core=2Ec
>> @@ -4121,7 +4121,7 @@ static void hci_rx_work(struct work_struct *work)
>>         }
>>  }
>>
>> -static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *sk=
b)
>> +static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb=
)
>>  {
>>         int err;
>>
>> @@ -4133,16 +4133,19 @@ static void hci_send_cmd_sync(struct hci_dev *h=
dev, struct sk_buff *skb)
>>         if (!hdev->sent_cmd) {
>>                 skb_queue_head(&hdev->cmd_q, skb);
>>                 queue_work(hdev->workqueue, &hdev->cmd_work);
>> -               return;
>> +               return -EINVAL;
>>         }
>>
>>         if (hci_skb_opcode(skb) !=3D HCI_OP_NOP) {
>>                 err =3D hci_send_frame(hdev, skb);
>>                 if (err < 0) {
>>                         hci_cmd_sync_cancel_sync(hdev, -err);
>> -                       return;
>> +                       return err;
>>                 }
>>                 atomic_dec(&hdev->cmd_cnt);
>> +       } else {
>> +               err =3D -ENODATA;
>> +               kfree_skb(skb);
>
>Does this address your concern about the skb not being consumed/leaking?

Yes, I think now the original skb gets freed in all paths=2E

>
>>         }
>>
>>         if (hdev->req_status =3D=3D HCI_REQ_PEND &&
>> @@ -4150,12 +4153,15 @@ static void hci_send_cmd_sync(struct hci_dev *h=
dev, struct sk_buff *skb)
>>                 kfree_skb(hdev->req_skb);
>>                 hdev->req_skb =3D skb_clone(hdev->sent_cmd, GFP_KERNEL)=
;
>>         }
>> +
>> +       return err;
>>  }
>>
>>  static void hci_cmd_work(struct work_struct *work)
>>  {
>>         struct hci_dev *hdev =3D container_of(work, struct hci_dev, cmd=
_work);
>>         struct sk_buff *skb;
>> +       int err;
>>
>>         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
>>                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q)=
);
>> @@ -4166,12 +4172,8 @@ static void hci_cmd_work(struct work_struct *wor=
k)
>>                 if (!skb)
>>                         return;
>>
>> -               hci_send_cmd_sync(hdev, skb);
>> -
>> -               /* Don't trigger cmd_timer in case of HCI_OP_NOP since =
there is
>> -                * no command pending=2E
>> -                */
>> -               if (hci_skb_opcode(skb) =3D=3D HCI_OP_NOP)
>> +               err =3D hci_send_cmd_sync(hdev, skb);
>> +               if (err)
>>                         return;
>>
>>                 rcu_read_lock();
>> --
>> 2=2E51=2E1
>>
>
>
