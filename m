Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <530812.29878.qm@web8414.mail.in.yahoo.com>
References: <530812.29878.qm@web8414.mail.in.yahoo.com>
Date: Fri, 01 Feb 2008 11:53:41 +0000
Message-Id: <1201866821.2389.316.camel@cookie.hadess.net>
Mime-Version: 1.0
Cc: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdp not starting
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


On Fri, 2008-02-01 at 17:16 +0530, pramod gurav wrote:
> hi all
> i am not able to start the sdp daemon. These are the meesages i get
> in /var/log/messages :   
> Feb  1 17:12:23 localhost hcid[31049]: HCI dev 0 registered
> Feb  1 17:12:23 localhost hcid[31049]: HCI dev 0 up
> Feb  1 17:12:23 localhost hcid[31049]: Device hci0 has been added
> Feb  1 17:12:23 localhost hcid[31049]: Starting security manager 0
> Feb  1 17:12:23 localhost hcid[31049]: Device hci0 has been activated
> Feb  1 17:12:54 localhost sdpd[31717]: Bluetooth SDP daemon
> Feb  1 17:12:54 localhost sdpd[31717]: Starting SDP server
> Feb  1 17:12:54 localhost sdpd[31717]: binding L2CAP socket: Address
> already in use
> Feb  1 17:12:54 localhost sdpd[31717]: Server initialization failed
> 
> 
> What is the reason 
> Can anyone help me in sorting this?

You're probably already using the SDP server built into hcid (by passing
the "-s" argument to hcid), so it's normal that it fails.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
