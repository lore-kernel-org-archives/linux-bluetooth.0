Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805180132n2831ca34x905f45e174e35fbc@mail.gmail.com>
Date: Sun, 18 May 2008 10:32:59 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <CD0EBC4C-69FC-4FAB-940C-28ED6308376A@holtmann.org>
MIME-Version: 1.0
References: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
	<75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
	<3e9cdced0805171138r278aad56i9d1af3dfea5ca7c0@mail.gmail.com>
	<CD0EBC4C-69FC-4FAB-940C-28ED6308376A@holtmann.org>
Subject: Re: [Bluez-users] using bluez dbus interface exposed from hcid with
	plain c code
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1798001812=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1798001812==
Content-Type: multipart/alternative;
	boundary="----=_Part_3637_24674597.1211099580005"

------=_Part_3637_24674597.1211099580005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good morning Marcel,

well in my doc folder I can only find four txt's which list the Interfaces
and some methods, but since there a types like "string" used it seems it is
not supposed to be used as low level c interface.
And I would really appreciate a step-by-step tutorial with some examples how
to use low-level C interface of bluez with dbus.

Thanks a lot,

Fritz.

On Sun, May 18, 2008 at 2:04 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Fritz,
>
> > is there anywhere a HowTo / Tutorial how to use the low-level C API
> > of bluez through dbus?
> >
> > I've found a Tutorial for using the low-level C API of dbus here
> > (unfortunately just a ver basic Tut.)
> > http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html
> >
> > But I didn't find anything about the characteristics of the Adapter
> > Interface of bluez (hcid) if its used from low-level API.
> > E.g. the method names which I have to pass the method
> > dbus_message_new_method_call() ...
>
> they are all documented. Check the doc/ directory within bluez-utils.
>
> Regards
>
> Marcel
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Regards,
--Codefritz

------=_Part_3637_24674597.1211099580005
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Good morning Marcel,<br><br>well in my doc folder I can only find four txt&#39;s which list the Interfaces and some methods, but since there a types like &quot;string&quot; used it seems it is not supposed to be used as low level c interface.<br>
And I would really appreciate a step-by-step tutorial with some examples how to use low-level C interface of bluez with dbus.<br><br>Thanks a lot,<br><br>Fritz.<br><br><div class="gmail_quote">On Sun, May 18, 2008 at 2:04 AM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Fritz,<br>
<div class="Ih2E3d"><br>
&gt; is there anywhere a HowTo / Tutorial how to use the low-level C API<br>
&gt; of bluez through dbus?<br>
&gt;<br>
&gt; I&#39;ve found a Tutorial for using the low-level C API of dbus here<br>
&gt; (unfortunately just a ver basic Tut.)<br>
&gt; <a href="http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html" target="_blank">http://dbus.freedesktop.org/doc/dbus/libdbus-tutorial.html</a><br>
&gt;<br>
&gt; But I didn&#39;t find anything about the characteristics of the Adapter<br>
&gt; Interface of bluez (hcid) if its used from low-level API.<br>
&gt; E.g. the method names which I have to pass the method<br>
&gt; dbus_message_new_method_call() ...<br>
<br>
</div>they are all documented. Check the doc/ directory within bluez-utils.<br>
<div><div></div><div class="Wj3C7c"><br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</div></div></blockquote></div><br><br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_3637_24674597.1211099580005--


--===============1798001812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1798001812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1798001812==--
