Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] uclinux and bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: egroJorge <egroJorge@terra.es>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <143918984.20040508155253@terra.es>
References: <1083853467.28356.18.camel@pancho>
	 <1083877519.4420.78.camel@pegasus>  <1083925117.1946.36.camel@pancho>
	 <1083946524.4420.124.camel@pegasus>  <143918984.20040508155253@terra.es>
Content-Type: text/plain
Message-Id: <1084054174.4420.169.camel@pegasus>
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
Date: Sun, 09 May 2004 00:09:34 +0200

Hi Jorge,

> I noticed that hciattach doesnt seem to work in uclinux: i could never
> get a "up" device ("hciconfig hci0 up" always failed). In Linux it works
> perfectly. So I compared the behaviour in both system and realised
> that in linux hciattach sends a 0x01x03x10x00 and in uclinux not. I
> think that the sentence "ioctl(fd, HCIUARTSETPROTO, u->proto)" is
> which send that in linux but no in uclinux (although doesnt fail in
> uclinux, simply doesnt send nothing). I was able to see it thanks to a
> oscilloscope.
> I havent study the bluetooth protocols but I tried to send the
> 0x01x03x10x00 "by hand", opening the ttySx in 115200 baudrate and
> writing to it directly (with an auxiliar program I wrote).

what kind of hciattach command do you use? What kind of Bluetooth module
do you use? What endian is your ucLinux platform?

> I know it is not an elegant method and maybe this will only work with
> my hardware configuration. I have no idea of why "ioctl(fd,
> HCIUARTSETPROTO, u->proto)" is not working but I suppossed it was
> fault of the uclinux system (it has a 2.4.20 linux kernel).

This ioctl sets the H4 or BCSP mode of the hci_uart driver.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
