Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50703310928g50908e3bg6f03e5a0c92cd1e2@mail.gmail.com>
Date: Sat, 31 Mar 2007 13:28:20 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1175348935.5815.262.camel@violet>
MIME-Version: 1.0
References: <c49421c50703292018r4a1fb72fpc47f1339fa1f2939@mail.gmail.com>
	<1175348935.5815.262.camel@violet>
Subject: Re: [Bluez-users] problem reading rssi
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1485708397=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1485708397==
Content-Type: multipart/alternative;
	boundary="----=_Part_89251_14494427.1175358500461"

------=_Part_89251_14494427.1175358500461
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for answer Marcel.

However, i think this is not the case. In some test I have made, I put two
scripts to run at the same time. The first one used hcitool for getting the
RSSI, the second one used my program to get the RSSI. Looking to the prints
on the terminal window, my program returned zero for the RSSI value while
hcitool returned a non zero value...

I am quite confused with this result. The code I am using for getting the
rssi is the same as the code hcitool uses. As far as a saw, the whole code
necessary for measuring rssi through hcitool is within the "cmd_rssi"
function. Is that right or there is some state outside cmd_rssi that impacts
in the correctness of the measurement?

Thanks again,

Loreno

On 3/31/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Loreno,
>
> > I am having some headache for reading the rssi of a remote device. The
> > code bellow insists in returning 0 to the "rssi" variable when I try
> > to read the rssi of a connected Nokia 770. If I run the same code for
> > a connected desktop, then a non zero value is returned. For
> > complicating even more, if I run "hcitool clkoff <addr>" when
> > connected to the 770, then a non zero value is also returned.
>
> it depends on the local adapter you use and the Bluetooth chip in the
> remote device. Some devices don't report the correct RSSI value. It
> seems they always return 0.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_89251_14494427.1175358500461
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for answer Marcel.<br><br>However, i think this is not the case. In some test I have made, I put two scripts to run at the same time. The first one used hcitool for getting the RSSI, the second one used my program to get the RSSI. Looking to the prints on the terminal window, my program returned zero for the RSSI value while hcitool returned a non zero value...
<br><br>I am quite confused with this result. The code I am using for getting the rssi is the same as the code hcitool uses. As far as a saw, the whole code necessary for measuring rssi through hcitool is within the &quot;cmd_rssi&quot; function. Is that right or there is some state outside cmd_rssi that impacts in the correctness of the measurement?
<br><br>Thanks again,<br><br>Loreno<br><br><div><span class="gmail_quote">On 3/31/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Loreno,<br><br>&gt; I am having some headache for reading the rssi of a remote device. The<br>&gt; code bellow insists in returning 0 to the &quot;rssi&quot; variable when I try<br>&gt; to read the rssi of a connected Nokia 770. If I run the same code for
<br>&gt; a connected desktop, then a non zero value is returned. For<br>&gt; complicating even more, if I run &quot;hcitool clkoff &lt;addr&gt;&quot; when<br>&gt; connected to the 770, then a non zero value is also returned.
<br><br>it depends on the local adapter you use and the Bluetooth chip in the<br>remote device. Some devices don&#39;t report the correct RSSI value. It<br>seems they always return 0.<br><br>Regards<br><br>Marcel<br><br><br>
<br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>
opinions on IT &amp; business topics through brief surveys-and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_89251_14494427.1175358500461--


--===============1485708397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1485708397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1485708397==--
