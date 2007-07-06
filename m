Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510707061046m60093a6di9895824152220706@mail.gmail.com>
Date: Sat, 7 Jul 2007 01:46:18 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1183042585.9499.19.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <22b6c3510706280736h6367a25eiac4918c0f80497a2@mail.gmail.com>
	<1183042585.9499.19.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] hcid defunct
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0788830204=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0788830204==
Content-Type: multipart/alternative;
	boundary="----=_Part_175276_1723170.1183743978201"

------=_Part_175276_1723170.1183743978201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

I'd upgraded to Bluez 3.12 as per advised, but the problem still persist. I
notice that the issue only occurs when I have more than 1 dongle attached
into the USB port. Thanks

Regards,
Ben


On 6/28/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Ben,
>
> > I've written a program which periodically invokes hcitool scan, and
> > following that propagate out content via obex to the acquired
> > bluetooth address. I've noticed something remarkably strange occuring
> > throughout the process. The program which I'd written is invoked
> > immediately after boot. I'd noticed when I "ps -e" my system, there
> > are a couple of defunct hcid processes. These defunct hcid jobs are
> > immediately visible right after boot and the amount of defunct hcid
> > process will to continue grow until the entire bluetooth service is
> > stuffed. Once the bluetooth srvice is stuffed, if I were to invoke
> > either hcitool or sdptool...I would get a "connection timeout" reply.
> > The only way to remedy the situation is to periodically restart the
> > bluetooth service, once the service is restarted - all of the defunct
> > hcid process will be cleared.
> >
> > Btw I'm running Bluez-utils and bluez-libs 3.10.1 on both Fedora 6 and
> > 7 (issue is replicatable on both system). I've multiple dongles, but
> > only 1 dongle dedicated to scanning. Any idea, guys?
>
> why don't you start trying bluez-utils-3.12 and see if the issue still
> exists.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_175276_1723170.1183743978201
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div>&nbsp;</div>
<div>I&#39;d upgraded to Bluez 3.12 as per advised, but the problem still persist. I notice that the issue only occurs when I have more than 1 dongle attached into the USB port. Thanks</div>
<div><br>Regards,</div>
<div>Ben<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 6/28/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Ben,<br><br>&gt; I&#39;ve written a program which periodically invokes hcitool scan, and<br>&gt; following that propagate out content via obex to the acquired
<br>&gt; bluetooth address. I&#39;ve noticed something remarkably strange occuring<br>&gt; throughout the process. The program which I&#39;d written is invoked<br>&gt; immediately after boot. I&#39;d noticed when I &quot;ps -e&quot; my system, there
<br>&gt; are a couple of defunct hcid processes. These defunct hcid jobs are<br>&gt; immediately visible right after boot and the amount of defunct hcid<br>&gt; process will to continue grow until the entire bluetooth service is
<br>&gt; stuffed. Once the bluetooth srvice is stuffed, if I were to invoke<br>&gt; either hcitool or sdptool...I would get a &quot;connection timeout&quot; reply.<br>&gt; The only way to remedy the situation is to periodically restart the
<br>&gt; bluetooth service, once the service is restarted - all of the defunct<br>&gt; hcid process will be cleared.<br>&gt;<br>&gt; Btw I&#39;m running Bluez-utils and bluez-libs 3.10.1 on both Fedora 6 and<br>&gt; 7 (issue is replicatable on both system). I&#39;ve multiple dongles, but
<br>&gt; only 1 dongle dedicated to scanning. Any idea, guys?<br><br>why don&#39;t you start trying bluez-utils-3.12 and see if the issue still<br>exists.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_175276_1723170.1183743978201--


--===============0788830204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0788830204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0788830204==--
