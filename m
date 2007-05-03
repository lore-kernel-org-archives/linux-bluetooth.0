Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 3 May 2007 15:00:05 +1000
References: <001501c78d3c$dd4f3ba0$9d0cc70a@dlh.st.com>
In-Reply-To: <001501c78d3c$dd4f3ba0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
Message-Id: <200705031500.06707.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Esco implementation patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Mayank,

> How about the 2-EV* and 3-EV* packet types? The spec says that a 0 for
> these bits means they have been enabled. Shouldn't you also check for their
> support in the feature mask?

Good question.  I'm not entirely sure of this, however I did not interpret the 
specification in this manner.  All it says is that there is a specific 
feature mask to disable 2-EV and 3-EV packets.  There is nothing to say 
whether or not they are explicitly enabled.  Also the examples in the 
specification use the esco feature masks in the same manner as I do.  So I 
would assume that if EV3 support is not enabled, then 2-EV3 and 3-EV3 packets 
will not be used by the controller as well.  However, I could be wrong.

>
> > I've tested it on several machines here, including eSco->eSco
> > connection, eSco->sco connection for both incoming and outgoing
> > scenarios, everything seems fine, however I'm sure more testing is
> > required.
>
> How did you mangage to set up an eSCO since you are using only HV* packet
> types (ESCO_PTYPE_MASK)? Or is it because the 2-EV* and 3-EV* bits are "0"
> thus the controller thinks you want to enable those packet types?

Well, it comes down to what the controller labels as an eSCO connection.  E.g. 
the link_type returned in the connection complete and sync connection 
complete events.  Doing BlueZ<->BlueZ which both use the patch, I get 
link_type of eSCO.  Doing BlueZ<->BlueZ with one end not using the patch, I 
get a link_type of SCO.  Perhaps it is the particular hardware I'm using?

Setup is a STLC2500 serial device connected to a BT1.2 USB dongle on a 
non-patched kernel and a BT 2.0 USB dongle on a patched kernel.

Regards,
-Denis


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
