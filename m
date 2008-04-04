Return-Path: <cyrus@holtmann.org>
From: Javi F Gorostiza <ingestado@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Fri, 04 Apr 2008 18:04:46 +0200
Message-Id: <1207325086.23019.67.camel@goya.uc3m.es>
Mime-Version: 1.0
Subject: [Bluez-users] laptop-headset pairing script
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,
I would like to know how I can make laptop-headset pairing in rc.3, that
is whithout X-server. How can I introduce the PIN? I have proved the
python script:

  import dbus
  bus = dbus.SystemBus()
  manager = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'), 'org.bluez.Manager')
  bus_id = manager.ActivateService('audio')
  audio = dbus.Interface(bus.get_object(bus_id, '/org/bluez/audio'), 'org.bluez.audio.Manager')

  path = audio.CreateDevice('00:0D:3C:35:CC:D3')
  #audio.ChangeDefaultDevice(path) #change the device to be used by default
  sink = dbus.Interface (bus.get_object(bus_id, path), 'org.bluez.audio.Sink')
  sink.Connect()

..with no exit.
Any help please?



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
