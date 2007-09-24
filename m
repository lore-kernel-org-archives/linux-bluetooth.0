Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46F7DD20.60407@tfh-berlin.de>
Date: Mon, 24 Sep 2007 17:52:00 +0200
From: David Rehle <rehle@tfh-berlin.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <46F38209.1050507@tfh-berlin.de>	<d89ddf300709231555x6722b2cl34c40b7100a799e3@mail.gmail.com>
	<1190617970.5133.90.camel@aeonflux.holtmann.net>
In-Reply-To: <1190617970.5133.90.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] can't etablish more than two connections
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

Hi Marcel,

i only changed Link mode to "master". Previous it was set to "accept". 
Next i changed link policy to "hold,sniff,park". Previous it was set to 
nothing.

I want my server to be master without the possibility to change to 
"slave". My server shall serve some incomming requests and i think it 
does it now.

For what side effects you are talking?

There is no much complexity, only to send some data via sockets after a 
request...

Regards,

David


Marcel Holtmann schrieb:
> Hi David,
> 
>> As Marcel points out I"m being lazy with terminology. It's in the
>> hcid.conf link mode and link policy that you control how you negotiate
>> master/slave.
> 
> and you better not touch these settings. If the defaults don't work, you
> should really know what you are doing. There are many side effects that
> can trouble your life later on.
> 
> Regards
> 
> Marcel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
