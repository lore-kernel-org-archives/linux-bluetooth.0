Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46C1A52F.7050102@free.fr>
Date: Tue, 14 Aug 2007 14:50:55 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46C088D7.9000108@silicom.fr>
	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
In-Reply-To: <1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Thanks frederic !

For some reason my headset tries to start the A2DP stream, connects to 
RFCOMM channel, and then stops the a2dp stream, while it stays connected 
to rfcomm (hs profile).

To force the use of a2dp i had to reload the audio daemon, and then 
launch the multimedia player. It then tries to start a2dp stream, and it 
works.

Btw i got perfect sound quality compared to a2dpd. No small glitches 
from time to time, just *perfect* sound. :-)


Fabien


> Hi,
> 
>> Certainly a very stupid question : but how do we get started using
>> the 
>> brand new A2DP support ? - for me it seems that it still favors sco over 
>> a2dp :-(
> 
> I modified the test-audio python script to get something like this:
> Look at your syslog to see what happen.
> I then got my headset connected and could hear something ;) 
> 
> #!/usr/bin/python
> import dbus
> bus = dbus.SystemBus()
> manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
> 'org.bluez.Manager')
> 
> conn = manager.ActivateService('audio')
> audio = dbus.Interface(bus.get_object(conn, '/org/bluez/audio'),
> 'org.bluez.audio.Manager')
> 
> # Create device
> path = audio.CreateDevice("00:03:89:AA:BD:64")
> 
> # Get org.bluez.audio.Sink interface
> sink = dbus.Interface(bus.get_object(conn, path),
> 'org.bluez.audio.Sink')
> 
> try:
> 	sink.Connect()
> except:
> 	pass
> 
> #sink.Disconnect() 
> 
> 
> Hope this helps
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
