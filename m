Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50705012238j36bd3f96u8baccf9bf4eb3ee1@mail.gmail.com>
Date: Wed, 2 May 2007 11:08:29 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>
MIME-Version: 1.0
References: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>
Subject: Re: [Bluez-devel] finding the least busy hci device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0680282168=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0680282168==
Content-Type: multipart/alternative;
	boundary="----=_Part_3792_32745073.1178084309051"

------=_Part_3792_32745073.1178084309051
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ben,
I was trying it few months ago. What I was doing was not very much effective
but workable.
There is status for every connection ... "ci->state". If its state is
BT_CONNECTED means its connected and u can't connect it with other once.
With these state u can have a watch on dongles and if any Dongle get free u
can use it.

u can find these function under hci.c and hci_lib.h. use them ... if get
soem better way then please let me know..

On 4/30/07, Benjamin Fong <benjamin.backup@gmail.com> wrote:
>
> Hi,
>
> I'm trying to write an OBEX application which will be deployed in an
> environment with multiple attached Bluetooth USB dongles. Since each
> bluetooth dongle can support only 7 ACL active connection simultaneously,
> can anyone please suggest a method to efficiently perform load balancing on
> all the available bluetooth dongles? Is there a function which I can use to
> seek out the least busy/connected hci device? Thanks
>
> Regards,
> Ben
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
>


-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_3792_32745073.1178084309051
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ben, <br>
I was trying it few months ago. What I was doing was not very much effective but workable. <br>
There is status for every connection ... &quot;ci-&gt;state&quot;. If its state
is BT_CONNECTED means its connected and u can&#39;t connect it with other
once. With these state u can have a watch on dongles and if any Dongle
get free u can use it. <br>
<br>
u can find these function under hci.c and hci_lib.h. use them ... if get soem better way then please let me know..<br><br><div><span class="gmail_quote">On 4/30/07, <b class="gmail_sendername">Benjamin Fong</b> &lt;<a href="mailto:benjamin.backup@gmail.com">
benjamin.backup@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>Hi,</div>
<div>&nbsp;</div>
<div>I&#39;m trying to write an OBEX application which will be deployed in
an environment with multiple attached Bluetooth USB dongles. Since each
bluetooth dongle can support only 7 ACL active connection
simultaneously, can anyone please suggest a method to efficiently
perform load balancing on all the available bluetooth dongles? Is there
a function which I can use to seek out the least busy/connected hci
device? Thanks
</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben</div>
<br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br></blockquote></div><br><br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_3792_32745073.1178084309051--


--===============0680282168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0680282168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0680282168==--
