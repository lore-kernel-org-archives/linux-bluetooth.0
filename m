Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY103-W384F0CD67A81C73CE7167F7260@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="_acdb1c71-1ce9-413d-874d-b647266eb24a_"
From: "Verber Seti" <verber_s@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] sendto give invalid argument
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
Date: Fri, 13 Jan 2006 18:15:42 -0500

--_acdb1c71-1ce9-413d-874d-b647266eb24a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello, I'm new to using Bluez. I need to create a simple program to send te=
xt over a specific type of port (SOCK_DGRAM, BTPROTO_L2CAP). The code compi=
les fine, but when I run it i get the following error (from then sendto fun=
ction). Send Failed: Invalid argument What might the problem be? My code is=
 shown below. Thank-you so much for any help that you can offer.,verber #in=
clude <stdio.h>#include <stdlib.h>#include <errno.h>#include <string.h> #in=
clude <bluetooth/bluetooth.h>#include <bluetooth/l2cap.h>#include <bluetoot=
h/hci.h>#include <bluetooth/hci_lib.h> #include "l2cap_msg_send.h" int fd; =
int send_msg(){	/* SETTING UP SOCKET */	struct sockaddr_l2 addr;    unsigne=
d int psm =3D 0x1001;        fd =3D socket(AF_BLUETOOTH, SOCK_DGRAM, BTPROT=
O_L2CAP);    if (fd =3D=3D -1) {        fprintf(stderr, "Could not open soc=
ket: %s\n", strerror(errno));		exit(1);    }    addr.l2_family =3D AF_BLUET=
OOTH;    bacpy(&addr.l2_bdaddr, BDADDR_ANY);    addr.l2_psm    =3D htobs(ps=
m);     if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {       =
 fprintf(stderr, "Could not bind socket: %s\n", strerror(errno));		exit(1);=
    }    /* END: SETTING UP SOCKET*/        /* SET UP MSG */    char recv_a=
ddr[18] =3D "00:0A:3A:53:1C:42";        struct sockaddr_l2 recipient;    re=
cipient.l2_family =3D AF_BLUETOOTH;    str2ba(recv_addr,&(recipient.l2_bdad=
dr));    recipient.l2_psm =3D htobs(psm);        char message[] =3D "57 123=
 189";    /* END: SET UP MSG */ 	/* SEND MSG */    int ret; 	socklen_t len;=
	len=3Dsizeof(recipient.l2_bdaddr);		size_t msg_len;	msg_len=3Dsizeof(messa=
ge);     ret =3D sendto(fd, &message, msg_len,0, (struct sockaddr *) &recip=
ient, len);    printf("%d\n",ret);    if( ret < 0 ) fprintf(stderr,"Send Fa=
iled: %s\n",strerror(errno));	/* END: SEND MSG */ //	close(fd);       retur=
n 0;}
_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/=

--_acdb1c71-1ce9-413d-874d-b647266eb24a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>=0A=
<head>=0A=
<style>=0A=
P=0A=
{=0A=
margin:0px;=0A=
padding:0px=0A=
}=0A=
body=0A=
{=0A=
FONT-SIZE: 10pt;=0A=
FONT-FAMILY:Tahoma=0A=
}=0A=
</style>=0A=
</head>=0A=
<body><P>Hello,</P><P> </P><P>I'm new to using Bluez. I need to create a si=
mple program to send text over a specific type of port (SOCK_DGRAM, BTPROTO=
_L2CAP). The code compiles fine, but when I run it i get the following erro=
r (from then sendto function).</P><P> </P><P>Send Failed: Invalid argument<=
/P><P> </P><P>What might the problem be? My code is shown below. Thank-you =
so much for any help that you can offer.</P><P>,verber</P><P> </P><P>#inclu=
de &lt;stdio.h&gt;</P><P>#include &lt;stdlib.h&gt;</P><P>#include &lt;errno=
.h&gt;</P><P>#include &lt;string.h&gt;</P><P> </P><P>#include &lt;bluetooth=
/bluetooth.h&gt;</P><P>#include &lt;bluetooth/l2cap.h&gt;</P><P>#include &l=
t;bluetooth/hci.h&gt;</P><P>#include &lt;bluetooth/hci_lib.h&gt;</P><P> </P=
><P>#include &quot;l2cap_msg_send.h&quot;</P><P> </P><P>int fd;</P><P> </P>=
<P>int send_msg()</P><P>{</P><P>	/* SETTING UP SOCKET */</P><P>	struct sock=
addr_l2 addr;</P><P>    unsigned int psm =3D 0x1001;</P><P>    </P><P>    f=
d =3D socket(AF_BLUETOOTH, SOCK_DGRAM, BTPROTO_L2CAP);</P><P>    if (fd =3D=
=3D -1) {</P><P>        fprintf(stderr, &quot;Could not open socket: %s\n&q=
uot;, strerror(errno));</P><P>		exit(1);</P><P>    }</P><P>    addr.l2_fami=
ly =3D AF_BLUETOOTH;</P><P>    bacpy(&amp;addr.l2_bdaddr, BDADDR_ANY);</P><=
P>    addr.l2_psm    =3D htobs(psm);</P><P> </P><P>    if (bind(fd, (struct=
 sockaddr *) &amp;addr, sizeof(addr)) &lt; 0) {</P><P>        fprintf(stder=
r, &quot;Could not bind socket: %s\n&quot;, strerror(errno));</P><P>		exit(=
1);</P><P>    }</P><P>    /* END: SETTING UP SOCKET*/</P><P>    </P><P>    =
/* SET UP MSG */</P><P>    char recv_addr[18] =3D &quot;00:0A:3A:53:1C:42&q=
uot;;</P><P>    </P><P>    struct sockaddr_l2 recipient;</P><P>    recipien=
t.l2_family =3D AF_BLUETOOTH;</P><P>    str2ba(recv_addr,&amp;(recipient.l2=
_bdaddr));</P><P>    recipient.l2_psm =3D htobs(psm);</P><P>    </P><P>    =
char message[] =3D &quot;57 123 189&quot;;</P><P>    /* END: SET UP MSG */<=
/P><P> </P><P>	/* SEND MSG */</P><P>    int ret;</P><P> </P><P>	socklen_t l=
en;</P><P>	len=3Dsizeof(recipient.l2_bdaddr);</P><P>	</P><P>	size_t msg_len=
;</P><P>	msg_len=3Dsizeof(message);</P><P> </P><P>    ret =3D sendto(fd, &a=
mp;message, msg_len,0, (struct sockaddr *) &amp;recipient, len);</P><P>    =
printf(&quot;%d\n&quot;,ret);</P><P>    if( ret &lt; 0 ) fprintf(stderr,&qu=
ot;Send Failed: %s\n&quot;,strerror(errno));</P><P>	/* END: SEND MSG */</P>=
<P> </P><P>//	close(fd);   </P><P>    return 0;</P><P>}</P><br /><hr />Expr=
ess yourself instantly with MSN Messenger! <a href=3D'http://clk.atdmt.com/=
AVE/go/onm00200471ave/direct/01/' target=3D'_new'>MSN Messenger</a></body>=
=0A=
</html>=

--_acdb1c71-1ce9-413d-874d-b647266eb24a_--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
