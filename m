Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Per Thomas Jahr <perja@extern.uio.no>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1159993227.8692.2.camel@localhost>
References: <1159992040.19347.29.camel@localhost.localdomain>
	<1159992339.8692.0.camel@localhost>
	<1159992821.19347.32.camel@localhost.localdomain>
	<1159993227.8692.2.camel@localhost>
Date: Thu, 05 Oct 2006 08:49:31 +0200
Message-Id: <1160030972.18364.175.camel@pc044.coreteam.oslo.opera.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Problems with security block
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

On Wed, 2006-10-04 at 22:20 +0200, Marcel Holtmann wrote:
> Hi Per,
> 
> > > show us the output of "hcidump -X -V" for both attempts.
> > 
> > That was quick :-)
> > 
> > Outputs for both attempts are attached.
> 
> it seems that the RFCOMM server on the Linux died between the connects
> or is no longer accepting another incoming connection.

OK, I see. I will take a closer look at my accept and open loop in the
server. Thanks.

-- 
Per Thomas


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
