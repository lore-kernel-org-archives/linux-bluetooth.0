Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4034.124.243.174.189.1177582757.squirrel@ice-gw.trolltech.com.au>
In-Reply-To: <00cd01c787cc$44fda460$8935c70a@dlh.st.com>
References: <200704261519.30004.denis.kenzior@trolltech.com>
	<00cd01c787cc$44fda460$8935c70a@dlh.st.com>
Date: Thu, 26 Apr 2007 20:19:17 +1000 (EST)
From: dkenzior@trolltech.com
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
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

Sumeet,

Yep you are correct.  However what I'm trying to say is that if the
adapter is Bluetooth 1.2+ compatible and implements Add Sco Connection for
backward compatibility, then the faster eSCO alternative will never be
used.  Most of the Bluetooth 1.2+ USB adapters I've had experience with,
do implement the Add Sco command for backward compatibility.

Shouldn't we try to query the Adapter version first and then use the
commands which are appropriate?

-Denis

> Denis
> Actually when the ADD_SCO_CONNECTION is not supported a command complete
> is
> generated with the status 0x01 (Unknown HCI Command). The controller
> doesn't
> know about this command at all. If the controller had known about this
> command then it will generate a command status with suitable status code.
>
> Regards,
> Sumeet



-----------------------------------------
Trolltech ASA, Sandakerveien 116, PO Box 4332, Nydalen NO-0402 Oslo, Norway

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
