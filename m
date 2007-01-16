Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <2e9fc96f0701160623i44199950u8005dc70a9176975@mail.gmail.com>
Date: Tue, 16 Jan 2007 19:53:34 +0530
From: "Prabhu nath" <gprabhunath@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1168867650.5728.11.camel@violet>
MIME-Version: 1.0
References: <1d1502880701122216v187542ecx45af28f4da86323e@mail.gmail.com>
	<1168867650.5728.11.camel@violet>
Subject: Re: [Bluez-users] Object Push from Nokia N93 to BlueZ fails
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0896124569=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0896124569==
Content-Type: multipart/alternative;
	boundary="----=_Part_19304_1578767.1168957414069"

------=_Part_19304_1578767.1168957414069
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,
         I started the rfcomm to listen on channel 9. Now, when I transfer
file from Nokia N93 to my
         PC.
          It hangs. hcidump will give a segmentation fault.

          My configuration : http://gprabhunath.googlepages.com/bluez_conf

          hcidump : http://gprabhunath.googlepages.com/home

          I did the following.
          * Edited rfcomm.conf and hcid.conf (Ref: My configuration)
          * started hcid and sdpd (service bluetooth start)
          * started rfcomm to listen on channel 9 (rfcomm -i hci0 listen 2
9)
          * started obexftpd (obexftpd -b -c /tmp/inbox)

           output of hciconfig, hcitool scan, and sdptool browse can be
viewed at
              http://gprabhunath.googlepages.com/bluez_conf


Thanks,
Prabhu



On 1/15/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi,
>
> >  I am doing an experiment to transfer file from Cellphones to Linux
> > over BT
> > using BlueZ stack available in Linux.
> >
> > Object Push from Nokia 93 to BlueZ fails.
> >
> > 1) I am able to push a file from Motorola to Linux BlueZ.
> >
> > 2) But I am unable to push a file from Nokia N93 to Linux BlueZ.
> >
> > Error message displayed on Nokia 93 is "Unable to Connect".
> >
> > Can anyone help me, in identifying what's going wrong from the log
> > attached
> > below? Since I am new to BT, I am not yet become expert in
> > understanding the
> > BT protocol. There is something going wrong from Linux BlueZ stack,
> > when Nokia
> > cellphone is sending file transfer request.
> >
> > 3) I also tried transferring files from Linux to Nokia, which works
> > fine.
> >
> > HciDumps for both the file pushes are given below
>
> the MotoQ dump doesn't show any OBEX nor RFCOMM activity. The Nokia dump
> indicates that no RFCOMM server is listening on channel 9.
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
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_19304_1578767.1168957414069
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I started the rfcomm to listen on channel 9. Now, when I transfer file from Nokia N93 to my </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PC. <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; It hangs. hcidump will give a segmentation fault. </div>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My configuration : <a href="http://gprabhunath.googlepages.com/bluez_conf">http://gprabhunath.googlepages.com/bluez_conf</a></p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hcidump : <a href="http://gprabhunath.googlepages.com/home">http://gprabhunath.googlepages.com/home</a><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I did the following. <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Edited rfcomm.conf and hcid.conf (Ref: My configuration)
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * started hcid and sdpd (service bluetooth start)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * started rfcomm to listen on channel 9 (rfcomm -i hci0 listen 2 9)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * started obexftpd (obexftpd -b -c /tmp/inbox)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;output of hciconfig, hcitool scan, and sdptool browse can be viewed at
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://gprabhunath.googlepages.com/bluez_conf">http://gprabhunath.googlepages.com/bluez_conf</a></p>
<p><br>Thanks,<br>Prabhu<br></p>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 1/15/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br><br>&gt;&nbsp;&nbsp;I am doing an experiment to transfer file from Cellphones to Linux<br>&gt; over BT<br>&gt; using BlueZ stack available in Linux.
<br>&gt;<br>&gt; Object Push from Nokia 93 to BlueZ fails.<br>&gt;<br>&gt; 1) I am able to push a file from Motorola to Linux BlueZ.<br>&gt;<br>&gt; 2) But I am unable to push a file from Nokia N93 to Linux BlueZ.<br>&gt;
<br>&gt; Error message displayed on Nokia 93 is &quot;Unable to Connect&quot;.<br>&gt;<br>&gt; Can anyone help me, in identifying what&#39;s going wrong from the log<br>&gt; attached<br>&gt; below? Since I am new to BT, I am not yet become expert in
<br>&gt; understanding the<br>&gt; BT protocol. There is something going wrong from Linux BlueZ stack,<br>&gt; when Nokia<br>&gt; cellphone is sending file transfer request.<br>&gt;<br>&gt; 3) I also tried transferring files from Linux to Nokia, which works
<br>&gt; fine.<br>&gt;<br>&gt; HciDumps for both the file pushes are given below<br><br>the MotoQ dump doesn&#39;t show any OBEX nor RFCOMM activity. The Nokia dump<br>indicates that no RFCOMM server is listening on channel 9.
<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your
<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_19304_1578767.1168957414069--


--===============0896124569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0896124569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0896124569==--
