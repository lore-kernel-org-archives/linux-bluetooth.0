Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0602200818i38950849pbde9c9ed404590e6@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdp_record_register()
In-Reply-To: <26872589.1140424746785.JavaMail.tomcat@pne-ps5-sn2>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7972_8881066.1140452313537"
References: <26872589.1140424746785.JavaMail.tomcat@pne-ps5-sn2>
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
Date: Mon, 20 Feb 2006 11:18:33 -0500

------=_Part_7972_8881066.1140452313537
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> I found following thing in sdp_record_register():
> The comment in source code tells that the function returns non-null
> pointer on
> success and -1 on failure. I have investigated the code and found out tha=
t
> the
> function returns only 0 or -1:


what version of bluez are you using?  The latest versions don't say this, i=
n
either sdp.h or sdp_lib.h

There are two return commands in the function: return -1; and return status=
;
> and for status: status=3D-1; and status =3D sdp_send_req_w4_rsp(...); In
> sdp_send_req_w4_rsp() there is three times return -1; and one return 0;
> So, is the return value zero success here?
>

yes.

-albert

------=_Part_7972_8881066.1140452313537
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I found foll=
owing thing in sdp_record_register():<br>
The comment in source code tells that the function returns non-null pointer=
 on<br>success and -1 on failure. I have investigated the code and found ou=
t that the<br>function returns only 0 or -1:</blockquote><div><br>
what version of bluez are you using?&nbsp; The latest versions don't say th=
is, in either sdp.h or sdp_lib.h<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">There a=
re two return commands in the function: return -1; and return status;<br>an=
d for status: status=3D-1; and status =3D sdp_send_req_w4_rsp(...); In
<br>sdp_send_req_w4_rsp() there is three times return -1; and one return 0;=
<br>So, is the return value zero success here?<br></blockquote></div><br>
yes.&nbsp; <br>
<br>
-albert<br>

------=_Part_7972_8881066.1140452313537--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
