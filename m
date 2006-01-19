Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Message-Id: <1137698545.22814.11.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Question concerning l2cap_parse_conf_req()
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
Date: Thu, 19 Jan 2006 20:22:24 +0100

Hello together,

I'm partly rewriting the l2cap_parse_conf_req() function but there's
something that I do not quite understand and perhaps one from this list
has an idea.
In this mentioned function we use a while() loop that checks the length
of the remaining configuration request; inside the loop the length field
is continuously decreased. Now my question comes into play: Why do we
need this while loop? As we are already in a configuration request (code
0x04), I can't see anything in the current specification that we might
have more than one =C2=BBConfiguration Options=C2=AB within one Configurati=
on
Request packet. The Continuation flag (C) has a different meaning:
	=C2=BBWhen all configuration options cannot fit into a Configuration=20
	 Request with length that does not exceed the receiver's=20
	 MTUsig, the options shall be passed in multiple configuration=20
	 command packets.=C2=AB (page 48 of BLUETOOTH SPECIFICATION Version=20
	 2.0 + EDR [vol 4])
I see that we can have multiple commands in one L2CAP packet (see page
41), but if we parse only one Configuration Request that shouldn't
apply.

Any ideas?

Martin



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
