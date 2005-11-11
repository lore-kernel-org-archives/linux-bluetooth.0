Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] bluez and asterisk - new problem
Message-ID: <HCEOIFALKKLBLJPENPNOEEEMCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1131643489.25312.40.camel@blade>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 11 Nov 2005 11:26:03 -0000

Hi Marcel (and list),

Unfortunately my hcidump is still not showing anything - but I have got my
mobile to connect to the computer (via rfcomm connect), pin is entered and
recognised on both sides, and I get:

Connected /dev/rfcomm0 to XX:XX:XX:XX:XX:XX on channel 3
Press CTRL-C for hang-up

Also, having tried to connect from Asterisk, the phone is connected
successfully also. The output at the asterisk console is:

*CLI> Nov 11 16:53:34 NOTICE[2222]:
/usr/src/chan_bluetooth/chan_bluetooth.c:2041 try_connect: Initialised
bluetooth link to device Nokia
 [AG]      Nokia < AT+BRSF=23
 [AG]      Nokia > AT+BRSF=23
Nov 11 16:53:34 WARNING[2222]: /usr/src/chan_bluetooth/chan_bluetooth.c:2399
handle_rd_data: Device Nokia: Unhandled Unsolicited: +BRSF: 47
 [AG]      Nokia > +BRSF: 47
 [AG]      Nokia > OK
 [AG]      Nokia < AT+CIND=?
 [AG]      Nokia > AT+CIND=?
 [AG]      Nokia > +CIND:
("call",(0,1)),("service",(0,1)),("call_setup",(0-3)),("callsetup",(0-3))
 [AG]      Nokia > OK
 [AG]      Nokia < AT+CIND?
 [AG]      Nokia > AT+CIND?
Nov 11 16:53:34 NOTICE[2222]: /usr/src/chan_bluetooth/chan_bluetooth.c:417
set_cind: Audio Gateway Nokia got signal
 [AG]      Nokia > +CIND: 0,1,0,0
 [AG]      Nokia > OK
 [AG]      Nokia < AT+CMER=3,0,0,1
 [AG]      Nokia > AT+CMER=3,0,0,1
 [AG]      Nokia > OK
 [AG]      Nokia < AT+CLIP=1
 [AG]      Nokia > AT+CLIP=1
 [AG]      Nokia > OK
 [AG]      Nokia < AT+CGMI=?
 [AG]      Nokia > AT+CGMI=?
 [AG]      Nokia > OK
 [AG]      Nokia < AT+CGMI
 [AG]      Nokia > AT+CGMI
 [AG]      Nokia > Nokia
 [AG]      Nokia > OK

Though I'm not too sure about the warning at the top...

When I execute 'bluetooth show peers', the output is positive:

bluetooth show peers
BDAddr            Name       Role Status      A/C SCOCon/Fd/Th Sig
----------------- ---------- ---- ----------- --- ------------ ---
00:12:62:E1:E5:45 Nokia      AG   Ready       Yes -1/-1/0      Yes

But when trying to dial from asterisk (via a soft sip phone), I get a
segmentation fault:

   -- Executing Dial("SIP/01-25d3", "BLT/Nokia") in new stack
Segmentation fault

Note the Dial trying to be executed; I am wery about this since I didnt
fully understand Theo's documentation
(http://crazygreek.co.uk/content/chan_bluetooth), in whcih he states:

'Send a call out by using Dial(BLT/DevName/0123456). Call a HS with
Dial(BLT/DevName)'

Because I am dialing an AG, I am to use the Dial(BLT/DevName/0123456)
command, but what are the digits after /DevName/? Is this the phone number
of the mobile phone? Perhaps this is why I cannot dial from asterisk?

Any help/hint/reply/best wishes is helpful - its kind of lonely when no-one
replies (thanks to Marcel for all the help, perhaps a *little* more if
you're up for it? plz?)

Kindest Regards

Khaled

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email
______________________________________________________________________



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
