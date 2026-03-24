Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922D36C9C5;
	Tue, 24 Mar 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346688; cv=fail; b=p8hNBBkh6zHEdFJ/1Swb8dWBTxXbtE00N641Ocves5Eq4gRIqoFuZz7+kyu7yq0qZq+MQ1K2ayeW0vWeTzIuWTDF4fojOm2qmQyAbFxspdnRQP58ZrOcQAnFtJM9Hl4WRcFZ6FZVvC1muRBRHyxhetZ9+oVGn8/T5OfxuUSl1EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346688; c=relaxed/simple;
	bh=5HNf3pUbZ9zacT4NT12TUlgoTNXf2ytZEWVaIxQswXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MbVGzUcjRuU88+CvvWGvEteBurOgbs+JfSdKsJZTsx2+LOkqOAO+5zbyrL0UyhXCJCHiapSWHtDPFbzyBb+rri3ZugZRJspAUJpxKPoBN8Jz24OYTLLsJTmhxXrcuUwq39Laft656IxjfAEi2PYQAT40GG6Y/tvUlXmJjB8eTJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=EAfNpcGg; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="EAfNpcGg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMDdr056MQVl/LUBxsDLvPC5x6CFEh67VEeOq8b6bORJxfv2ygdfQW+oqZ3clDpIkoVPEN00m9GLb9U3lM8Foo5tPTwQuGv6+FoA0oG6uU+UH4zy7MqsGwN39k6PvXemaFGOIHWpr6Gao/+m6toNyLbFgFURfe1PbcDJacaMAMBG9YffMtVbKwMrUUtr66nvr+EjMGbjxCBmQW75AYYr2x3UlkWSzlGDy7/Twfrg886RVJzb93nsGnUJYTRI1pfmicKl9XnVqpn5ummsonkEM7nZttKLZmFZK3755SpZWZ6XfnhMCC6mT75PfN+yqMaLWoGuL+xsAWo8Q4axn0ZZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbuVmqLb86tT6t6QrPkKdqeh9dMbKqILMhqY8mHsxwU=;
 b=VJHKuTzdeNHTnDnUXdjAF2h7oAIjJgLQy6K5vxhLwKtMzbSaU25p6RijyPcIED/p1fhAj63hop8chu1mrLScFQcCocRn7ne06/em5A5KYAc0y5uAw92O2Voofwmzf5ScHrDjiC0EFHqJinhBJeQ2GDnLy554nw+NxIRVDKLt8diIROhcXXVrLXjh2x1qjaZMEENArkQWb0afiodRKYLfS82RgsYH8Ikhf49O55AqIUvXQqG8sEszbYAk1qLmSKBFglTPWHC/XZw34i+eXMqbRJyMN6c3FDVU69ISlfFqIzrvxQB0iewbrWopUmAT6p96cEGrJkRc9hC0ymMWCqiQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbuVmqLb86tT6t6QrPkKdqeh9dMbKqILMhqY8mHsxwU=;
 b=EAfNpcGg08nvF3ZDiCLfMJ7iuvtQe6eEF2k/bks9n3TiUQl7Tp9W3QdF6/uqR/OaWSRBm930LXdViUJ7SAznxxA9Vs/tyoY+kw9uzxAkG6Qr8SRvcIISZfoA6xrUzafcMl3KNRFsyrkoZwVX3TbMxjwUX+r8AzPHhtl7pIXVJK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from GVUPR02MB11819.eurprd02.prod.outlook.com (2603:10a6:150:31c::8)
 by AS2PR02MB9320.eurprd02.prod.outlook.com (2603:10a6:20b:578::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 10:04:33 +0000
Received: from GVUPR02MB11819.eurprd02.prod.outlook.com
 ([fe80::fc32:b20d:2d0c:4b63]) by GVUPR02MB11819.eurprd02.prod.outlook.com
 ([fe80::fc32:b20d:2d0c:4b63%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 10:04:32 +0000
Message-ID: <d118906b-6a94-41d8-9d2a-74bddc0fd81f@axis.com>
Date: Tue, 24 Mar 2026 11:04:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_h4: Fix race during initialization
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com>
 <CABBYNZKkK-SU51kjexh0uKx0N9m-63dZf0vnGA3c5LsSkmFPOg@mail.gmail.com>
Content-Language: en-US
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
In-Reply-To: <CABBYNZKkK-SU51kjexh0uKx0N9m-63dZf0vnGA3c5LsSkmFPOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0080.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::22) To GVUPR02MB11819.eurprd02.prod.outlook.com
 (2603:10a6:150:31c::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVUPR02MB11819:EE_|AS2PR02MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc93347-e9db-4ea8-85f2-08de898cbefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info:
	EgYX5wscgAE9WCqwIRfIFbWtT92UAoiJu80yIDigNoWDeSeEcEbhA5mkRN1QNH6epjKuYRFshl2KFT5ClL87hFNvA00+BZRDZCTHMuYrNI2aTVuWN/ot+ZSZWkS9KQjs2c3El838625xZd44vr/lMad5fVJWZLcnLY/lzqlaFeLImKRkmWEjycoYA0y59ZyksRlj6oIKH9TAhaACQf/CLHpHKJ2ZP/FBwnc+May1qdlZ18pHUJJpg1NEvZ5CC/NePBP7RFM7WCkis6ippA7obEAsDMCE+qxHs5boUe5Vey5+mDZ6GCIehsL17CiIUA4BdetLSQfQMfI6ngF6MoXibjlsxQheIrTEwgIBTy1EtFliyGItt9nA5/Ddup5OirTDXk0LJlyNKsJpwWAUV7FXk5Ser7uaofUNSOyr2P8+m1vQW4CsFvjvk+I0RQtqxMZpju/7CEtK8pgbpym4iPtFLQ/J8Aih6Nr9F9+//AaqsUlhNkrK0rHtwV7LwpnwSJS01ldx95UzZig694RcfuXR254T0zUhwrxdt0q2HKoxvOvu5VRPP6rDBy3Hrc38NWCFNBeJC3OosgwLkO/XylnKDhp8nA/SWW8bC/gmIScl9x543F6bBsfpG/XQu5OOmTmJdJyZ6nqmYghw/cRWQAjEs7MAkQtdB5JcgkQC6+DNYpt7p5OFioIt01ttfsqGUbYg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVUPR02MB11819.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(7053199007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1RVRU5NYUZDQ0NkVG5nNHNwSU5DRXE0NG4wWDNrRFRCNFVTSTU0ZklKNm5N?=
 =?utf-8?B?dzgxdUNlZEQzZFJUVjErRjlmYzgvTWZMTTR2ZjRKc2xOZnJBbWhINHduZGV0?=
 =?utf-8?B?MjFsaUFDamFiY2NuOFNuamJIeXRkb01jc0o3SU0xNFNYWmg1S0NBQlRSZlBN?=
 =?utf-8?B?QUJhcmcxN29nMy9tY2dxaFhsQnl6L084aGNQOEd5bTF2dU9NdVNjK1VmaHBi?=
 =?utf-8?B?VkRuNHJiVURGcUpFWHh4RVFueGw3VzNQWitXU0IzVUJFQVRFWmdhNlhrOW8v?=
 =?utf-8?B?NjBtc0svVHpCSnRsMndxS3lOWXpOdHdNTU9sdnpaQnB6c2dEdG9sVjlBZmRN?=
 =?utf-8?B?RlgveFovZVlQRndwa2g1RGh1aGIzeGhIWlBwWGtHZmdYckwxemFvVHhHZS9l?=
 =?utf-8?B?Nzgvb2M3S1FrVGJaOUxDSEhWS2NMM2NMQW9TYzlicTRYb3dtd096MlJBZnky?=
 =?utf-8?B?MklBcHFkQXIrV1NIaEZNMlpaSkxnZlZhdzFqNWtRSkRvWncydkpUa3M2cGJv?=
 =?utf-8?B?UCtvYWF0aFJlYWRZUnNDNUZXRzNhZUs2SmJ5NDRONnlaVmRNT3pqME5LcWlV?=
 =?utf-8?B?cHhpUGh5N3ljMEh2UDhPMlNSbjZzZ1Q3Vmx0bWdlRTZaYjloRDByK21RR3di?=
 =?utf-8?B?dnpuZDBqZVE2dnFZbVhyTHZhekVZaGpGbEwwUTE2dzFlbXh4K3d5aTl2UkFC?=
 =?utf-8?B?SitteWFaTTZOT09hZmorM3ZlQThoTkNIRXN1a1BOandVY1hRNkhFNS9zR0F6?=
 =?utf-8?B?QVRSQWdVMFVLR2hOZ0pSSjZrMjBnR3BqYzVTc1dMYzRZdGRQcjBZQXd4MzZZ?=
 =?utf-8?B?em9rOWg0ZUpZQ0ZJN3VuZE1ZcVNxeEFhOThtdExUV0NSZ2o3UXVTZ0ZxTHYw?=
 =?utf-8?B?aHlUUG9kcVhuQVFuL1oxY0xBM1M5Z21XOWd1cSsrSkVaZFlJamJWOHNKaFVk?=
 =?utf-8?B?QWlUcHVlVk1XRFVGWHpwejg0VWg4ZW5hUFBJQStJRTROdVlHZ0MvRDhrQnRH?=
 =?utf-8?B?VDVOblU3a3lNWU9rV0ZkckhlNnJ2OE9JZjJSOGtydDMxTldyaEkyZ1A2d3Jw?=
 =?utf-8?B?b1hFL1BMQllwdlV3TTMyWjRPbkJRTXBmNEppZmZjdjdOLzNzRjhnUW5zQmoz?=
 =?utf-8?B?TEFLemlpSEowWFM4a1ZpdkhBQ3dPU3dOYVUramkyQTNOY3hmVG9oN0tMczNl?=
 =?utf-8?B?OG5VdEl4UDI1V2dQQ2s2SFg3Y3FnbDBHL3FZSjNjVGhOellUSGNndE5zZ1hi?=
 =?utf-8?B?T0xkQVFsRzdqZzFWWWNDa05BcVlDUGFvenhDMytlNTU5THF2N1V3VFFLbkVU?=
 =?utf-8?B?SDdJSmRSa3N2aFFKTmFkZFNURnJuVGp6TEdrNmM5UEExYTR4K2Z2ZnJsRGJU?=
 =?utf-8?B?NCtWcFQ0d3hrVXE4QW94MFFsMTljekRCcmNmR0psblRrWkRJZTZDSVdaRUJy?=
 =?utf-8?B?SHlSYko5Tkx4c1ZXY3dPK0ppT2dDMUVFUlhWcW9MZ0RLZTU1SjQxdURyakQ0?=
 =?utf-8?B?MHh5Ynl6d3hJRjh3WVVFZE01cXh1dGtqTXNzd1I3S1l1Uzl1QnE3V2FRYTNs?=
 =?utf-8?B?VXc1cmdZWEU3eVRmeHFqdUw1Ym1rcG9ncWdQNE4ra1JUOUhyUnJPdjkrbStY?=
 =?utf-8?B?cGhOVC9CdTBUbXdvRnJxNzBobmFRV2dteS9UZjlkUEtsNGlVbXF0bkwvYW40?=
 =?utf-8?B?NSt3YldZc3FXcEFmaEpaYVd1YksrbTNWY0dIYndrQWZXZXNvYzZJQ2RjcU92?=
 =?utf-8?B?U2xEUHZnamN5YThvSkdBRDlncWR0blZDN3pSWUFlMUtVeE93aWpaSVpyUXVi?=
 =?utf-8?B?cVhRVFRnNEt2NElsNm5XTzNVR2lSa3FQRHpLZVczQkVhT1NyQW1aMG5YVThV?=
 =?utf-8?B?bkhJd3pFU1N6NWxOUG1SVVVoR01rZ2J2Y3picmkxZldkY3VBK0pHNzhzUDla?=
 =?utf-8?B?SUtXTkVDL3cyVGhsZUwyRjRUWWV4akF0OVlMZTZzUFhRYnI0a1RqdW9nYjN1?=
 =?utf-8?B?U0hTTVFCeGgyMFB3bDd0Q1Q1UkloOGdHcVlwc0x2dmxISFZ2RmxvNmJQZzdn?=
 =?utf-8?B?aVRBaGNZNy9GUVZydjlBSGhhSmE1VE1BaDJ2Q1p5QnlXWTliWWF3TThQaFpn?=
 =?utf-8?B?a3lEWU96TU5mMUV5TCtwQjhwUS9KaDBGYTVpSnFGVmhSeTdFRU12Sk1CT0Rw?=
 =?utf-8?B?TWlsbFU3WTRzSGI3dDkxVlZhaURLZlc3WmZoOUxpdHZVRlF0WHF2YmQzem1s?=
 =?utf-8?B?QlkvMnZzVmN2dTk3K3ExTUZSTnZ6YjFVV0pnME5rYldya2FrdXB1TVJyS2Vq?=
 =?utf-8?Q?dbo8d7cL1HNjlaTOAv?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc93347-e9db-4ea8-85f2-08de898cbefc
X-MS-Exchange-CrossTenant-AuthSource: GVUPR02MB11819.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 10:04:32.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FV21sk4ftUnwHHSMNhLX0Ynbmu1ds1apR0Qvadhj4yDRkvbJl4B8VjwtBZartFdGHzGS5zuuHxi7oEPMb2Emw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9320

Hello Luiz,

On 3/20/26 21:04, Luiz Augusto von Dentz wrote:
> [You don't often get email from luiz.dentz@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Jonathan,
> 
> On Fri, Mar 20, 2026 at 8:10 AM Jonathan Rissanen
> <jonathan.rissanen@axis.com> wrote:
>>
>> Commit 5df5dafc171b ("Bluetooth: hci_uart: Fix another race during
>> initialization") fixed a race for hci commands sent during initialization.
>> However, there is still a race that happens if an hci event from one of
>> these commands is received before HCI_UART_REGISTERED has been set at
>> the end of hci_uart_register_dev(). The event will be ignored which
>> causes the command to fail with a timeout in the log:
>>
>> "Bluetooth: hci0: command 0x1003 tx timeout"
>>
>> This is because the hci event receive path (hci_uart_tty_receive ->
>> h4_recv) requires HCI_UART_REGISTERED to be set in h4_recv(), while the
>> hci command transmit path (hci_uart_send_frame -> h4_enqueue) only
>> requires HCI_UART_PROTO_INIT to be set in hci_uart_send_frame().
>>
>> The check for HCI_UART_REGISTERED was originally added in commit
>> c2578202919a ("Bluetooth: Fix H4 crash from incoming UART packets")
>> to fix a crash caused by hu->hdev being null dereferenced. That can no
>> longer happen: once HCI_UART_PROTO_INIT is set in hci_uart_register_dev()
>> all pointers (hu, hu->priv and hu->hdev) are valid, and
>> hci_uart_tty_receive() already calls h4_recv() on HCI_UART_PROTO_INIT
>> or HCI_UART_PROTO_READY.
>>
>> Remove the check for HCI_UART_REGISTERED in h4_recv() to fix the race
>> condition.
>>
>> Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
>> ---
>>   drivers/bluetooth/hci_h4.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
>> index ec017df8572c..1e9e2cad9ddf 100644
>> --- a/drivers/bluetooth/hci_h4.c
>> +++ b/drivers/bluetooth/hci_h4.c
>> @@ -109,9 +109,6 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
>>   {
>>          struct h4_struct *h4 = hu->priv;
>>
>> -       if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>> -               return -EUNATCH;
>> -
>>          h4->rx_skb = h4_recv_buf(hu, h4->rx_skb, data, count,
>>                                   h4_recv_pkts, ARRAY_SIZE(h4_recv_pkts));
>>          if (IS_ERR(h4->rx_skb)) {
>>
>> ---
> 
> There is some interesting comments on:
> 
> https://sashiko.dev/#/patchset/20260320-hci-init-fix-v1-1-e1960a41baf2%40axis.com

I see. Yeah there seem to be some valid comments:

> If hci_register_dev() fails, the error path calls hu->proto->close(hu)
> which frees the protocol-private data in hu->priv and sets it to NULL.
> However, the error path fails to clear the HCI_UART_PROTO_INIT flag.

I think regardless of this patch it makes sense to clear 
HCI_UART_PROTO_INIT if hci_register_dev() fails, since we're no longer 
in the initializing state. It becomes more important with this patch 
since it will lead to a null pointer dereference if h4_recv() is called 
after hci_register_dev() fails.

> Additionally, since hci_uart_register_dev() is called without holding the
> write-side of hu->proto_lock, can concurrent incoming UART data during
> the failure window trigger a use-after-free while hu->priv is actively
> being freed by h4_close()?

I believe adding a write lock and clearing the bit would solve these issues:

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 2b28515de92c..5455990ab211 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -692,6 +692,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)

  	if (hci_register_dev(hdev) < 0) {
  		BT_ERR("Can't register HCI device");
+		percpu_down_write(&hu->proto_lock);
+		clear_bit(HCI_UART_PROTO_INIT, &hu->flags);
+		percpu_up_write(&hu->proto_lock);
  		hu->proto->close(hu);
  		hu->hdev = NULL;
  		hci_free_dev(hdev);


> It seems the issues pointed out there are unrelated to this change,
> but I guess it is worth double checking just in case.

I think it's best to fix it before applying this change as it can cause 
null pointer dereference in error path. I can send a new patchset with 
the fix.


-- 
Best regards, Jonathan
