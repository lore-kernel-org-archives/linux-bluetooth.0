Return-Path: <ABHISHEK.BHATT@motorola.com>
Message-ID: <5987A7CB1694D811A04D0002B32C289601BF3BFE@il93exb05.corp.mot.com>
From: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
To: "'Stephen Crane'" <steve.crane@rococosoft.com>,
   Marcel Holtmann
	 <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Service level security for RFCOMM
Date: Fri, 29 Oct 2004 09:36:03 -0500
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Service level security is required for JSR-82 like Steve pointed it out. 
For anyone implementing JSR-82, they would have to add this service level
security themselves. It would be most useful to have it as part of bluez
rather than have people implement their own way of it. 

Marcel, if you recall, we've exchanged an email regarding service level security. At that point, you had mentioned thinking about a security manager embedded in bluez that would allow it.

I am currently working on implementing JSR-82 which requires this level 
of security. If anyone has already implemented or has a good way of doing it,
please let me know. I would be very interested.

Also, currently there is no service level security in l2cap for outgoing
connections. I would like to know if someone has already taken a stab at it
and if this should be part of bluez in the future. 

Regards
Abhi


> actually it seems that nobody really cares about service level security
> on the RFCOMM layer. Or people are too lazy to send in a patch. However,
> I spent some hours with thinking about it and the core stuff of a small
> framework for providing authentication and encrypt feedback from HCI to
> higher level protocols is finished.

Perhaps this is because no-one except you and Max understands the RFComm
state-machine? :-)

> The problem now is to change the RFCOMM state machine to deal with it
> and reject connections in the failure case. After looking at the state
> machine of RFCOMM, I realized that there are two posibilities when to
> trigger the authentication. One is after we receive the PN CMD and the
> other after the SABM for the specific channel. The specification says
> nothing about that. What are the pros and cons?
> 
> And btw, who is really interested in this feature or needs it?

This is useful (and probably required, I can't remember) for JSR-82.
Especially for people who want to encrypted/authenticated OBEX
connections.

Are you going to do the client-side too?

Steve
-- 
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)



-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
