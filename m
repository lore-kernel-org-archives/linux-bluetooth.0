Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <ctqulk$ce4$1@sea.gmane.org>
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org> <4200D3B6.1050708@tootai.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
In-Reply-To: <4200D3B6.1050708@tootai.net>
Subject: [Bluez-users] Re: Connection issue with headset
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
Date: Wed, 02 Feb 2005 17:21:36 +0100

Hi Daniel,


> Did not help. I made following:
> 
> - modprobe snd-bt-sco
are the other things build into the kernel or loaded? (bluetooth,
hci_usb, l2cap, rfcomm, sco)

> - headset is switch off
? what. Maybe you missed me on some point? A switched off headset cannot
play any sound! ;-)

> - btsco 00:0b:2e:06:01:2e
> Device is 1:0
> Failed to connect to SDP server: Host is down
> Assuming channel 2
> - I swith on headset, information above is completed by
> Voice setting: 0x0060
> RFCOMM channel 2 connected
Maybe it's working when switching it on half the way but IMO that's no
good idea.

- load all necessary modules
- start hcid
- check if all is up (hciconfig)
- switch on your headset (normal mode)
- make sure you have the correct address!!
- btsco <hwaddr>
- wait for "RFCOMM channel X connected"
- press the headset button
- you should see some more messages now (have a look at my output below)

btsco <hwaddr>
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected	# press headset button
recieved AT+CKPD=200
opened hwdep
connected SCO channel
Setting sco fd
Done setting sco fd
recieved AT+VGS=01
Sending up speaker change 1	# now you should hear a static noise
recieved AT+CKPD=200		# press button to stop it
disconnected SCO channel
recieved AT+VGS=01		# canceled btsco with ^C
Sending up speaker change 1


When I've pressed the button to start the sound I can see a lot of SCO
data in the output of hcidump. You too?


If you followed this and it does not work I have two ideas.
1. Is it possible that your headset does not send any AT commands
over the connected RFCOMM channel? As far as I know btsco will never
try to establish an SCO connection without having recived the cmd
from your headset.
2. The headset is sending "other" commands when pressing the headset
button. Same effect as 1.

Please have a look at hcidump -x to see if your headset is sending such
a command when pressing the button!

Regards,
hecatomb



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
