Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4645FD54.4060508@mojo-working.com>
Date: Sat, 12 May 2007 10:45:56 -0700
From: Art Rothstein <holtmann@mojo-working.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <463A38C2.80403@mojo-working.com>	<1178260234.25425.16.camel@violet>
	<463BA912.5020907@mojo-working.com>
In-Reply-To: <463BA912.5020907@mojo-working.com>
Subject: Re: [Bluez-users] hcitool info dropped feature
 details	between	versions 3.7 and 3.9?
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

Probes in a custom build of hcitool narrow the error to a status return of 18 
(HCI_INVALID_PARAMETERS?) from an hci_send_req call with command 
OCF_READ_REMOTE_FEATURES. As a newbie to Linux, I don't yet know how to follow 
the problem into kernel mode.

Cross-posted to:
http://www.vmware.com/community/thread.jspa?threadID=84352

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
