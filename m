Return-Path: <cyrus@holtmann.org>
Message-ID: <20080613114741.aegcm62tc0gcwscs@webmail.cloudsprinter.com>
Date: Fri, 13 Jun 2008 11:47:41 +0100
From: neil@cloudsprinter.com
To: bluez-users@lists.sourceforge.net
References: <20080612204135.qbeehdkkasog4o88@webmail.cloudsprinter.com>
	<e378cfb20806122242u67c866d6vddecf3f42ce30c4b@mail.gmail.com>
In-Reply-To: <e378cfb20806122242u67c866d6vddecf3f42ce30c4b@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] changing a USB blutooth dongle mac address
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

Quoting Nel D <newatlinux@gmail.com>:

> On Fri, Jun 13, 2008 at 1:11 AM,  <neil@cloudsprinter.com> wrote:
>>
>> sorry if this has been here before, but i have been driving my self
>> mad on google and trying things, i am working on a bluegiga access
>> server box, i need to be able to make the box think my computer is one
>> of the phones in its oui list for testing, there for i need to change
>> the mac address of my usb dongle.
>
> My understanding of your question is that you want a bluetooth enabled
> device look up as a phone when it is searched by other bluetooth
> enabled device. If this is what you want to perform then i guess you
> can do it by editing the file  /etc/bluetooth/hcid.conf   to set the
> device class. "man hcid" should tell you what bits need to be set.
>

thanks.. seems i have been totally wasting my time.. i need to chage  
the bletooth class of device, not mess with the mac address

someone else pointed me to this.. which should help.. i thoguht i'd  
post it here incase someone else is having my issues ;)

http://bluetooth-pentest.narod.ru/software/bluetooth_class_of_device-service_generator.html





-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
