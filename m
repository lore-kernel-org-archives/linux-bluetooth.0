Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0806120412ic2904bai44cd6eee00179c2f@mail.gmail.com>
Date: Thu, 12 Jun 2008 13:12:09 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0806120337p5043c4celf7092d086f937691@mail.gmail.com>
MIME-Version: 1.0
References: <3e9cdced0806120309i7d7dd9e7ta299c4bd5c325437@mail.gmail.com>
	<1213266546.17870.44.camel@violet.holtmann.net>
	<3e9cdced0806120337p5043c4celf7092d086f937691@mail.gmail.com>
Subject: Re: [Bluez-users] implement hcitool cc call with dbus interface
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1636264647=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1636264647==
Content-Type: multipart/alternative;
	boundary="----=_Part_16216_31045185.1213269129554"

------=_Part_16216_31045185.1213269129554
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok taking a look at hcitool.c I understand.
I will simply take the functions hci_open_dev and hci_create_connection
(provided by bluez-lib) in order to implement the
hcitool cc call in my application. So the kernel handles the low-level stuff
like socket-calls etc ....

But anyway is there a way to do that through  the comfortable dbus
interface? I guess not.

On Thu, Jun 12, 2008 at 12:37 PM, Fritz Code <codefritz@googlemail.com>
wrote:

> hm but I have to setup a connection manually just like hcitool does
> (hcitool cc --role=s) in my programm.
> Is there now way to do that through the comfortable dbus interface?
> So just the same as hcitool cc --role=s <bdaddr> (this establishes a ACL
> connection, right? ) but more comfortable to implement error-handling etc.
>
> >you don't have to do that at all. Never ever establish ACL links by
> >yourself. Let the kernel do it for you.
>
> In which ways does the kernel that for me, or how can I initiate it?
> I thought this can be done with socket-calls etc. as it done by a lot of
> tools like hcitool etc.
>
> Thanks,
> Fritz
>
>
>
>
> On Thu, Jun 12, 2008 at 12:29 PM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
>
>> Hi Fritz,
>>
>> > hcitool cc --role=s <bdaddr>
>> > establishes a low level ACL connection.
>> >
>> > I have to do that in a self-written tool with error-handling etc.
>> > How can this be done through the dbus-interface, I've actually found
>> > no method in the interfaces listed here http://wiki.bluez.org/wiki
>>
>
> >>you don't have to do that at all. Never ever establish ACL links by
> >>yourself. Let the kernel do it for you.
>
>>
>>
>> Regards
>>
>> Marcel
>>
>>
>>
>> -------------------------------------------------------------------------
>> Check out the new SourceForge.net Marketplace.
>> It's the best place to buy or sell services for
>> just about anything Open Source.
>> http://sourceforge.net/services/buy/index.php
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>
>
>
> --
> Regards,
> --Codefritz
>
>
>
>


-- 
Regards,
--Codefritz

------=_Part_16216_31045185.1213269129554
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok taking a look at hcitool.c I understand.<br>I will simply take the functions hci_open_dev and hci_create_connection (provided by bluez-lib) in order to implement the <br>hcitool cc call in my application. So the kernel handles the low-level stuff like socket-calls etc ....<br>
<br>But anyway is there a way to do that through&nbsp; the comfortable dbus interface? I guess not.<br><br><div class="gmail_quote">On Thu, Jun 12, 2008 at 12:37 PM, Fritz Code &lt;<a href="mailto:codefritz@googlemail.com">codefritz@googlemail.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">hm but I have to setup a connection manually just like hcitool does (hcitool cc --role=s) in my programm.<br>
Is there now way to do that through the comfortable dbus interface? <br>So just the same as hcitool cc --role=s &lt;bdaddr&gt; (this establishes a ACL connection, right? ) but more comfortable to implement error-handling etc.<div class="Ih2E3d">
<br>
<br>&gt;you don&#39;t have to do that at all. Never ever establish ACL links by<br>
&gt;yourself. Let the kernel do it for you. <br><br></div>In which ways does the kernel that for me, or how can I initiate it?<br>I thought this can be done with socket-calls etc. as it done by a lot of tools like hcitool etc.<br>

<br>Thanks,<br>Fritz<div><div></div><div class="Wj3C7c"><br><br><br><br><div class="gmail_quote">On Thu, Jun 12, 2008 at 12:29 PM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org" target="_blank">marcel@holtmann.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Fritz,<br>
<div><br>
&gt; hcitool cc --role=s &lt;bdaddr&gt;<br>
&gt; establishes a low level ACL connection.<br>
&gt;<br>
&gt; I have to do that in a self-written tool with error-handling etc.<br>
&gt; How can this be done through the dbus-interface, I&#39;ve actually found<br>
&gt; no method in the interfaces listed here <a href="http://wiki.bluez.org/wiki" target="_blank">http://wiki.bluez.org/wiki</a><br>
</div></blockquote><div><br>&gt;&gt;you don&#39;t have to do that at all. Never ever establish ACL links by<br>&gt;&gt;yourself. Let the kernel do it for you. <br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
Check out the new SourceForge.net Marketplace.<br>
It&#39;s the best place to buy or sell services for<br>
just about anything Open Source.<br>
<a href="http://sourceforge.net/services/buy/index.php" target="_blank">http://sourceforge.net/services/buy/index.php</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net" target="_blank">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br><br clear="all"><br></div></div><font color="#888888">-- <br>Regards,<br>--Codefritz<br><br><br><br>
</font></blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_16216_31045185.1213269129554--


--===============1636264647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1636264647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1636264647==--
