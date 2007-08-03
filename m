Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0708022330obca2bdds2d21bdda830db6b4@mail.gmail.com>
Date: Fri, 3 Aug 2007 12:00:44 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d5920d1e0708022327v665d3c02gc8799485d896d459@mail.gmail.com>
MIME-Version: 1.0
References: <d5920d1e0708010151h1610b190vb7618b71686cba05@mail.gmail.com>
	<57c68ddc0708010345u73c7482esff100f76b20646fc@mail.gmail.com>
	<d5920d1e0708022327v665d3c02gc8799485d896d459@mail.gmail.com>
Subject: Re: [Bluez-users] Module bluez not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0147423933=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0147423933==
Content-Type: multipart/alternative;
	boundary="----=_Part_58676_12229443.1186122644931"

------=_Part_58676_12229443.1186122644931
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

what is the output of hciconfig

On 8/3/07, Hamid MENOUAR <menouar@gmail.com> wrote:
>
> Thank you for your answer.
>
> Even when doing that, still no devices is detected when scanning
> (hcitool scan) !!
>
> Regards,
> Menouar
>
> On 8/1/07, siddhant tewari <siddhant.tewari@gmail.com> wrote:
> > u should try
> > modprobe hci_usb
> > modprobe rfcomm
> >
> > then run
> > hciconfig hci0 up (only one dongle attached)
> >
> > then
> > hcitool scan (if near by devices are scanned succesfully then part of
> > bluetooth system is working fine)
> >
> > now for sending and recieving files you should try searching in mail
> > archive.....
> >
> > regards
> > siddhant
> >
> >
> >
> > On 8/1/07, Hamid MENOUAR < menouar@gmail.com> wrote:
> > >
> > > Dear all,
> > >
> > > In order to use Bluez to connect some bluetooth device on my computer,
> > > I have installed on my Linux FC2 the four following packages
> > > (bluez-libs, bluez-utils, bluez-firmware, bluez-hcidump).
> > >
> > > And, when trying to load the Bluez module manually by doing "modprobe
> > > bluez" it says "FATAL: Module bluez not found."
> > >
> > > Could anyone help me to explain and solve this?
> > >
> > > Thank you in advance,
> > > Menouar
> > >
> > >
> >
> -------------------------------------------------------------------------
> > > This SF.net email is sponsored by: Splunk Inc.
> > > Still grepping through log files to find problems?  Stop.
> > > Now Search log events and configuration files using AJAX and a
> browser.
> > > Download your FREE copy of Splunk now >>   http://get.splunk.com/
> > > _______________________________________________
> > > Bluez-users mailing list
> > > Bluez-users@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-users
> > >
> >
> >
> >
> -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc.
> > Still grepping through log files to find problems?  Stop.
> > Now Search log events and configuration files using AJAX and a browser.
> > Download your FREE copy of Splunk now >>  http://get.splunk.com/
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_58676_12229443.1186122644931
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

what is the output of hciconfig <br><br><div><span class="gmail_quote">On 8/3/07, <b class="gmail_sendername">Hamid MENOUAR</b> &lt;<a href="mailto:menouar@gmail.com">menouar@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Thank you for your answer.<br><br>Even when doing that, still no devices is detected when scanning<br>(hcitool scan) !!<br><br>Regards,<br>Menouar<br><br>On 8/1/07, siddhant tewari &lt;<a href="mailto:siddhant.tewari@gmail.com">
siddhant.tewari@gmail.com</a>&gt; wrote:<br>&gt; u should try<br>&gt; modprobe hci_usb<br>&gt; modprobe rfcomm<br>&gt;<br>&gt; then run<br>&gt; hciconfig hci0 up (only one dongle attached)<br>&gt;<br>&gt; then<br>&gt; hcitool scan (if near by devices are scanned succesfully then part of
<br>&gt; bluetooth system is working fine)<br>&gt;<br>&gt; now for sending and recieving files you should try searching in mail<br>&gt; archive.....<br>&gt;<br>&gt; regards<br>&gt; siddhant<br>&gt;<br>&gt;<br>&gt;<br>&gt; On 8/1/07, Hamid MENOUAR &lt; 
<a href="mailto:menouar@gmail.com">menouar@gmail.com</a>&gt; wrote:<br>&gt; &gt;<br>&gt; &gt; Dear all,<br>&gt; &gt;<br>&gt; &gt; In order to use Bluez to connect some bluetooth device on my computer,<br>&gt; &gt; I have installed on my Linux FC2 the four following packages
<br>&gt; &gt; (bluez-libs, bluez-utils, bluez-firmware, bluez-hcidump).<br>&gt; &gt;<br>&gt; &gt; And, when trying to load the Bluez module manually by doing &quot;modprobe<br>&gt; &gt; bluez&quot; it says &quot;FATAL: Module bluez not found.&quot;
<br>&gt; &gt;<br>&gt; &gt; Could anyone help me to explain and solve this?<br>&gt; &gt;<br>&gt; &gt; Thank you in advance,<br>&gt; &gt; Menouar<br>&gt; &gt;<br>&gt; &gt;<br>&gt; -------------------------------------------------------------------------
<br>&gt; &gt; This SF.net email is sponsored by: Splunk Inc.<br>&gt; &gt; Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>&gt; &gt; Now Search log events and configuration files using AJAX and a browser.<br>&gt; &gt; Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp; 
<a href="http://get.splunk.com/">http://get.splunk.com/</a><br>&gt; &gt; _______________________________________________<br>&gt; &gt; Bluez-users mailing list<br>&gt; &gt; <a href="mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br>&gt; &gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt; -------------------------------------------------------------------------
<br>&gt; This SF.net email is sponsored by: Splunk Inc.<br>&gt; Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>&gt; Now Search log events and configuration files using AJAX and a browser.<br>&gt; Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp;
<a href="http://get.splunk.com/">http://get.splunk.com/</a><br>&gt; _______________________________________________<br>&gt; Bluez-users mailing list<br>&gt; <a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br>&gt; <a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br>&gt;<br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt;&nbsp;&nbsp;
<a href="http://get.splunk.com/">http://get.splunk.com/</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_58676_12229443.1186122644931--


--===============0147423933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0147423933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0147423933==--
