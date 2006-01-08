Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C1356C.60109@in.tum.de>
From: Aleksandar Kanchev <kanchev@in.tum.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <BAY24-F20084DBFE3577D788A970CF82F0@phx.gbl> <1136420779.6652.30.camel@localhost> <dpotfk$832$1@sea.gmane.org>
In-Reply-To: <dpotfk$832$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] broadcast packets
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
Date: Sun, 08 Jan 2006 16:53:16 +0100

Hello,

does bluez support broadcast packets ?
I've tried to send a raw broadcast packet to hci and I could see the 
remote bluetooth controller blinking as if it is receiving data but 
hcidump didn't show anything.
Before writing the packet I've connected the both devices with "hcitool 
cc <addr>" and I wrote the packet from the connecting side (the master).



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
