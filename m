Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] RFCOMM service level security testing
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4189272C.4080306@csr.com>
References: <1099151759.16247.18.camel@pegasus>
	 <1099433039.7125.13.camel@pegasus>
	 <1099495689.3265.44.camel@baroque.rococosoft.com>
	 <1099496238.6330.2.camel@notepaq>
	 <1099497364.3261.64.camel@baroque.rococosoft.com>
	 <41890BFF.8040501@csr.com> <1099504367.7125.131.camel@pegasus>
	 <4189272C.4080306@csr.com>
Content-Type: text/plain
Message-Id: <1099508519.7125.153.camel@pegasus>
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
Date: Wed, 03 Nov 2004 20:01:59 +0100

Hi Steven,

> > do you know any document that explicit requires it? Maybe SIM Access?
> 
> Not offhand, but I would have thought it was implicit in the security
> model.
> 
> Not many systems have to worry about running profiles whilst
> simultaneously allowing direct access to HCI.
> 
> Of course, even for systems that don't allow access to HCI, they still
> have to worry about the other side disabling encryption.

I have to check that, because I can't remember that I read something
like that somewhere. Maybe it is possible that nobody thought about this
before. I only realized that problem when I implemented the security
hooks in the BlueZ core.

> > I heard rumors that encryption costs more CPU and so consumes more
> > power. Is this still true with modern chips or can we ignore this?
> 
> I'd be surprised if this has ever been true to a significant level.
> 
> The encryption engine used in Bluetooth is quite lightweight if
> implemented in hardware. I can't imagine that anyone has implemented it
> in software (not least because the encryption stream used depends on the
> time at which the packet is transmitted - retransmits use a different
> obscuring stream).
> 
> Compared to the power the rest of the system is taking (most notably,
> the radio), the encryption is negligible.
> 
> It's reasonable to work on a model that encryption is free. In which
> case the question is, is there any reason encryption shouldn't be turned
> on as early as possible (as soon as authentication completes)?

Thanks for this clarification. So automatically dropping the encryption
is not an option that we will support. You need to do this by your own
with a HCI command.

If anyone has measured this for some reason, I like to see the data or
the report with the end result.

> > This is a good point, but I think I will explicit have this fine gain
> > control. However it is enough to set the *_ENCRYPT flag for example and
> > the authentication will be triggered always first.
> 
> Strictly speaking, it's impossible to enable encryption at the baseband
> level without first having authenticated (though only one side needs to
> have initiated authentication).
> 
> There's a strong argument, however, for having just one combined flag
> that requests both authentication and encryption. Fewer flags means
> less complexity.
> 
> The problem with having separate flags is that someone might think "oh,
> I don't care if anyone snoops on this data, I just want to make sure I
> get requests only from trusted devices". In that case they might request
> only authentication and not encryption. Unfortunately, this is not
> enough to prevent session hijacking.
> 
> By having just one flag, you remove the possibility that anyone could
> chose an inappropriate setting. They'll just have two options: secure
> and insecure.

I think of following your advice, but still having a *_ENCRYPT and
*_AUTH flag. If one of this flags is set, the authentication and also
the encryption will be requested. But only when the *_ENCRYPT flag is
set, the connection will be dropped when the encryption is disabled.
Does this makes sense or should we simply introduce another flag that is
named for example *_SECURE. I haven't made any decision so far and any
feedback and comments are welcome.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
