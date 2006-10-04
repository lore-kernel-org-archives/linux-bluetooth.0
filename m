Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4523A57A.4020709@vasmac.com>
Date: Wed, 04 Oct 2006 08:13:46 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4521DCC4.6090705@vasmac.com>	<e1effdeb0610030954o50ef2d6elf25e77e3a85737ac@mail.gmail.com>	<e1effdeb0610031048i3e290d5cu59f3d8670627d8b2@mail.gmail.com>	<4523113E.4000608@vasmac.com>
	<1159950383.1601.3.camel@localhost>
In-Reply-To: <1159950383.1601.3.camel@localhost>
Subject: Re: [Bluez-devel] Error: Authentication Failure
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
...
>>> It's pretty easy to reproduce. I've tried with two USB dongles
>>> (CSR & Broadcom) and different headsets. Connect a device
>>> on Linux, then take the device and dongle and connect on
>>> Windows; when you go back with both to Linux you get this
>>> problem.
>>>
>>> You are right that one can remove the bonding manually but
>>> this is not obvious to the uninitiated and it requires a manual
>>> step. Plus, the message presented to the application is
>>> typically "Record not found" if the first connection is an SDP
>>> lookup.
>>>
>>> Perhaps in security.c in utils/hcid, the routine conn_complete
>>> should delete the cached entry if there's an error.
>>>       
>
> this is not an option, because it will be a security risk. We have to
> keep the old key until we actually generated a new one or someone
> deleted the old one. The only think that is possible it too improve the
> error message.
>
> These are also known errors and you can even switch BlueZ into a pairing
> once mode. This is because device should implement a pairing mode. That
> means that will never accept a pairing if they are not in that mode. So
> if the link key is a wrong one, it simply rejects the connection instead
> of starting a new pairing process.
>
> Regards
>
> Marcel
>   
Hi Marcel,

I'm not familiar with the security issues; that is not my focus.
I game a suggestion based on a cursory look at the source code.
There is a problem here and it looks like the Windows
environment can cope with this but Bluez can't. Granted this
is not very common condition.

Jose


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
