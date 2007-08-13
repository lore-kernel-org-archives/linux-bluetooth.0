Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C088D7.9000108@silicom.fr>
References: <46C088D7.9000108@silicom.fr>
Date: Mon, 13 Aug 2007 18:46:31 +0200
Message-Id: <1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
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

Hi,

> Certainly a very stupid question : but how do we get started using
> the 
> brand new A2DP support ? - for me it seems that it still favors sco over 
> a2dp :-(

I modified the test-audio python script to get something like this:
Look at your syslog to see what happen.
I then got my headset connected and could hear something ;) 

#!/usr/bin/python
import dbus
bus = dbus.SystemBus()
manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')

conn = manager.ActivateService('audio')
audio = dbus.Interface(bus.get_object(conn, '/org/bluez/audio'),
'org.bluez.audio.Manager')

# Create device
path = audio.CreateDevice("00:03:89:AA:BD:64")

# Get org.bluez.audio.Sink interface
sink = dbus.Interface(bus.get_object(conn, path),
'org.bluez.audio.Sink')

try:
	sink.Connect()
except:
	pass

#sink.Disconnect() 


Hope this helps

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
