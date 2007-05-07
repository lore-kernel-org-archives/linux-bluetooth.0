Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1ab01fb50705062337h27e492e1k96fb7acba7481b98@mail.gmail.com>
Date: Mon, 7 May 2007 12:07:33 +0530
From: "Vikas Sinha" <compuvikas@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1608.190.30.192.53.1178493815.squirrel@www.y2knetworks.com.ar>
MIME-Version: 1.0
References: <mailman.10877.1178436722.11342.bluez-devel@lists.sourceforge.net>
	<1608.190.30.192.53.1178493815.squirrel@www.y2knetworks.com.ar>
Subject: Re: [Bluez-devel] Services Discovering
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1801310182=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1801310182==
Content-Type: multipart/alternative;
	boundary="----=_Part_86297_22456929.1178519853222"

------=_Part_86297_22456929.1178519853222
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Mauricio,
Check out the code for sdptool.c . It use browse() to browse all service
found in any device. Actually when we do browse it get a link-list which
need to browse each list inside list.  There is a magic number 0xffff to get
all service. use it.



On 5/7/07, msaglietto@y2knetworks.com.ar <msaglietto@y2knetworks.com.ar>
wrote:
>
> Hi,
>     I was looking a way  to get all the services of a bluetooth device.And
> found this that can help me ...
> http://people.csail.mit.edu/albert/bluez-intro/x601.html
> But still if use this method i have to have a list of all UUID  then i was
> wondering if there is another method or at least there is a list of all
> UUID somewhere.
>
> Regards,
> Mauricio
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



-- 
Impossible
itself contain
I M Possible

Vikas

------=_Part_86297_22456929.1178519853222
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi Mauricio,<br>
Check out the code for sdptool.c . It use browse() to browse all
service found in any device. Actually when we do browse it get a
link-list which need to browse each list inside list.&nbsp; There is a
magic number 0xffff to get all service. use it.<br>
<br>
<br><br><div><span class="gmail_quote">On 5/7/07, <b class="gmail_sendername"><a href="mailto:msaglietto@y2knetworks.com.ar">msaglietto@y2knetworks.com.ar</a></b> &lt;<a href="mailto:msaglietto@y2knetworks.com.ar">msaglietto@y2knetworks.com.ar
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>&nbsp;&nbsp;&nbsp;&nbsp;I was looking a way&nbsp;&nbsp;to get all the services of a bluetooth 
device.And<br>found this that can help me ...<br><a href="http://people.csail.mit.edu/albert/bluez-intro/x601.html">http://people.csail.mit.edu/albert/bluez-intro/x601.html</a><br>But still if use this method i have to have a list of all UUID&nbsp;&nbsp;then i was
<br>wondering if there is another method or at least there is a list of all<br>UUID somewhere.<br><br>Regards,<br>Mauricio<br><br><br><br>-------------------------------------------------------------------------<br>This SF.net
 email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br><a href="http://sourceforge.net/powerbar/db2/">
http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br><br clear="all"><br>-- <br>Impossible <br>itself contain <br>I M Possible<br><br>Vikas

------=_Part_86297_22456929.1178519853222--


--===============1801310182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1801310182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1801310182==--
