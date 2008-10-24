Return-Path: <cyrus@holtmann.org>
Message-ID: <223378410810240218x7c25901fne41220d39549d4ea@mail.gmail.com>
Date: Fri, 24 Oct 2008 14:48:04 +0530
From: "rakesh agarwal" <zen.raj@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1224737867.9386.184.camel@californication>
MIME-Version: 1.0
References: <1224737867.9386.184.camel@californication>
Subject: Re: [Bluez-devel] problems with kernel 2.6.23 + bluez 3.36 + SCO
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2379408171928751153=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2379408171928751153==
Content-Type: multipart/alternative;
	boundary="----=_Part_4847_1228641.1224839884426"

------=_Part_4847_1228641.1224839884426
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am using bluez-gnome-1.8 on ububntu-8.04.
It doesn't seems to work properly.
when I run the command `bluetooth-wizard` I get the following messages on
the terminal----

(bluetooth-wizard:6803): Gtk-CRITICAL **:
gtk_tree_model_filter_set_visible_func:
assertion `GTK_IS_TREE_MODEL_FILTER (filter)' failed

(bluetooth-wizard:6803): Gtk-CRITICAL **:
gtk_tree_model_sort_new_with_model: assertion `GTK_IS_TREE_MODEL
(child_model)' failed

(bluetooth-wizard:6803): Gtk-CRITICAL **:
gtk_tree_sortable_set_sort_column_id: assertion `GTK_IS_TREE_SORTABLE
(sortable)' failed

(bluetooth-wizard:6803): GLib-GObject-CRITICAL **: g_object_unref: assertion
`G_IS_OBJECT (object)' failed

(bluetooth-wizard:6803): GLib-GObject-CRITICAL **: g_object_unref: assertion
`G_IS_OBJECT (object)' failed


I am using the kernel version 2.6.24.


Regards,
Rakesh Agarwal


On Thu, Oct 23, 2008 at 10:27 AM, Marcel Holtmann <marcel@holtmann.org>wrote:

> Hi Pierre,
>
> > We develop an application for our board based on SCO. We use the kernel
> > version 2.6.23 and the bluez-lib 3.36. However we have a lot of problems
> and
> > some "kernel panic". Below this message you will find some of these
> kernel
> > messages.
> > How can we stop it? Have you ever saw that?
>
> switch to a 2.6.27 kernel.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's
> challenge
> Build the coolest Linux based applications with Moblin SDK & win great
> prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_4847_1228641.1224839884426
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am using bluez-gnome-1.8 on ububntu-8.04. <br>It doesn&#39;t seems to work properly.<br>when I run the command `bluetooth-wizard` I get the following messages on the terminal----<br><br>(bluetooth-wizard:6803): Gtk-CRITICAL **: gtk_tree_model_filter_set_<div id=":4f" class="ArwC7c ckChnd">
visible_func: assertion `GTK_IS_TREE_MODEL_FILTER (filter)&#39; failed<br>
<br>(bluetooth-wizard:6803): Gtk-CRITICAL **: gtk_tree_model_sort_new_with_model: assertion `GTK_IS_TREE_MODEL (child_model)&#39; failed<br><br>(bluetooth-wizard:6803): Gtk-CRITICAL **: gtk_tree_sortable_set_sort_column_id: assertion `GTK_IS_TREE_SORTABLE (sortable)&#39; failed<br>

<br>(bluetooth-wizard:6803): GLib-GObject-CRITICAL **: g_object_unref: assertion `G_IS_OBJECT (object)&#39; failed<br><br>(bluetooth-wizard:6803): GLib-GObject-CRITICAL **: g_object_unref: assertion `G_IS_OBJECT (object)&#39; failed<br>

<br><br>I am using the kernel version <a href="http://2.6.24./" target="_blank">2.6.24.</a><br><br><br>Regards,<br><font color="#888888">Rakesh Agarwal</font></div><br><br><div class="gmail_quote">On Thu, Oct 23, 2008 at 10:27 AM, Marcel Holtmann <span dir="ltr">&lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Pierre,<br>
<br>
&gt; We develop an application for our board based on SCO. We use the kernel<br>
&gt; version 2.6.23 and the bluez-lib 3.36. However we have a lot of problems and<br>
&gt; some &quot;kernel panic&quot;. Below this message you will find some of these kernel<br>
&gt; messages.<br>
&gt; How can we stop it? Have you ever saw that?<br>
<br>
switch to a 2.6.27 kernel.<br>
<br>
Regards<br>
<br>
Marcel<br>
<br>
<br>
<br>
-------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Moblin Your Move Developer&#39;s challenge<br>
Build the coolest Linux based applications with Moblin SDK &amp; win great prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world<br>
<a href="http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/" target="_blank">http://moblin-contest.org/redirect.php?banner_id=100&amp;url=/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
</blockquote></div><br>

------=_Part_4847_1228641.1224839884426--


--===============2379408171928751153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2379408171928751153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2379408171928751153==--
