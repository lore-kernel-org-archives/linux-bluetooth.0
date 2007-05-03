Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200705031357.04459.denis.kenzior@trolltech.com>
References: <016001c788a0$b7b229c0$8935c70a@dlh.st.com>
	<1178018694.25217.8.camel@violet>
	<200705031357.04459.denis.kenzior@trolltech.com>
Date: Thu, 03 May 2007 07:25:28 +0200
Message-Id: <1178169928.6891.39.camel@violet>
Mime-Version: 1.0
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

Hi Denis,

> Here's a modified patch that implements eSCO sockets, including incoming SCO 
> connections.  This was a merge of my previous work for the 2.4 series of 
> kernels, so some variables might be named differently than in your patch.

please make sure you use my naming of variables. Otherwise it is too
much confusion. And please create a patch relative to this one so I can
actually review it. And please keep hci_setup_sync(). Doing the
separation this way it more logical than hacking up hci_add_sco(). The
function that decides which command to use should be hci_connect().

> > this patch is incomplete. It doesn't handle incoming eSCO connections
> > and it can't handle SCO audio packets over HCI when a real eSCO
> > connection has been established.
> 
> Why do you say this? What is required in order to get eSCO packets flowing?

If you have type == ESCO_LINK then the kernel doesn't send these packets
over the transport layer.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
