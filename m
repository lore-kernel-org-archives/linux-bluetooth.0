Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4717360C.7090801@free.fr>
Date: Thu, 18 Oct 2007 12:31:40 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
In-Reply-To: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
Subject: Re: [Bluez-devel] SCO connection timed out issue
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

Hi,

Sorry i have to say you this, but you're basically trying to make sth
work that will never make it ;-)

* STLC2500C does not support sco over hci, so unless your development 
has an audio codec hardwired to the BT chip, you're screwed :-(
* You need latest bluez-utils CVS to have any chance for your chip
to run at decent speed, which is required for a2dp streaming. You should 
then use the follwing syntax to start the chip at max speed: hciattach 
/dev/ttyUSB0 stlc2500 921600

Apart from that this is know to work.

Regards,

Fabien

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
