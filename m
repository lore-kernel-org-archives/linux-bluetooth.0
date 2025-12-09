Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64112FDC21
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281593; cv=none; b=G1QpUfWq5tqtkaL0yFAYMOSbXHDjSoYBBpSgYnOUCveKruhxOtHdj9wIfCBEoDZeu/w0sYpn5mwMD7KYKxgmyBYORFDM0etZ6CNvfCF53Q9pZOUq9AQrUauZ6d0jNF3h+u4o1m6by6xEDYjRqI1+9XsrSdK0owYtfqD1R+Pd8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281593; c=relaxed/simple;
	bh=032D9VvLUgl8YpxTVBVp2NhLvEAxxRjHA7Are7Xu6QU=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=PPWuqKXWthQXnIBVJY3AqM8v5SqlGaob30V3jWRekpV6IVP2H/BevdQHtZH6C+G2Wd4HPJcQw4dGgUqoE+ss0rrKFzhO39HVVrn3PoQoxeciH4T4KTHS/tfdSnOoYXHZottgGqbrM4UhQ8p7hpcJv6TQtWwHTDoLl+zbDqJvXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dQcpp1jXTz5BNRd;
	Tue, 09 Dec 2025 19:59:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5B9BxV88080630;
	Tue, 9 Dec 2025 19:59:31 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Dec 2025 19:59:34 +0800 (CST)
Date: Tue, 9 Dec 2025 19:59:34 +0800 (CST)
X-Zmail-TransId: 2af969380f26023-c4694
X-Mailer: Zmail v1.0
Message-ID: <20251209195934117dOZMagBKlAEelaDzehffA@zte.com.cn>
In-Reply-To: <069caee5-1169-4ae3-a501-d873cb4ed0bb@molgen.mpg.de>
References: 20251208203404000bLAos3jnZFMsLDRmqZb_S@zte.com.cn,069caee5-1169-4ae3-a501-d873cb4ed0bb@molgen.mpg.de
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <pmenzel@molgen.mpg.de>
Cc: <marcel@holtmann.org>, <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <chen.junlin@zte.com.cn>, <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgMi8yXSBCbHVldG9vdGg6IGhjaV9jb25uOiBmaXggV0FSTklORyBpbiBoY2lfY29ubl90aW1lb3V0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5B9BxV88080630
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 09 Dec 2025 19:59:46 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69380F32.000/4dQcpp1jXTz5BNRd

Thank you for your feedback.

>> From: Qiu Yutan <qiu.yutan@zte.com.cn>
>> 
>> The warning is triggered when conn->refcnt is decremented to a negative value.
>
>Please past the warning (no line wrapping for pastes required).
>

The monthly penetration testing results for this issue from Google are available 
at the following link:
https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907

>> Since atomic_dec_if_positive(&conn->refcnt) only decrements the value by 1
>> when conn->refcnt is positive, the resulting value will be greater than or equal to zero,
>> preventing this warning from reoccurring.
>
>Please re-flow for 75 characters per line.
>

I'll submit a patch v2 to fix these formatting issues.

>> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
>> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>
>Please start the names with a capital letter.
>
>> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
>> ---
>>   include/net/bluetooth/hci_core.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index 5e01e6c501c1..2b306115add4 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -1635,7 +1635,7 @@ static inline void hci_conn_drop(struct hci_conn *conn)
>>       trace_hci_conn_drop(conn);
>>       BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
>> 
>> -    if (atomic_dec_and_test(&conn->refcnt)) {
>> +    if (atomic_dec_if_positive(&conn->refcnt) == 0) {
>>           unsigned long timeo;
>> 
>>           switch (conn->type) {
>
>This patch looks unrelated from the trace point patch. Could you send it 
>in separately? Also, why did you mark it as RFC?

The trace point patch aims to better reproduce and resolve the 
"WARNING in hci_conn_timeout" issue. 

Actually, the purpose of this patch series is primarily to address the WARNING in 
hci_conn_timeout issue, while also initiating a discussion on the asymmetric i
ncrement/decrement operations of conn->refcnt exposed therein.

Please refer to the cover-letter description for details.

Sincerely,

Qiu Yutan
