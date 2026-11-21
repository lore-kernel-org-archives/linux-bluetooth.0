Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.18.0.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258246;
	b=HuB/Mdzl2G5tEU79mV0emaPJa8NQ1KxqBBCOoM+4rdigwb60H8Dnn62l1xt45CLBl4gP
	 RcgB3jgfZwRtnBigvGvp+IHyljHNQjTxY9mhIGhxNXk6OzwjKRvLLK0sYko/4fuWG/esC
	 3DKtmG/w9jazqTRHurb4QoMiVuOpg11C9YiPGKfvk/bYBrYLehtJ7ktNWljVedM4u0D69
	 AyMlDFT64ayF/OTxshp/H1tyB/Zt8Wq/Tt/ZZFffkKguUtrYxKA49EKEnfmTC8m+6HoOf
	 2BnTzqGI8bIAZH2FjEaMDHgfs650DWptTPEKC/kU6XeXpfy0eSgDch0i+NE7grJxhRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Auth-Info:
	 X-Auth-Info:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GQ+eMDXBDrVrEVn9GoLWEDNtXo7EEZLQkKakt155Xjc=;
	b=TpwXg04izy6owXrUrPd50UonoHA5yHqdzJbNshYZM2A+U/cjF+JymBvunM1TQCIKIPCx
	 YnKXGGe5+jq7LBu0L8niKh9BJ9JYw4+36Iyc4VBFjGkVJ6m9t96o5ydLemjkPc9j7X1hf
	 QSQTJkOLMII+55ToRWRFI1bPeHIFIQLwwLv4NkDXkHBO6U0iYAZ+FJiH6w3p9+/33ySU4
	 rKi38A+YN1YZ3OOWIFVYhc80f9Q2tBbt1k3aA7pPTzXslXcQ3dIpKmlnpM5oiQ3GG1z51
	 vlbjODrVGn7p7BdAnxMljxulQrIvvqp3chO0dIkevFfuez7rRQj1dPGlUQf22mNMLCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=muenchen-mail.de;
	spf=pass smtp.mailfrom=muenchen-mail.de;
	dkim=pass header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b="kpNvtQJ/";
	arc=none smtp.remote-ip=212.18.0.10
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B400606A334;
	Sat, 21 Nov 2026 10:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B400606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=kpNvtQJ/
Received: from mail-out.m-online.net (localhost [127.0.0.1])
	by mail-out.m-online.net (Postfix) with ESMTP id 4jWprr1dd5z1sRL0;
	Sat, 21 Nov 2026 11:50:36 +0100 (CET)
DKIM-Signature: a=rsa-sha256; bh=GQ+eMDXBDrVrEVn9GoLWEDNtXo7EEZLQkKakt155Xjc=;
        c=relaxed/relaxed; d=muenchen-mail.de;
        h=Date:From:To:Message-ID:Subject;
        s=r1; t=1795258236; v=1;
        b=kpNvtQJ/+V2Ss8c9TpaByzxGEglvqK4rv9YadtKtVOA8puInEP6QdEklI3YGq/bS
         HqUlJNaSWXobFm84GUTqczT1d/gHYCPO89uqOPPMrRa9cOjQNJ6HQ+GpmY2n2wMy
         bBccjZVyRN329VaxX8ThQrNmi1hRg5XnNIf5nDmLaHtGFWrWDjgnDYaOxu/sX955
         w/JmndlVfUM6zr5Xs5J7YtrYcBBCjJuIkT+CpJTcjQcUyhf5n/YjmBNRvokPtlr9
         uK+0D7peC3RrXcoKRHAbBj8MEyR75XN9XZTlFJ+BzsUEIUFj739d0VRrE/Othd/K
         ikgNALNupRMbtrhCrXFkqA==
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4jWprp2t3dz1sRLT;
	Sat, 21 Nov 2026 11:50:34 +0100 (CET)
