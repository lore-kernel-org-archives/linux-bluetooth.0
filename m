Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47348770.5030509@dev.rtsoft.ru>
Date: Fri, 09 Nov 2007 19:14:40 +0300
From: Rusev <arusev@dev.rtsoft.ru>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] hcid to passkey agent interaction question
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

Greetings!

>>From my experiments with pairing to various devices I found that
presence of pincodes file (in /var/lib/bluetooth/<dondle-MAC>/)  in mode
"user" prevents
from pairing for some unknown reason, while absense
of pincodes file in mode "auto" just makes hcid fallback
to using of D-bus passkey agent.

Is it intented behavior? I suggested that in "user" mode pincodes would
be ignored...

Im using BlueZ libs/utils ver. 3.22

Regards,
      Alexandre.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
