Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050323011147.34760.qmail@web60904.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] connect T610 to PC problem
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1068803032-1111540307=:34055"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 23 Mar 2005 09:11:47 +0800 (CST)

--0-1068803032-1111540307=:34055
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Fredy!

>Ka Kin Cheung escribio':
>> Hi all!
>> I can connect T610 from PC successfully! The key
>> point is: you have to set the same channel of SDP and
>> rfcomm, and set the class in hciconfig as 0x200404
>> i.e. headset. Then after typing "rfcomm listen 0
>> ", the phone can connect to Pc successfully.
>> But then, I face a new problem. When I put the socket
>> programming part in my main program, after I
>> successfully connect T610 to the PC, it showed
>> "dev/rfcomm0: no such device". Why is that?
>> Then I looked at rfcomm/main.c, and put the
>> cmd_listen part in my main program, but after that,
>> when I tried to connect T610 to PC, the T610 always
>> showed "Bluetooth connection failed". Why is that?
>It is becouse you have a lm master, i only have :

>lm accept;
But I checked /etc/bluetooth/hcid.conf, and I just found lm acept. Then I changed the line into lm accept, master, and then reboot PC, but the problem still exists.

>and y can add the pc to movil from movil
What do you mean about this sentence?
 
Thank you very much.
Michael



---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-1068803032-1111540307=:34055
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Fredy!<BR></DIV>
<DIV>&gt;Ka Kin Cheung escribio':<BR>&gt;&gt; Hi all!<BR>&gt;&gt; I can connect T610 from PC successfully! The key<BR>&gt;&gt; point is: you have to set the same channel of SDP and<BR>&gt;&gt; rfcomm, and set the class in hciconfig as 0x200404<BR>&gt;&gt; i.e. headset. Then after typing "rfcomm listen 0<BR>&gt;&gt; <CHANNEL>", the phone can connect to Pc successfully.<BR>&gt;&gt; But then, I face a new problem. When I put the socket<BR>&gt;&gt; programming part in my main program, after I<BR>&gt;&gt; successfully connect T610 to the PC, it showed<BR>&gt;&gt; "dev/rfcomm0: no such device". Why is that?<BR>&gt;&gt; Then I looked at rfcomm/main.c, and put the<BR>&gt;&gt; cmd_listen part in my main program, but after that,<BR>&gt;&gt; when I tried to connect T610 to PC, the T610 always<BR>&gt;&gt; showed "Bluetooth connection failed". Why is that?<BR>&gt;It is becouse you have a lm master, i only have :<BR><BR>&gt;lm accept;<BR>But I checked /etc/bluetooth/hcid.conf, and I just f
 ound lm
 acept. Then I changed the line into lm accept, master, and then reboot PC, but the problem still exists.<BR><BR>&gt;and y can add the pc to movil from movil<BR>What do you mean about this sentence?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thank you very much.</DIV>
<DIV>Michael</DIV><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1068803032-1111540307=:34055--


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
