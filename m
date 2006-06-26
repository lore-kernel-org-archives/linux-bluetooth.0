Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606252100l772b6de2ida4b3dc07c2b89a6@mail.gmail.com>
Date: Mon, 26 Jun 2006 09:30:44 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200606251632.12624.g.issel@fh-wolfenbuettel.de>
MIME-Version: 1.0
References: <200606251632.12624.g.issel@fh-wolfenbuettel.de>
Subject: Re: [Bluez-devel] reading response on bluetooth socket
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0032573926=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0032573926==
Content-Type: multipart/alternative;
	boundary="----=_Part_38147_14034279.1151294444825"

------=_Part_38147_14034279.1151294444825
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Goetz,

On 6/25/06, G=F6tz Issel <g.issel@fh-wolfenbuettel.de> wrote:
>
> After having set up a rfcommm connection from my notebook to a mobile
> phone I
> need to get the response data from the mobile device. I can read from the
> socket using 'recv()' but if no data is there at thaht moment this will
> block
> the process or pause my program. What I need to do is get a signal on
> 'data
> available' on the socket for reading or a non blocking read. I heard ther=
e
> is
> a function 'select()' .. but it does not seem to work or I don't
> understand
> it. It needs to be as simple as possible.


This is correct. A read() will block your thread completely.
You have two options:
- Write from one thread and read from another (Doesn't sound interesting!)
- Use select

This is what I have now:
>
> // init + declare variables
>        fd_set readFds;
>        struct timeval timeout;
>        struct sockaddr_rc addr =3D { 0 };
>        int rfcomm_sock, status;
>
> // allocate a socket
>         rfcomm_sock =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)=
;
>
> // set the connection parameters (who to connect to)
>        addr.rc_family =3D AF_BLUETOOTH;
>        addr.rc_channel =3D (uint8_t) dest_channel;
>        str2ba( dest, &addr.rc_bdaddr );
>
> // connect to server, here mobile phone
>         status =3D connect(rfcomm_sock, (struct sockaddr *)&addr,
> sizeof(addr));
>
>        timeout.tv_sec=3D5;
>        timeout.tv_usec=3D0;
>        FD_ZERO(&readFds);
>        FD_SET(rfcomm_socket, &readFds);
>        if (select(rfcommsocket + 1, &readFds, NULL, NULL, &timeout) =3D=
=3D 0)
>        {
>                printf("timed out");
>        }
>        else
>                printf("data ready for read");


Ahh, I assume that rfcomm_sock, rfcomm_socket and rfcommsocket refer to the
same thing.
God! did the above code ever compile??

Try the following code snippet which works for me:
fd_set readfds;
FD_ZERO(&readfds);
FD_SET(rfcomm_sock, &readfds);
while(1) {
  int ready =3D select(FD_SETSIZE, &readfds, 0, 0, 0);
  if(ready =3D=3D 0)
   continue;
  if(ready =3D=3D -1 && errno !=3D EINTR)
   break;
  if(FD_ISSET(rfcomm_sock, &readfds)) {
    /* You've got something on rfcomm_sock, perform a read */
   int size =3D 1024;
   size =3D read(rfcomm_sock, &buf, 1024);//buf is a char array declared
somewhere
   /* Now, you have got the data in buf, parse it for the SAP header and
send a response if required */
  }
}


Hope that helps.

Regards,
Mayank

------=_Part_38147_14034279.1151294444825
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Goetz,<br><br>
<div><span class=3D"gmail_quote">On 6/25/06, <b class=3D"gmail_sendername">=
G=F6tz Issel</b> &lt;<a href=3D"mailto:g.issel@fh-wolfenbuettel.de">g.issel=
@fh-wolfenbuettel.de</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">After having set up a rfcommm co=
nnection from my notebook to a mobile phone I<br>need to get the response d=
ata from the mobile device. I can read from the
<br>socket using 'recv()' but if no data is there at thaht moment this will=
 block<br>the process or pause my program. What I need to do is get a signa=
l on 'data<br>available' on the socket for reading or a non blocking read. =
I heard there is
<br>a function 'select()' .. but it does not seem to work or I don't unders=
tand<br>it. It needs to be as simple as possible.</blockquote>
<div>&nbsp;</div>
<div>This is correct. A read() will block your thread completely.</div>
<div>You have two options:</div>
<div>- Write from one thread and read from another (Doesn't sound interesti=
ng!)</div>
<div>- Use select</div><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">This is what I have now:<br><br>=
// init + declare variables<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd_set =
readFds;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct timeval timeout;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sockaddr_rc addr =3D { 0 };=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rfcomm_sock, status;<br><br>//=
 allocate a socket<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rfcom=
m_sock =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);<br><br>// set=
 the connection parameters (who to connect to)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr.rc_family =3D AF_BLUETOOTH;<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr.rc_channel =3D (uint8_t) dest_c=
hannel;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str2ba( dest, &amp;addr.rc_=
bdaddr );<br><br>// connect to server, here mobile phone<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;status =3D connect(rfcomm_sock, (struct so=
ckaddr *)&amp;addr, sizeof(addr));
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout.tv_sec=3D5;<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout.tv_usec=3D0;<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; FD_ZERO(&amp;readFds);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; FD_SET(rfcomm_socket, &amp;readFds);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (select(rfcommsocket + 1, &amp;readFds, NULL, NULL, &amp;timeout) =
=3D=3D 0)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;timed =
out&quot;);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;data ready for read&quot;=
);</blockquote>
<div>&nbsp;</div>
<div>Ahh, I assume that rfcomm_sock, rfcomm_socket and rfcommsocket refer t=
o the same thing.</div>
<div>God! did the above code ever compile??</div>
<div>&nbsp;</div>
<div>Try the following code snippet which works for me:</div>
<div>fd_set readfds;<br>FD_ZERO(&amp;readfds);<br>FD_SET(rfcomm_sock, &amp;=
readfds);</div>
<div>while(1) {</div>
<div>&nbsp;&nbsp;int ready =3D select(FD_SETSIZE, &amp;readfds, 0, 0, 0);<b=
r>&nbsp;&nbsp;if(ready =3D=3D 0)<br>&nbsp;&nbsp;&nbsp;continue;<br>&nbsp;&n=
bsp;if(ready =3D=3D -1 &amp;&amp; errno !=3D EINTR)<br>&nbsp;&nbsp;&nbsp;br=
eak;<br>&nbsp;&nbsp;if(FD_ISSET(rfcomm_sock, &amp;readfds)) {</div>
<div>&nbsp;&nbsp;&nbsp; /* You've got something on rfcomm_sock,&nbsp;perfor=
m a read&nbsp;*/</div>
<div>&nbsp;&nbsp; int size =3D 1024;<br>&nbsp;&nbsp;&nbsp;size =3D read(rfc=
omm_sock, &amp;buf, 1024);//buf is a char array declared somewhere</div>
<div>&nbsp;&nbsp; /* Now, you have got the data in buf, parse it for the SA=
P header and send a response if required&nbsp;*/</div>
<div>&nbsp;&nbsp;}</div>
<div>}</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Hope that helps.</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Mayank</div></div>

------=_Part_38147_14034279.1151294444825--


--===============0032573926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0032573926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0032573926==--
