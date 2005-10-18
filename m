Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ae97cd740510180827o34a45078n@mail.gmail.com>
From: aCiDBiTS <acidbits@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: "Wrong data" from my BT GPS Roylatek
In-Reply-To: <20051015213050.GC12751@elmicha.333200002251-0001.dialin.t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ae97cd740510150951l76f4b0d3qe28795c25fe8411b@mail.gmail.com>
	 <20051015211946.GB12751@elmicha.333200002251-0001.dialin.t-online.de>
	 <20051015213050.GC12751@elmicha.333200002251-0001.dialin.t-online.de>
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
Date: Tue, 18 Oct 2005 17:27:32 +0200

Finally I got everything clear, know how to make it work in the proper
way. Sure someone else will be stucked on this, I've spend some hours
on it.

Royaltek RBT-1000 has two operational modes, SiRF and NMEA. By default
it starts in SiRF mode. I read some documentation and I know how to
switch from SiRF to NMEA mode. There are 2 issues with this Bluetooth
GPS reciever and gpsd:

1. First time gpsd starts to request data to RBT-1000, gpsd forces it
to SiRF mode.

2. In SiRF mode there's some kind of issue between gpsd and RBT-1000,
that leads to have a lot of timeouts reading the data. This produces
timeouts in the applications that make requests to gpsd, and they
don't work properly.

I've been doing lots of tests and finally I found a trick to force
gpsd to get data from RBT-1000 in NMEA mode. Here we go:

Set up rfcomm & gpsd:

acid@pluto:~# hcitool scan
Scanning ...
        00:02:C7:29:23:4F       BlueGPS 29234F
acid@pluto:~# sudo rfcomm bind /dev/rfcomm0 00:02:C7:29:23:4F 1
acid@pluto:~# gpsd /dev/rfcomm0

Right now we have SiRF mode. Switching now to NMEA is useless,
although gpsd is running it won't connect with the GPS device (and
force SiRF mode) till some client request data to gpsd. There are
several ways to make it: "telnet localhost 2947" and type DATA, or=20
launching a simple app like xgps:

acid@pluto:~# xgps

Once gpsd has established the first connection with RBT-1000 and
forced it to be in SiRF mode comes the magic. First we have to close
the client app that we used to request data to gpsd thus making it to
establish the connection with RBT-1000. And now we send the magic
string to switch RBT-1000 to NMEA mode:

acid@pluto:~# echo -e -n
"\240\242\000\030\201\002\001\001\000\001\005\001\005\001\000\001\000\001\0=
00\001\000\001\000\001\000\001\022\300\001\152\260\263"
> /dev/rfcomm0

If you "cat < /dev/rfcomm0" you'll get those nice NMEA strings, no
binary chars anymore. Gpsd recognizes the new mode but doesn't switch
back to SiRF, it reads data in NMEA mode from RBT-1000. Now you can
launch any gpsd based app again (xgps, gpsdrive, kismet, ...) and no
more timeouts!! That's it!

It looks like in SiRF mode RBT-1000 can't answer the requests from
gpsd as fast as they are performed and this produces those timeouts.
Switching to NMEA mode using this trick is a workaround, it would be
better if gpsd had some option to force the GPS reciever to operate in
NMEA mode if availible.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
