Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35468280335
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010335; cv=pass; b=C3RCRvH9IYIrQ0EBkHE67MDMgjF981LRNYXX3V5epMrkrf1BySD3+EAIuuYDqPX0tTZ7gat9zHbaTcjTISsozdPr55IuC93vLDBujSUCGRfwhE62NnARrjuiPTuLWeVskLLE4YvwxkpqfzCQWgXoSzcd8RYZUnUEjhdP/iIIRgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010335; c=relaxed/simple;
	bh=gwbqwIzATi+Vaz/dyTwj8HNBfXmVh1OzDfFL/kVnwk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3M/Wc6BezSSBAzRjg5VC8oPF3mtoTHyxAfVoOZTaoCaRmnpXrcvZlrCMx6Fu2eF9IRrRz328gnat0jRrp8kMTlXBqrZt9+TFhqIQVxZREkuWdJI1y9rR9st4/5yjjHhtKFqSs/jYUzOnwX5oMvmUyxHuFrqEnHsHx3mGIQH/pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=aWLeC76Z; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="aWLeC76Z"
ARC-Seal: i=1; a=rsa-sha256; t=1755010330; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g1D30IS77TXvRuw62kpET7Fuqs7AsbbdAn1W63AryrCQkhs7fgC8fuV3UW4Hfha+3V/wdeLF9FdtrTm3E3vvDGnOd/spEgi1z/X4Kn+uJUHxIgEQ1DlPkDPuF4+kypzPZDLx/xAqfUxsoIF2Nw48Xm/nA4cgPLAm75joEV02aes=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755010330; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hG6WM1GFTR/kY9YIzdOuWXguOWK07HtUhps6xngebXA=; 
	b=ExUPlTLi6RZk76O1mnuGiOfP1PNUHA4Wsq3bLZ7BBMXPEMyuMSj0sZDgzEJE7lE4HJCwlhUw/s1YOJB79tucx3PxhA7pzWZhDaOYLpZ+HpSAXF57r2+Ozi/I8uvPCfD3KuS7LzN/Cl5NOOKKpP5vdwzRkcpmrs1610Myev0l/d4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755010330;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hG6WM1GFTR/kY9YIzdOuWXguOWK07HtUhps6xngebXA=;
	b=aWLeC76ZV9sAyROquO6AP4+6ptqKvtrjgqN19qb6QVra6zLofciX/dWB21Pu9kS4
	WbPT+ZnlBiC6YmkK3SjUwb3E7ojUKqUMNxEodOQMFzUkHr9Lpl03u/+eXZRGZvGnIbb
	H3ijg3cnrOhMjxB9PnIV5YdtpjkSDE7KjAM9diic=
Received: by mx.zohomail.com with SMTPS id 1755010327094858.4292651302959;
	Tue, 12 Aug 2025 07:52:07 -0700 (PDT)
Message-ID: <db56537a-418f-409e-8d71-1bb02ed1c7a9@collabora.com>
Date: Tue, 12 Aug 2025 16:52:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Bluetooth: hci_event: Mark connection as closed
 during suspend disconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250812141028.509783-1-ludovico.denittis@collabora.com>
 <20250812141028.509783-3-ludovico.denittis@collabora.com>
 <CABBYNZKTYrYmd_C36GU2xZ6YEr1cQGsrpke1mYuz3K3QDhzw6Q@mail.gmail.com>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <CABBYNZKTYrYmd_C36GU2xZ6YEr1cQGsrpke1mYuz3K3QDhzw6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 8/12/25 4:41 PM, Luiz Augusto von Dentz wrote:
> Hi Ludovico,
>
> On Tue, Aug 12, 2025 at 10:26 AM Ludovico de Nittis
> <ludovico.denittis@collabora.com> wrote:
>> When suspending, the disconnect command for an active Bluetooth
>> connection could be issued, but the corresponding
>> `HCI_EV_DISCONN_COMPLETE` event might not be received before the system
>> completes the suspend process. This can lead to an inconsistent state.
>>
>> On resume, the controller may auto-accept reconnections from the same
>> device (due to suspend event filters), but these new connections are
>> rejected by the kernel which still has connection objects from before
>> suspend. Resulting in errors like:
>> ```
>> kernel: Bluetooth: hci0: ACL packet for unknown connection handle 1
>> kernel: Bluetooth: hci0: Ignoring HCI_Connection_Complete for existing
>> connection
>> ```
>>
>> This is a btmon snippet that shows the issue:
>> ```
>> < HCI Command: Disconnect (0x01|0x0006) plen 3
>>          Handle: 1 Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)
>>          Reason: Remote User Terminated Connection (0x13)
>>> HCI Event: Command Status (0x0f) plen 4
>>        Disconnect (0x01|0x0006) ncmd 2
>>          Status: Success (0x00)
>> [...]
>> // Host suspends with the event filter set for the device
>> // On resume, the device tries to reconnect with a new handle
>>
>>> HCI Event: Connect Complete (0x03) plen 11
>>          Status: Success (0x00)
>>          Handle: 2
>>          Address: 78:20:A5:4A:DF:28 (Nintendo Co.,Ltd)
>>
>> // Kernel ignores this event because there is an existing connection with
>> // handle 1
>> ```
>>
>> By explicitly setting the connection state to BT_CLOSED we can ensure a
>> consistent state, even if we don't receive the disconnect complete event
>> in time.
>>
>> Link: https://github.com/bluez/bluez/issues/1226
>> Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
>> ---
>>   net/bluetooth/hci_event.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index 6c67dfa13..81c9fc774 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2718,6 +2718,11 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
>>                  goto done;
>>          }
>>
>> +       /* During suspend, mark connection as closed immediately
>> +        * since we might not receive HCI_EV_DISCONN_COMPLETE
>> +        */
> Hmm, the comments suggests that this shall be done only for suspend
> case though, should we be checking for hdev->suspended?

Yes, good point. Initially I didn't do an explicit check because we 
already had:
```
     if (!status && !hdev->suspended)
         return;
[...]
     if (status) {
         [...]
         goto done;
     }
```

But by changing the second `if` to exclude `HCI_ERROR_UNKNOWN_CONN_ID`, 
now there is
one case where it's not implicit the fact that we are in suspend mode.
Let me send a v2 with that change.

>> +       conn->state = BT_CLOSED;
>> +
>>          mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
>>
>>          if (conn->type == ACL_LINK) {
>> --
>> 2.50.1
>>
>>
>

