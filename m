Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Sebastian Roth <sebiroth@web.de>
Message-ID: <csts46$p5n$1@sea.gmane.org>
References: <41F0EB0A.1020302@webstuhl.net> <41F0FE84.8030401@dark-reality.de> <41F128F4.2020006@webstuhl.net> <41F13638.1080207@dark-reality.de> <41F25C4B.6040709@webstuhl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <41F25C4B.6040709@webstuhl.net>
Subject: [Bluez-devel] Re: Again: Problems with Dongle, Headset or btsco
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
Date: Sat, 22 Jan 2005 16:40:11 +0100

Hi Ben,

> ok. Is it possible that the SCO Part of this dongle is somehow broken?
> Obviously the RFCOMM Part is working fine.
I've had problems with a Anycom 220 dongle (also Silicon Wave chip) too. 
RFCOMM seemed to work but no sound. hcidump showed a flow of sco packets 
with handle 0. Can't get it working till now so I decided to use another 
one.

> Question: when connected via btsco and trying to play
> some sound with:
> aplay -D plughw:Headset soundfile
> Does soundfile need to have the correct samplerate,frequency,etc
> as the Headset?
IMHO, no.

> unfortunately
> arecord -D plughw:Headset z1.out
> Recording WAVE 'z1.out' : Unsigned 8 bit, Rate 8000 Hz, Mono
> 
> only creates a 44 Byte big file z1.out with the header but
> no content
For older versions of arecord this is the usual behaviour. Update 
alsa-tools or try the commandline switch '-d' (man arecord).

Best regards,

Sebastian



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
