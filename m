Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20040718194607.29341.qmail@webmail.aruba.it>
From: "ubaldo" <ubaldo@eja.it>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Subject: [Bluez-devel] SCO audio packets dropping
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
Date: Sun, 18 Jul 2004 21:46:07 +0200

Hi, 

With kernel 2.4.22, hcitools 2.2 and voice set 0x0060 HV1 if I play what I 
recorded (aplay -f S16_LE) the voice is a little bit quicker than normal. If 
I set voice as 0x0040 and "aplay -f S8" everything is perfect. 

With kernel 2.6.6 and voice 0x0060 HV1 everything is ok until I set the 
packet type as HV3, then same problem as with kernel 2.4.22. 

The quality link is always 255. 

I thought it could be an hardware packet dropping problem, but I did the 
test with the same computer just changing kernel and some parameter. 

Is this a known problem?


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
