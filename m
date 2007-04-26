Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 26 Apr 2007 11:59:39 +0530
Message-ID: <00cd01c787cc$44fda460$8935c70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <200704261519.30004.denis.kenzior@trolltech.com>
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

Denis
Actually when the ADD_SCO_CONNECTION is not supported a command complete is
generated with the status 0x01 (Unknown HCI Command). The controller doesn't
know about this command at all. If the controller had known about this
command then it will generate a command status with suitable status code.

Regards,
Sumeet 
-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Denis
KENZIOR
Sent: Thursday, April 26, 2007 10:49 AM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Esco implementation patch

I'm concerned about the ADD_SCO addition to the hci_cc_link_ctl function.
The Version 2.0 + EDR page 617 specifies that:

"no Command Complete event will be sent by the Controller to indicate that
this command has been completed...."

To me that means that Add Sco should never trigger the hci_cc_link_ctl
function?

-Denis

On Thursday 26 April 2007 14:56, Sumeet VERMA wrote:
> Hi Marcel
> Sorry for the mistake. Please find a single diff attached.
>
> Regards,
> Sumeet
> -----Original Message-----
> From: bluez-devel-bounces@lists.sourceforge.net
> [mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Marcel 
> Holtmann
> Sent: Wednesday, April 25, 2007 1:14 PM
> To: BlueZ development
> Subject: Re: [Bluez-devel] Esco implementation patch
>
> Hi Sumeet,
>
> > I have done an implementation of esco in bluez kernel. I have 
> > hardcoded
>
> the settings of eSCO connection at the moment (packet type EV3).
>
> > Please review it and feel free to make modifications. This is 
> > working fine
>
> on my side. I changed the 2.6.20 kernel code.
>
> your patch is reverse and please don't send separate patches for each
file.
> Create a big diff that includes all changes.
>
> Regards
>
> Marcel
>
>
>
> ----------------------------------------------------------------------
> --- This SF.net email is sponsored by DB2 Express Download DB2 Express 
> C - the FREE version of DB2 express and take control of your XML. No 
> limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express Download DB2 Express C - the
FREE version of DB2 express and take control of your XML. No limits. Just
data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
