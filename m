Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0512051044sc3b9cb4y535e2d709f87d714@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcitool feature patch
In-Reply-To: <43948373.9080606@masaka.cs.ohiou.edu>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_33849_22636644.1133808267426"
References: <43948373.9080606@masaka.cs.ohiou.edu>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 5 Dec 2005 13:44:27 -0500

------=_Part_33849_22636644.1133808267426
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

oh gee, I dunno.  Marcel hates my coding style ;)

better might be to patch the bluez-libs and then patch hcitool to call a
library function.

-albert

On 12/5/05, Jim Wyllie <jwyllie@masaka.cs.ohiou.edu> wrote:
>
> I had to write a program which changed the flush timeout for a Bluetooth
> connection.  I integrated it into my version of hcitool since that
> seemed the appropriate place for it.  The patch applies to hcitool in
> bluez-utils 2.22, and adds the 'ftmo' option (for flush timeout).  Let
> me know if you want me to make any changes.
>
> Jim Wyllie
> IRG Lab
> Ohio University
>
>
> 966a967,1089
> > /* Alter connection timeout (for all connections, unfortunately) */
> >
> > static struct option ftmo_options[] =3D {
> >       { "help",       0, 0, 'h' },
> >       { "tmout",      1, 0, 't' },
> >       { 0, 0, 0, 0 }
> > };
> >
> > static char *ftmo_help =3D
> >       "Usage:\n"
> >       "\tftmo --tmout=3Dvalue bdaddr\n"
> >       "Sets the flush timeout value to 0.625msec * value for bdaddr\n"
> >       "Will change reliability for all connections from
> microcontroller\n";
> >
> > static void cmd_ftmo(int dev_id, int argc, char **argv)
> > {
> >       int err =3D 0, dd, opt, timeout;
> >       struct hci_conn_info_req *cr =3D 0;
> >       struct hci_request rq =3D { 0 };
> >       bdaddr_t *ba;
> >
> >       struct {
> >               uint16_t handle;
> >               uint16_t flush_timeout;
> >       } cmd_param;
> >
> >       struct {
> >               uint8_t  status;
> >               uint16_t handle;
> >       } cmd_response;
> >
> >       for_each_opt(opt, ftmo_options, NULL) {
> >               switch (opt) {
> >
> >               case 't':
> >                       timeout =3D atoi( optarg );
> >
> >                       if( timeout < 0) {
> >                               printf("Must be 1 or greater, or 0 for no
> timeout\n");
> >                               printf(ftmo_help);
> >                       }
> >
> >                       break;
> >
> >               default:
> >                       printf(ftmo_help);
> >                       return;
> >               }
> >       }
> >
> >       argc -=3D optind;
> >       argv +=3D optind;
> >
> >       if (argc < 1) {
> >               printf(ftmo_help);
> >               return;
> >       }
> >
> >       ba =3D (bdaddr_t *)malloc( sizeof( bdaddr_t ) );
> >       str2ba(argv[0], ba);
> >
> >       if (dev_id < 0) {
> >               dev_id =3D hci_get_route(ba);
> >               if (dev_id < 0) {
> >                       perror("Error in obtaining route to device\n");
> >                       return;
> >               }
> >       }
> >
> >       // find the connection handle to the specified bluetooth device
> >       cr =3D (struct hci_conn_info_req*) malloc(
> >       sizeof(struct hci_conn_info_req) +
> >       sizeof(struct hci_conn_info));
> >
> >       bacpy( &cr->bdaddr, ba );
> >
> >       cr->type =3D ACL_LINK;
> >
> >       dd =3D hci_open_dev( dev_id );
> >
> >       if( dd < 0 ) {
> >               err =3D dd;
> >               goto cleanup;
> >       }
> >
> >       err =3D ioctl(dd, HCIGETCONNINFO, (unsigned long) cr );
> >
> >       if( err ) {
> >               fprintf(stderr, "Could not get connection handle, is one
> established yet?\n");
> >               goto cleanup;
> >       }
> >
> >       // build a command packet to send to the bluetooth microcontrolle=
r
> >       cmd_param.handle =3D cr->conn_info->handle;
> >       cmd_param.flush_timeout =3D htobs(timeout);
> >       rq.ogf =3D OGF_HOST_CTL;
> >       rq.ocf =3D 0x28;
> >       rq.cparam =3D &cmd_param;
> >       rq.clen =3D sizeof(cmd_param);
> >       rq.rparam =3D &cmd_response;
> >       rq.rlen =3D sizeof(cmd_response);
> >       rq.event =3D EVT_CMD_COMPLETE;
> >
> >       // send the command and wait for the response
> >       err =3D hci_send_req( dd, &rq, 0 );
> >
> >       if( err ) {
> >               perror("Could not send request to the microcontroller");
> >               goto cleanup;
> >       }
> >
> >       if( cmd_response.status ) {
> >               err =3D -1;
> >               errno =3D bt_error(cmd_response.status);
> >       }
> >
> >       cleanup:
> >               free(cr);
> >               if( dd >=3D 0)
> >               close(dd);
> >               return;
> > }
> >
> 2055a2179
> >       { "ftmo",   cmd_ftmo,   "Modify microcontroller flush timeout" },
>
>
>

------=_Part_33849_22636644.1133808267426
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

oh gee, I dunno.&nbsp; Marcel hates my coding style ;)<br>
<br>
better might be to patch the bluez-libs and then patch hcitool to call a li=
brary function.<br>
<br>
-albert<br><br><div><span class=3D"gmail_quote">On 12/5/05, <b class=3D"gma=
il_sendername">Jim Wyllie</b> &lt;<a href=3D"mailto:jwyllie@masaka.cs.ohiou=
.edu">jwyllie@masaka.cs.ohiou.edu</a>&gt; wrote:</span><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I had to write a program which changed the flush timeout for a Bluetooth<br=
>connection.&nbsp;&nbsp;I integrated it into my version of hcitool since th=
at<br>seemed the appropriate place for it.&nbsp;&nbsp;The patch applies to =
hcitool in<br>bluez-utils=20
2.22, and adds the 'ftmo' option (for flush timeout).&nbsp;&nbsp;Let<br>me =
know if you want me to make any changes.<br><br>Jim Wyllie<br>IRG Lab<br>Oh=
io University<br><br><br>966a967,1089<br>&gt; /* Alter connection timeout (=
for all connections, unfortunately) */
<br>&gt;<br>&gt; static struct option ftmo_options[] =3D {<br>&gt;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;help&quot;,&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0, 0, 'h' },<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { &quot;t=
mout&quot;,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1, 0, 't' },<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0, 0, 0, 0 }<br>&gt; };<br>&gt;<br>&gt; stat=
ic char *ftmo_help =3D
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Usage:\n&quot;<br>&gt;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;\tftmo --tmout=3Dvalue bdaddr\n&qu=
ot;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Sets the flush timeou=
t value to 0.625msec * value for bdaddr\n&quot;<br>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &quot;Will change reliability for all connections from mic=
rocontroller\n&quot;;
<br>&gt;<br>&gt; static void cmd_ftmo(int dev_id, int argc, char **argv)<br=
>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0, dd, opt,=
 timeout;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hci_conn_info_=
