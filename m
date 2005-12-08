Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1134074044.17592.13.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14211_24741629.1134083452790"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
	 <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
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
Date: Thu, 8 Dec 2005 15:10:52 -0800

------=_Part_14211_24741629.1134083452790
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I used pstool, which is a tool bluegiga made to change settings of the
bluetooth chip via SPI interface. To be more specific, settings I changed o=
n
the bluetooth chip includes:

PSKEY_HOST_INTERFACE UART H4
PSKEY_VM_DISABLE  true
PSKEY_UART_CONFIG  00a8
PSKEY_UART_BAUD_RATE  115200
PSKEY_ONCHIP_HCI_CLIENT   0000

I tried noflow as well, but doesn't seem to help.

When you say what chip the module manufacturer is using, what do you mean
specifically?
Do you mean the "type" option in hciattach (ericsson, digi, csr... etc) ?

Thanks a lot for the help.

Cheers,

  Arthur

On 12/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > Since I can change the setting on the bluetooth chip, I am currently
> > using UART H4 and baudrate 115200. As for what chip they are using, I
> > suppose they manufacture their own bluetooh chip?
>
> no they don't. With what tool do you change the settings?
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

------=_Part_14211_24741629.1134083452790
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi, I used pstool, which is a tool bluegiga made to change settings of
the bluetooth chip via SPI interface. To be more specific, settings I
changed on the bluetooth chip includes:<br>
<br>
<font face=3D"'PrimaSans BT,Verdana,sans-serif'">PSKEY_HOST_INTERFACE UART =
H4<br>PSKEY_VM_DISABLE&nbsp; true<br>PSKEY_UART_CONFIG&nbsp; 00a8<br>PSKEY_=
UART_BAUD_RATE&nbsp; 115200<br>PSKEY_ONCHIP_HCI_CLIENT&nbsp;&nbsp; 0000<br>
<br>
I tried noflow as well, but doesn't seem to help. <br>
<br>
When you say what chip the module manufacturer is using, what do you mean s=
pecifically? <br>
Do you mean the &quot;type&quot; option in hciattach (ericsson, digi, csr..=
. etc) ? <br>
<br>
Thanks a lot for the help. <br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>
</font><br><div><span class=3D"gmail_quote">On 12/8/05, <b class=3D"gmail_s=
endername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">m=
arcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Hi Arthur,<br><br>&gt; Since I can change the setting on the bluetooth chip=
, I am currently<br>&gt; using UART H4 and baudrate 115200. As for what chi=
p they are using, I<br>&gt; suppose they manufacture their own bluetooh chi=
p?
<br><br>no they don't. With what tool do you change the settings?<br><br>Re=
gards<br><br>Marcel<br><br><br><br><br>------------------------------------=
-------------------<br>This SF.net email is sponsored by: Splunk Inc. Do yo=
u grep through log files
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes<br>searching your log files as easy as surfing the&nbsp;&=
nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad=
_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick">
http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a><b=
r>_______________________________________________<br>Bluez-users mailing li=
st<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@list=
s.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockqu=
ote></div><br>

------=_Part_14211_24741629.1134083452790--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
