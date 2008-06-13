Return-Path: <cyrus@holtmann.org>
Message-ID: <e378cfb20806122242u67c866d6vddecf3f42ce30c4b@mail.gmail.com>
Date: Fri, 13 Jun 2008 11:12:30 +0530
From: "Nel D" <newatlinux@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <20080612204135.qbeehdkkasog4o88@webmail.cloudsprinter.com>
MIME-Version: 1.0
References: <20080612204135.qbeehdkkasog4o88@webmail.cloudsprinter.com>
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

On Fri, Jun 13, 2008 at 1:11 AM,  <neil@cloudsprinter.com> wrote:
>
> sorry if this has been here before, but i have been driving my self
> mad on google and trying things, i am working on a bluegiga access
> server box, i need to be able to make the box think my computer is one
> of the phones in its oui list for testing, there for i need to change
> the mac address of my usb dongle.

My understanding of your question is that you want a bluetooth enabled
device look up as a phone when it is searched by other bluetooth
enabled device. If this is what you want to perform then i guess you
can do it by editing the file  /etc/bluetooth/hcid.conf   to set the
device class. "man hcid" should tell you what bits need to be set.


Hope that helps

cheers,
 Nel
>
> ive been messing around with various bits and bobs on my command line
> but not sure if everything i have been doing is totally wrong.
>
> last month i was not a hardware programmer... please help
>
> if this kind of procedure is not one that should be in the public
> domain then please direct mail me
>
> and clues suggestions or advice greatly received
>
> i have built bluez from source with --enable-all , not really sure
> what commands i want to use or how to directly access the stick
>
> Neil
> (UK)
>
>
>
>
>
>
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
