Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <6297d67c0604180319p69ad44d6t23eb6a773ba2d998@mail.gmail.com>
From: "Mayank Batra" <mayankbatra@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Sdpd not working
In-Reply-To: <41CB8F9678E6F0498DA096429793FA850DA382@blr-m3-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <41CB8F9678E6F0498DA096429793FA850DA382@blr-m3-msg.wipro.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 18 Apr 2006 15:49:00 +0530

Milan,

I feel that the problem is that you have not executed the following
command before starting sdpd:

insmod l2cap

Try the above command before starting sdpd.
It should work.

Mayank


On 4/18/06, milankumar.rathod@wipro.com <milankumar.rathod@wipro.com> wrote=
:
>
>
>
> Hi all,
>
>
>
> I have RedHat 9 installed on my system. I built and installed
> bluez-firmware, bluez-utils, bluez-libs packages. But when I try running
> sdpd, it exits. Hcid is running. Hciconfig =96a shows me all details as
> specified in hci.conf file. It also displays correct BD address. But,
> sdptool is not able to find services on other devices.
>
>
>
> I installed same bluez packages on Fedora Core 4 (kernel 2.6). It is work=
ing
> fine. I am not getting any clue. Can someone guide me on Bluetooth setup =
on
> RedHat 9 (Kernel 2.4.20).
>
>
>
> Thanks in advance,
>
> -milan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
