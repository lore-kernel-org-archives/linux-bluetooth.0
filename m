Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 3 May 2007 15:24:06 +1000
References: <001501c78d3c$dd4f3ba0$9d0cc70a@dlh.st.com>
	<200705031500.06707.denis.kenzior@trolltech.com>
	<1178169412.6891.36.camel@violet>
In-Reply-To: <1178169412.6891.36.camel@violet>
MIME-Version: 1.0
Message-Id: <200705031524.10794.denis.kenzior@trolltech.com>
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

Marcel,

> don't worry about packet types. This is the link managers job. Enable as
> much packet types as possible.

OK, that is what I thought as well.

>
> No. It is the difference between using Accept Connection Request or
> Accept Synchronous Connection Request. In the first case it has to fall
> back to SCO since it has no further information on how to negotiate an
> eSCO link.

This is strange, because I would send an accept_sync_conn, get a 
sync_conn_complete_event and the link_type would be 0x0 (SCO) when connecting 
to an unpatched BlueZ box.  Again, I imagine more testing is required.

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
