Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300706030814n3c66c621r80fb45ebee05b378@mail.gmail.com>
Date: Sun, 3 Jun 2007 09:14:09 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <776670.33525.qm@web62301.mail.re1.yahoo.com>
MIME-Version: 1.0
References: <776670.33525.qm@web62301.mail.re1.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1121095969=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1121095969==
Content-Type: multipart/alternative;
	boundary="----=_Part_1081_12225764.1180883649733"

------=_Part_1081_12225764.1180883649733
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

cd btsco/kernel; sudo make clean default install

On 6/3/07, walt shekrota <penguinacity@yahoo.com> wrote:
>
> Hi,
>
> On one of my systems I'm having difficulty jumping to the 2.6.20 kernel
> from 18.
> The kernel builds fine but my headset fails to work. I noted the alsa
> snd-bt-sco module is not rebuilt.
> Does anyone remember exactly what process it is that builds this
> component? The btsco code was separate I know..... I am using 0.5 there.
> snd-bt-sco is in the kernel? If so what question in menuconfig toggles
> it's creation? In 2.6.18 it was added to the extra directory in
> /lib/modules/kernelversion for me but in my 2.6.20 build there is no such
> module.
>
> Thanks for any help.
> -Walt
>
> ------------------------------
> Building a website is a piece of cake.
> Yahoo! Small Business gives you all the tools to get online.<http://us.rd.yahoo.com/evt=48251/*http://smallbusiness.yahoo.com/webhosting/?p=PASSPORTPLUS>
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

------=_Part_1081_12225764.1180883649733
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

cd btsco/kernel; sudo make clean default install<br><br><div><span class="gmail_quote">On 6/3/07, <b class="gmail_sendername">walt shekrota</b> &lt;<a href="mailto:penguinacity@yahoo.com">penguinacity@yahoo.com</a>&gt; wrote:
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br> <br> On one of my systems I&#39;m having difficulty jumping to the 2.6.20 kernel from 18.
<br> The kernel builds fine but my headset fails to work. I noted the alsa snd-bt-sco module is not rebuilt.<br> Does anyone remember exactly what process it is that builds this component? The btsco code was separate I know..... I am using 
0.5 there. <br> snd-bt-sco is in the kernel? If so what question in menuconfig toggles it&#39;s creation? In 2.6.18 it was added to the extra directory in /lib/modules/kernelversion for me but in my 2.6.20 build there is no such module.
<br> <br> Thanks for any help.<br><span class="sg"> -Walt<br></span><span class="ad"> <p> 
      </p><hr size="1">Building a website is a piece of cake. <br>Yahoo! Small Business gives you <a href="http://us.rd.yahoo.com/evt=48251/*http://smallbusiness.yahoo.com/webhosting/?p=PASSPORTPLUS" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
all the tools to get online.</a><p></p></span><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take
<br>control of your XML. No limits. Just data. Click to get it now.<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote>
</div><br>

------=_Part_1081_12225764.1180883649733--


--===============1121095969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1121095969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1121095969==--
