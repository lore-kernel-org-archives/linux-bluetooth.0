Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43FB1B2A.4060104@masaka.cs.ohiou.edu>
From: Jim Wyllie <jwyllie@masaka.cs.ohiou.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] MTU limited to 672
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
Date: Tue, 21 Feb 2006 08:52:42 -0500

I am implementing a protocol over L2CAP and would like to increase the 
MTU over 672 bytes.  However, attempting a connection with the requisite 
size will fail in connect() with "Connection Reset by Peer".  I am also 
unable to get an actual MTU over 672 using l2test.

I was unable to find the location in the kernel where this functionality 
was implemented.  Could someone let me know if it's the case that one 
can't get an MTU over 672 with the current kernel and libraries, and if 
so, if there are any workarounds?

Thank you for your time,
Jim


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
