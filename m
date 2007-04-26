Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 26 Apr 2007 11:54:16 +0530
Message-ID: <003901c787cb$849c11c0$9d0cc70a@dlh.st.com>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
Denis,

> I'm concerned about the ADD_SCO addition to the 
> hci_cc_link_ctl function.  The 
> Version 2.0 + EDR page 617 specifies that:
> 
> "no Command Complete event will be sent by the Controller to 
> indicate that 
> this command has been completed...."
> 
> To me that means that Add Sco should never trigger the 
> hci_cc_link_ctl 
> function?

Yes, but please also read page 611 which states "They may be implemented
by a controller to allow for backwards compatibility
with a host utilizing a prior version of the specification.
A host should not use these commands."

This means that a BT 2.0 controller is not expected to implement the
deprecated commands.

In this case the device treats the ADD_SCO command as an unknown HCI
command and thus generates a command complete event.
The point that you mentioned would be applicable if the device processes
the ADD_SCO command normally.

Having said this, I agree that a problem is bound to arise when the host
is BT 1.1 and it has no idea about the BT 2.0 specifications.

Best Regards,

Mayank
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)

iQEVAwUBRjBFkPlzfQCQpKQiAQJmXggAtllspT24CRt62TK6RL810xjq/DCXxKbk
Nn9JSCph2ev+jHdyvdBIWgfUAw0HEWZDJn82/9il4t3+AjiL6eCvCtYcxBAbvHXa
GGOzDknA2B133dRmJsR0bwHhO2e8fSLMYyiTMV2OINF52UHlHZKtqfy2oOGhGc2F
LqO0KxRFZ8Gt4LqoakWW7wyM1n22ny62QzBsP01hE/zTrMInMFSCNv+M6MgqQCW4
EUW5JWKQe72g3FMTS+NBAWhED3v69ckDWBLlHlFIS2OSARbh19bNC2O+f1BF9oZU
3riR6GDlnW2mvB6O002ImlABp2ZlYD2g4fofPgFGHBaNNp6gjG5SSQ==
=kZ/x
-----END PGP SIGNATURE-----



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
