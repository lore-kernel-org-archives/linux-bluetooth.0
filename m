Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DC2595;
	Wed, 21 Aug 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724215769; cv=none; b=VLUmoNp6EJBfD6qs6RCG47iHObagp75Y/37ZwkYXvGfE9jqwMmSlbNKvw9vOWEds0z7A9mpYEJGtByTegmyaorOZtWhU7zA4zCnCtIwzAoRqmGnPGdlYA4hFM5O619hr+PA4J7htp52tZXnBL4nm1/iv9YVusfNlUNbB0aN5wgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724215769; c=relaxed/simple;
	bh=5TzSpBhkHJgJIltrTatdurkNQNLcrphViEYYqPuagxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebmOFfU1Tj+EkutDv7dZoFQ4ex64AGJWdePrcLWRfOSn3XFZpSDp1VT73PqLt7v80pMyc7Qd8cLg4xYvjp95kVAILtVObW2Id71fQdRd0OQ5jdY4K7y4KGteSf8e5PM/XviLGNNSEhtW3bykHEaYNR0SU7XDurvUhIL4PVSHN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2a8.dynamic.kabel-deutschland.de [95.90.242.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EBD4361E5FE05;
	Wed, 21 Aug 2024 06:49:05 +0200 (CEST)
Message-ID: <2be3922d-8899-4e58-aa23-57a0b5cfc111@molgen.mpg.de>
Date: Wed, 21 Aug 2024 06:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Drop unused event during BT on
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240726095828.2707111-1-quic_chejiang@quicinc.com>
 <15472cea-904c-4d79-9195-3063ce7f1e2e@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <15472cea-904c-4d79-9195-3063ce7f1e2e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Cheng,


Thank you for your patch.

Am 21.08.24 um 06:16 schrieb Cheng Jiang:

> Is there any comment for the changes? Thanks!
> 
> On 7/26/2024 5:58 PM, Cheng Jiang wrote:
>> For the WCN6750/WCN6855/WCN7850, the vendor command for a baudrate
>> change is not sent as synchronous HCI command, controller sends the
>> corresponding vendor event with the new baudrate. It needs to be
>> dropped, otherwise it may be misinterpreted as response to a later
>> command.

Is that documented in some datasheet?

How can this behavior be tested, and your change be verified? How did 
you test it?

>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
>> ---
>>   drivers/bluetooth/hci_qca.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index ca6466676902..f497d601e035 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1206,7 +1206,15 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>>   		 * vendor command).
>>   		 */
>>   
>> -		if (hdr->evt == HCI_EV_VENDOR)
>> +		/* For the WCN6750/WCN6855/WCN7850, like the WCN3990, the

Does “like the” mean “and” in this situation? WCN3990 is not mentioned 
in the commit message.

>> +		 * vendor command for a baudrate change command isn't sent as
>> +		 * synchronous HCI command, the controller sends the corresponding
>> +		 * command complete event with the new baudrate. The event is
>> +		 * received and properly decoded after changing the baudrate of
>> +		 * the host port. It needs to be dropped.
>> +		 */
>> +

It’d remove the blank line.

>> +		if (hdr->evt == HCI_EV_VENDOR || hdr->evt == HCI_EV_CMD_COMPLETE)
>>   			complete(&qca->drop_ev_comp);

Excuse my ignorance. Is `HCI_EV_CMD_COMPLETE` only sent in case of a 
baudrate change?

>>   		kfree_skb(skb);
>> @@ -1497,6 +1505,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   
>>   		switch (soc_type) {
>>   		case QCA_WCN3990:
>> +		case QCA_WCN6750:
>> +		case QCA_WCN6855:
>> +		case QCA_WCN7850:

So setting the speed wasn’t working before?

>>   			reinit_completion(&qca->drop_ev_comp);
>>   			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
>>   			break;
>> @@ -1531,6 +1542,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
>>   
>>   		switch (soc_type) {
>>   		case QCA_WCN3990:
>> +		case QCA_WCN6750:
>> +		case QCA_WCN6855:
>> +		case QCA_WCN7850:
>>   			/* Wait for the controller to send the vendor event
>>   			 * for the baudrate change command.
>>   			 */


Kind regards,

Paul
