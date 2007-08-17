Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20070817092054.bnqr0fdkowkkgcwk@tern.doc.ic.ac.uk>
Date: Fri, 17 Aug 2007 09:20:54 +0100
From: ps104@doc.ic.ac.uk
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] SDP Two way discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have two devices that both need to retrieve the service record from  
each other. When I create two seperate sessions, one to publish the  
sdp record and the second to search for records on other devices only  
one ever finds the other device (always the one which starts first) Is  
there a better way to do this or should it be possible and I am doing  
something wrong?

Thanks,
Phil


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
