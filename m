Return-Path: <cyrus@holtmann.org>
Message-Id: <CDC3B7EE-50E8-409A-8F70-D98CC13018A5@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e29894ca0804031337n1b68f8c3j9ce3f16fe4867904@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 3 Apr 2008 23:53:40 +0300
References: <1207252447.18442.11.camel@californication>
	<e29894ca0804031337n1b68f8c3j9ce3f16fe4867904@mail.gmail.com>
Subject: Re: [Bluez-devel] [BlueZ-Announce] Release of bluez-libs-3.30 and
	bluez-utils-3.30
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Apr 3, 2008, at 23:37, Marc-Andr=E9 Lureau wrote:
>
> On Thu, Apr 3, 2008 at 10:54 PM, Marcel Holtmann  =

> <marcel@holtmann.org> wrote:
>>
>> After a long discussion, the consensus was to use plugins instead of
>> separate processes for the future of BlueZ. This release marks the  =

>> start
>> of this change. All existing services have been converted to plugins
>> while keeping the old D-Bus API.
>
> I am just being curious, I'd like to know why the separate processes
> approach was dropped.

It isn't of course the whole story (Marcel will probably fill up with  =

more reasons), but the following is a table of the pros/cons of each  =

approach that we created couple of weeks ago when planing the 4.x  =

work: http://iki.fi/jhedberg/plugin-vs-process.jpg

Johan
-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
