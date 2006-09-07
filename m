Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Javier Cuesta <jcuesta@pindiatec.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200609061228.41138.jcuesta@pindiatec.com>
	<5f30e2610609060501n10f77d8fj4ed489c4cc9f3ae6@mail.gmail.com>
In-Reply-To: <5f30e2610609060501n10f77d8fj4ed489c4cc9f3ae6@mail.gmail.com>
MIME-Version: 1.0
Date: Thu, 7 Sep 2006 11:18:54 +0200
Message-Id: <200609071118.54616.jcuesta@pindiatec.com>
Subject: Re: [Bluez-devel] Starting to work with bluez
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

HI jeff and thanks for your answer,

Albert Huang's Web is helping me a lot but i still have some problems, Im =

trying to writte some simple code, just for starting to work with bluez, an=
d =

im findin some problems ussing the libraries, for example:

Im trying to writte the class of device using hci_write_class_of_dev(int dd=
, =

uint32_t cls, int to) im having problems ussing the libraries becouse i hav=
e =

found no documentation about what "dd" and "to" means(whats suposed to be =

sent to those variables and maybe whats that for).

Im more interested in fidnding a documentation about the libraries themself=
s =

so i can solve the problems that ill find in the future by my own than in =

knowing what those variables means.

Thanks for your help again.

Javier

P.S.: im having problems sending mails to the list, i have to send each mai=
l =

3/4 times becouse all of them return to me with an error, hope they are =

really not reaching you, =BFanyone knows what could be wrong?

El Mi=E9rcoles, 6 de Septiembre de 2006 14:01, Jeff Wilson escribi=F3:
> Albert Huang's work helped me to get started.
> http://people.csail.mit.edu/albert/bluez-intro/
>
> After you read Albert's site, download bluez-utils (rctool, sdptool,
> etc) and use it as an example.
>
>           Regards,
>           Jeff
>
> On 9/6/06, Javier Cuesta <jcuesta@pindiatec.com> wrote:
> > HI all,
> >
> > Here, at pindiatec, we are going to start to develop some aplications
> > using linux and therefore bluez for bluetooth devices, im still gatheri=
ng
> > info on how to do things and would like to know where i can get adition=
al
> > information about how to use bluez, any information or advice is wellco=
me
> > but i have some concerns:
> >
> > - =BFis there any special documentation about the .h and .c libraries?
> > maybe some short of short explanation of what its suposed to do each
> > function and what their parameters means.
> >
> > - =BFis there any place i can get some short examples to start working
> > with?
> >
> > - I took a look over Marcel web (wich seems quite nice) and although i
> > didn't checked all links it seems it was more focused in how to connect
> > devices than how to program devices, as you could supose im more
> > interesting in programing than in any other thing, any information, web,
> > example or manual about how to program devices using Bluez would be
> > great.
> >
> > Thanks all.
> >
> > (this is the 3rd time i sent this, both last tryes returned with an
> > error, hope tou dont recive this severall times)
> > --
> > ******************************************************
> > Javier Cuesta Ca=F1as
> >
> > PINDIATEC SL
> > Cemcam Of. 114
> > Pg. Trascueto s/n
> > 39600 Camargo -Cantabria- Espa=F1a
> > Tel. +34 942059901 Fax: +34 942059902
> > email: jcuesta@pindiatec.com
> > ******************************************************
> >
> > -----------------------------------------------------------------------=
--
> > Using Tomcat but need to do more? Need to support web services, securit=
y?
> > Get stuff done quickly with pre-integrated technology to make your job
> > easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- =

******************************************************
Javier Cuesta Ca=F1as

PINDIATEC SL
Cemcam Of. 114
Pg. Trascueto s/n
39600 Camargo -Cantabria- Espa=F1a
Tel. +34 942059901 =A0 =A0 =A0Fax: +34 942059902
email: jcuesta@pindiatec.com
******************************************************

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
