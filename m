Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445792ED15C
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025500; cv=pass; b=gw1QZ1v0CKuAYVI3sDRqswiB+8w4UQXA8Ei8Iq6QrsB7M1iV95AoYn/JOvMPVzCbsw6fU4QRt6vIh6q7ppC8bcje/a7gLEgHHD2DbXYO1knrD0/ohrd+l+LSxqpSM55BXUau1No8nMiJqUf7fQryAsliAoG4b91DS/ltNg4d3wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025500; c=relaxed/simple;
	bh=l45Efr801OCaGWkdA4pbRIc6bqt0gFaTpCZ8A4Phd38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/pY8pXWF9IMu+K88N6W6KZ/BR0YjYNSFN0xYEE46JUdSwNDUKGcroAKD5X186gSqKBJLeQOI9c+kFBinTpjHTa5SuQI35fBJEog4J1inS7TqLivfg9WWCVXG5pxpTZl22SGyGdjSmAHtCLDtbd2zrNq0sbz3wAlL4qkiPvSiPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=YRcwxzJs; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="YRcwxzJs"
ARC-Seal: i=1; a=rsa-sha256; t=1760025494; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P6EAQK+F3dmKV4zmz3Z5++Fn/K+/PATWMS5w7pyWXIohSC+5mXsLObe6kiyUVnqUzdQvDDsXut/QzXDE4XrPSXFK5pGS0sOj5D49ZuWFAMwKawo7FYkGWfkHH9d7LP3YEX3qgVEX4kyetZRFHkCrlv1dZVn/eT7RdyBbomDg4vA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760025494; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sr9BvipH10qAjWy7UhGw3G84jz2wi3yN6qQyFSDevqw=; 
	b=jP1rwcLBkmcrg5Zr0vQUFGs1wI/5JGw9A0DfOJUGtoJm/UCFfvG1N66IXB7mIpOb97uDyJ3pqQNiK+nTBLndzByPoYTUw+TJMl92G6LqlikKKYdDqs/fTX0oP1HnbPw56XkinZnI5mxfujcuDzenG0TR9hNZ/dszfuOl1HYhJow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760025494;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sr9BvipH10qAjWy7UhGw3G84jz2wi3yN6qQyFSDevqw=;
	b=YRcwxzJs3YJZt8A+GwVEWRfDocjDoBDdALjb6qZo32VTdVsw/Scrmjf7fg0UYg8n
	jwjklUtaUC4TmEtWAg8LZlHYB+7yNJx4cxvuRuIBfHP6NUxycfdgKOqZMAW+KdMaNnx
	jhCFAREpsbyz5EpHMVyXu5HuV48PMOIKeJ025oAA=
Received: by mx.zohomail.com with SMTPS id 1760025492578213.1716743414372;
	Thu, 9 Oct 2025 08:58:12 -0700 (PDT)
Message-ID: <7c9a5707-af06-4540-8add-fc2901fac610@collabora.com>
Date: Thu, 9 Oct 2025 17:58:08 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] gobex: Fix abort for SRM operation
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20251009071159.359476-1-frederic.danis@collabora.com>
 <CABBYNZJo4z67N4RbNAgfdMpJ1swQt3360ytCTddkzBhHrMzxrA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJo4z67N4RbNAgfdMpJ1swQt3360ytCTddkzBhHrMzxrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 09/10/2025 17:53, Luiz Augusto von Dentz wrote:
> Hi Frederic,
>
> On Thu, Oct 9, 2025 at 3:13 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> The OBEX Abort operation currently triggers an OBEX session
>> which prevents further OBEX operations:
>>
>> obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
>>                 0x50e000001380 registered
>>                 /org/bluez/obex/client/session0/transfer0
>> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>>                 ref=3
>> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>>                 ref=4
>> obexd[327475]: obexd/client/session.c:session_process_transfer()
>>                 Transfer(0x50e000001380) started
>> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>>                 ref=3
>> obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by user
>> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>>                 ref=4
>> obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
>>                 0x50e000001380 unregistered
>>                 /org/bluez/obex/client/session0/transfer0
>> obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001380
>> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>>                 ref=3
>> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>>                 ref=2
>> obexd[327475]: Unknown header offset for opcode 0x10
>> obexd[327475]: obexd/client/session.c:obc_session_shutdown()
>>                 0x50c0000010c0
>> obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
>>                 ref=3
>> obexd[327475]: obexd/client/pbap.c:pbap_remove()
>>                 /org/bluez/obex/client/session0
>> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>>                 ref=2
>> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>>                 ref=1
>> obexd[327475]: obexd/client/session.c:session_unregistered()
>>                 Session(0x50c0000010c0) unregistered
>>                 /org/bluez/obex/client/session0
>> obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:
>>                 ref=0
>>
>> As its highest bit is always set to 1, and so its value located after
>> G_OBEX_RSP_CONTINUE, the G_OBEX_OP_ABORT is part of the operations
>> constants.
>>
>> This has been tested for PBAP and BIP-AVRCP with Android 15 and 16.
>> ---
>>   gobex/gobex.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gobex/gobex.c b/gobex/gobex.c
>> index 0e33ececf..df80d79f3 100644
>> --- a/gobex/gobex.c
>> +++ b/gobex/gobex.c
>> @@ -382,7 +382,7 @@ static void check_srm_final(GObex *obex, guint8 op)
>>          case G_OBEX_OP_CONNECT:
>>                  return;
>>          default:
>> -               if (op <= G_OBEX_RSP_CONTINUE)
>> +               if (op <= G_OBEX_RSP_CONTINUE || op == G_OBEX_OP_ABORT)
> Let's move it to a case statement as it was done with G_OBEX_OP_CONNECT.
The case for G_OBEX_OP_CONNECT is switched from obex->srm->op, while the 
test for G_OBEX_OP_ABORT is done on the op function parameter.
I don't think it's useful to create a switch here.
>
>>                          return;
>>          }
>>
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

