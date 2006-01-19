Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43D01438.5000409@south-wing.com>
From: Southwing - Miquel Puchol <miquel.puchol@south-wing.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Dongle with a strange configuration
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
Date: Thu, 19 Jan 2006 23:35:36 +0100

Hi all,

I'm trying out this Billionton dongle (CSR-based, class 1), and it's 
curious that:

Name: 'James-1711....'  (I guess James what one of the developers)
Class: 0x000000
HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP Subver: 0x460

The problem is that when I start hcid, it doesn't configure the dongle 
with the values in hcid.conf, but the ones above. I've tried various 
combinations of inserting, then starting hcid, having hcid running then 
insert, etc.

Can anyone give me an insight as to why this is happening? How can I get 
the dongle to init with the right settings?

Regards,

Mike



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
