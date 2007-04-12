Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Per Thomas Jahr <perja@extern.uio.no>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <461BB6A4.6070100@access-company.com>
References: <1176218309.28200.198.camel@pc047.qadoc.oslo.opera.com>
	<461BB6A4.6070100@access-company.com>
Date: Thu, 12 Apr 2007 08:37:12 +0200
Message-Id: <1176359832.22896.12.camel@pc047.qadoc.oslo.opera.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] A2DP - using a mobile as source?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tue, 2007-04-10 at 18:09 +0200, Frederic Dalleau wrote:
> Hi,
> 
> Per Thomas Jahr wrote:
> > Does anyone know if it's possible to use the a2dpd program for streaming
> > audio from a mobile (Sony Ericsson K800i) to an Alsa output on the PC?
> >   
> A2dpd do not have this role but there is a program a2recv that does what 
> you want.
> I think it is available in btsco-0.5 tarball on sourceforge or look for 
> btsco module in cvs.

Thank you - it works! I'm not sure of how useful this is, but it's very
cool.

I had to modify the source a bit. Also I will implement the missing
parts of the protocol (f.ex. a "suspend stream" is issued when I change
tracks). I guess I will post the code somewhere when I'm finished (or
commit it to cvs).

Thanks
-- 
Per Thomas


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
