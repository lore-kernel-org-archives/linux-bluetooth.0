Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 14 Jan 2007 16:35:59 -0800 (PST)
From: George Manousakis <geomanous@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <108051.71949.qm@web31705.mail.mud.yahoo.com>
Subject: [Bluez-users] asterisk+chan_bluetooth+Nokia6310i->one way voice
Reply-To: geomanous@mycosmos.gr,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I managed to install a system with the following
configuration:

debian sarge, 2.6.8-k7, with all the must have files
to compile and install asterisk.1.0.10.

Everything worked fine, the compile was a success, all
the features were installed and i have the following
config:

/etc/asterisk/bluetooth.conf
[general]
rfchannel_ag = 13
interface = 0
;; A Nokia 6310i
[XX:XX:XX:XX:XX:XX]
name        = Nokia
type        = AG
channel     = 13
autoconnect = yes

/etc/asterisk/sip.conf
[05435]
type=friend
username=05435
callerid="05435" <05435>
host=dynamic
nat=no
canreinvite=no
context=sip
allow=gsm
allow=ulaw
allow=alaw

/etc/asterisk/extensions.conf
[sip]
exten => 05439,1,Dial(BLT/Nokia/XXXXXXXXXX)


When i dial 05439 from the sip phone the gsm phones
dials the preferred number as i should and the dial is
bridged as it should.
The problem is that the sip's voice is transmitted to
the gsm end but the voice of the gsm guy is not
forward to the sip phone. It's an one way
communication.

I'm using the stable versions of sarge reciprocities.

Thanks 


 
____________________________________________________________________________________
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
