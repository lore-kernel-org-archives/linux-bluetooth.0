Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] SCO question
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDC65@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "Bluez-Devel (E-mail)" <bluez-devel@lists.sourceforge.net>
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
Date: Thu, 8 Jul 2004 16:11:43 -0400

Arnaud, Thank you.

exactly right.... The channel for my headset is "2".

hstest record t1.wav 00:0A:D9:74:97:19 2
sets up the SCO channel correctly, and rings the headset.

And I can see the various "AT" commands coming from the headset for =
volume control, etc.

However, there is no audio. Neither "record" nor "play" appears to do =
anything.

Next idea ??

BTW: I am using Bluez-utils 2.3 and bluez-libs 2.4. I don't know if that =
makes a difference.

Best Regards,

Rich



-----Original Message-----
From: Arnaud Mouiche [mailto:arnaud.mouiche@inventel.fr]
Sent: Thursday, July 08, 2004 10:09 AM
To: Williams, Richard; Bluez-Devel (E-mail)
Subject: Re: [Bluez-devel] SCO question


At 09:12 08/07/2004 -0400, Williams, Richard wrote:

>Hi,
>
>I'm getting back to a BT headset <-> LINUX project that I had abandoned =

>some months ago. I have an X-scale single board computer running Linux=20
>2.4.26 with the latest Bluez patches. I have a Sony Ericsson HBH-35=20
>headset that I'm trying to get to work with my computer. I have an =
Anycomm=20
>USB BT dongle.
>
>I have done the following:
>modprobe hci_usb
>modprobe rfcomm
>modprobe sco
>hcid
>hciconfig hci0 up
>hciconfig hci0 voice 0x0040
>.... My Pin file is set up for a pin of "0000" - required by the =
headset.
>
>hcitool scan works OK and finds the headset
>
>l2ping works OK and pairs with the headset.
>
>hstest record t1.wav 00:0A:D9:74:97:19 1

are you sure than "1" is the correct rfcomm channel ?
you should perform a SDP request to get the correct one.

arnaud

><<<This gives output:
>Voice setting: 0x0040
>RFCOMM channel connected
>Can't connect SCO audio channel: Connection refused.
>
>I know that the socket connect statement in sco_connect() in hstest is=20
>failing.
>Any ideas of the cause of this ?
>
>
>thanks very much,
>
>Rich
>
>
>
>Richard B. Williams
>Vitronics, Inc.
>3 Corbett Way
>Eatontown, NJ 07724-2262
>732-389-0244 x29
>Richard.Williams@vitronics.com
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by Black Hat Briefings & Training.
>Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
>digital self defense, top technical experts, no vendor pitches,
>unmatched networking opportunities. Visit www.blackhat.com
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
