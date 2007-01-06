Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Tom Allebrandi" <tom@ytram.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Sat, 6 Jan 2007 16:57:11 -0500
Message-ID: <000501c731dd$9e7eec00$0cbbbac6@fte.local>
MIME-Version: 1.0
In-Reply-To: <001f01c731ba$8cda66f0$0300a8c0@2600xp>
Subject: Re: [Bluez-devel] Error: Unsupported LMP Parameter Value
Reply-To: tom@ytram.com, BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

It would be helpful to see the HCI Command that resulted in the HCI Event.
Unfortunately that event is used for all mode changes and doesn't indicate
what mode was requested.

If you've got a "Write Link Policy Settings" command in your trace it might
be helpful to see that as well.

Sounds like the headset doesn't like the parameters in the power saving mode
request. Or, it could be that the headset doesn't support power saving mode
that is being requested, but I think that causes a different status to be
returned.

--- tom
tom allebrandi
tom@ytram.com

 -----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Tom Lloyd
Sent: Saturday, January 06, 2007 12:46 PM
To: bluez-devel@lists.sourceforge.net
Cc: 'Brad Midgley'
Subject: [Bluez-devel] Error: Unsupported LMP Parameter Value

Hi All,

I have been working on the problem of my headset running down quickly with
the help of Brad (Thanks I owe you about 10 by now) I have established that
once the headset is connected to the btsco daemon it is unable to switch
into the low power standby mode. I have taken the output from hcidump -V -X
and put the relevant lines below. This message continues to repeat itself
every twenty seconds while the headset is connected to btsco. I hope this
can help someone explain what the problem is to me. I have taken a crash
course in Bluetooth just recently. 
It occurred to me that it could be my hciconfig file which is now not the
standard file under Ubuntu 6.10. While I was attempting to get the headset
to work I modified it quite heavily. If someone thinks this could be the
problem please drop me a line at thomaslloyd82@hotmail.com feel free to <MSN
me or Yahoo thomaslloyd@yahoo.com or skype thomas_lloyd.  

Any ideas on the problem would be appreciated. I am trying to get this
working for my new business idea but I am struggling with this last point.

HCI Event: Mode Change (0x14) plen 6
    status 0x20 handle 1 mode 0x00 interval 65535
    Error: Unsupported LMP Parameter Value

I am using a Logitech HS05 v2 headset with a safecom dongle. As I have said
it all seems to work apart from going into park (if that's the right term).

Thanks

Tom Lloyd

	



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
