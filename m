Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Gabriel Wicke <lists@wikidev.net>
Message-ID: <pan.2006.01.30.19.35.06.850476@wikidev.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] [micro-howto] Ericsson K700i as hid device (hidd options)
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 30 Jan 2006 20:35:07 +0100

Hi,

I just got my Ericsson k700i to work with hidd 2.24 (Ubuntu Dapper) and
would like to share what i needed to do:

If you never paired the phone with your computer before:
* edit /etc/bluetooth/pin, remember the number
If you did pair it before, but it's failing now (was the case after a
firmware upgrade in my case), remove the old pairing information in
/var/lib/bluetooth/<deviveId>

* edit /etc/default/bluez-utils
------------
HIDD_ENABLED=1

# -D (nosdp) special hack for k700i (and similar Ericsson phones afaik)
# -Z (nocheck) also needed in the setup procedure
HIDD_OPTIONS="--master --server -D -Z" 
------------
* sudo /etc/init.d/bluez-utils restart

Now you should be able to connect from your phone's remote control menu-
enjoy!

Thanks to everybody who made this possible!
-- 
Gabriel Wicke




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
