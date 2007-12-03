Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5f84803c0712030850k5810ee43na4a13f5e74657388@mail.gmail.com>
Date: Mon, 3 Dec 2007 11:50:42 -0500
From: "Chris Rivera" <chrismrivera@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1196699122.12292.113.camel@violet>
MIME-Version: 1.0
References: <5f84803c0712030733q38350283m77e8930dfcca4162@mail.gmail.com>
	<1196699122.12292.113.camel@violet>
Subject: Re: [Bluez-devel] [PATCH] [RESEND] make bluez GNOME UIs singletons
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0486578633=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0486578633==
Content-Type: multipart/alternative;
	boundary="----=_Part_8735_12209210.1196700642870"

------=_Part_8735_12209210.1196700642870
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 3, 2007 11:25 AM, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Chris,
>
> I meant to look into it, but never got around it. Some small comments
> about it. Don't make the applet a singleton. That is totally unneeded
> since the applet will be loaded at login.


I still think it should be a singleton.  You wouldn't ever want two applets
running unless you're testing, and we have the singleton flags for that.  I
don't think this hurts anything.


> For the well known names use org.bluez.properties and org.bluez.wizard
> and don't define constants for it. Simply use the string.


That's fine.


>
> For the "Present" method. Don't use the D-Bus low-level calls. It should
> be all dbus-glib. Which means we have to abstract that into an object. I
> don't know if there is a well defined way for this. If it is, it might
> be good to use that. If not, then propose something for freedesktop.org.


I thought about doing this, but it seems like overkill to define a GObject
to just expose one method.  GObject isn't exactly terse either.


>
>
> And we should probably have some generic methods inside common/ instead
> of doing it again in every program.
>
> Please follow the kernel coding style. I know it is odd for a GTK
> application, but it makes it a lot easier for me.
> <https://lists.sourceforge.net/lists/listinfo/bluez-devel>


Which parts of the patch violate the kernel coding style?  The function
parameter spacing?

Chris

------=_Part_8735_12209210.1196700642870
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 3, 2007 11:25 AM, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Chris,<br><div class="Ih2E3d"><br></div>I meant to look into it, but never got around it. Some small comments<br>about it. Don&#39;t make the applet a singleton. That is totally unneeded<br>since the applet will be loaded at login.
</blockquote><div><br>I still think it should be a singleton.&nbsp; You wouldn&#39;t ever want two applets running unless you&#39;re testing, and we have the singleton flags for that.&nbsp; I don&#39;t think this hurts anything. <br>
<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>For the well known names use org.bluez.properties and org.bluez.wizard<br>and don&#39;t define constants for it. Simply use the string.
</blockquote><div><br>That&#39;s fine.<br>&nbsp;<br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>For the &quot;Present&quot; method. Don&#39;t use the D-Bus low-level calls. It should
<br>be all dbus-glib. Which means we have to abstract that into an object. I<br>don&#39;t know if there is a well defined way for this. If it is, it might<br>be good to use that. If not, then propose something for <a href="http://freedesktop.org" target="_blank">
freedesktop.org</a>.</blockquote><div><br>I thought about doing this, but it seems like overkill to define a GObject to just expose one method.&nbsp; GObject isn&#39;t exactly terse either.<br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><br>And we should probably have some generic methods inside common/ instead<br>of doing it again in every program.<br><br>Please follow the kernel coding style. I know it is odd for a GTK<br>application, but it makes it a lot easier for me.
<br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank"></a></blockquote><div><br>Which parts of the patch violate the kernel coding style?&nbsp; The function parameter spacing?<br><br>Chris<br></div>
</div><br>

------=_Part_8735_12209210.1196700642870--


--===============0486578633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============0486578633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0486578633==--
