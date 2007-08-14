Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: leiyu <leiyu@kcoe.cn>
Date: Tue, 14 Aug 2007 00:53:10 +0000 (UTC)
Message-ID: <loom.20070814T024925-26@post.gmane.org>
References: <mailman.223268.1187020437.21973.bluez-users@lists.sourceforge.net>
	<811023.94565.qm@web58008.mail.re3.yahoo.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] error for bluez-utils -3.11 configure
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

hong zhang <henryzhang62 <at> yahoo.com> writes:



> configure: error: Bluetooth library is required
> 
> bluez-libs-3.11 is installed why Bluetooth library
> cannot be found?
> 
> ----henry
> 
>       

reconfigure bluez-libs-3.11 with "--prefix=/usr"
then make && make install
_______________________________________________________________________________
_____
> Park yourself in front of a world of choices in alternative vehicles. Visit 
the Yahoo! Auto Green Center.
> http://autos.yahoo.com/green_center/ 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> 





-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
