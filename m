Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Tue, 7 Nov 2006 12:11:13 +0530
Message-ID: <00a501c70237$b8464be0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <454F6A79.40603@palmsource.com>
Subject: Re: [Bluez-devel] DUN Gateway
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

Hi Fr=E9d=E9ric,

I tried this out and it actually works.
Thanks for your great patch! It is really helpful!

Best Regards,

Mayank


Fr=E9d=E9ric DALLEAU wrote:
> Hi,
> =

> I don't know if you can make dund work like this, however, =

> the patch I =

> just proposed can be used in a similar way :
> See thread called "[Bluez-devel] rfcomm patch to startup an =

> executable =

> at connection"
> If a modem is installed on a serial port, then a simple gateway =

> application can be used between /dev/rfcomm0 and the modem.
> =

> 1) Create SDP record:
> sdptool add --channel 20 DUN
> =

> 2) setup your serial port
> stty -F /dev/ttyS0 115200 ...
> =

> 3) Start the rfcomm utility in watch mode:
> rfcomm --raw watch 0 20 gateway_app {} /dev/ttyS0
> Note: the {} will be replaced by /dev/rfcomm0.
> =

> 4) Setup your DUN data terminal and connect.
> Upon connection, rfcomm launches a gateway_app process.
> =

> It's up to you to write the gateway ;) Something like this =

> should be enough:
> =

> int f1 =3D open(argv[1]);
> int f2 =3D open(argv[2]);
> while(!error)
> {
> int fd =3D poll(f1, f2)
> if(fd=3D=3D1)
>     read(f1); write(f2);
> else if(fd=3D=3D2)
>     read(f2); write(f1);
> else error;
> }
> close(f1);
> close(f2);
> =

> Maybe a shell command already exists
> =

> Hope this helps!
> Fr=E9d=E9ric
> =

> =

> Mayank BATRA a =E9crit :
> > Hi Marcel,
> >
> > There is an option --dialup -u (Pretend to be a =

> dialup/telephone) in the dund daemon. But I see that this =

> option only registers a DIALUP_NET_SVCLASS_ID SDP record. It =

> does nothing else apart from that. My requirement is that I =

> want to make dund work as a DUN Gateway. Thus, it should read =

> AT commands sent from the DUN Terminal and send back responses to it.
> > Is there some way through which I can make dund do so?
> >
> > Best Regards,
> >
> > Mayank


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
