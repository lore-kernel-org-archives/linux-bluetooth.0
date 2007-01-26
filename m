Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20070126151002.69793.qmail@web53314.mail.yahoo.com>
Date: Fri, 26 Jan 2007 23:10:01 +0800 (CST)
From: KS H <kspam1234@yahoo.com.hk>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <2e9fc96f0701252145x71b8810tfa22948c5a9e63d8@mail.gmail.com>
MIME-Version: 1.0
Subject: [Bluez-users] =?big5?q?=A6^=C2=D0=A1G=20Re:=20=20pin=20code?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0447634540=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0447634540==
Content-Type: multipart/alternative; boundary="0-2012281723-1169824201=:69505"
Content-Transfer-Encoding: 8bit

--0-2012281723-1169824201=:69505
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi 

I follow the configure described. When I execut 'dbus-daemon --system'
it return 

Failed to start message bus: Could not get UID and GID for username "messagebus"

What is that mean?

and also there is no blue-hcid.conf in hcid folder
but I found a file call bluetooth.conf. is that the same file you said

Regards

SH
Prabhu nath <gprabhunath@gmail.com> 說： You have to cross-compile dbus-1.0, and start dbus-daemon before executing hcid. 
 dbus-daemon --system
  
 While cross-compiling dbus-1.0 and bluez-utils, pass the following parameters for the configure script.
 --localstatedir=/var --sysconfdir=/etc
  
 Once you do this, by default hcid will look for hcid.conf in /etc/bluetooth directory. 
  
  
 Warning. Take a backup of /etc/dbus-1 and /etc/bluetooth, because this will overwrite the previous config, which was already present in ur system.
  
 Run make install for dbus, and u need not run make install for bluez-utils. U can directly copy the hcid.conf and blue-hcid.conf to /etc/bluetooth and /etc/dbus-1/system.d directory respectively.
  
 Now, when u start dbus-daemon --system, it will create a system_bus_socket in /var/run/dbus and it will create a message.pid in /var/run/. 
  
 next, when u start hcid, u should not get problem.
  
 -Prabhu
  
 

 
 On 1/23/07, KS H <kspam1234@yahoo.com.hk> wrote: Dear

I cross compile the bluez3.8 and try to setup the bluetooth in arm. I connect the arm with CSR BC03 with BCSP configuration. I am able to make the Bluez discoverable and try to pair bluez. however i found that there is no pin respond from Bluez. So i try to configure bluez using hcid. 

> hcid -n -f /etc/bluetooth/hcid.conf

it return

hcid[481]: Can't connect to system message bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket:  No such file or directory 
hcid[481]: Unable to get on D-Bus

My question
1. where can I found the missing file and what is that used for?
2. Is there any method to repsond the pin request other than using hcid

Regards
SH
  _______________________________________
YM - 離線訊息
就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
http://messenger.yahoo.com.hk  

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your 
opinions on IT & business topics through brief surveys - and earn cash
 http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

_______________________________________________
Bluez-users mailing list
 Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users 




 -------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 _______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-2012281723-1169824201=:69505
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

Hi <br><br>I follow the configure described. When I execut 'dbus-daemon --system'<br>it return <br><br>Failed to start message bus: Could not get UID and GID for username "messagebus"<br><br>What is that mean?<br><br>and also there is no blue-hcid.conf in hcid folder<br>but I found a file call bluetooth.conf. is that the same file you said<br><br>Regards<br><br>SH<br><b><i>Prabhu nath &lt;gprabhunath@gmail.com&gt;</i></b> 說：<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <div>You have to cross-compile dbus-1.0, and start dbus-daemon before executing hcid. </div> <div>dbus-daemon --system</div> <div>&nbsp;</div> <div>While cross-compiling dbus-1.0 and bluez-utils, pass the following parameters for the configure script.</div> <div>--localstatedir=/var --sysconfdir=/etc</div> <div>&nbsp;</div> <div>Once you do this, by default hcid will look for hcid.conf in /etc/bluetooth directory. </div> <div>&nbsp;</div>
 <div>&nbsp;</div> <div><strong>Warning</strong>. Take a backup of /etc/dbus-1 and /etc/bluetooth, because this will overwrite the previous config, which&nbsp;was already present in ur system.</div> <div>&nbsp;</div> <div>Run make install for dbus, and u need not run make install for bluez-utils. U can directly copy the hcid.conf and blue-hcid.conf to /etc/bluetooth and /etc/dbus-1/system.d directory respectively.</div> <div>&nbsp;</div> <div>Now, when u start dbus-daemon --system, it will create a system_bus_socket in /var/run/dbus and it will create a message.pid in /var/run/. </div> <div>&nbsp;</div> <div>next, when u start hcid, u should not get problem.</div> <div>&nbsp;</div> <div>-Prabhu</div> <div>&nbsp;</div> <div><br><br>&nbsp;</div> <div><span class="gmail_quote">On 1/23/07, <b class="gmail_sendername">KS H</b> &lt;<a href="mailto:kspam1234@yahoo.com.hk">kspam1234@yahoo.com.hk</a>&gt; wrote:</span> <blockquote class="gmail_quote" style="border-left: 1px solid
 rgb(204, 204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;">Dear<br><br>I cross compile the bluez3.8 and try to setup the bluetooth in arm. I connect the arm with CSR BC03 with BCSP configuration. I am able to make the Bluez discoverable and try to pair bluez. however i found that there is no pin respond from Bluez. So i try to configure bluez using hcid. <br><br>&gt; hcid -n -f /etc/bluetooth/hcid.conf<br><br>it return<br><br>hcid[481]: Can't connect to system message bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket:&nbsp; No such file or directory <br>hcid[481]: Unable to get on D-Bus<br><br>My question<br>1. where can I found the missing file and what is that used for?<br>2. Is there any method to repsond the pin request other than using hcid<br><br>Regards<br>SH<br> <span class="ad"> <div>_______________________________________<br>YM -
 離線訊息<br>就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://messenger.yahoo.com.hk/" target="_blank">http://messenger.yahoo.com.hk </a> </div></span><br>-------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your <br>opinions on IT &amp; business topics through brief surveys - and earn cash<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV" target="_blank"> http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br><br>_______________________________________________<br>Bluez-users mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)"
 href="mailto:Bluez-users@lists.sourceforge.net"> Bluez-users@lists.sourceforge.net</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users </a><br><br><br></blockquote></div><br> -------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys - and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;_______________________________________<br> YM - 離線訊息<br>
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-2012281723-1169824201=:69505--


--===============0447634540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0447634540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0447634540==--
