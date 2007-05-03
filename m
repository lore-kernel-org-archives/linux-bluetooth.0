Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510705022305s522c254fy511ee6e9db90c44c@mail.gmail.com>
Date: Thu, 3 May 2007 14:05:42 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1ab01fb50705012238j36bd3f96u8baccf9bf4eb3ee1@mail.gmail.com>
MIME-Version: 1.0
References: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>
	<1ab01fb50705012238j36bd3f96u8baccf9bf4eb3ee1@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0237391863=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0237391863==
Content-Type: multipart/alternative;
	boundary="----=_Part_24945_8769568.1178172342618"

------=_Part_24945_8769568.1178172342618
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Vikas,

I think your solution is far more elegant than mine. I'd tried to obtain the
amount of connected device  to the dongle via cl->conn_num, and try to gauge
from there if the dongle is busy. Thanks mate

Regards,
Ben


On 5/2/07, Vikas Sinha <compuvikas@gmail.com> wrote:
>
> Hi Ben,
> I was trying it few months ago. What I was doing was not very much
> effective but workable.
> There is status for every connection ... "ci->state". If its state is
> BT_CONNECTED means its connected and u can't connect it with other once.
> With these state u can have a watch on dongles and if any Dongle get free u
> can use it.
>
> u can find these function under hci.c and hci_lib.h. use them ... if get
> soem better way then please let me know..
>
>  On 4/30/07, Benjamin Fong < benjamin.backup@gmail.com> wrote:
>
> >  Hi,
> >
> > I'm trying to write an OBEX application which will be deployed in an
> > environment with multiple attached Bluetooth USB dongles. Since each
> > bluetooth dongle can support only 7 ACL active connection simultaneously,
> > can anyone please suggest a method to efficiently perform load balancing on
> > all the available bluetooth dongles? Is there a function which I can use to
> > seek out the least busy/connected hci device? Thanks
> >
> > Regards,
> > Ben
> >
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by DB2 Express
> > Download DB2 Express C - the FREE version of DB2 express and take
> > control of your XML. No limits. Just data. Click to get it now.
> > http://sourceforge.net/powerbar/db2/
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>
>
> --
> Impossible
> itself contain
> I M Possible
>
> Vikas
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

------=_Part_24945_8769568.1178172342618
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Vikas,</div>
<div>&nbsp;</div>
<div>I think your solution is far more elegant than mine. I&#39;d tried to obtain the amount of connected device&nbsp; to the dongle via cl-&gt;conn_num, and try to gauge from there if the&nbsp;dongle is busy. Thanks mate</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 5/2/07, <b class="gmail_sendername">Vikas Sinha</b> &lt;<a href="mailto:compuvikas@gmail.com">compuvikas@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Ben, <br>I was trying it few months ago. What I was doing was not very much effective but workable. <br>
There is status for every connection ... &quot;ci-&gt;state&quot;. If its state is BT_CONNECTED means its connected and u can&#39;t connect it with other once. With these state u can have a watch on dongles and if any Dongle get free u can use it. 
<br><br>u can find these function under hci.c and hci_lib.h. use them ... if get soem better way then please let me know..<br><br>
<div>
<div><span class="e" id="q_1124b4cef3a454d3_1"><span class="gmail_quote">On 4/30/07, <b class="gmail_sendername">Benjamin Fong</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:benjamin.backup@gmail.com" target="_blank">
 benjamin.backup@gmail.com</a>&gt; wrote:</span></span></div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(204,204,204) 1px solid">
<div><span class="e" id="q_1124b4cef3a454d3_3">
<div>Hi,</div>
<div>&nbsp;</div>
<div>I&#39;m trying to write an OBEX application which will be deployed in an environment with multiple attached Bluetooth USB dongles. Since each bluetooth dongle can support only 7 ACL active connection simultaneously, can anyone please suggest a method to efficiently perform load balancing on all the available bluetooth dongles? Is there a function which I can use to seek out the least busy/connected hci device? Thanks 
</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben</div></span></div><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now. <br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/
</a><br>_______________________________________________<br>Bluez-devel mailing list <br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank">Bluez-devel@lists.sourceforge.net
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br></blockquote>
</div><br><br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><span class="sg"><br>Vikas </span><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express
<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br><br></blockquote></div><br>

------=_Part_24945_8769568.1178172342618--


--===============0237391863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0237391863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0237391863==--
