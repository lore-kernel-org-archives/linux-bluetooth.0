Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Vendor Specific Commands
Message-ID: <A35A8D03A748B34A9DA2AB0335A3F93D408823@rfsdmail.internal.rfmd.com>
From: "Jatin Nahar" <jnahar@rfmd.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Tue, 6 Dec 2005 13:05:59 -0800

Hi Marcel,
I am using UART connection to the host. Currently I donot have the
chipset manual, but it should not matter because not all vendor specific
commands are related to hardware configuration.

I searched the source code little bit and I feel that hciattach might be
the place to put it since it already has some RFMD (swave) specific
code. am I correct? (In that case my original question might have been
worded incorrectly).

Thanks,
Jatin

> Thanks for the response. I am using RFMD chipset, but I don't think it

> matters. The reason I need vendor specific commands/events support is=20
> for cases where there is no non volatile memory present and the host=20
> needs to send down configurations using vendor specific commands. An=20
> example of such a case would be mobile phone environment, where the=20
> host uses these to do simple things like write Bluetooth address or=20
> complicated things like configure registers.
>=20
> I know that general framework for these commands/events are already=20
> supported, but what I am trying to find is the right place to do this=20
> (which is the first thing that should  happen) and for that I am=20
> trying to understand the BlueZ model.

this depends on. Send me the programming manual for the RFMD chip and
then I can tell you more. Are we talking about UART or USB connection to
host?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files for problems?  Stop!  Download the new AJAX search engine that
makes searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
