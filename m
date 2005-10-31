Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051031153846.77684.qmail@web32007.mail.mud.yahoo.com>
From: Dani Camps <danicamps81@yahoo.com>
Subject: Re: [Bluez-users] Problems compiling btsco
To: bluez-users@lists.sourceforge.net
In-Reply-To: <436637AE.70408@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 31 Oct 2005 07:38:46 -0800 (PST)

Thanks for the reply, 

I ran the command you told me and I think it was fine
this is the output :

______________
[root@localhost btsco]# aclocal -I /usr/share/aclocal
&& autoheader && automake --add-missing --copy &&
autoconf

/usr/share/aclocal/wxwin.m4:36: warning: underquoted
definition of AM_OPTIONS_WXCONFIG
  run info '(automake)Extending aclocal'
  or see
http://sources.redhat.com/automake/automake.html#Extending-aclocal
/usr/share/aclocal/wxwin.m4:59: warning: underquoted
definition of AM_PATH_WXCONFIG
/usr/share/aclocal/progsreiserfs.m4:13: warning:
underquoted definition of AC_CHECK_LIBREISERFS
______________

My problem now comes when I run configure, I get this
error:

__________________________

checking bluetooth/bluetooth.h usability... no
checking bluetooth/bluetooth.h presence... no
checking for bluetooth/bluetooth.h... no
configure: error: Bluetooth header files not found
_______________________

I have all the bluez packages installed, so what am I
missing ? What are these headers it can not find ?

Thanks

Dani

PS: My system is a Fedora Core 3, with
2.6.12-1.1372_FC3 kernel, bluez 2.10-2 and alsa-driver
and alsa-lib.1.0.9rc4a.

--- Brad Midgley <bmidgley@xmission.com> wrote:

> Dani
> 
> try this instead of running bootstrap:
> 
> aclocal -I /usr/share/aclocal && autoheader &&
> automake --add-missing
> --copy && autoconf
> 
> i am probably going to take out the version check
> since it's outdated.
> 
> brad
> 
> > I am trying to compile btsco to add support for my
> > headset.
> > When running bootstrap it asks for automake-1.7, I
> > have in my system automake-1.9.2-3, so is there a
> way
> > to tell  bootstrap to use the automake-1.9.2-3 or
> I
> > should install automake-1.7 anyway ?
> > 
> > Thanks
> > 
> > Dani
> > 
> > 
> > 	
> > 		
> > __________________________________ 
> > Yahoo! Mail - PC Magazine Editors' Choice 2005 
> > http://mail.yahoo.com
> > 
> > 
> >
>
-------------------------------------------------------
> > This SF.Net email is sponsored by the JBoss Inc.
> > Get Certified Today * Register for a JBoss
> Training Course
> > Free Certification Exam for All Training Attendees
> Through End of 2005
> > Visit http://www.jboss.com/services/certification
> for more information
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> >
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.
> Get Certified Today * Register for a JBoss Training
> Course
> Free Certification Exam for All Training Attendees
> Through End of 2005
> Visit http://www.jboss.com/services/certification
> for more information
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
