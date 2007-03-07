Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 7 Mar 2007 00:31:45 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070307033145.GA9009@jh-mbp>
References: <1173227233.10237.44.camel@cookie.hadess.net>
	<1173267255.28512.3.camel@aeonflux.holtmann.net>
	<1173272708.10237.81.camel@cookie.hadess.net>
MIME-Version: 1.0
In-Reply-To: <1173272708.10237.81.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] non-ASCII chars in device names
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

Hi Bastien,

On Wed, Mar 07, 2007, Bastien Nocera wrote:
> > > In hcid/storage.c:
> > >         for (i = 0; i < 248 && name[i]; i++)
> > >                 if ((unsigned char) name[i] < 32 || name[i] == 127)
> > >                         str[i] = '.';
> > >                 else
> > >                         str[i] = name[i];
> > > 
> > > Why? If the data is correct UTF-8, it could be saved as-is in the file,
> > > minus any tabs, unbreakable spaces, or line feeds.
> > 
> > I don't see any problem with this code. It only replaces all ASCII
> > control characters (including delete). So this must be an issue with
> > still having the old name in the cache.
> 
> It wasn't the old cache (as I delete it, to be sure) but an old
> bluez-utils (3.7) that had this problem. Works fine with 3.9.

Yep, in 3.7 the unsigned char typecast was missing which caused all 
greater than 7 bit characters to be replaced by '.'

Johan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
