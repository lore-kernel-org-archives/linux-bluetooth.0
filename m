Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Dave Henriksen <dhenriksen@optibrand.com>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1074718139.2978.7.camel@linux.local>
Mime-Version: 1.0
Subject: [Bluez-devel] pand Connection refused(111) when connecting to a Belkin NAP
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 21 Jan 2004 12:48:59 -0800

Hi,

I'm wondering what may be causing a "Connection refused(111)" message
when I issue a "pand --connect 00:02:72:00:DC:F1" command to connect to 
a Belkin NAP.   The proper pins are setup, and I can l2ping the NAP, I
just can't get pand to connect to it.  Any help would be greatly
appreciated.   I know that when I do networking through this NAP on the
Windows side, I need to specify and id/password combination in addition
to a pin.  I'm not sure how to do this in Linux.

Thanks,

Dave H

log info:

Jan 21 11:28:51 linux pand[2711]: PAN daemon ver 1.1
Jan 21 11:28:51 linux pand[2711]: Connecting to 00:02:72:00:DC:F1
Jan 21 11:28:53 linux hcid[2690]:
link_key_request(sba=00:0D:88:AC:BE:C5, dba=0 0:02:72:00:DC:F1)
Jan 21 11:28:54 linux pand[2711]: Connect to 00:02:72:00:DC:F1 failed.
Connection refused(111)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
