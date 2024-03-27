Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6E224DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509415; cv=none; b=BXSylmD6s2Loz4LBjrJvCp6EnKzlwGdsv+HHDut7hiRKi/wY2Id0DCLz6UUXWIuCTdeXGEmLmuHLLgAU0/Qqp2ynTGO7T6sdUqhpcK3NlAZHLHkhRAw/Eu5kSpkMKUpiq34Zq531OdAMSV99AQLPhdgKUIOOPM03pd/NZcybw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509415; c=relaxed/simple;
	bh=PtxCyoh8kHYeJPqnEt9qhSJ2XPVSv7pK4t6JdznHRvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSlDaAxNigeS1qwjdDJkOn3x8HkwgEslLKvkPMSYB1EoJQpkm6t5P5A3d5LRuBkxDI4pSCBIOir3vLLu+pPjk5ikzxhrNKsvGV0Ba5L6hymnssf0kuG6Hd5B7j5nPpEKmc5gJSrFtU9IG9i1kWSuYp+DUcUanVikeH3rM5b5cTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iKHCXcei; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iKHCXcei"
Received: from [192.168.0.106] (unknown [123.112.66.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9248E3F28B;
	Wed, 27 Mar 2024 03:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711509404;
	bh=GyDYJPl5SAMCniRMuwyDANpyukdxuKJxNiZBTiPucuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=iKHCXceiRhZtCv1iFkyOI1wxj/4Y+Zna2nEVSsIOG1tdPiKYZyP6DcrTZBBI+x/Qd
	 3fASE5zr+xp0AEnP1UvHVS69HpM/s4JzNVgLY08zpjHR/M/VrcAeywfLFCZ67W+1IK
	 Vk0ow56lRUnynfnW7PfZmN3uUEjJhAJsVIu+Oz9g+J9MdPPRwihecJBXpN7GNq/JZm
	 NcWWA1joNkrAHNO7LKU7b3YXDSVy/6nSR3ULqv/3Z8X2Y9OrCVAa4visAzLty235lm
	 IhpOam78RDtash/pkSHMomfMqgYSAvHGFRxuBNDxg2Bj9r7BSV9tx39lqDUkym2ne9
	 KiaJN8V3Z8gBA==
Message-ID: <36b87a84-1979-4237-bd68-ddef2601951e@canonical.com>
Date: Wed, 27 Mar 2024 11:16:36 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: conn is already encryped before
 conn establishes
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com
References: <20240325061841.22387-1-hui.wang@canonical.com>
 <bedd53fd-e034-4038-9180-5ee378460e09@molgen.mpg.de>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <bedd53fd-e034-4038-9180-5ee378460e09@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/25/24 22:18, Paul Menzel wrote:
> Dear Hui,
>
>
> Thank you for your patch. Some minor nits from my side.
>
> Regarding the summary (encryp*t*ed), please describe the action of the 
> change and not the issue.
>
> Am 25.03.24 um 07:18 schrieb Hui Wang:
>> We have a BT headset (Lenovo Thinkplus XT99), the pairing and
>> connecting has no problem, once this headset is paired, bluez will
>> remember this device and will auto re-connect it whenever the device
>> is power on. The auto re-connecting works well with Windows and
>
> power*ed*
>
>> Android, but with Linux, it always fails. Through debugging, we found
>> at the rfcomm connection stage, the bluetooth stack reports
>> "Connection refused - security block (0x0003)".
>>
>> For this device, the re-connecting negotiation process is different
>> from other BT headsets, it sends the Link_KEY_REQUEST command before
>> the CONNECT_REQUEST completes, and it doesn't send ENCRYPT_CHANGE
>> command during the negotiation. When the device sends the "connect
>> complete" to hci, the ev->encr_mode is 1.
>
> Is that in accordance with the specification or a violation?
>
According to Luiz's comment, looks like it follows the Security Mode 3 
policy, Encryption is established during Link Level.
>> So here in the conn_complete_evt(), if ev->encr_mode is 1, link type
>> is ACL and HCI_CONN_ENCRYPT is not set, we set HCI_CONN_ENCRYPT to
>> this conn, and update conn->enc_key_size accordingly.
>>
>> After this change, this BT headset could re-connect with Linux
>> successfully.
>
> Despite this being a generic issue, could you please document with 
> what controller you tested this?
>
> Do you have any bug/issue tracker URL, you can reference?
OK, will address them in the v2, and will also fix those misspell.
>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>> This is the btmon log for auto re-connecting negotiation:
>> Before applying this patch:
>> https://pastebin.com/NUa9RJv8
>>
>> After applying the patch:
>> https://pastebin.com/GqviChTC
>>
>> net/bluetooth/hci_event.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 4ae224824012..0c45beb08cb2 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -3208,6 +3208,32 @@ static void hci_conn_complete_evt(struct 
>> hci_dev *hdev, void *data,
>>           if (test_bit(HCI_ENCRYPT, &hdev->flags))
>>               set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>>   +        /* "Link key request" completed ahead of "connect request" 
>> completes */
>> +        if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, 
>> &conn->flags) &&
>> +            ev->link_type == ACL_LINK) {
>> +            struct link_key *key;
>> +            struct hci_cp_read_enc_key_size cp;
>> +
>> +            key = hci_find_link_key(hdev, &ev->bdaddr);
>> +            if (key) {
>> +                set_bit(HCI_CONN_ENCRYPT, &conn->flags);
>> +
>> +                if (!(hdev->commands[20] & 0x10)) {
>> +                    conn->enc_key_size = HCI_LINK_KEY_SIZE;
>> +                    goto notify;
>> +                }
>> +
>> +                cp.handle = cpu_to_le16(conn->handle);
>> +                if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
>> +                         sizeof(cp), &cp)) {
>> +                    bt_dev_err(hdev, "sending read key size failed");
>> +                    conn->enc_key_size = HCI_LINK_KEY_SIZE;
>> +                }
>> +notify:
>> +                hci_encrypt_cfm(conn, ev->status);
>
>
> Is goto and labels necessary?

Will drop them in the v2, replace them with if {} else {}

Thanks,

Hui.

>
>> +            }
>> +        }
>> +
>>           /* Get remote features */
>>           if (conn->type == ACL_LINK) {
>>               struct hci_cp_read_remote_features cp;
>
>
> Kind regards,
>
> Paul
