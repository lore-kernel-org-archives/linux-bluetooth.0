Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D89EBB.3060908@gmx.net>
From: Maximilian Michel <pinky99@gmx.net>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] PAN with DLink Access Point DBT-900AP
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 26 Jan 2006 11:04:43 +0100

Hi,

I have a problem with connecting to this access point.

I do following:

fry ~ # hcitool scan
Scanning ...
         00:0D:88:9F:38:A5       DBT-900AP

fry ~ # pand --service NAP -Q -n
pand[7714]: Bluetooth PAN daemon version 2.24
pand[7714]: Inquiring
pand[7714]: Searching for NAP on 00:0D:88:9F:38:A5
pand[7714]: Failed to connect to the SDP server. Function not 
implemented(38)


fry ~ # pand --connect 00:0D:88:9F:38:A5 -n
pand[7904]: Bluetooth PAN daemon version 2.24
pand[7904]: Connecting to 00:0D:88:9F:38:A5
pand[7904]: Connect to 00:0D:88:9F:38:A5 failed. Function not 
implemented(38)
fry ~ #

Is it possible to connect my pc to this ap or is impossible due to an 
unimplemented bluetooth requirement?
I'm using gentoo with
net-wireless/bluez-libs 2.24
net-wireless/bluez-utils 2.24


Thanks,
Maximilian


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
