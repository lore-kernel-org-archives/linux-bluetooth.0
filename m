Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84E17545
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509738; cv=none; b=ODAAzKF0P/YFKaX24whAIuhge1L4CBR61eH5FCD1w+mHRoSDlCZebc9k6u0PSqk8GRpSY/pkPDIcJP3osGsCwyODl3urhFeKAaSCqhOJd8903yykUeqmKVGKXVarfRz4MZFWlv17VtLNSQC0sO+mo9LrNS+o9wi6FKM2gzk8W2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509738; c=relaxed/simple;
	bh=puAktRmiHC/LhWygH1Fql4azP1pr8tgq5ea9PVJfvR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dod1B0VFParsbNQu7i49VWB9pPb4rxKhS3e00d2/4ji8cPCW8xblUx3TFVym5VRbexaUf6vwJkIm65d1iHgInXhWf3LB2agVpDhBfulYA8bU5aIly4S3nDlLWDu7VwsUbVcRFC3JcQnewuhCQIRUe2+j7+H6DR2XkWx4vjjafb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bhbUsBnF; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bhbUsBnF"
Received: from [192.168.0.106] (unknown [123.112.66.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 01B863F313;
	Wed, 27 Mar 2024 03:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711509733;
	bh=MZ3c9h096T33Eu5/duuVeVeDk8cclsgCLQJtUuzUXnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=bhbUsBnFprOunkyuBwzsVVgpLQwBUQSEKdTSQBY7PaEQz/93uMNrPXvYICoTgYb1w
	 natMiERHsythmHsRoVMfCdgXsTLsuH31+3+GmICy/gpBfO6kg4QB8R45p8rFJu0c27
	 WMpYY0Pv6/t+MFsgEFMF3er1H32dknYH76g++jHIXPYUp75qySqX0zAI5WrfdHPFb6
	 863tKN78HjnDTDNqiPgQMJqoeFjhzYQgDSgrqxw7HmigIx0H1LnqQW/H7VB0vuBKF8
	 QTGX+eQI19C2Q/OHo4XNhYcb2nw6I92ijjAUbFb0FwNScL4YX4lWK/SCjNDipCEKnR
	 XmHpCWWsuuMwQ==
Message-ID: <a7cd8cd8-6ffa-460d-aab8-4964682ae9d2@canonical.com>
Date: Wed, 27 Mar 2024 11:22:08 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: conn is already encryped before
 conn establishes
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com
References: <20240325061841.22387-1-hui.wang@canonical.com>
 <CABBYNZLNQtYnh=DbPV7vzmt_Aje87dBuEJrhXiJRabOr5a3O0w@mail.gmail.com>
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <CABBYNZLNQtYnh=DbPV7vzmt_Aje87dBuEJrhXiJRabOr5a3O0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/26/24 00:59, Luiz Augusto von Dentz wrote:
> Hi Hui,
>
> On Mon, Mar 25, 2024 at 2:19 AM Hui Wang <hui.wang@canonical.com> wrote:
>> We have a BT headset (Lenovo Thinkplus XT99), the pairing and
>> connecting has no problem, once this headset is paired, bluez will
>> remember this device and will auto re-connect it whenever the device
>> is power on. The auto re-connecting works well with Windows and
>> Android, but with Linux, it always fails. Through debugging, we found
>> at the rfcomm connection stage, the bluetooth stack reports
>> "Connection refused - security block (0x0003)".
>>
>> For this device, the re-connecting negotiation process is different
>> from other BT headsets, it sends the Link_KEY_REQUEST command before
>> the CONNECT_REQUEST completes, and it doesn't send ENCRYPT_CHANGE
>> command during the negotiation. When the device sends the "connect
>> complete" to hci, the ev->encr_mode is 1.
>>
>> So here in the conn_complete_evt(), if ev->encr_mode is 1, link type
>> is ACL and HCI_CONN_ENCRYPT is not set, we set HCI_CONN_ENCRYPT to
>> this conn, and update conn->enc_key_size accordingly.
>>
>> After this change, this BT headset could re-connect with Linux
>> successfully.
> I suspect it is doing Security Mode 3, so it establishes the
> encryption _before_ the connection handle which probably disables
> EncryptionChange since there is no handle at that point. That said I
> don't remember what we shall do with respect to AES since the
> Encryption_Enabled field can only be set to 0x00 or 0x01 so I assume
> the later can only be:
>
> Link Level Encryption is ON with E0 for BR/EDR.
Thanks for sharing this, it is sth I will study. :-)
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>> This is the btmon log for auto re-connecting negotiation:
>> Before applying this patch:
>> https://pastebin.com/NUa9RJv8
>>
>> After applying the patch:
>> https://pastebin.com/GqviChTC
> Lets add these to the patch description to be more informative about
> the change, you can strip the unrelated traffic at the start and end
> and just focus on what changes to the traffic the patches introduces.

OK, will address it in the v2.

Thanks,

Hui.

>
>> net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 4ae224824012..0c45beb08cb2 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3208,6 +3208,32 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
>>                  if (test_bit(HCI_ENCRYPT, &hdev->flags))
>>                          set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>>
>> +               /* "Link key request" completed ahead of "connect request" completes */
>> +               if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
>> +                   ev->link_type == ACL_LINK) {
>> +                       struct link_key *key;
>> +                       struct hci_cp_read_enc_key_size cp;
>> +
>> +                       key = hci_find_link_key(hdev, &ev->bdaddr);
>> +                       if (key) {
>> +                               set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>> +
>> +                               if (!(hdev->commands[20] & 0x10)) {
>> +                                       conn->enc_key_size = HCI_LINK_KEY_SIZE;
>> +                                       goto notify;
>> +                               }
>> +
>> +                               cp.handle = cpu_to_le16(conn->handle);
>> +                               if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
>> +                                                sizeof(cp), &cp)) {
>> +                                       bt_dev_err(hdev, "sending read key size failed");
>> +                                       conn->enc_key_size = HCI_LINK_KEY_SIZE;
>> +                               }
>> +notify:
>> +                               hci_encrypt_cfm(conn, ev->status);
>> +                       }
>> +               }
>> +
>>                  /* Get remote features */
>>                  if (conn->type == ACL_LINK) {
>>                          struct hci_cp_read_remote_features cp;
>> --
>> 2.34.1
>>
>
> --
> Luiz Augusto von Dentz
