Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F02DBA9.1060305@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez Dev <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Bluetooth headset problems.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 02 Jul 2003 14:18:33 +0100

Hi,

I am using the hstest program to try to send and receive sound from the 
headset.
I can record sound, but it seems that only half the sound samples are 
getting through.
E.g. Through the headset microphone, I could seconds in time with my watch.
I then play the recorded sound stream.
If I play at 8000hz, My voice is at the correct pitch, but the counting 
is every 0.5 seconds, instead of 1 seconds.
If I play at 4000hz, My voice is very low and sounds slow, but the 
seconds are counted at the correct speed.
I conclude that the bluez sco driver is only sending us half the samples.

Can anyone help ?

I am using kernel 2.4.21-mh2 (kernel.org kernel patched with mh2 
patches.) and the latest hstest etc. from bluez cvs, as of a few days ago.


Cheers
James



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
