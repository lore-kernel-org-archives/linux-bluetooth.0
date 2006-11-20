Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <b5dccebe0611200031v64a8d2d0xfdd92edf29a44d0@mail.gmail.com>
Date: Mon, 20 Nov 2006 09:31:57 +0100
From: "Mikael Lindqvist" <li.mikael.spam@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1163940471.11790.2.camel@localhost>
MIME-Version: 1.0
References: <b5dccebe0611190350p4801a631m3cca5cc0b5c9abb3@mail.gmail.com>
	<1163940471.11790.2.camel@localhost>
Subject: Re: [Bluez-users] permissions to set local name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0536850405=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0536850405==
Content-Type: multipart/alternative;
	boundary="----=_Part_33225_24347492.1164011517499"

------=_Part_33225_24347492.1164011517499
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,

How does hcid know what mode that is "best" for my application? I want to
make sure that it is 1 (result with rssi), is there a way I can tell hcid to
always choose that mode then?

Also, I would like to have as few external dependencies, so if possible I
would prefer to not use d-bus. Is there a way to set the local name without
d-bus and without root privileges?

-- Mikael

On 11/19/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mikael,
>
> > I've noticed that only the superuser may perform some hci commands,
> > such as OCF_WRITE_LOCAL_NAME and OCF_WRITE_INQUIRY_MODE. How can I
> > grant privileges for other users to perform those commands?
> >
> > The problem is that I have an application that needs to set those
> > paramaters, but I don't want to run the application as root.
>
> the inquiry mode should never be set by an application. It is up to hcid
> to pick the best inquiry mode.
>
> The local name can be set via the D-Bus interface and no root privileges
> are needed.
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

------=_Part_33225_24347492.1164011517499
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi again,<br><br>How does hcid know what mode that is &quot;best&quot; for my application? I want to make sure that it is 1 (result with rssi), is there a way I can tell hcid to always choose that mode then?<br><br>Also, I would like to have as few external dependencies, so if possible I would prefer to not use d-bus. Is there a way to set the local name without d-bus and without root privileges?
<br><br>-- Mikael<br><br><div><span class="gmail_quote">On 11/19/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Mikael,<br><br>&gt; I've noticed that only the superuser may perform some hci commands,<br>&gt; such as OCF_WRITE_LOCAL_NAME and OCF_WRITE_INQUIRY_MODE. How can I<br>&gt; grant privileges for other users to perform those commands?
<br>&gt;<br>&gt; The problem is that I have an application that needs to set those<br>&gt; paramaters, but I don't want to run the application as root.<br><br>the inquiry mode should never be set by an application. It is up to hcid
<br>to pick the best inquiry mode.<br><br>The local name can be set via the D-Bus interface and no root privileges<br>are needed.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">
http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_33225_24347492.1164011517499--


--===============0536850405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0536850405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0536850405==--
