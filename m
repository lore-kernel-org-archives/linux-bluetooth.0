Return-Path: <cyrus@holtmann.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1277621246-10960-6-git-send-email-justinmattock@gmail.com>
References: <1277621246-10960-6-git-send-email-justinmattock@gmail.com> <1277621246-10960-1-git-send-email-justinmattock@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org,
	sds@tycho.nsa.gov, lenb@kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5]bluetooth:hci_bcsp Fix operation on 'bcsp->msgq_txseq' may be undefined
Date: Mon, 28 Jun 2010 13:52:56 +0100
Message-ID: <7323.1277729576@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Justin P. Mattock <justinmattock@gmail.com> wrote:

> -		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq);
> -		bcsp->msgq_txseq = ++(bcsp->msgq_txseq) & 0x07;
> +		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq | ret);
> +		ret = ++(bcsp->msgq_txseq) & 0x07;

I don't know what you're trying to do here, but you seem to be trying to send
the computed value back in time.

The problem is that the compiler is confused about why a '++' operator makes
any sense here.  It doesn't.  It should be a '+ 1' instead.  I think what you
want is:

	-	bcsp->msgq_txseq = ++(bcsp->msgq_txseq) & 0x07;
	+	bcsp->msgq_txseq = (bcsp->msgq_txseq + 1) & 0x07;

David
