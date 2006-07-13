Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060713091840.63659.qmail@web50503.mail.yahoo.com>
Date: Thu, 13 Jul 2006 02:18:40 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1152620993.15028.30.camel@localhost>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluetooth USB dongles
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0835025105=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0835025105==
Content-Type: multipart/alternative; boundary="0-1946793574-1152782320=:63294"
Content-Transfer-Encoding: 8bit

--0-1946793574-1152782320=:63294
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,

Thanks for your help. I know it may be irrelevant to ask this......but I have no other way! This group seems to be the only one where I can get a bit help.

1. I want to know the golden receiver power range (GRPR) of the bluetooth dongles I am using (specifically the upper & lower threshold). From your reply, I guess it should be implemented in the chips (BlueCore4-Ext or BlueCore4-ROM) and so will be a chip paramter. Should reading the data-sheets of those chips help me in finding their Golden Receiver Power Range (i.e. the upper & lower threshold level)? Or any other way to find it?

2. Is Link Quality (LQ) also a chip-parameter? Is the link quality algorithm same for all CSR chips (the one posted in your website)? How could you find that algorithm?

3. Does the power-control (stepping up or down of power) vary from chip to chip?

4. What's the main purpose of the driver (Toshiba or Level1 etc.)?

Thanks in advance
Mahtab

Marcel Holtmann <marcel@holtmann.org> wrote: Hi Mahtab,

> >it is kinda unusual to find a CSR based dongle with software from Broadcom
> Indeed it is!
> Can I know which bluetooth dongles u r using currently (or last used)?

I ended up with dongles from Level1 and Toshiba. All of them were
BlueCore4-External, but it seems nowadays they only use BlueCore4-ROM
chips to reduce the costs.

Regards

Marcel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-1946793574-1152782320=:63294
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Marcel,<br><br>Thanks for your help. I know it may be irrelevant to ask this......but I have no other way! This group seems to be the only one where I can get a bit help.<br><br>1. I want to know the golden receiver power range (GRPR) of the bluetooth dongles I am using (specifically the upper &amp; lower threshold). From your reply, I guess it should be implemented in the chips (BlueCore4-Ext or BlueCore4-ROM) and so will be a chip paramter. Should reading the data-sheets of those chips help me in finding their Golden Receiver Power Range (i.e. the upper &amp; lower threshold level)? Or any other way to find it?<br><br>2. Is Link Quality (LQ) also a chip-parameter? Is the link quality algorithm same for all CSR chips (the one posted in your website)? How could you find that algorithm?<br><br>3. Does the power-control (stepping up or down of power) vary from chip to chip?<br><br>4. What's the main purpose of the driver (Toshiba or Level1 etc.)?<br><br>Thanks in
 advance<br>Mahtab<br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Mahtab,<br><br>&gt; &gt;it is kinda unusual to find a CSR based dongle with software from Broadcom<br>&gt; Indeed it is!<br>&gt; Can I know which bluetooth dongles u r using currently (or last used)?<br><br>I ended up with dongles from Level1 and Toshiba. All of them were<br>BlueCore4-External, but it seems nowadays they only use BlueCore4-ROM<br>chips to reduce the costs.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache
 Geronimo<br>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-1946793574-1152782320=:63294--


--===============0835025105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0835025105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0835025105==--
