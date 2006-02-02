Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43E17EF7.50801@purdue.edu>
From: Chase Douglas <cndougla@purdue.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] btsco occasional loud bursts of static
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
Date: Wed, 01 Feb 2006 22:39:35 -0500

I have a dlink dbt-120 rev. b4 bluetooth adapter with a motorola hs850 
and I use btsco to talk with people online. When I have my laptop 
sitting on my lap, everything works fine. However, when I start to walk 
around, the sound transmitted to the other person from my headset will 
have bursts of loud static. I am guessing that this is a problem with 
the connection being worse. I would like to get this resolved, and I can 
do some coding as well. I have a 2 MB hcidump which somewhere near the 
end has the offending sound packets. I can't find any documentation on 
the SCO protocol, so I can't find where the static was. Can anyone point 
me in the right direction?

Thank you,
Chase Douglas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
