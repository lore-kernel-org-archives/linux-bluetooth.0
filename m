Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand Connection refused(111) when connecting to
	a Belkin NAP
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Henriksen <dhenriksen@optibrand.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1074718139.2978.7.camel@linux.local>
References: <1074718139.2978.7.camel@linux.local>
Content-Type: text/plain
Message-Id: <1074715001.7263.19.camel@pegasus>
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
Date: Wed, 21 Jan 2004 20:56:42 +0100

Hi Dave,

> I'm wondering what may be causing a "Connection refused(111)" message
> when I issue a "pand --connect 00:02:72:00:DC:F1" command to connect to 
> a Belkin NAP.   The proper pins are setup, and I can l2ping the NAP, I
> just can't get pand to connect to it.  Any help would be greatly
> appreciated.   I know that when I do networking through this NAP on the
> Windows side, I need to specify and id/password combination in addition
> to a pin.  I'm not sure how to do this in Linux.

run "hcidump -w <file>" and send us the dump.

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
