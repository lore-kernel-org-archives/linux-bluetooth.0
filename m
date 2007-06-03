Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 3 Jun 2007 09:34:34 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300706030814n3c66c621r80fb45ebee05b378@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <297218.79751.qm@web62303.mail.re1.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============2094014418=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2094014418==
Content-Type: multipart/alternative; boundary="0-2034616625-1180888474=:79751"
Content-Transfer-Encoding: 8bit

--0-2034616625-1180888474=:79751
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ahhhh I knew a step was missing but couldn't see it in any infos.
 Now it has load problems :(
 warning on make
 
     INSTALL /home/wshek/btsco-0.5/kernel/snd-bt-sco.ko
     DEPMOD  2.6.20-gentoo-r7
     WARNING: /lib/modules/2.6.20-gentoo-r7/extra/snd-bt-sco.ko needs unknown symbol try_to_freeze
 
 probably a kernel dependency I have not enabled? Something new?
 ====
 appears to be show stopper on load
 modprobe snd-bt-sco
 
 : from dmesg tail after trying to load module
 Bluetooth: SCO (Voice Link) ver 0.5
 Bluetooth: SCO socket layer initialized
 snd_bt_sco: Unknown symbol try_to_freeze

 ===
 
 and lsmod does not show module loaded
 Thanks.
 -Walt
 
Brad Midgley <bmidgley@gmail.com> wrote: cd btsco/kernel; sudo make clean default install

On 6/3/07, walt shekrota <penguinacity@yahoo.com> wrote: Hi,
 
 On one of my systems I'm having difficulty jumping to the 2.6.20 kernel from 18. 
 The kernel builds fine but my headset fails to work. I noted the alsa snd-bt-sco module is not rebuilt.
 Does anyone remember exactly what process it is that builds this component? The btsco code was separate I know..... I am using  0.5 there. 
 snd-bt-sco is in the kernel? If so what question in menuconfig toggles it's creation? In 2.6.18 it was added to the extra directory in /lib/modules/kernelversion for me but in my 2.6.20 build there is no such module. 
 
 Thanks for any help.
 -Walt
         

---------------------------------
Building a website is a piece of cake. 
Yahoo! Small Business gives you  all the tools to get online.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take 
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/ 
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/bluez-users

 

 -------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 
---------------------------------
Expecting? Get great news right away with email Auto-Check.
Try the Yahoo! Mail Beta.
--0-2034616625-1180888474=:79751
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Ahhhh I knew a step was missing but couldn't see it in any infos.<br> Now it has load problems :(<br> warning on make<br> <br> &nbsp;&nbsp;&nbsp; INSTALL /home/wshek/btsco-0.5/kernel/snd-bt-sco.ko<br> &nbsp;&nbsp;&nbsp; DEPMOD&nbsp; 2.6.20-gentoo-r7<br> &nbsp;&nbsp;&nbsp; WARNING: /lib/modules/2.6.20-gentoo-r7/extra/snd-bt-sco.ko needs unknown symbol try_to_freeze<br> <br> probably a kernel dependency I have not enabled? Something new?<br> ====<br> appears to be show stopper on load<br> modprobe snd-bt-sco<br> <br> : from dmesg tail after trying to load module<br> Bluetooth: SCO (Voice Link) ver 0.5<br> Bluetooth: SCO socket layer initialized<br> snd_bt_sco: Unknown symbol try_to_freeze<br><br> ===<br> <br> and lsmod does not show module loaded<br> Thanks.<br> -Walt<br> <br><b><i>Brad Midgley &lt;bmidgley@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> cd btsco/kernel; sudo make
 clean default install<br><br><div><span class="gmail_quote">On 6/3/07, <b class="gmail_sendername">walt shekrota</b> &lt;<a href="mailto:penguinacity@yahoo.com">penguinacity@yahoo.com</a>&gt; wrote: </span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br> <br> On one of my systems I'm having difficulty jumping to the 2.6.20 kernel from 18. <br> The kernel builds fine but my headset fails to work. I noted the alsa snd-bt-sco module is not rebuilt.<br> Does anyone remember exactly what process it is that builds this component? The btsco code was separate I know..... I am using  0.5 there. <br> snd-bt-sco is in the kernel? If so what question in menuconfig toggles it's creation? In 2.6.18 it was added to the extra directory in /lib/modules/kernelversion for me but in my 2.6.20 build there is no such module. <br> <br> Thanks for any help.<br><span class="sg"> -Walt<br></span><span
 class="ad"> <div>        </div><hr size="1">Building a website is a piece of cake. <br>Yahoo! Small Business gives you <a href="http://us.rd.yahoo.com/evt=48251/*http://smallbusiness.yahoo.com/webhosting/?p=PASSPORTPLUS" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> all the tools to get online.</a><div></div></span><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take <br>control of your XML. No limits. Just data. Click to get it now.<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://sourceforge.net/powerbar/db2/" target="_blank">http://sourceforge.net/powerbar/db2/ </a><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)"
 href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net </a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br><br></blockquote> </div><br> -------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;

<hr size=1>Expecting? Get great news right away with <a href="http://us.rd.yahoo.com/evt=49982/*http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html">email Auto-Check.</a><br>Try the <a href="http://us.rd.yahoo.com/evt=49982/*http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html">Yahoo! Mail Beta.</a>
--0-2034616625-1180888474=:79751--


--===============2094014418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2094014418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2094014418==--
