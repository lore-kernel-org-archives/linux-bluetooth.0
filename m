Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E062270EBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 20:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032391; cv=none; b=DyHRoDMagXqR/0freqcaDfXO1LL0O1Rz7pLw5nrawzsM3H+uOUxPH7LnLVDqz/et0bJZw9GoXnPO3OAGMzQB1o13jcf7MUVxtAs9SyrJAM+4PKvLOiMi4jli0wizZhhpdqXqnH7DxIao3+WjDDzxa2r3jqmjRlveM/vhjypuPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032391; c=relaxed/simple;
	bh=BvmLs+O+SFUFsmpu8EC1cxF9C5CQ5vOL3ym53f8I0bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAlhsp+ZW2yLAlqB8i0sLdyRLObWrDYsfLjtpusfciuwB5TWk88x0m7eNpM71dUbNkRjQLzePrG2JQXNb5PZ/iq1QZ49fy6jbRU2vepYfEAanNRVEIgWCHHgYa3QIZopjP/prqG3Fd/mL/JZoKb6T+XlIfmzYVGi8x7cSczUzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af16d.dynamic.kabel-deutschland.de [95.90.241.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E086561E647BA;
	Tue, 12 Aug 2025 22:59:42 +0200 (CEST)
Message-ID: <b011421a-cd9a-4dc9-a252-b4537654971d@molgen.mpg.de>
Date: Tue, 12 Aug 2025 22:59:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_conn: Make unacked packet handling
 more robust
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250812195323.1522605-1-luiz.dentz@gmail.com>
 <20250812195323.1522605-3-luiz.dentz@gmail.com>
 <a5a68086-adad-416a-b276-ab03fa53bea1@molgen.mpg.de>
 <CABBYNZ+P39Sgsc+7HZVbN+PuWB=4wEs-ga3bN8n7q52YwtyEPQ@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CABBYNZ+P39Sgsc+7HZVbN+PuWB=4wEs-ga3bN8n7q52YwtyEPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Am 12.08.25 um 22:29 schrieb Luiz Augusto von Dentz:

> On Tue, Aug 12, 2025 at 4:03 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 12.08.25 um 21:53 schrieb Luiz Augusto von Dentz:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This attempts to make unacked packet handling more robust by detecting
>>> if there are no connections left then restore all buffers of the
>>> respective pool.
>>
>> Did you find this in code review, or was a bug reported?
> 
> Internal testing has run into a problem where some packets are never
> TX for some reason, we are still accessing if this is going to help
> but it is not an actual fix and more of a way to improve the handling
> of unacked packets.
> 
> Now I'm curious, why this sort of question seem to be recurring, we do
> encourage as much details as possible, but I don't think we ever said
> that it is required to disclose what sort of test or bug report it
> came from, especially if they come from internal testing which cannot
> be referenced anyway, so was there anything unclear with the commit
> message?

Kind of:

1.  “attempt” sounds to me like, that you tried to fix something, but 
are not actually sure.

2.  In the end, the devices need to work, so knowing how to verify a fix 
– myself for example – is always helpful in my opinion, so I often ask 
for reproducers and tests.

>>> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>> ---
>>>    net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
>>>    1 file changed, 28 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index e6cea51b3eab..4bd2e4cd477f 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -1152,22 +1152,44 @@ void hci_conn_del(struct hci_conn *conn)
>>>        disable_delayed_work_sync(&conn->auto_accept_work);
>>>        disable_delayed_work_sync(&conn->idle_work);
>>>
>>> -     /* Handle unnacked frames */
>>> +     /* Handle unnacked frames:
>>> +      *
>>> +      * - In case there are no connection restore all buffers to the pool
>>> +      * - Otherwise restore just the buffers considered in transit for the
>>> +      *   hci_conn
>>> +      */
>>>        switch (conn->type) {
>>>        case ACL_LINK:
>>> -             hdev->acl_cnt += conn->sent;
>>> +             if (!hci_conn_num(hdev, ACL_LINK))
>>> +                     hdev->acl_cnt = hdev->acl_pkts;
>>> +             else
>>> +                     hdev->acl_cnt += conn->sent;
>>>                break;
>>>        case LE_LINK:
>>>                cancel_delayed_work(&conn->le_conn_timeout);
>>>
>>> -             if (hdev->le_pkts)
>>> -                     hdev->le_cnt += conn->sent;
>>> -             else
>>> -                     hdev->acl_cnt += conn->sent;
>>> +             if (hdev->le_pkts) {
>>> +                     if (!hci_conn_num(hdev, LE_LINK))
>>> +                             hdev->le_cnt = hdev->le_pkts;
>>> +                     else
>>> +                             hdev->le_cnt += conn->sent;
>>> +             } else {
>>> +                     if (!hci_conn_num(hdev, LE_LINK) &&
>>> +                         !hci_conn_num(hdev, ACL_LINK))
>>> +                             hdev->acl_cnt = hdev->acl_pkts;
>>> +                     else
>>> +                             hdev->acl_cnt += conn->sent;
>>> +             }
>>>                break;
>>>        case CIS_LINK:
>>>        case BIS_LINK:
>>>        case PA_LINK:
>>> +             if (!hci_conn_num(hdev, CIS_LINK) &&
>>> +                 !hci_conn_num(hdev, BIS_LINK) &&
>>> +                 !hci_conn_num(hdev, PA_LINK))
>>> +                     hdev->iso_cnt = hdev->iso_pkts;
>>> +             else
>>> +                     hdev->iso_cnt += conn->sent;
>>>                hdev->iso_cnt += conn->sent;
>>>                break;
>>>        }

Kind regards,

Paul
