Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <ctob73$ph0$1@sea.gmane.org>
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
In-Reply-To: <41FE4744.5010804@tootai.net>
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
Date: Tue, 01 Feb 2005 17:37:11 +0100

Hi Daniel,

>>> nomade:/home/dh# btsco 00:0b:2e:06:01:2e
>>> Device is 1:0
>>> Voice setting: 0x0060
>>> RFCOMM channel 6 connected
>>
>>
>> You have to press the headset button now!
I wanted to say that you have to press the button like on a cd-player.
First turn on your cd-player or headset ;-) then start btsco and now
push the button once more!


> I check further and still I can't get it work. If I do a hcitool scan no
> device is found. But the info command is working:
My headset has a so called "scan mode". I have to turn it off and press
the button for a long time. Now the LED is blinking alternately red and
green. Only in this mode it show's up on hcitool scan! btw no address
is needed when scanning for devices.
$ hcitool scan

Regards,
Sebastian



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
