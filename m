Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074015121.2533.11.camel@pegasus>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
	 <1073889186.3923.27.camel@pccross.average.org>
	 <1073913755.3126.48.camel@pegasus>
	 <1073919178.7667.41.camel@ariel.sovam.com>
	 <1073920544.3126.100.camel@pegasus>
	 <1073942535.5527.7.camel@pccross.average.org>
	 <1073943342.8198.8.camel@pegasus>
	 <1073944953.5527.16.camel@pccross.average.org>
	 <1074015121.2533.11.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-CvgtVNReElk5u/WqjQ4R"
Message-Id: <1074022381.2894.5.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 13 Jan 2004 20:33:01 +0100


--=-CvgtVNReElk5u/WqjQ4R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Eugene,

> This means that the termination of an incoming RFCOMM connections
> decrements the reference counting of the L2CAP module. This should not
> happen and I think we have a wrong owner entry somewhere in the RFCOMM
> socket code, but at the moment I don't know where.

actually it is not a wrong owner entry. But the RFCOMM core layer have
to increment the module reference count of the L2CAP module, when we
accept a new incoming L2CAP connection. I am not 100% that this is the
right way to fix this problem, but for me it works. Please check if the
attached patch helps and don't breaks any other of your setups.

Regards

Marcel


--=-CvgtVNReElk5u/WqjQ4R
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- 1.32/net/bluetooth/rfcomm/core.c	Fri Dec 19 19:44:32 2003
+++ edited/net/bluetooth/rfcomm/core.c	Tue Jan 13 20:25:56 2004
@@ -1649,7 +1649,9 @@
 
 	nsock->type = sock->type;
 	nsock->ops  = sock->ops;
-	
+
+	__module_get(nsock->ops->owner);
+
 	err = sock->ops->accept(sock, nsock, O_NONBLOCK);
 	if (err < 0) {
 		sock_release(nsock);

--=-CvgtVNReElk5u/WqjQ4R--



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
