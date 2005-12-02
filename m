Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <94e407f00512020254pb83407ds7fec44efaaca1385@mail.gmail.com>
From: Arpit Rai <whalesurf@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Definition of hci_conn_info_req
In-Reply-To: <1133519615.11226.13.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22161_26308529.1133520856381"
References: <94e407f00512020222g42375059h491249e313cea536@mail.gmail.com>
	 <1133519615.11226.13.camel@blade>
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
Date: Fri, 2 Dec 2005 18:54:16 +0800

------=_Part_22161_26308529.1133520856381
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel

> no, it is not.

What does hci_conn_info_req do then?Any documentation anywhere?I'm kinda
lost with all the Bluez code.

> Depends on how you convert the address. Use ba2str().

Yes I'm using ba2str to convert.My question is, should &cr->bdaddr contain
the address of the remote bluetooth device?

    char add[18];
    struct hci_conn_info_req *cr;
    cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
    bacpy( &cr->bdaddr, &bdaddr );
    ba2str( &bdaddr, add);
    printf("Bluetooth address-remote device: %s \n", add);
    cr->type =3D ACL_LINK;

Everytime I run the executable C, I get a different value for &cr->bdaddr.

Regards
Arpit

On 12/2/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arpit,
>
> > Another basic question.The statement below is a request to establish
> > connection with a remote device,right?
>
> no, it is not.
>
> > struct hci_conn_info_req *cr;
> > cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
> >
> > Now,is &cr->bdaddr supposed to be the remote device bluetooth address?
> >
> > When I convert this value to string and output it, it doesn't give me
> > the correct value for the remote bluetooth device. It returns
> > 08:04:9A:AC:00:00. Doesn't make sense to me.
>
> Depends on how you convert the address. Use ba2str().
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_22161_26308529.1133520856381
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel<br>
<br>
&gt; no, it is not.<br>
<br>
What does hci_conn_info_req do then?Any documentation anywhere?I'm kinda lo=
st with all the Bluez code.<br>
<br>
&gt; Depends on how you convert the address. Use ba2str().<br>
<br>
Yes I'm using ba2str to convert.My question is, should &amp;cr-&gt;bdaddr c=
ontain the address of the remote bluetooth device? <br>
<br>
&nbsp;&nbsp;&nbsp; char add[18];<br>

&nbsp;&nbsp;&nbsp; struct hci_conn_info_req *cr;&nbsp;&nbsp;  <br>

&nbsp;&nbsp;&nbsp; cr =3D malloc(sizeof(*cr) + sizeof(struct hci_conn_info)=
);<br>

&nbsp;&nbsp;&nbsp; bacpy( &amp;cr-&gt;bdaddr, &amp;bdaddr );<br>

&nbsp;&nbsp;&nbsp; ba2str( &amp;bdaddr, add);<br>

&nbsp;&nbsp;&nbsp; printf(&quot;Bluetooth address-remote device: %s \n&quot=
;, add);<br>

&nbsp;&nbsp;&nbsp; cr-&gt;type =3D ACL_LINK;<br>
<br>
Everytime I run the executable C, I get a different value for &amp;cr-&gt;b=
daddr. <br>
<br>
Regards<br>
Arpit<br><br><div><span class=3D"gmail_quote">On 12/2/05, <b class=3D"gmail=
_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org"=
>marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
Hi Arpit,<br><br>&gt; Another basic question.The statement below is a reque=
st to establish<br>&gt; connection with a remote device,right?<br><br>no, i=
t is not.<br><br>&gt; struct hci_conn_info_req *cr;<br>&gt; cr =3D malloc(s=
izeof(*cr) + sizeof(struct hci_conn_info));
<br>&gt;<br>&gt; Now,is &amp;cr-&gt;bdaddr supposed to be the remote device=
 bluetooth address?<br>&gt;<br>&gt; When I convert this value to string and=
 output it, it doesn't give me<br>&gt; the correct value for the remote blu=
etooth device. It returns
<br>&gt; 08:04:9A:AC:00:00. Doesn't make sense to me.<br><br>Depends on how=
 you convert the address. Use ba2str().<br><br>Regards<br><br>Marcel<br><br=
><br><br><br>-------------------------------------------------------<br>
This SF.net email is sponsored by: Splunk Inc. Do you grep through log file=
s<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search=
 engine that makes<br>searching your log files as easy as surfing the&nbsp;=
&nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!
<br><a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;o=
p=3Dclick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3D=
click</a><br>_______________________________________________<br>Bluez-users=
 mailing list
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</=
a>
<br></blockquote></div><br>

------=_Part_22161_26308529.1133520856381--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
