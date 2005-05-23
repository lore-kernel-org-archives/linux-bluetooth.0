Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050523195921.07267820.szz@freemail.hu>
References: <20050523165711.055d97c2.szz@freemail.hu>
	 <1116857587.30044.84.camel@pegasus>
	 <20050523195921.07267820.szz@freemail.hu>
Content-Type: text/plain
Message-Id: <1116871922.30044.126.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 23 May 2005 20:12:02 +0200

Hi Zol,

> >> May 23 09:37:59 kernel: bt3c_open: Firmware request failed
> > do you might think this line could be the problem? You need to install
> > the firmware into the right directory.
> > 	http://www.bluez.org/drivers.html
> 
> Thank you, now I downloaded and extracted the BT3CPCC.bin file into "the
> right place on the local file system".
> According to www.bluez.org/drivers.html "the right place" is
> /lib/firmware.
> The bluez-bluefw files of my linux-distribution are in
> /etc/bluetooth/firmware, so I made a symbolic link to this, too.

the bluez-bluefw package is outdated.

> But /var/log/syslog gives the same result:
> May 23 19:46:38 localhost kernel: bt3c_open: Firmware request failed
> 
> Is there some possibility to find out where pt3c_open is looking for the
> firmware file?

Do you installed hotplug? Does /etc/hotplug/firmware.agent exists?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
