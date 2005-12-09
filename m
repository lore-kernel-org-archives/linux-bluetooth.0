Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1134154036.10644.18.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4574_6073584.1134156236650"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
	 <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
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
Date: Fri, 9 Dec 2005 11:23:56 -0800

------=_Part_4574_6073584.1134156236650
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I checked the firmware version and this is what it says:
"The chip reports version 1503 (0x05df):
bc02x_8unified_fl_bt1.2_18_200407161536_encr56 2004-07-16"

What should I ask the support group then? It seems like they verified that
the settings I used on the chip is sufficient to modify the chip so that it
fits the requirements of hciattach (baud_rate and setting it to use externa=
l
HCI provided by hcid).

What other things would you suggest me to try? Hopefully you can help me to
get this to work. Thanks a lot!

Cheers,

  Arthur


On 12/9/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > I just received a reply from the support group of the company that we
> > bought the chip from. Here's some answer to the questions I ask him
> > with regards to how to change the chip such that the HCI will be ran
> > by host processor (which is the case we need right?).
>
> I don't know anything about their module. I don't know what firmware
> version they use and what kind of special settings they might have.
> However a CSR chip in general is fully supported and with bccmd from CVS
> you even have a powerful tool for its configuration, but you need to
> know what you are doing.
>
> The comments you got are almost one-to-one extracts from the pskeys.txt
> file that comes with every CSR firmware. If they don't do better then
> send these modules back and order other CSR based modules from a company
> that knows what their customers are asking them.
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

------=_Part_4574_6073584.1134156236650
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I checked the firmware version and this is what it says:<br>
&quot;The chip reports version 1503 (0x05df):<br>
bc02x_8unified_fl_bt1.2_18_200407161536_encr56 2004-07-16&quot;<br>
<br>
What should I ask the support group then? It seems like they verified
that the settings I used on the chip is sufficient to modify the chip
so that it fits the requirements of hciattach (baud_rate and setting it
to use external HCI provided by hcid). <br>
<br>
What other things would you suggest me to try? Hopefully you can help me to=
 get this to work. Thanks a lot!<br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>
<br>
<br><div><span class=3D"gmail_quote">On 12/9/05, <b class=3D"gmail_senderna=
me">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marcel@h=
oltmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
Hi Arthur,<br><br>&gt; I just received a reply from the support group of th=
e company that we<br>&gt; bought the chip from. Here's some answer to the q=
uestions I ask him<br>&gt; with regards to how to change the chip such that=
 the HCI will be ran
<br>&gt; by host processor (which is the case we need right?).<br><br>I don=
't know anything about their module. I don't know what firmware<br>version =
they use and what kind of special settings they might have.<br>However a CS=
R chip in general is fully supported and with bccmd from CVS
<br>you even have a powerful tool for its configuration, but you need to<br=
>know what you are doing.<br><br>The comments you got are almost one-to-one=
 extracts from the pskeys.txt<br>file that comes with every CSR firmware. I=
f they don't do better then
<br>send these modules back and order other CSR based modules from a compan=
y<br>that knows what their customers are asking them.<br><br>Regards<br><br=
>Marcel<br><br><br><br><br>------------------------------------------------=
-------
<br>This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX se=
arch engine that makes<br>searching your log files as easy as surfing the&n=
bsp;&nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!
<br><a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;o=
p=3Dclick">http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3D=
click</a><br>_______________________________________________<br>Bluez-users=
 mailing list
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</=
a>
<br></blockquote></div><br>

------=_Part_4574_6073584.1134156236650--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
