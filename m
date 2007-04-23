Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50704231133q4949da84m7b93a5e0043d8b9e@mail.gmail.com>
Date: Mon, 23 Apr 2007 15:33:53 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <419284.19431.qm@web43138.mail.sp1.yahoo.com>
MIME-Version: 1.0
References: <419284.19431.qm@web43138.mail.sp1.yahoo.com>
Subject: Re: [Bluez-users] Bluez source code doubt
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0503679655=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0503679655==
Content-Type: multipart/alternative;
	boundary="----=_Part_141861_1196310.1177353233792"

------=_Part_141861_1196310.1177353233792
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is definitely not a silly question.

As far as I know, these magic numbers values refer to the timeout value for
each operation. However, I also do not understand how to choose a value for
each function call. Generally, when I need to change some code, I just copy
and past the code block and maitain the magic numbers. I just have faith
they will keep working fine in my code :-)

It would be nice to hear some words about choosing these timeouts values (
unless this is a really silly question ).

Regards,

Loreno

On 4/23/07, Bluezapper <enigma_enu@yahoo.com> wrote:
>
> Hi,
>
> I am sorry if this question is silly. I am new to Bluez and C socket
> programming. I was going through the bluez source code but did not
> understand the following statements from hcitool.c:
>
> if (hci_read_remote_version(dd, handle, &version, 20000) == 0)
>
> if (hci_read_remote_name(dd, &bdaddr, sizeof(name), name, 25000)== 0)
>
>
> What are the numbers "25000" or "20000" in these statements and I see that
> they are different for different statments sometimes compared to less than
> zero or equal to zero ??
>
>
> thanks in advance for your replies,
>
> Marco.
>
> ------------------------------
> Ahhh...imagining that irresistible "new car" smell?
> Check out new cars at Yahoo! Autos.<http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM->
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
>

------=_Part_141861_1196310.1177353233792
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is definitely not a silly question.<br><br>As far as I know, these magic numbers values refer to the timeout value for each operation. However, I also do not understand how to choose a value for each function call. Generally, when I need to change some code, I just copy and past the code block and maitain the magic numbers. I just have faith they will keep working fine in my code :-)
<br><br>It would be nice to hear some words about choosing these timeouts values ( unless this is a really silly question ).<br><br>Regards,<br><br>Loreno<br><br><div><span class="gmail_quote">On 4/23/07, <b class="gmail_sendername">
Bluezapper</b> &lt;<a href="mailto:enigma_enu@yahoo.com">enigma_enu@yahoo.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br><br>I am sorry if this question is silly. I am new to Bluez and C socket programming. I was going through the bluez source code but did not understand the following statements from hcitool.c:<br><br>if (hci_read_remote_version(dd, handle, &amp;version, 20000) == 0)
<br><br>if (hci_read_remote_name(dd, &amp;bdaddr, sizeof(name), name, 25000)== 0)<br><br><br>What are the numbers &quot;25000&quot; or &quot;20000&quot; in these statements and I see that they are different for different statments sometimes compared to less than zero or equal to zero ??
<br><br><br>thanks in advance for your replies,<br><br>Marco.<br><span class="ad"><p> 



      </p><hr size="1">Ahhh...imagining that irresistible &quot;new car&quot; smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
new cars at Yahoo! Autos.</a>
<p></p></span><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote></div><br>

------=_Part_141861_1196310.1177353233792--


--===============0503679655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0503679655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0503679655==--
