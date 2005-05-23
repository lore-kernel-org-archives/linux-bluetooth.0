Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: =?ISO-8859-2?Q?Szab=F3_Zolt=E1n?= <szz@freemail.hu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3CRWB6096 PCMCIA card
Message-Id: <20050523195921.07267820.szz@freemail.hu>
In-Reply-To: <1116857587.30044.84.camel@pegasus>
References: <20050523165711.055d97c2.szz@freemail.hu>
	<1116857587.30044.84.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Mon, 23 May 2005 19:59:21 +0200

>> May 23 09:37:59 kernel: bt3c_open: Firmware request failed
> do you might think this line could be the problem? You need to install
> the firmware into the right directory.
> 	http://www.bluez.org/drivers.html

Thank you, now I downloaded and extracted the BT3CPCC.bin file into "the
right place on the local file system".
According to www.bluez.org/drivers.html "the right place" is
/lib/firmware.
The bluez-bluefw files of my linux-distribution are in
/etc/bluetooth/firmware, so I made a symbolic link to this, too.

But /var/log/syslog gives the same result:
May 23 19:46:38 localhost kernel: bt3c_open: Firmware request failed

Is there some possibility to find out where pt3c_open is looking for the
firmware file?

Thank you in advance, 

Regards
Zol




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
