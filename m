Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <1134158505.10644.22.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11258_193604.1134411663532"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
	 <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
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
Date: Mon, 12 Dec 2005 10:21:03 -0800

------=_Part_11258_193604.1134411663532
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

After the weekend I finally get a reply to the email that I sent asking for
pskeys.txt.

"Unfortunately not. But I have pskeys.html instead. :) I hope that will do.
Please do not pay attention to the default values mentioned in the file,
some
of them may vary in out modules."

I'm not sure whether I can attach files to this mailing list. So I send the
pskeys.html file to your personal email (marcel@holtmann.org) seperately,
hope that's fine. Once again, thanks a lot for your help.

Cheers,

  Arthur

On 12/9/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Arthur,
>
> > I checked the firmware version and this is what it says:
> > "The chip reports version 1503 (0x05df):
> > bc02x_8unified_fl_bt1.2_18_200407161536_encr56 2004-07-16"
> >
> > What should I ask the support group then? It seems like they verified
> > that the settings I used on the chip is sufficient to modify the chip
> > so that it fits the requirements of hciattach (baud_rate and setting
> > it to use external HCI provided by hcid).
> >
> > What other things would you suggest me to try? Hopefully you can help
> > me to get this to work. Thanks a lot!
>
> I am not 100% sure, but I think the PS key for UART configuration and
> baud rate settings were with HCI 18.x firmware. Meaning that there
> exists per transport PS keys. However I might be also wrong here. Tell
> them to send you the pskeys.txt file.
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

------=_Part_11258_193604.1134411663532
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, <br>
<br>
After the weekend I finally get a reply to the email that I sent asking for=
 pskeys.txt. <br>
<br>
&quot;<font face=3D"'PrimaSans BT,Verdana,sans-serif'">Unfortunately not. B=
ut I have pskeys.html instead. :) I hope that will do.<br>Please do not pay=
 attention to the default values mentioned in the file, some <br>of them ma=
y vary in out modules.&quot;
<br>
<br>
I'm not sure whether I can attach files to this mailing list. So I send
the pskeys.html file to your personal email (<a href=3D"mailto:marcel@holtm=
ann.org">marcel@holtmann.org</a>)
seperately, hope that's fine. Once again, thanks a lot for your help. <br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>
</font><br><div><span class=3D"gmail_quote">On 12/9/05, <b class=3D"gmail_s=
endername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">m=
arcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Hi Arthur,<br><br>&gt; I checked the firmware version and this is what it s=
ays:<br>&gt; &quot;The chip reports version 1503 (0x05df):<br>&gt; bc02x_8u=
nified_fl_bt1.2_18_200407161536_encr56 2004-07-16&quot;<br>&gt;<br>&gt; Wha=
t should I ask the support group then? It seems like they verified
<br>&gt; that the settings I used on the chip is sufficient to modify the c=
hip<br>&gt; so that it fits the requirements of hciattach (baud_rate and se=
tting<br>&gt; it to use external HCI provided by hcid).<br>&gt;<br>&gt; Wha=
t other things would you suggest me to try? Hopefully you can help
<br>&gt; me to get this to work. Thanks a lot!<br><br>I am not 100% sure, b=
ut I think the PS key for UART configuration and<br>baud rate settings were=
 with HCI 18.x firmware. Meaning that there<br>exists per transport PS keys=
. However I might be also wrong here. Tell
<br>them to send you the pskeys.txt file.<br><br>Regards<br><br>Marcel<br><=
br><br><br><br>-------------------------------------------------------<br>T=
his SF.net email is sponsored by: Splunk Inc. Do you grep through log files
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

------=_Part_11258_193604.1134411663532--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