X-Auth-Info: gZR21gORsY69QSjr0ULjndmUbiQCWC2CS/qQJCc8xGJFaSKF6dOb8giB328fqP7N
X-Auth-Info: gZR21gORsY69QSjr0ULjndmUbiQCWC2CS/qQJCc8xGJFaSKF6dOb8giB328fqP7N
Received: from wiesel.intern (ppp-212-114-181-207.dynamic.mnet-online.de [212.114.181.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA id 4jWprm3rb6z1qqlS;
	Sat, 21 Nov 2026 11:50:32 +0100 (CET)
Received: from [IPV6:fdea:9b79:8984:1:7c3b:4612:a548:c3c8] (unknown [IPv6:fdea:9b79:8984:1:7c3b:4612:a548:c3c8])
	by wiesel.intern (Postfix) with ESMTP id A79B479A0818;
	Sat, 21 Nov 2026 11:50:31 +0100 (CET)
Message-ID: <fbaa1ed3-6e59-430f-9ce5-26020591bceb@muenchen-mail.de>
Date: Sat, 21 Nov 2026 11:50:31 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: disable read tx power for
 BeagleV-Ahead
To: Drew Fustini <fustini@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
 <20261020132604.90708-2-thomas.gerner@muenchen-mail.de> <awDdetFNaeuxKkbp@x1>
Content-Language: en-US
From: Thomas Gerner <thomas.gerner@muenchen-mail.de>
In-Reply-To: <awDdetFNaeuxKkbp@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 21.11.26 um 00:53 schrieb Drew Fustini:
> On Tue, Oct 20, 2026 at 03:26:03PM +0200, Thomas Gerner wrote:
>> The bluetooth module of the Ampak AP6203BM is identified by the btbcm
>> driver as BCM4362A2.
>>
>> The firmware of the bluetooth module on the BeagleV-Ahead reports a
>> capability of reading LE tx power. However reading fails. To get
>> bluetooth working it is necessary to disable reading of LE tx power on
>> the BeagleV-Ahead board. The disable is implemented in a similar way as
>> for several Apple boards but uses the board compatible identification
>> from the DTB as there is no DMI.
> Thanks for sending this patch. Do you know if this is a problem on any
> other boards with the AP6203BM?

Unfortunately I don't know of other boards with the AP6203BM.

> Also, is there an error message for the failed read?


Without the quirk I get this message:

Bluetooth: hci0: unexpected cc 0x204b length: 1 < 3
Bluetooth: hci0: Opcode 0x204b failed: -38

As a result the hci driver stops initializing and Bluetooth is not working.


>> Signed-off-by: Thomas Gerner <thomas.gerner@muenchen-mail.de>
>> ---
>> No changes in v2
>>
>>   drivers/bluetooth/btbcm.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index 463d59890bef..2d02cc1863d0 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
> [..]
>> -static const char *btbcm_get_board_name(struct device *dev)
>> +static const char *btbcm_get_board_name(struct hci_dev *hdev)
>>   {
>>   #ifdef CONFIG_OF
>>   	struct device_node *root __free(device_node) = of_find_node_by_path("/");
>>   	char *board_type;
>>   	const char *tmp;
>> +	const char **s;
>>   
>>   	if (!root)
>>   		return NULL;
>> @@ -550,8 +556,15 @@ static const char *btbcm_get_board_name(struct device *dev)
>>   	if (of_property_read_string_index(root, "compatible", 0, &tmp))
>>   		return NULL;
>>   
>> +	/* disable broken Read LE Min/Max Tx Power on first board found in list */
>> +	for (s = board_broken_read_transmit_power; *s; s++)
>> +		if (!strcmp(tmp, *s)) {
>> +			hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);
>> +			break;
>> +		}
> It seems that btbcm_get_board_name() only looks up the board name for
> the firmware file so I think it could be unexpected to set a quirk here.
> Maybe this would work better?
>
>    static const char * const board_broken_read_transmit_power[] = {
>            "beagle,beaglev-ahead",
>            NULL
>    };
>   
>    [..]
>
>    if (dmi_first_match(disable_broken_read_transmit_power))
>            hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);
>
>    if (of_machine_compatible_match(board_broken_read_transmit_power))
>            hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);
>
>
> However, I am not very familiar with Bluetooth drivers so I am hoping
> Marcel or Luiz can comment too.

My idea was to use the board name at btbcm_get_board_name() as it is 
already available. However, this suggestion looks is it is more common 
than my idea.

> Thanks,
> Drew


Best regadrs

