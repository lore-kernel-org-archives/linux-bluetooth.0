Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Jun 2010 13:10:24 -0700 (PDT)
Message-Id: <20100630.131024.190380261.davem@davemloft.net>
To: gustavo@padovan.org
Cc: dhowells@redhat.com, linux-bluetooth@vger.kernel.org,
	justinmattock@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix abuse of the preincrement operator
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100628131058.GA25275@vigoh>
References: <1277621246-10960-6-git-send-email-justinmattock@gmail.com>
	<20100628125752.8945.50572.stgit@warthog.procyon.org.uk>
	<20100628131058.GA25275@vigoh>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <gustavo@padovan.org>
Date: Mon, 28 Jun 2010 10:12:30 -0300

> Hi David,
> 
> * David Howells <dhowells@redhat.com> [2010-06-28 13:57:52 +0100]:
> 
>> Fix abuse of the preincrement operator as detected when building with gcc
>> 4.6.0:
>> 
>> 	 CC [M]  drivers/bluetooth/hci_bcsp.o
>> 	drivers/bluetooth/hci_bcsp.c: In function 'bcsp_prepare_pkt':
>> 	drivers/bluetooth/hci_bcsp.c:247:20: warning: operation on 'bcsp->msgq_txseq' may be undefined
>> 
>> Reported-by: Justin P. Mattock <justinmattock@gmail.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
...
> Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

Applied, thanks everyone.