req *cr =3D 0;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hci_reque=
st rq =3D { 0 };<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bdaddr_t *ba;<br>&gt;<br>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t handle;<=
br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint16_t flush_timeout;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; } cmd_param;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;status;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; uint16_t handle;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } cmd_response;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for=
_each_opt(opt, ftmo_options, NULL) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (opt) {<br>&gt=
;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; case 't':<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;
timeout =3D atoi( optarg );<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
if( timeout &lt; 0) {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(&quot;Must be 1 or greater, or 0 for no timeout\n&quot;);<br>&gt;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(ftmo_help);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
}<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
break;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
printf(ftmo_help);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
return;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; argc -=3D optind;<br>&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; argv +=3D optind;<br>&gt;<br>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (argc &lt; 1) {<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(=
ftmo_help);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ba =3D (bdaddr_t *)malloc( sizeof( bdaddr_t ) );<br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; str2ba(argv[0], ba);<br>&gt;<br>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev_id &lt; 0) {<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; dev_id =3D hci_get_route(ba);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev_id &lt; 0) {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
perror(&quot;Error in obtaining route to device\n&quot;);<br>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
return;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br=
>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // find the connection ha=
ndle to the specified bluetooth device<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cr =3D (struct hci_conn_info_req*) malloc(<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; sizeof(struct hci_conn_info_req) +
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct hci_conn_info));=
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bacpy( &amp;cr-&gt;bda=
ddr, ba );<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cr-&gt;type =
=3D ACL_LINK;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dd =3D hc=
i_open_dev( dev_id );<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f( dd &lt; 0 ) {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; err =3D dd;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; err =3D ioctl(dd, HCIGETCONNINFO, (unsigned long) cr );<br>&gt;<br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( err ) {<br>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
fprintf(stderr, &quot;Could not get connection handle, is one established
yet?\n&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto cleanup;<br>&gt;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // bui=
ld a command packet to send to the bluetooth microcontroller<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd_param.handle =3D cr-&gt;conn_info-&gt;han=
dle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd_param.flush_timeout =3D htobs(=
timeout);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.ogf =3D OGF_HOST_C=
TL;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.ocf =3D 0x28;<br>&gt;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.cparam =3D &amp;cmd_param;<br>&gt;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.clen =3D sizeof(cmd_param);<br>&gt;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.rparam
 =3D &amp;cmd_response;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.rlen=
 =3D sizeof(cmd_response);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rq.e=
vent =3D EVT_CMD_COMPLETE;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; // send the command and wait for the response<br>&gt;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; err =3D hci_send_req( dd, &amp;rq, 0 );
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( err ) {<br>&gt;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;
perror(&quot;Could not send request to the microcontroller&quot;);<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; goto cleanup;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt=
;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( cmd_response.status ) {<b=
r>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; err =3D -1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errno =3D bt_error(cmd_respons=
e.status);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;<br>&gt;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; cleanup:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free(cr);<br>&gt;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if( dd &gt;=3D 0)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(dd);<br>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br=
>&gt; }<br>&gt;<br>2055a2179<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { =
&quot;ftmo&quot;,&nbsp;&nbsp; cmd_ftmo,&nbsp;&nbsp; &quot;Modify microcontr=
oller flush timeout&quot; },
<br><br><br></blockquote></div><br>

------=_Part_33849_22636644.1133808267426--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
