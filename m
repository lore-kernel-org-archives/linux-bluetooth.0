Return-Path: <ABHISHEK.BHATT@motorola.com>
Message-ID: <5987A7CB1694D811A04D0002B32C289601BF3C01@il93exb05.corp.mot.com>
From: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
To: "'Stephen Crane'" <steve.crane@rococosoft.com>,
   Marcel Holtmann
	 <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
Date: Fri, 29 Oct 2004 10:35:32 -0500
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Steve, Marcel,

> > Service level security is required for JSR-82 like Steve pointed it out. 
> > For anyone implementing JSR-82, they would have to add this service level
> > security themselves. It would be most useful to have it as part of bluez
> > rather than have people implement their own way of it. 
> 
> actually you can't implement it in a sane way in userspace, because you
> don't have control over the RFCOMM signalling channel.

> Marcel is right here. You can try and kludge it by trying to enforce the
> security requirements _after_ the connection has been accepted but this
> is pretty horrible (and it's hard to prevent acceptAndOpen() returning a
> connection which is immediately closed).

Sorry for the confusion but I wasn't referring to user space at all. I was thinking of having the rfcomm service level security implemented in almost the same way as the l2cap service level security(incoming connection). The service level security options could be set using setsockopt(..) in rfcomm. This in turn could be used to set the service level settings for the l2cap socket it uses. I can draw a sequence diagram(function calls) to show how i
picture the design. I'll do that.

> > Also, currently there is no service level security in l2cap for 
> > outgoing connections. I would like to know if someone has already 
> > taken a stab at it and if this should be part of bluez in the 
> > future.

> > I've had a look at this recently. If I get time I will have a go at  
> > implementing it.

Steve, I would be interested to know how you intend to implement it.


> You must convince me that this is really needed and a good idea. For 
> what kind of application do you want to use it?

> It's for the same reason as stated above: you don't want the connection to > succeed unless the security requirements can be met. If you have a client > in security mode 2 and a server in security mode 1, you want the server to > see an incoming connection _only_ if authentication/encryption have been 
> successfully performed. You _don't_ want the server to see an incoming 
> connection which is immediately closed.	

Plus JSR-82 requires that service level security should be possible for
outgoing connections. So for anyone trying to implement JSR-82 and using
bluez, it is needed.

Regards
Abhi


Hi Marcel, Abhi,

On Fri, 2004-10-29 at 15:47, Marcel Holtmann wrote:
> > Service level security is required for JSR-82 like Steve pointed it out. 
> > For anyone implementing JSR-82, they would have to add this service level
> > security themselves. It would be most useful to have it as part of bluez
> > rather than have people implement their own way of it. 
> 
> actually you can't implement it in a sane way in userspace, because you
> don't have control over the RFCOMM signalling channel.

Marcel is right here. You can try and kludge it by trying to enforce the
security requirements _after_ the connection has been accepted but this
is pretty horrible (and it's hard to prevent acceptAndOpen() returning a
connection which is immediately closed).

> > Marcel, if you recall, we've exchanged an email regarding service level security. At that point, you had mentioned thinking about a security manager embedded in bluez that would allow it.
> 
> This is a little bit different, because this is more basic stuff. You
> need to integrate the trigger points of the Bluetooth security mechanism
> into the RFCOMM layer. And actually the state machine of RFCOMM is more
> complex than the one of L2CAP. For me it is not clear at the moment what
> is the best thing to do without breaking anything.
> 
> So the question still stands. Should we already force authentication
> when the peer sends PN CMD?

Actually p412 in the SPEC (v1.1) says:

"On the responding side, if authentication procedures are triggered from
RFCOMM, this must only be done when receiving a SABM frame, not when
receiving configuration commands preparing an unopened DLC (Erratum
1052)."

> > I am currently working on implementing JSR-82 which requires this level 
> > of security. If anyone has already implemented or has a good way of doing it,
> > please let me know. I would be very interested.
> 
> As mentioned above the only way is inside the kernel, because otherwise
> you will trigger after the MSC exchange and this is too late.
> 
> > Also, currently there is no service level security in l2cap for outgoing
> > connections. I would like to know if someone has already taken a stab at it
> > and if this should be part of bluez in the future. 

I've had a look at this recently. If I get time I will have a go at
implementing it.

> You must convince me that this is really needed and a good idea. For
> what kind of application do you wanna use it?

It's for the same reason as stated above: you don't want the connection
to succeed unless the security requirements can be met. If you have a
client in security mode 2 and a server in security mode 1, you want the
server to see an incoming connection _only_ if authentication/encryption
have been successfully performed. You _don't_ want the server to see an
incoming connection which is immediately closed.

Regards,
Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)
