Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0019DF62;
	Thu, 12 Jun 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.96.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740625; cv=none; b=kBXlRcTpbHjbhvRrPObvYfeCs5JSuhanUXP5wSuqp7ZLi2Fa/O/cAEmibbsNLbxquGWx+eUyjzaQAQIN917Ltx/OWVaTg4kFQXlah584AhThYfAygxR1AuK2dtJJlqvsh2vSKeYOUeVIyQW/QviBzd+H7PkOzMXUcsDkLuq7pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740625; c=relaxed/simple;
	bh=LGq4W/AVh1LENpNZXkWrjg15YMHjdVmZBFOA9zyK+co=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZVrOCKluw+tTz77K1zFeqwfp9DECLDTyH1VsWibnZUG3uaIVz3/5hYPywukQysrV+3JQ3vJp2bSXU6O/qICpI/YqYEIpem1EMukQM90t0YSqGQrZYDnSNfr0Yyujnu4E5F8SbgsWVvzbOWvFFHRsWMXj/sM25l8qbQYLmSPWEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=osfBOWtz; arc=none smtp.client-ip=176.109.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="osfBOWtz"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 534674000A;
	Thu, 12 Jun 2025 18:03:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 534674000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1749740614;
	bh=Q7seAgJ78KZAi5drpBpMLIL4uxYndiQKhZrpO+3hQHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=osfBOWtzt9wddUW4LnMTn2jO2BqyS/i/uHF+u+19od1vFzBv5PmVv3L+emaS7jw8y
	 H9TWRC9D4CQdkFClAJy2gKMg24oxsazQtAYOTC6uG9m+xjJEIr5Utu7Isl7yoM0Zhm
	 tlqneych3NRzDsGPGeH9jkJDaSzTsaxy+gZg5FUtnZdySnE2tMWyRk7nrLZsP74g30
	 iUtlC8F/LNseOPRvZLNOuxwX9+B1+9ZiDaXsGJvX2RN+ND2envVg8UCE1Hk0+yNgUl
	 j9YdlUN1FcNqdOT8S/S2rQmd3wDeDnlrvBKDzZrvZdu42RlHF1W9m8l65kuXFUf8L7
	 IjXYTD+opwIoQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R11" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 18:03:34 +0300 (MSK)
Message-ID: <83ecfd0b-575a-5534-33f2-c6983d703012@salutedevices.com>
Date: Thu, 12 Jun 2025 18:03:28 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1] Bluetooth: hci_sync: fix double free in
 'hci_discovery_filter_clear()'
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, <oxffffaa@gmail.com>,
	<kernel@salutedevices.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <4e1578fb-c81d-fe9c-1aa1-26b6016866eb@salutedevices.com>
 <CABBYNZJPuZKifTNe5DMEaro6-4j+_7ExvKU5C6JgRZEwcbZBDw@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CABBYNZJPuZKifTNe5DMEaro6-4j+_7ExvKU5C6JgRZEwcbZBDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2025/06/12 14:07:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 62 0.3.62 e2af3448995f5f8a7fe71abf21bb23519d0f38c3, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;github.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194027 [Jun 11 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/06/12 12:35:00 #27560989
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/06/12 14:07:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5



On 12.06.2025 16:12, Luiz Augusto von Dentz wrote:
> Hi Arseniy,
> 
> On Wed, Jun 11, 2025 at 12:31 PM Arseniy Krasnov
> <avkrasnov@salutedevices.com> wrote:
>>
>> Function 'hci_discovery_filter_clear()' frees 'uuids' array and then
>> sets it to NULL. There is a tiny chance of the following race:
>>
>> 'hci_cmd_sync_work()'
>>
>>  'update_passive_scan_sync()'
>>
>>    'hci_update_passive_scan_sync()'
>>
>>      'hci_discovery_filter_clear()'
>>        kfree(uuids);
>>
>>        <-------------------------preempted-------------------------------->
>>                                            'start_service_discovery()'
>>
>>                                              'hci_discovery_filter_clear()'
>>                                                kfree(uuids); // DOUBLE FREE
>>
>>        <-------------------------preempted-------------------------------->
>>
>>       uuids = NULL;
>>
>> To fix it let's add locking around call  'hci_update_passive_scan_sync()' in
>> 'update_passive_scan_sync()'. Otherwise the following backtrace fires:
>>
>> [ ] ------------[ cut here ]------------
>> [ ] kernel BUG at mm/slub.c:547!
>> [ ] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>> [ ] CPU: 3 UID: 0 PID: 246 Comm: bluetoothd Tainted: G O 6.12.19-sdkernel #1
>> [ ] Tainted: [O]=OOT_MODULE
>> [ ] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [ ] pc : __slab_free+0xf8/0x348
>> [ ] lr : __slab_free+0x48/0x348
>> ...
>> [ ] Call trace:
>> [ ]  __slab_free+0xf8/0x348
>> [ ]  kfree+0x164/0x27c
>> [ ]  start_service_discovery+0x1d0/0x2c0
>> [ ]  hci_sock_sendmsg+0x518/0x924
>> [ ]  __sock_sendmsg+0x54/0x60
>> [ ]  sock_write_iter+0x98/0xf8
>> [ ]  do_iter_readv_writev+0xe4/0x1c8
>> [ ]  vfs_writev+0x128/0x2b0
>> [ ]  do_writev+0xfc/0x118
>> [ ]  __arm64_sys_writev+0x20/0x2c
>> [ ]  invoke_syscall+0x68/0xf0
>> [ ]  el0_svc_common.constprop.0+0x40/0xe0
>> [ ]  do_el0_svc+0x1c/0x28
>> [ ]  el0_svc+0x30/0xd0
>> [ ]  el0t_64_sync_handler+0x100/0x12c
>> [ ]  el0t_64_sync+0x194/0x198
>> [ ] Code: 8b0002e6 eb17031f 54fffbe1 d503201f (d4210000)
>> [ ] ---[ end trace 0000000000000000 ]---
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>  net/bluetooth/hci_sync.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index e56b1cbedab90..61a9922eb820d 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -3167,7 +3167,15 @@ int hci_update_scan(struct hci_dev *hdev)
>>
>>  static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
>>  {
>> -       return hci_update_passive_scan_sync(hdev);
>> +       int ret;
>> +
>> +       hci_dev_lock(hdev);
>> +
>> +       ret = hci_update_passive_scan_sync(hdev);
>> +
>> +       hci_dev_unlock(hdev);
>> +
>> +       return ret;
> 
> This deadlocks since it is a callback on hci_cmd_sync_work which shall
> never use hci_dev_lock while waiting for events processed by
> hci_event_packet which will attempt to do:
> 
>     hci_dev_lock(hdev);
>     kfree_skb(hdev->recv_event);
>     hdev->recv_event = skb_clone(skb, GFP_KERNEL);
>     hci_dev_unlock(hdev);
> 
> This is why there are no test results because all tests seem to be failing now:

Thanks,

ahhhh, may be more valid solution will be to add spinlock to 'struct discovery_state', which protects
operations on this structure at least in 'hci_discovery_filter_clear()' ? 

Thanks, Arseniy

> 
> https://github.com/BluezTestBot/bluetooth-next/pull/2884
> 
>>  }
>>
>>  int hci_update_passive_scan(struct hci_dev *hdev)
>> --
>> 2.30.1
>>
> 
> 
