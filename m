Return-Path: <cyrus@holtmann.org>
Message-ID: <4856EC25.5040508@earthlink.net>
Date: Mon, 16 Jun 2008 17:41:41 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: Voni Hakau <hakauvoni@gmail.com>
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>	
	<4852914F.6020209@earthlink.net>
	<e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
In-Reply-To: <e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez build problem
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

On 06/16/2008 07:05 AM, Voni Hakau wrote:
> On Fri, Jun 13, 2008 at 6:25 PM, Mumia W..
> <paduille.4061.mumia.w+nospam@earthlink.net> wrote:
>> [...]
>> make --prefix=/usr
>>
>> When you "install" the package, you'll use this command:
>>
>> make install DESTDIR=/tmp/buildplace
>> [...]
> 
> Wow this is an amazing idea !! Thank you so much !!
> 
> I didn't know I can give --prefix to make. Or did you mean to ./configure ?
> 
> and I didn't know there is DESTDIR for make install. great great tip !!!
> 
> So I can just do make install DESTDIR with the prefix of my platform 
> root filesystem, 
> right ? I don't have to do the package, right ?
> 
> Thank you so much for this!! it's a really great idea..
> 
> Voni
> 

You're welcome Voni.

Yes, I meant "./configure --prefix=/usr"

But DESTDIR is used during "make install," and as you figured, you can 
use the platform's prefix.

Note that some programs don't use the DESTDIR variable, but almost all do.



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
