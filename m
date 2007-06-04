Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706032041r78a9d91ata7a0ea7a90c8d482@mail.gmail.com>
Date: Sun, 3 Jun 2007 21:41:27 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <718248.43136.qm@web62305.mail.re1.yahoo.com>
MIME-Version: 1.0
References: <d89ddf300706031548m725fa8c3wabcb72a10e15cfb5@mail.gmail.com>
	<718248.43136.qm@web62305.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] alsa module rebuild
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0819826953=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0819826953==
Content-Type: multipart/alternative;
	boundary="----=_Part_4122_33221668.1180928487347"

------=_Part_4122_33221668.1180928487347
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

there is no "stable branch" of the kernel in the same way we had before. the
module api changes enough from release to release to make it painful to
maintain a module outside the kernel. (and don't ask... it will never be
merged upstream because it doesn't belong in the kernel)

On 6/3/07, walt shekrota <penguinacity@yahoo.com> wrote:
>
> yes this is in all the kernels under include/linux/freezer.h.
> I don't see an include for it in the bt code.
> Without digging into it deeper I can't explain the 3 different
> behaviors...
>
> 2.6.18 compiles fine
> 2.6.20 warning (apparently deadly)
> 2.6.21 where I am not gets pages of errors. My post of these held for
> admin approval due to length.
>
> Is it me or does the code not scale to later kernels?
> I'm lost.
> Thanks.
> -Walt
>
> *Brad Midgley <bmidgley@gmail.com>* wrote:
>
> Walt
>
> try_to_freeze seems to do something real if config_pm is defined and
> otherwise it is a trivial function. either way it should be there, at least
> in 2.6.17 in sched.h.
>
> things may have changed more recently.
>
> Brad
>
>
> ------------------------------
> Pinpoint customers
> <http://us.rd.yahoo.com/evt=48250/*http://searchmarketing.yahoo.com/arp/sponsoredsearch_v9.php?o=US2226&cmp=Yahoo&ctv=AprNI&s=Y&s2=EM&b=50>who
> are looking for what you sell.
>
> ------------------------------
> Get the free Yahoo! toolbar<http://us.rd.yahoo.com/evt=48226/*http://new.toolbar.yahoo.com/toolbar/features/norton/index.php>and rest assured with the added security of spyware protection.
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

------=_Part_4122_33221668.1180928487347
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

there is no &quot;stable branch&quot; of the kernel in the same way we had before. the module api changes enough from release to release to make it painful to maintain a module outside the kernel. (and don&#39;t ask... it will never be merged upstream because it doesn&#39;t belong in the kernel)
<br><br><div><span class="gmail_quote">On 6/3/07, <b class="gmail_sendername">walt shekrota</b> &lt;<a href="mailto:penguinacity@yahoo.com">penguinacity@yahoo.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
yes this is in all the kernels under include/linux/freezer.h.<br> I don&#39;t see an include for it in the bt code.<br> Without digging into it deeper I can&#39;t explain the 3 different behaviors...<br> <br> 2.6.18 compiles fine
<br> 2.6.20 warning (apparently deadly)<br> 2.6.21 where I am not gets pages of errors. My post of these held for admin approval due to length.<br> <br> Is it me or does the code not scale to later kernels?<br> I&#39;m lost.
<span class="q"><br> Thanks.<br> -Walt<br><br><b><i>Brad Midgley &lt;<a href="mailto:bmidgley@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bmidgley@gmail.com</a>&gt;</i></b> wrote:</span>
<span class="q"><blockquote style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Walt<br><br>try_to_freeze seems to do something real if config_pm is defined and otherwise it is a trivial function. either way it should be there, at least in 
2.6.17 in sched.h.<br><br>things may have changed more recently. <br><br>Brad<br><br> </blockquote><br></span><p> 
      </p><hr size="1"><a href="http://us.rd.yahoo.com/evt=48250/*http://searchmarketing.yahoo.com/arp/sponsoredsearch_v9.php?o=US2226&amp;cmp=Yahoo&amp;ctv=AprNI&amp;s=Y&amp;s2=EM&amp;b=50" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
Pinpoint customers </a>who are looking for what you sell. <p><span class="ad"> 
      <hr size="1"><a href="http://us.rd.yahoo.com/evt=48226/*http://new.toolbar.yahoo.com/toolbar/features/norton/index.php" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Get the free Yahoo! toolbar
</a> and rest assured with the added security of spyware protection.
 </span></p><p></p><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/</a><br>_______________________________________________<br>Bluez-users mailing list
<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote></div><br>

------=_Part_4122_33221668.1180928487347--


--===============0819826953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0819826953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0819826953==--
