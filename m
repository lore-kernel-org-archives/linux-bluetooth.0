Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: David Hughes <dahhorn@gmail.com>
Message-ID: <loom.20041115T183351-61@post.gmane.org>
References: <1099151759.16247.18.camel@pegasus>  <1099433039.7125.13.camel@pegasus>  <1099495689.3265.44.camel@baroque.rococosoft.com>  <1099496238.6330.2.camel@notepaq>  <1099497364.3261.64.camel@baroque.rococosoft.com>  <41890BFF.8040501@csr.com> <1099504367.7125.131.camel@pegasus>  <4189272C.4080306@csr.com> <1099508519.7125.153.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: RFCOMM service level security testing
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 17:58:37 +0000 (UTC)

Marcel Holtmann <marcel <at> holtmann.org> writes:

> 
> Hi Steven,
> 
> > > do you know any document that explicit requires it? Maybe SIM Access?
> > 
> > Not offhand, but I would have thought it was implicit in the security
> > model.
> > 
> > Not many systems have to worry about running profiles whilst
> > simultaneously allowing direct access to HCI.
> > 
> > Of course, even for systems that don't allow access to HCI, they still
> > have to worry about the other side disabling encryption.
> 
> I have to check that, because I can't remember that I read something
> like that somewhere. Maybe it is possible that nobody thought about this
> before. I only realized that problem when I implemented the security
> hooks in the BlueZ core.
> 
> > > I heard rumors that encryption costs more CPU and so consumes more
> > > power. Is this still true with modern chips or can we ignore this?
> > 
> > I'd be surprised if this has ever been true to a significant level.
> > 
> > The encryption engine used in Bluetooth is quite lightweight if
> > implemented in hardware. I can't imagine that anyone has implemented it
> > in software (not least because the encryption stream used depends on the
> > time at which the packet is transmitted - retransmits use a different
> > obscuring stream).
> > 
> > Compared to the power the rest of the system is taking (most notably,
> > the radio), the encryption is negligible.
> > 
> > It's reasonable to work on a model that encryption is free. In which
> > case the question is, is there any reason encryption shouldn't be turned
> > on as early as possible (as soon as authentication completes)?
> 
> Thanks for this clarification. So automatically dropping the encryption
> is not an option that we will support. You need to do this by your own
> with a HCI command.
> 
> If anyone has measured this for some reason, I like to see the data or
> the report with the end result.
> 
> > > This is a good point, but I think I will explicit have this fine gain
> > > control. However it is enough to set the *_ENCRYPT flag for example and
> > > the authentication will be triggered always first.
> > 
> > Strictly speaking, it's impossible to enable encryption at the baseband
> > level without first having authenticated (though only one side needs to
> > have initiated authentication).
> > 
> > There's a strong argument, however, for having just one combined flag
> > that requests both authentication and encryption. Fewer flags means
> > less complexity.
> > 
> > The problem with having separate flags is that someone might think "oh,
> > I don't care if anyone snoops on this data, I just want to make sure I
> > get requests only from trusted devices". In that case they might request
> > only authentication and not encryption. Unfortunately, this is not
> > enough to prevent session hijacking.
> > 
> > By having just one flag, you remove the possibility that anyone could
> > chose an inappropriate setting. They'll just have two options: secure
> > and insecure.
> 
> I think of following your advice, but still having a *_ENCRYPT and
> *_AUTH flag. If one of this flags is set, the authentication and also
> the encryption will be requested. But only when the *_ENCRYPT flag is
> set, the connection will be dropped when the encryption is disabled.
> Does this makes sense or should we simply introduce another flag that is
> named for example *_SECURE. I haven't made any decision so far and any
> feedback and comments are welcome.
> 
> Regards
> 
> Marcel
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> 



Please keep in mind that a device that has been authenticated and even 
authorized does not necessarily mean it is trusted.  I believe that trusted 
means that the user does not need to "ok" a secure connection using 
Authorization for each time it connects.  Some services may wish to have a 
device be authorized each time it connects to a particular service (profile), 
even though the device has been previously paired.

also, regarding enabling/disabling encrypted links...there are a few 
controllers out there that REQUIRE encyption to be disabled before allowing a 
Role Switch.  So being able to disable encrption and reenable it Must be an 
option (without disconnecting RFCOMM and/or L2CAP channels).  There is 
currently a Bluetooth design proposal to require the controllers to perform 
this logic...but it is still at an early revision phase, and therefore won't 
be a requirement for a long time.  This also shows that an application WILL 
need to be able to talk directly to HCI when it has l2cap and/or rfcomm 
channels that are active.  When apps start getting more sophisticated and need 
to allow lots of profiles (Such as phones, PCs, and PDAs), they need to manage 
the Controller for roles, power management, eSCO, etc.

Regards,
David



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
