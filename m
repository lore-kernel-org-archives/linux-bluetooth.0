Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061020093544.63213.qmail@web52002.mail.yahoo.com>
Date: Fri, 20 Oct 2006 02:35:44 -0700 (PDT)
From: anoop <ee02m043@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1161334276.27585.42.camel@localhost>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Cant get dongle up
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0122074123=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0122074123==
Content-Type: multipart/alternative; boundary="0-843856465-1161336944=:62621"
Content-Transfer-Encoding: 8bit

--0-843856465-1161336944=:62621
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Marcel. Dongle's BD address is not changing. How about buying a D-link DBT120 dongle?. I will try upgrading the kernel. Mean while can you please tell me how to load hci_usb with isoc=0 switch ?.

 Regards
 Anoop
Marcel Holtmann <marcel@holtmann.org> wrote: Hi,

> I am new to Linux and blueZ, so may be my question may be  silly.
> 
> My USB BT dongle has ISSC chipset (the ebay seller claimed that it
> will be a Bilionton dongle but it turned out to be a cheap EEPROM less
> dongle with 11:11.. BD address ) . It works fine in windows with
> blusoleil. But  I could not get it working in Linux - Kernerl 2.6.11 ,
> Fedora core 3 redhat 12.0. 

does it change the address when using it with BlueSoleil? If it doesn't
then you might wanna return this dongle and buy a good one.

You kernel is quite ancient. You can try to load the hci_usb driver with
the isoc=0 switch, but it might be a better idea to upgrade to Fedora
Core 6 on Tuesday.

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
Get your own web address for just $1.99/1st yr. We'll help. Yahoo! Small Business.
--0-843856465-1161336944=:62621
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Thanks Marcel. Dongle's BD address is not changing. How about buying a D-link DBT120 dongle?. I will try upgrading the kernel. Mean while can you please tell me how to load hci_usb with isoc=0 switch ?.<br><br> Regards<br> Anoop<br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi,<br><br>&gt; I am new to Linux and blueZ, so may be my question may be  silly.<br>&gt; <br>&gt; My USB BT dongle has ISSC chipset (the ebay seller claimed that it<br>&gt; will be a Bilionton dongle but it turned out to be a cheap EEPROM less<br>&gt; dongle with 11:11.. BD address ) . It works fine in windows with<br>&gt; blusoleil. But  I could not get it working in Linux - Kernerl 2.6.11 ,<br>&gt; Fedora core 3 redhat 12.0. <br><br>does it change the address when using it with BlueSoleil? If it doesn't<br>then you might wanna return this dongle and buy a good
 one.<br><br>You kernel is quite ancient. You can try to load the hci_usb driver with<br>the isoc=0 switch, but it might be a better idea to upgrade to Fedora<br>Core 6 on Tuesday.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
	
		<hr size=1>Get your own <a href=" http://us.rd.yahoo.com/evt=43290/*http://smallbusiness.yahoo.com/domains"
>web address for just $1.99/1st yr</a>. We'll help. <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/"
>Yahoo! Small Business</a>.

--0-843856465-1161336944=:62621--


--===============0122074123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0122074123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0122074123==--
