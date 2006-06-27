Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060627085731.12075.qmail@web50501.mail.yahoo.com>
Date: Tue, 27 Jun 2006 01:57:31 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <BAY114-F36DD43CFD742B96E05E081CF790@phx.gbl>
MIME-Version: 1.0
Subject: Re: [Bluez-users] howto use hci_read_rssi
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1053371087=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1053371087==
Content-Type: multipart/alternative; boundary="0-808545264-1151398651=:11104"
Content-Transfer-Encoding: 8bit

--0-808545264-1151398651=:11104
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Colina,

>Moreover, I don't know if its necessary or not to make a previous connection
>with another function.
Yes, you need to make a previous connection before you can read the status parameter (e.g. RSSI or link quality) of a connection. You may do it at the HCI level (though not recommended by Marcel, e.g. hcitool cc <BD_ADDR>) or by upper level transport protocol (recommended, e.g. rfcomm).

>handle and to
"handle" is the connection handle of the connection u have made and "to" is the timeout field. You may need to look into the source-code of "hcitool" which comes with bluez-utils - then everything will be clear.

Regards
Mahtab

Luis Colina <todten@hotmail.com> wrote: 



Hi everyone!

I want to program an example using the hci_read_rssi function but I don't
know how to do it because I don't understand its parameters, specially the
uint16_t handle and the int to. I don't know how ti initialize them.

Moreover, I don't know if its necessary or not to make a previous connection
with another function.

Can anybody help me?

Thanks a lot.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ countries) for 2¢/min or less.
--0-808545264-1151398651=:11104
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Colina,<br><br>&gt;Moreover, I don't know if its necessary or not to make a previous connection<br>&gt;with another function.<br>Yes, you need to make a previous connection before you can read the status parameter (e.g. RSSI or link quality) of a connection. You may do it at the HCI level (though not recommended by Marcel, e.g. hcitool cc &lt;BD_ADDR&gt;) or by upper level transport protocol (recommended, e.g. rfcomm).<br><br>&gt;handle and to<br>"handle" is the connection handle of the connection u have made and "to" is the timeout field. You may need to look into the source-code of "hcitool" which comes with bluez-utils - then everything will be clear.<br><br>Regards<br>Mahtab<br><br><b><i>Luis Colina &lt;todten@hotmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> <br><br><br><br>Hi everyone!<br><br>I want to program an example using the hci_read_rssi function but I don't<br>know
 how to do it because I don't understand its parameters, specially the<br>uint16_t handle and the int to. I don't know how ti initialize them.<br><br>Moreover, I don't know if its necessary or not to make a previous connection<br>with another function.<br><br>Can anybody help me?<br><br>Thanks a lot.<br><br><br><br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
		<hr size=1>Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman1/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Make PC-to-Phone Calls</a> to the US (and 30+ countries) for 2¢/min or less.
--0-808545264-1151398651=:11104--


--===============1053371087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1053371087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1053371087==--
