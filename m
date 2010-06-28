Return-Path: <cyrus@holtmann.org>
Message-ID: <4C28E23B.7020406@gmail.com>
Date: Mon, 28 Jun 2010 10:56:11 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, lenb@kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5]bluetooth:hci_bcsp Fix operation on 'bcsp->msgq_txseq'
 may be undefined
References: <1277621246-10960-6-git-send-email-justinmattock@gmail.com> <1277621246-10960-1-git-send-email-justinmattock@gmail.com> <7323.1277729576@redhat.com>
In-Reply-To: <7323.1277729576@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/28/2010 05:52 AM, David Howells wrote:
> Justin P. Mattock<justinmattock@gmail.com>  wrote:
>
>> -		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq);
>> -		bcsp->msgq_txseq = ++(bcsp->msgq_txseq)&  0x07;
>> +		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq | ret);
>> +		ret = ++(bcsp->msgq_txseq)&  0x07;
>
> I don't know what you're trying to do here, but you seem to be trying to send
> the computed value back in time.
>

I was under the impression that hdr[0] |= 0x80 + bcsp->msgq_txseq;
is computing a value for BT_DBG then ret = ++(bcsp->msgq_txseq)&  0x07
computes a value as well i.e.

BT_DBG("Sending packet with seqno %u", hdr[0] | ret);

> The problem is that the compiler is confused about why a '++' operator makes
> any sense here.  It doesn't.  It should be a '+ 1' instead.  I think what you
> want is:
>
> 	-	bcsp->msgq_txseq = ++(bcsp->msgq_txseq)&  0x07;
> 	+	bcsp->msgq_txseq = (bcsp->msgq_txseq + 1)&  0x07;
>
> David
>

yeah I did play around with the ++ and noticed the compiler would be 
satisfied if the ++ was not there, but didn't think to just add a + 1

Justin P. Mattock
