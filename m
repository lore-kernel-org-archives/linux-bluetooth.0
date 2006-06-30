Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Pierre-Yves Paulus <py@idlum.be>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1151596732.14964.25.camel@localhost>
References: <1151590561.753.27.camel@localhost>
	<1151596732.14964.25.camel@localhost>
Date: Fri, 30 Jun 2006 08:36:28 +0200
Message-Id: <1151649389.753.32.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus API and rfcomm crashing hcid
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

Hi Marcel,

> run hcid with -n and through gdb. So we get a backtrace and line numbers
> where this fails.

Hope this is what you were looking for:

(gdb) r -xn
Starting program: /tmp/Bluez/bluez-utils-3.1/hcid/hcid -xn
hcid[9730]: Bluetooth HCI daemon
hcid[9730]: Register path:/org/bluez fallback:1
hcid[9730]: Device hci0 has been added
hcid[9730]: Starting security manager 0
hcid[9730]: Device hci0 has been activated
hcid[9730]: Register path:/org/bluez/hci0 fallback:0
hcid[9730]: Connect in progress
hcid[9730]: rfcomm_connect_cb: connected
hcid[9730]: ioctl(RFCOMMCREATEDEV): Operation not supported (95)
)cid[9730]: rfcomm_release(=EC=B7=EC=B7

Program received signal SIGSEGV, Segmentation fault.
g_io_channel_close (channel=3D0x11) at glib-ectomy.c:58
58              close(channel->fd);
(gdb) bt full
#0  g_io_channel_close (channel=3D0x11) at glib-ectomy.c:58
No locals.
#1  0x0805d77b in rfcomm_release (node=3D0x8068118, err=3D0x0) at
dbus-rfcomm.c:174
        req =3D {dev_id =3D 0, flags =3D 3086381648, src =3D {b =3D "h}\006=
\bh}"},
dst =3D {b =3D "\006\b0=E8\006\b"}, channel =3D 95 '_'}
#2  0x0805d9ff in rfcomm_connect_cb (chan=3D0x11, cond=3DG_IO_OUT,
c=3D0x806e830) at dbus-rfcomm.c:323
        sk =3D 11
        ret =3D 0
        err =3D 95
        fd =3D 0
        i =3D 95
        len =3D 10
        ptr =3D 0x0
        req =3D {dev_id =3D -1, flags =3D 3, src =3D {b =3D "=D9\a=F4 \000P=
"}, dst =3D
{b =3D "\222M=BBW`"}, channel =3D 9 '\t'}
        node =3D (struct rfcomm_node *) 0x8068118
        reply =3D (DBusMessage *) 0x0
#3  0x0805fdba in g_main_loop_run (loop=3D0x8066b08) at glib-ectomy.c:302
        nfds =3D 4
        rc =3D 17
        n =3D (struct watch *) 0x4
        w =3D (struct watch *) 0x806e860
        ufds =3D (struct pollfd *) 0x806c828
#4  0x0804c77b in main (argc=3D0, argv=3D0x0) at main.c:729
        addr =3D {hci_family =3D 31, hci_dev =3D 65535}
        flt =3D {type_mask =3D 16, event_mask =3D {0, 536870912}, opcode =
=3D 0}
        sa =3D {__sigaction_handler =3D {sa_handler =3D 0x1, sa_sigaction =
=3D
0x1}, sa_mask =3D {__val =3D {0 <repeats 32 times>}}, sa_flags =3D 1, =

  sa_restorer =3D 0}
        ctl_io =3D (GIOChannel *) 0x11
        opt =3D 17
        daemonize =3D 0
        sdp =3D 0
        experimental =3D 1
(gdb)

As you can see, I'm running the 3.1 version. I would be happy to provide
any other information that could be helpful, if I can.

Regards,
Pierre-Yves


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
