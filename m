Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Mats Erik Andersson <mats@blue2net.com>
To: List Bluez users <bluez-users@lists.sourceforge.net>
Date: Thu, 30 Aug 2007 17:11:38 +0200
Message-Id: <1188486698.4817.60.camel@Blue2net-mats.bellman.mea>
Mime-Version: 1.0
Subject: [Bluez-users] Byte order for baddr-to-string
Reply-To: mats.andersson@blue2net.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello all,

I observe that the bluez-libs functions 

  int ba2str(const bdaddr_t *, char *);

  char * batostr(const bdaddr_t *);

deliver strings with different byte order. Is it just
me making a slip of mind regarding netorder or endianness,
or is there a deeper reason that I fail to comprehend?
I observe the same thing on i386 architecture as well
as on cris architecture.


Thanks for any pointers or corrections.

Best regards

M E Andersson

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
