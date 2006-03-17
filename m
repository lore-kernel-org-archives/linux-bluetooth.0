Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Thomas Arendsen Hein <thomas@intevation.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20060317114903.GC19061@intevation.de>
References: <fe0a97c20603170259o137b2ed1p8e3235de4e48e715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe0a97c20603170259o137b2ed1p8e3235de4e48e715@mail.gmail.com>
Subject: [Bluez-users] Re: Vend/id 0xa12 /0x1
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
Date: Fri, 17 Mar 2006 12:49:03 +0100

* Sowmya Gattupalli <sowmya.gattupalli@gmail.com> [20060317 12:01]:
> Please help me out... i know my question is silly... i have to find out...
> My dongle's vendor id and prod id is 0xa12 and 0x001... will be able to find
> out which manufacturer from this info???
> 
> (I know its CSR chipset.... ))

I have Acer and Cellink dongles with this USB id, so this is not
helpful, but you can look at the BD addr:

"hcitool dev" will give you something like
Devices:
        hci0    00:0A:94:xx:xx:xx

Just enter the first three pairs (without colons, i.e. 000A94) in
the OUI search form at:
http://standards.ieee.org/regauth/oui/index.shtml

and you'll get something like:
00-0A-94   (hex)                ShangHai cellink CO., LTD
000A94     (base 16)            ShangHai cellink CO., LTD
                                C3 MeiLong ZhongXin Industrial Park,No.1
                                ShangHai  200237
                                CHINA

Thomas

-- 
Email: thomas@intevation.de
http://intevation.de/~thomas/


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
