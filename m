Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4489AC19.3030200@free.fr>
Date: Fri, 09 Jun 2006 19:12:57 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4489AB13.3020501@dgreaves.com>
In-Reply-To: <4489AB13.3020501@dgreaves.com>
Subject: Re: [Bluez-devel] 2 instances of btsco on one dongle...
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

David Greaves wrote:
> Hi
> 
> I'm running btsco 0.42 happily with an HDW-3 headset and an Epox (CSR)
> USB dongle on 2.6.16.9.
> 
> I'd like to be able to use 2 headsets with the same dongle. That should
> work shouldn't it? (theoretically)
> 
> When I run a second btsco it just creates a new connection and
> overwrites the old one. I was going to start hacking around the source
> to see if I could make it work but I thought I'd check to see if it was
> feasible or if I've misunderstood something.
> 
> David
> 

Hello David,

I don't know if btsco can handle more than one headset, however what is 
sure is that the hci USB driver cannot (as SCO support is not complete...)
Having what you want to work might require quite a lot of work actually :-(

Cheer,

Fabien


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
