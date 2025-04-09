Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573622253E4
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201983; cv=none; b=Y0G/0C2M26U1vyoqutUHvOuU4CO255o0v34UubYHT5zoNnOdIEL8t7o5+oclk2W6uYdfK59J2gvXEl8WiJSR+wkQ63rZzjOAVJPhFQXBFOHwnyfPoCxBhz8+peMJJV5sGp3MWf+P+JLD9gc5JV7xaPr9hk9x3FFDgtjHNlBoGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201983; c=relaxed/simple;
	bh=COhtqQHd5uQMLEHUMwktHuVOl2dqgnbJjBhJzWVDCE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d45Qygi3MzWM7ok5iIt0mdh44joPfBFzgF4Yf1bP+qiFe7fJU5xeMOPlKK1xVjBlrePndQTipLn+wDFoW10+K9XWbgg4g447V0LmC28vZnS6dYDE/RNyNNNNuivjN2MrgpGFzUEKUgZeMe1G27jCl747Y6Irxg0DUoyx0avps/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6D0B661E64799;
	Wed, 09 Apr 2025 14:32:52 +0200 (CEST)
Message-ID: <570876be-3dfb-41b1-b6a5-613dc7ec7b87@molgen.mpg.de>
Date: Wed, 9 Apr 2025 14:32:52 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Prohibit establishing of ACL
 links during poweroff
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_bt@quicinc.com
References: <20250408115146.2300584-1-quic_shuaz@quicinc.com>
 <46521c87-ed61-420d-bb2d-d5499d119f5c@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <46521c87-ed61-420d-bb2d-d5499d119f5c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Shuai,


Thank you for the improved patch. Should you resend only some minor things.


Am 09.04.25 um 11:13 schrieb Shuai Zhang:

> On 4/8/2025 7:51 PM, Shuai Zhang wrote:
>> If turning off BT during pairing, "hci_acl_create_conn_sync" has chances
>> to be left in cmd_sync_work_list. Then the driver will try to send
>> the HCI command of creating connection but failed.
>>
>> bluetoothctl test step:
>> 1. local device pair with remote device
>> 2. once pair is complete, local device will immediately perform power off

The noun is written without a space: poweroff.

>> 3. powe on local device fail

powe*r*

>> Check if the device is not starting up, that means powering off,
>> when establishing the ACL link, and cancel early in this case.
> 
> Do you have other suggestions? Please let me know. Thanks.
> 
>> Change-Id: I72802f306a20d43282dd374dd33b8cb1a22f48d8
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> ---
>>   net/bluetooth/hci_sync.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index c553b637c..c4f1c0f30 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -6755,7 +6755,7 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
>>   	struct hci_cp_create_conn cp;
>>   	int err;
>>   
>> -	if (!hci_conn_valid(hdev, conn))
>> +	if (!hci_conn_valid(hdev, conn)|| !test_bit(HCI_UP, &hdev->flags))
>>   		return -ECANCELED;
>>   
>>   	/* Many controllers disallow HCI Create Connection while it is doing


Kind regards,

Paul
