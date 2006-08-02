Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 2 Aug 2006 19:16:32 +0200
From: Stefan Maintz <stefanmaintz@gmx.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20060802191632.090909b3@p4.prod.lan>
In-Reply-To: <1154525837.3905.49.camel@aeonflux.holtmann.net>
References: <20060802120735.632c4f18@p4.prod.lan>
	<1154525837.3905.49.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] system freeze in 2.6.17-mh5
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

 
> this looks like a problem with the kthread API. We converted BNEP,
> CMTP and HIDP to it with 2.6.17-mh3. So a 2.6.17-mh2 kernel should
> work without any problems.
> 
> Christoph, any ideas. Did you see a similar problem before.
> 
> Regards
> 
> Marcel

Just patched my kernel with the mh2-patch and it works nicely! Thx a
lot so far!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
