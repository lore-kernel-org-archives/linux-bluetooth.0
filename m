Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCI_switch_role 
In-reply-to: ""Thor Egil Skaug""'s message of "Wed, 03 Mar 2004 18:59:51 PST."
             <000501c40194$c308add0$9349edc7@thores>
Message-ID: <7130.1078397385@csr.com>
From: Peter Stephenson <pws@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 04 Mar 2004 10:49:45 +0000

"Thor Egil Skaug" wrote:
> Does anyone know why the HCI_switch_role command takes a BDADDR argument
> instead of
> a connectionhandle?

It's not clear to me, either, but it may be for compatibility with the
role-change event when generated during connection creation: in that
case, the connection_complete event hasn't come up yet, so there's no
valid ACL handle.  Hence it has to report the BD ADDR (as with
the connection_request event).

> The role_change event should be sent from both devices to their
> respective sw stacks after this.
> 
> I don't understand the following from the BT specification:
> 
> 1. Is the BDADDR the address of the remote device, or the local device
> (to the caller)?

The remote device.

> 2. In the returned event, what bdaddr is returned to the
> (HCI_switch_role) calling stack, and what bdaddr
>    is returned to the stack on the remote device?

Each side reports the remote address (where it reports anything).

> 3. What if there is more than one connection between two devices?

There can't be, you can only have one ACL between any two devices.
This a specific error code acl_connection_already_exists or something
similar if you try and add another one.

pws


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
