Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/5]bluetooth:hci_bcsp Fix operation on
 'bcsp->msgq_txseq' may be undefined
From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To: David Howells <dhowells@redhat.com>
Cc: "Justin P. Mattock" <justinmattock@gmail.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, lenb@kernel.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <7323.1277729576@redhat.com>
References: <1277621246-10960-6-git-send-email-justinmattock@gmail.com>
	 <1277621246-10960-1-git-send-email-justinmattock@gmail.com>
	 <7323.1277729576@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Jun 2010 15:02:38 +0200
Message-ID: <1277730158.3831.17.camel@thorin>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-06-28 at 13:52 +0100, David Howells wrote:
> Justin P. Mattock <justinmattock@gmail.com> wrote:
> 
> > -		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq);
> > -		bcsp->msgq_txseq = ++(bcsp->msgq_txseq) & 0x07;
> > +		BT_DBG("Sending packet with seqno %u", bcsp->msgq_txseq | ret);
> > +		ret = ++(bcsp->msgq_txseq) & 0x07;
> 
> I don't know what you're trying to do here, but you seem to be trying to send
> the computed value back in time.
> 
> The problem is that the compiler is confused about why a '++' operator makes

It's even worse as that expression is explicitly undefined (and should
be fixed anyways and unconditionally).

> any sense here.  It doesn't.  It should be a '+ 1' instead.  I think what you
> want is:
> 
> 	-	bcsp->msgq_txseq = ++(bcsp->msgq_txseq) & 0x07;
> 	+	bcsp->msgq_txseq = (bcsp->msgq_txseq + 1) & 0x07;

Yes, that's looks like the most probable intention of it - at least for
one who doesn't know the bluetooth code.

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

