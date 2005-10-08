Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510081605p56bcd8fcob8fcd77f616c105d@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net, Claudio Takahasi <cktakahasi@gmail.com>
Subject: Re: [Bluez-devel] hcid patch (patch 00.13)
In-Reply-To: <1128784148.5212.17.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5612_10828652.1128812729333"
References: <e1effdeb0510060731s191b17bbrd52897af77622ba6@mail.gmail.com>
	 <1128784148.5212.17.camel@blade>
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
Date: Sat, 8 Oct 2005 20:05:29 -0300

------=_Part_5612_10828652.1128812729333
Content-Type: multipart/alternative;
	boundary="----=_Part_5613_31474239.1128812729334"

------=_Part_5613_31474239.1128812729334
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,


The basic configuration file is attached. We can define better
policies after. Check the dbus-daemon man for more policies information.

The hcid.conf file have to be copied to /etc/dbus-1/system.d/

Regards,
Claudio.

On 10/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > What was the final decision about the path name?
>
> There is non at the moment.
>
> > I read the e-mails exchanged in the D-Bus mailing list. Due the
> > instability/side-effects of the support '-' for path
> > names, I think is not a good idea support it. I will keep the "hci"
> > device name in the path until we find a good solution.
>
> No problem. We will adjust it later.
>
> > Do you have any suggestions or changes before integrate this code?
>
> I applied this patch to my local tree and now I have to clean it up. You
> should really follow my advises on tabs, whitespaces etc. A good idea is
> to use an editor that will visualize tabs and whitespaces for you.
>
> Can you provide hcid.conf security settings file for the current
> services?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_5613_31474239.1128812729334
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
<br>The basic configuration file is attached. We can define better <br>
policies after. Check the dbus-daemon man for more policies information.<br=
>
<br>
&nbsp;The hcid.conf file have to be copied to /etc/dbus-1/system.d/<br>
<br>
Regards,<br>
Claudio.<br>
<br><div><span class=3D"gmail_quote">On 10/8/05, <b class=3D"gmail_senderna=
me">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@h=
oltmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
Hi Claudio,<br><br>&gt; What was the final decision about the path name?<br=
><br>There is non at the moment.<br><br>&gt; I read the e-mails exchanged i=
n the D-Bus mailing list. Due the<br>&gt; instability/side-effects of the&n=
bsp;&nbsp;support '-' for path
<br>&gt; names, I think is not a good idea support it. I will keep the &quo=
t;hci&quot;<br>&gt; device name in the path until we find a good solution.<=
br><br>No problem. We will adjust it later.<br><br>&gt; Do you have any sug=
gestions or changes before integrate this code?
<br><br>I applied this patch to my local tree and now I have to clean it up=
. You<br>should really follow my advises on tabs, whitespaces etc. A good i=
dea is<br>to use an editor that will visualize tabs and whitespaces for you=
.
<br><br>Can you provide hcid.conf security settings file for the current<br=
>services?<br><br>Regards<br><br>Marcel<br><br><br><br><br>----------------=
---------------------------------------<br>This SF.Net email is sponsored b=
y:
<br>Power Architecture Resource Center: Free content, downloads, discussion=
s,<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">htt=
p://solutions.newsforge.com/ibmarch.tmpl</a><br>___________________________=
____________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net">Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists=
.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/=
lists/listinfo/bluez-devel
</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br>---------------=
------------------------------------------<br>Claudio Takahasi<br>Nokia's I=
nstitute of Technology - INdT<br><a href=3D"mailto:claudio.takahasi@indt.or=
g.br">
claudio.takahasi@indt.org.br</a><br>

------=_Part_5613_31474239.1128812729334--

------=_Part_5612_10828652.1128812729333
Content-Type: application/octet-stream; name="hcid.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hcid.conf"

PCEtLSBUaGlzIGNvbmZpZ3VyYXRpb24gZmlsZSBzcGVjaWZpZXMgdGhlIHJlcXVpcmVkIHNlY3Vy
aXR5IHBvbGljaWVzCiAgICAgZm9yIGJsdWV6LWhjaWQgdG8gd29yay4gLS0+Cgo8IURPQ1RZUEUg
YnVzY29uZmlnIFBVQkxJQyAiLS8vZnJlZWRlc2t0b3AvL0RURCBELUJVUyBCdXMgQ29uZmlndXJh
dGlvbiAxLjAvL0VOIgogImh0dHA6Ly93d3cuZnJlZWRlc2t0b3Aub3JnL3N0YW5kYXJkcy9kYnVz
LzEuMC9idXNjb25maWcuZHRkIj4KPGJ1c2NvbmZpZz4KCiAgPCEtLSAuLi9zeXN0ZW0uY29uZiBo
YXZlIGRlbmllZCBldmVyeXRoaW5nLCBzbyB3ZSBqdXN0IHB1bmNoIHNvbWUgaG9sZXMgLS0+CiAg
CiAgPCEtLSBPbmx5IHJvb3QgY2FuIG93biB0aGUgYmx1ZXogc2VydmljZSAtLT4KICA8cG9saWN5
IHVzZXI9InJvb3QiPgogICAgPGFsbG93IG93bj0ib3JnLmJsdWV6Ii8+CiAgPC9wb2xpY3k+Cgog
IDwhLS0gQWxsb3cgYW55b25lIHRvIGludm9rZSBtZXRob2RzIG9uIHRoZSBNYW5hZ2VyIGFuZCBE
ZXZpY2UgaW50ZXJmYWNlcyAtLT4gCiAgPHBvbGljeSBjb250ZXh0PSJkZWZhdWx0Ij4KCiAgICA8
IS0tIERldmljZXMgcG9saWNpZXMgIC0tPgogICAgPGFsbG93IHNlbmRfaW50ZXJmYWNlPSJvcmcu
Ymx1ZXouRGV2aWNlcyIgLz4KICAgIDxhbGxvdyByZWNlaXZlX2ludGVyZmFjZT0ib3JnLmJsdWV6
LkRldmljZXMiLz4KCiAgICA8IS0tIE1hbmFnZXIgcG9saWNpZXMgLS0+CiAgICA8YWxsb3cgc2Vu
ZF9pbnRlcmZhY2U9Im9yZy5ibHVlei5NYW5hZ2VyIiAvPgogICAgPGFsbG93IHJlY2VpdmVfaW50
ZXJmYWNlPSJvcmcuYmx1ZXouTWFuYWdlciIgLz4gCiAgICAKICA8L3BvbGljeT4KCjwvYnVzY29u
ZmlnPgo=
------=_Part_5612_10828652.1128812729333--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
