Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] /usr/include/bluetooth/bnep.h
References: <1083857533.16650.25.camel@saag> <200405072351.32016.cijoml@volny.cz> <1083967722.4420.144.camel@pegasus>
In-Reply-To: <1083967722.4420.144.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405080023.12137.cijoml@volny.cz>
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
Date: Sat, 8 May 2004 00:23:12 +0200

On Saturday 08 of May 2004 00:08, Marcel Holtmann wrote:
> Hi Michal,
>
> > > > Great :) And now, do you plane to backport hidp kernel module from
> > > > 2.6 to 2.4?
> > >
> > > I have no plans for doing this.
> >
> > oh :( On my laptop bluez and few other drivers still oopses as I reported
> > few days ago...
> > I still can't use 2.6...
> >
> > Can you change your plans? ;-]
>
> I don't really think so, because this is not an easy work and my focus
> is on 2.6. However I added some missing stuff to hidd and it will be
> enabled in bluez-utils-2.7 even if I haven't published a patch that
> includes the hidp kernel module so far.

It is needed to have hid support in 2.4 and doesn't metter which way it will 
be supported. But I except, that you'll make bthid deprecated when hidp 
kernel module will be released, so... 

Michal


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
