Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60705090927n71d22c0an5116c8a1323ed3a3@mail.gmail.com>
Date: Wed, 9 May 2007 09:27:50 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1178726532.8628.107.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <4641DA61.8040709@tao-group.com>
	<1178722356.8628.96.camel@aeonflux.holtmann.net>
	<4641E662.6080303@tao-group.com>
	<1178724426.8628.102.camel@aeonflux.holtmann.net>
	<4641EA96.7070204@tao-group.com>
	<1178726532.8628.107.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] API documentation?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0492165101=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0492165101==
Content-Type: multipart/alternative;
	boundary="----=_Part_67487_7842474.1178728070739"

------=_Part_67487_7842474.1178728070739
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel:


I am trying to follow your advice and use the D-BUS API instead of the
low-level HCI API.
However, no matter which D-BUS method I issued, I got back this error:

   The name org.bluez was not provided by any .service files

I tried to search online but could not find any answer.  I searched the
archive, nothing comes up.   Can you provide your expertise on this one?
What are these .service files?  How can I make one for org.bluez?

I am forced to go back to the HCI API (at least they work for now) until I
figure out how to resolve this lack of .service files.   Any tips/pointers
much appreciated.


Mark


On 5/9/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi David,
>
> > > you choice, but that way is deprecated and might go away at any point
> in
> > > the future.
> >
> > My device doesn't *have* D-Bus.
> >
> > Actually, I forgot to mention that I can also use hcilib (as it's just a
> thin
> > wrapper over the ioctl layer). The only documentation for that appears
> to be
> > the header file...
>
> to be quite frankly, then don't ask me about it. If you wanna screw with
> your system you are on your own.
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
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_67487_7842474.1178728070739
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marcel:<br><br><br>I am trying to follow your advice and use the D-BUS API instead of the low-level HCI API.<br>However, no matter which D-BUS method I issued, I got back this error:<br><br>&nbsp;&nbsp; The name org.bluez
 was not provided by any .service files<br><br>I tried to search online but could not find any answer.&nbsp; I searched the archive, nothing comes up.&nbsp;&nbsp; Can you provide your expertise on this one?&nbsp; What are these .service files?&nbsp; How can I make one for 
org.bluez?<br><br>I am forced to go back to the HCI API (at least they work for now) until I figure out how to resolve this lack of .service files.&nbsp;&nbsp; Any tips/pointers much appreciated.<br><br><br>Mark<br><br><br><div><span class="gmail_quote">
On 5/9/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi David,<br><br>&gt; &gt; you choice, but that way is deprecated and might go away at any point in<br>&gt; &gt; the future.<br>&gt;<br>&gt; My device doesn&#39;t *have* D-Bus.<br>&gt;<br>&gt; Actually, I forgot to mention that I can also use hcilib (as it&#39;s just a thin
<br>&gt; wrapper over the ioctl layer). The only documentation for that appears to be<br>&gt; the header file...<br><br>to be quite frankly, then don&#39;t ask me about it. If you wanna screw with<br>your system you are on your own.
<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
<br></blockquote></div><br>

------=_Part_67487_7842474.1178728070739--


--===============0492165101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0492165101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0492165101==--
