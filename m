Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7727BF93
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765289014; cv=none; b=NrgoUjBHTRCwORWO10B0SRSlsFOL3UqAsiDVjw0iUQR1q5meK/bvdtktqHcUuCZ9lmqfa+iY5gmFoQFTncHTx0cWklzClWh+FUNuAxkHc8rSo7CLtR1xUVoIvFu54hcRTPyT66Rn18xtVQR35FAi3J3U5MzIepxoSucUg2toKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765289014; c=relaxed/simple;
	bh=nWZ9kTJ45BWy5kGHEZ0Y9ggRawOImc1q1WgP41kOils=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nisBPhG9Mg67+iZMNkLXXiBkMXXHXWpefTN08QNJ1e9IQiyv43CjX4gCNE146IuzCbtCkx9iZEFcVRfDz1XiB88Rabvj9EpUE+SpF/mdKJsIBdhc6aanm5ef8svEHc7QVMgUp274al1MT6tGL7ju6wM0TCD+ouEIj0jtVP4MCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7406E61E647BA;
	Tue, 09 Dec 2025 15:03:18 +0100 (CET)
Message-ID: <beaf4160-49b5-4922-976b-86fa9b1714b1@molgen.mpg.de>
Date: Tue, 9 Dec 2025 15:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] Bluetooth: hci_conn: fix WARNING in hci_conn_timeout
To: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, xu.xin16@zte.com.cn,
 yang.yang29@zte.com.cn, qiu.yutan@zte.com.cn, chen.junlin@zte.com.cn,
 jiang.kun2@zte.com.cn
References: <20251209195934117dOZMagBKlAEelaDzehffA@zte.com.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251209195934117dOZMagBKlAEelaDzehffA@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Yaxin,


Thank you for your reply.

Am 09.12.25 um 12:59 schrieb wang.yaxin@zte.com.cn:

>>> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>>>
>>> The warning is triggered when conn->refcnt is decremented to a negative value.
>>
>> Please past the warning (no line wrapping for pastes required).
> 
> The monthly penetration testing results for this issue from Google are available
> at the following link:
> https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907

I’d still add the relevant excerpt and put the URL under Link: at the end.

>>> Since atomic_dec_if_positive(&conn->refcnt) only decrements the value by 1
>>> when conn->refcnt is positive, the resulting value will be greater than or equal to zero,
>>> preventing this warning from reoccurring.
>>
>> Please re-flow for 75 characters per line.
> 
> I'll submit a patch v2 to fix these formatting issues.

Awesome.

>>> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
>>> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
>>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>>
>> Please start the names with a capital letter.
>>
>>> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
>>> ---
>>>    include/net/bluetooth/hci_core.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 5e01e6c501c1..2b306115add4 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -1635,7 +1635,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
>>>        trace_hci_conn_drop(conn);
>>>        BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
>>>
>>> -    if (atomic_dec_and_test(&conn->refcnt)) {
>>> +    if (atomic_dec_if_positive(&conn->refcnt) == 0) {
>>>            unsigned long timeo;
>>>
>>>            switch (conn->type) {
>>
>> This patch looks unrelated from the trace point patch. Could you send it
>> in separately? Also, why did you mark it as RFC?
> 
> The trace point patch aims to better reproduce and resolve the
> "WARNING in hci_conn_timeout" issue.

Yes, I understood. Still both patches can be applied independently so do 
not need to be in a series, which are normally applied as a whole. I’d 
send it in as separate patches and at least this one without RFC tag.

> Actually, the purpose of this patch series is primarily to address the WARNING in
> hci_conn_timeout issue, while also initiating a discussion on the asymmetric i
> ncrement/decrement operations of conn->refcnt exposed therein.
> 
> Please refer to the cover-letter description for details.

Indeed. Sorry, I missed this. I believe in the Bluetooth subsystem the 
patches are cherry-picked and the cover letter is lost. It’d be great if 
you added the relevant information to the commit message.

But, I am not the maintainer. Luiz is the authority.


Kind regards,

Paul
