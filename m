Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez stability problems?
From: Marcel Holtmann <marcel@holtmann.org>
To: Mauro Tortonesi <mtortonesi@ing.unife.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200401281510.36476.mtortonesi@ing.unife.it>
References: <200401281510.36476.mtortonesi@ing.unife.it>
Content-Type: text/plain
Message-Id: <1075307358.26729.15.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 28 Jan 2004 17:29:18 +0100

Hi Mauro,

> sometimes when i start playing with bluez the bluetooth subsystem hangs:
> 
> [mauro@daneel nc6]$ cat src/main.c | ./src/nc6 -vvv --mtu=672 -b 
> 00:0D:88:8E:CA:07 10
> nc6: unable to connect to remote address bluez socket
> [mauro@daneel nc6]$ hcitool scan
> Scanning ...
> [mauro@daneel nc6]$
> [mauro@daneel nc6]$ l2ping 00:0D:88:8E:CA:07
> Can't create socket.: Operation not permitted
> [mauro@daneel audiotest2]$ ./oggread -f 
> /mnt/disk/mauro/art_blakey_and_the_jazz_messengers-impulse/01_alamode.ogg -d 
> 00:0D:88:8E:CA:07 -p 10
> oggread[18536]: Can't connect. Operation already in progress(114)
> Cannot connect to Bluetooth device 00:0D:88:8E:CA:07
> 
> i have experienced this problem with both recent 2.4 (2.4.25-pre7 included) 
> and 2.6 kernels.

I can't follow your tests. Send us a more detailed description on what
you gonna trying to do and run hcidump to see what is really going on.

And check your own source code and that the parameter to your test lines
are correct. On another post you said that the PSM must be specified
with -p and so your fist command must fail, because you can't connect to
PSM 0. The l2ping command needs root rights and I haven't the source
code for oggread so I can't tell you anything about it.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
