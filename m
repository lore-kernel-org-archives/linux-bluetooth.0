Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand Connection refused(111) when connecting to
	a Belkin NAP
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Henriksen <dhenriksen@optibrand.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074719150.2980.9.camel@linux.local>
References: <1074718139.2978.7.camel@linux.local>
	 <1074715001.7263.19.camel@pegasus>  <1074719150.2980.9.camel@linux.local>
Content-Type: text/plain
Message-Id: <1074716061.7263.37.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 21 Jan 2004 21:14:22 +0100

Hi Dave,

> Here is the file from the hcidump.

	> ACL data: handle 0x0029 flags 0x02 dlen 16
	    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 2 status 0

The result code 2 means "Connection refused - PSM not supported". Are
you sure this AP supports the PAN Profile. Try using dund instead.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
