Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75863C6BA
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Apr 2025 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491999; cv=pass; b=G3Ki3MHiLEEsFrOghvlNqrC/Qm7Uq7QsvgtthZ+Gf6w5ckHhQhKOcAo6qheyax07dtzcSdbToShxF4S3BnzTfa8YKUKBK8TmIC796CUXH6xj65Q6egUqx6bHRTV3o+yHlczeHWZ1EbSXU1hGa2E7uJrewVsmGxFTrPauiZ1Oz/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491999; c=relaxed/simple;
	bh=PJBBVOGCESE95XB6OhwdiHBoVM2CLjrNM3bFd4YA500=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXmnQ2zReJ9LdIaASUfafhvxIUpkpJJkbkhTH9IbIS0PZlNlfkUEzbzkafQqcvW83AaHozPndhhtRSeDkpEhK/FUNedyLCjwGgwG7OgqEERfUQQmz6gbNKzG2CVs25fgYqAZgno2vMojfC2U49ecltLximm5Cel/0BMd8wsM4IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=MAGE2eYQ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="MAGE2eYQ"
ARC-Seal: i=1; a=rsa-sha256; t=1743491989; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b6vR8FqoHzGPOM1jWBUsy4x0GtDVh9B0rbPc7MY+PS1q1ki3uwoG+Ksz7AYPLh1YLbVQKH/O1Eyu5+pof6CxreuAbrxPYjjMkGfU925cdBvlO/3P5MOE7VoX44CFxdkyxnjqd1UUvMV9sU4cN9PLAq6sr2ltFB949oLi4VKenjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743491989; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tKTrkidLbdqaMxSHX408fierNwI3mNWPtr3BplR78Mo=; 
	b=cdSr8BL3tvTy+FjvatpsnvksII5w+ejOcV95mxGb1fvBTSAUSJkN38235r9kvCF9WMvGhBIBdureLllMSHlWhgfyeXmEhyOkU9FmMrRZxO0d3I8Nc7BnLLj9szpfxpsiQGmSKv4Q0p8006OEQ7w1zRVMvqtgDUIcC7iF7LCzDz4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743491989;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tKTrkidLbdqaMxSHX408fierNwI3mNWPtr3BplR78Mo=;
	b=MAGE2eYQjs/Fs79Tox/3MyDQtFj3ITVwN9gzXwq3LO9d0fqb/Ws0N1ljZz9N6MK7
	2n5WgHFLOpVyTLxYkk/jvlSgxPkK4ihyxfz/Tt/NBmkrCuCdVV+Sat7hz5PINTihSFA
	Lu3MhwCGRjCjU+UGN/XZdI7MnLpfK5jWQrF6FpBQ=
Received: by mx.zohomail.com with SMTPS id 1743491987523928.053449160281;
	Tue, 1 Apr 2025 00:19:47 -0700 (PDT)
Message-ID: <7a7dd576-2a77-4bef-b9ba-62d3d8e2dbe6@collabora.com>
Date: Tue, 1 Apr 2025 09:19:45 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: rfcomm: Accept any XON/XOFF char
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250331131503.63375-1-frederic.danis@collabora.com>
 <CABBYNZLDMhwzsWR9A0YWyvZxo8G3kubRubwz_DAT83ko24Gc+A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZLDMhwzsWR9A0YWyvZxo8G3kubRubwz_DAT83ko24Gc+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 31/03/2025 15:30, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Mon, Mar 31, 2025 at 9:15 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> The latest version of PTS test RFCOMM/DEVA-DEVB/RFC/BV-17-C
>> (RFCOMM v11.7.6.3) used unusual chars for XON (0x28 instead of
>> 0x11) and XOFF (0xC8 instead of 0x13) and expect a reply with RPN
>> parameters set for XON and XOFF.
>>
>> Current btmon traces:
>>> ACL Data RX: Handle 11 flags 0x02 dlen 18
>>        Channel: 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}
>>        RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>>           Address: 0x03 cr 1 dlci 0x00
>>           Control: 0xef poll/final 0
>>           Length: 10
>>           FCS: 0x70
>>           MCC Message type: Remote Port Negotiation Command CMD (0x24)
>>             Length: 8
>>             dlci 32
>>             br 3 db 3 sb 0 p 0 pt 0 xi 0 xo 0
>>             rtri 0 rtro 0 rtci 0 rtco 0 xon 40 xoff 200
>>             pm 0xff7f
>> < ACL Data TX: Handle 11 flags 0x00 dlen 18
>>        Channel: 64 len 14 [PSM 3 mode Basic (0x00)] {chan 0}
>>        RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>>           Address: 0x01 cr 0 dlci 0x00
>>           Control: 0xef poll/final 0
>>           Length: 10
>>           FCS: 0xaa
>>           MCC Message type: Remote Port Negotiation Command RSP (0x24)
>>             Length: 8
>>             dlci 32
>>             br 3 db 3 sb 0 p 0 pt 0 xi 0 xo 0
>>             rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19
>>             pm 0x3f1f
>>
>> Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
>> ---
>>   net/bluetooth/rfcomm/core.c | 20 ++++++--------------
>>   1 file changed, 6 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index ad5177e3a69b..0c0525939aa0 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -1562,23 +1562,15 @@ static int rfcomm_recv_rpn(struct rfcomm_session *s, int cr, int len, struct sk_
>>                  }
>>          }
>>
>> -       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON)) {
>> +       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XON))
>>                  xon_char = rpn->xon_char;
>> -               if (xon_char != RFCOMM_RPN_XON_CHAR) {
>> -                       BT_DBG("RPN XON char mismatch 0x%x", xon_char);
>> -                       xon_char = RFCOMM_RPN_XON_CHAR;
>> -                       rpn_mask ^= RFCOMM_RPN_PM_XON;
>> -               }
>> -       }
> So is the assumption that we don't need to check the actual character
> sent part of the spec? If it is then it is probably worth quoting it,
> otherwise I'd update the check to include both old and new chars.

Afaiu the RFCOMM and GSM 07.10 specs I would say that nothing defines 
that the XON/XOFF characters are limited to some values, but only 
defines default values for XON and XOFF (see 5.4.6.3.9 Remote Port 
Negotiation Command (RPN) in 
https://www.etsi.org/deliver/etsi_ts/101300_101399/101369/06.03.00_60/ts_101369v060300p.pdf).
I haven't found a clear "quotable" definition of this in the GSM 07.10.

On the other hand adding the characters used by PTS to the checks will 
not prevent future changes.

Any advice on this?

>> +       else
>> +               rpn_mask ^= RFCOMM_RPN_PM_XON;
>>
>> -       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF)) {
>> +       if (rpn->param_mask & cpu_to_le16(RFCOMM_RPN_PM_XOFF))
>>                  xoff_char = rpn->xoff_char;
>> -               if (xoff_char != RFCOMM_RPN_XOFF_CHAR) {
>> -                       BT_DBG("RPN XOFF char mismatch 0x%x", xoff_char);
>> -                       xoff_char = RFCOMM_RPN_XOFF_CHAR;
>> -                       rpn_mask ^= RFCOMM_RPN_PM_XOFF;
>> -               }
>> -       }
>> +       else
>> +               rpn_mask ^= RFCOMM_RPN_PM_XOFF;
>>
>>   rpn_out:
>>          rfcomm_send_rpn(s, 0, dlci, bit_rate, data_bits, stop_bits,
>> --
>> 2.43.0
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

