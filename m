Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] CLASS OF DEVICE AND L2CAP INCOMING CONNECTION
	REQUESTS
From: Marcel Holtmann <marcel@holtmann.org>
To: Xavier Garreau <xavier@xgarreau.org>
Cc: Dan ABITBOL <d.abitbol@bloophone.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200310291607.45916.xavier@xgarreau.org>
References: <006c01c39e27$f3d324c0$0900a8c0@Silicium>
	<1067438006.24041.272.camel@pegasus>
	<200310291607.45916.xavier@xgarreau.org>
Content-Type: text/plain
Message-Id: <1067440527.24043.279.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 29 Oct 2003 16:15:21 +0100

Hi Xavier,

> > > 2/  and/or  make a filter to allow l2cap incoming connections requests
> > > only from devices that have a specific class of device .
> >
> > I don't have any real thought about this. Any comments from other
> > people?
> 
> This can be achieved at hci level by sending a Set_Event_Filter command (OGF = 
> 3, OCF =5) with filter type set to 2, Filter_condition_type to 1 and the 
> condition, composed of the CoD that interrests you followed by a mask 
> indicating the bits of interrest in the preceding CoD.
> 
> The problem is i'm sure you need to be root to do that and it forbids hci 
> connections ...

you will need to be root for that and it will block all HCI connections
without the correct CoD. This is only usable for device where you have a
limited or known number of supported profiles. We should build this at
L2CAP level and use the same filter structure like the spec. uses for
Set_Event_Filter.

One reason for me in which case this makes sense is for the HID server
process on the host, because the connections from non-HID devices on the
L2CAP PSM's can be dropped at L2CAP level and the HID server don't have
to care about it. This means that no unneeded SDP connections are made.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
