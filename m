Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0610260201t5d8eb232l2e1ec89d16234a31@mail.gmail.com>
Date: Thu, 26 Oct 2006 05:01:58 -0400
From: "Joseph Vissarionovich Dzhugashvili" <albert@csail.mit.edu>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1161847943.28956.235.camel@ODole-Ubuntu>
MIME-Version: 1.0
References: <1161845689.8837.8.camel@amarnath-desktop>
	<1161847943.28956.235.camel@ODole-Ubuntu>
Subject: Re: [Bluez-users] Problem while compiling bluez-utils 3.7
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Or wait a few hours and upgrade to Edgy ;)

-albert

On 10/26/06, Olivier Dole <olivier.dole@palmsource.com> wrote:
> Hello,
>
> simply do:
> sudo apt-get install libdbus-1-dev
> and then retry configure step ;)
>
> Regards,
>
> Olivier
>
> Le jeudi 26 octobre 2006 =E0 12:24 +0530, Amarnath a =E9crit :
> > hi,
> >
> > I am getting problem when i try to compile Bluez-Utils3.7 :
> >
> > $./configure --prefix=3D/usr --mandir=3D/usr/share/man --sysconfdir=3D/=
etc
> > --localstatedir=3D/var --libexecdir=3D/lib
> >
> > the error was :
> > checking for DBUS... configure: error: dbus > 0.35 is required
> >
> > but Dbus 0.6 is loaded on my system(ubuntu) . Can anybody have
> > solution , how should i solve the problem. Any comments are
> > appreciated.
> >
> > thanx in advance
> > Amarnath.
> >
> > This message contains confidential information and is intended only
> > for the individual named. If you are not the named addressee you
> > should not disseminate, distribute or copy this e-mail. Please
> > notify the sender immediately by e-mail if you have received this
> > e-mail by mistake and delete this e-mail from your system. E-mail
> > transmission cannot be guaranteed to be secured or error-free as
> > information could be intercepted, corrupted, lost, destroyed, arrive
> > late or incomplete, or contain viruses. The sender therefore does
> > not accept liability for any errors or omissions in the contents
> > of this message, which arise as a result of e-mail transmission.
> >
> > For further query please contact info@fortuna.com
> > -----------------------------------------------------------------------=
--
> > Using Tomcat but need to do more? Need to support web services, securit=
y?
> > Get stuff done quickly with pre-integrated technology to make your job =
easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geron=
imo
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> > _______________________________________________ Bluez-users mailing lis=
t Bluez-users@lists.sourceforge.net https://lists.sourceforge.net/lists/lis=
tinfo/bluez-users
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
