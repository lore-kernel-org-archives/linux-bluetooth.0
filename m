Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] new bthid and switching off sensor in mouse???
References: <200404021906.54779.cijoml@volny.cz> <200404022335.41175.cijoml@volny.cz> <1080945468.3456.1.camel@pegasus>
In-Reply-To: <1080945468.3456.1.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200404030054.21634.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 3 Apr 2004 00:54:21 +0200

Hi Marcel,

this will be a little school of CVS :)

try:

cvs up -D "23 days ago" libs2 utils2

Michal

Dne so 3. dubna 2004 00:37 jste napsal(a):
> Hi Michal,
>
> > > I don't know what you are talking about, but maybe the battery of your
> > > mouse is almost empty.
> >
> > Hi, my batteries are good.
> > problem is follows:
> >
> > red lightning sensor goes totally off after a while when I for a little
> > time don't move my mouse or don't press button. Light stopps shining.
> > This started happens after updating to latest Bluez-CVS libs2 and utils2
> > previous version were without problem - I tried returned to previous
> > version of CVS and it works OK.
>
> I can't imagine what causes this effect. Do you still have the source
> code of both version? If yes, please diff them, so I can see what I have
> changed.
>
> Regards
>
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
