Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems while sending and receiving with rfcomm
	sockects
From: Marcel Holtmann <marcel@holtmann.org>
To: "Collin R. Mulliner" <collin@betaversion.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040601145616.3419c335@coredump>
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
	 <1086093267.4702.20.camel@pegasus>  <20040601145616.3419c335@coredump>
Content-Type: text/plain
Message-Id: <1086100267.4702.23.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 01 Jun 2004 16:31:07 +0200

Hi Collin,

> > I never used RFCOMM in a multi-threaded program. Actually I avoid to
> > use threads wherever possible. However sending and receiving at the
> > same time should work. Maybe there is a kernel bug, what version do
> > you use?
> 
> I allways thought one should ONLY use a socket within a single thread
> at the same time. I write my programs in that way that I never call
> read() and write() on a specific socket at the "same time" also I
> only access each socket within a single thread.

this is why we have select() and poll().

> Somehting else: I need a UUID for my application - any hints on where to
> find some information/instructions?

You must create a UUID-128. There was note in the specification about
that, but I can't remember it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
