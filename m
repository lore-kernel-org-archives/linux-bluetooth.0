Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710152150v6d5e591bw5eb6293cf0a9d316@mail.gmail.com>
Date: Tue, 16 Oct 2007 10:20:37 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <47137A98.9060204@celunite.com>
MIME-Version: 1.0
References: <d5d240eb0710120713r27a2ddcfm84493a711187bcb3@mail.gmail.com>
	<4712F226.5040506@celunite.com> <47137A98.9060204@celunite.com>
Subject: Re: [Bluez-users] problem in browsing services through dbus
	interface.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1124176626=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1124176626==
Content-Type: multipart/alternative;
	boundary="----=_Part_38718_144272.1192510237769"

------=_Part_38718_144272.1192510237769
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Rahul for your help.

Regards,
Rohit

On 10/15/07, rahul <rahul.tank@celunite.com> wrote:
>
> rahul wrote:
> > rohit puri wrote:
> >
> >> hi all,
> >>
> >> I am browsing the services using the dbus interface.but my code gives
> >> the following error
> >> `get_remote_service_channel':
> >> /root/marcel/main.c:78: undefined reference to `sdp_extract_pdu'
> >> /root/marcel/main.c:81: undefined reference to `sdp_get_access_protos'
> >> /root/marcel/main.c:85: undefined reference to `sdp_get_proto_port'
> >> /root/marcel/main.c:88: undefined reference to `sdp_list_free'
> >> /root/marcel/main.c:89: undefined reference to `sdp_list_free'
> >> /root/marcel/main.c:92: undefined reference to `sdp_record_free'
> >> collect2: ld returned 1 exit status
> >> Does someone know how to rectify this problem.
> >>
> >> Thanks in advance
> >>
> >>
> > Have you compiled the sources on your own? . If yes, then i think you
> > have linked the bluez-utils to the correct bluez-libs.
> >
>
> Oops .. it shuld have been .."you have *not* linked ..." .
> >
> >
> > thanks,
> >   rahul
> >
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_38718_144272.1192510237769
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Rahul for your help.<br><br>Regards,<br>Rohit<br><br><div><span class="gmail_quote">On 10/15/07, <b class="gmail_sendername">rahul</b> &lt;<a href="mailto:rahul.tank@celunite.com">rahul.tank@celunite.com</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">rahul wrote:<br>&gt; rohit puri wrote:<br>&gt;<br>&gt;&gt; hi all,<br>&gt;&gt;<br>&gt;&gt; I am browsing the services using the dbus 
interface.but my code gives<br>&gt;&gt; the following error<br>&gt;&gt; `get_remote_service_channel&#39;:<br>&gt;&gt; /root/marcel/main.c:78: undefined reference to `sdp_extract_pdu&#39;<br>&gt;&gt; /root/marcel/main.c:81: undefined reference to `sdp_get_access_protos&#39;
<br>&gt;&gt; /root/marcel/main.c:85: undefined reference to `sdp_get_proto_port&#39;<br>&gt;&gt; /root/marcel/main.c:88: undefined reference to `sdp_list_free&#39;<br>&gt;&gt; /root/marcel/main.c:89: undefined reference to `sdp_list_free&#39;
<br>&gt;&gt; /root/marcel/main.c:92: undefined reference to `sdp_record_free&#39;<br>&gt;&gt; collect2: ld returned 1 exit status<br>&gt;&gt; Does someone know how to rectify this problem.<br>&gt;&gt;<br>&gt;&gt; Thanks in advance
<br>&gt;&gt;<br>&gt;&gt;<br>&gt; Have you compiled the sources on your own? . If yes, then i think you<br>&gt; have linked the bluez-utils to the correct bluez-libs.<br>&gt;<br><br>Oops .. it shuld have been ..&quot;you have *not* linked ...&quot; .
<br>&gt;<br>&gt;<br>&gt; thanks,<br>&gt;&nbsp;&nbsp; rahul<br>&gt;<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc.<br>Still grepping through log files to find problems?&nbsp;&nbsp;Stop.
<br>Now Search log events and configuration files using AJAX and a browser.<br>Download your FREE copy of Splunk now &gt;&gt; <a href="http://get.splunk.com/">http://get.splunk.com/</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_38718_144272.1192510237769--


--===============1124176626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1124176626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1124176626==--
