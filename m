Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060824041210.69369.qmail@web50514.mail.yahoo.com>
Date: Wed, 23 Aug 2006 21:12:10 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <44EC4CFC.4060400@arcor.de>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Inquiry in Bluetooth 1.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1534040298=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1534040298==
Content-Type: multipart/alternative; boundary="0-95003943-1156392730=:68702"
Content-Transfer-Encoding: 8bit

--0-95003943-1156392730=:68702
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

As far as I know about bluetooth's inquiry (no idea about Interlaced scan though), it is suggested to take 10.24 sec to complete. I will try to explain a bit what I had read in Bluetooth spec. 1.2:

It uses 32 dedicated freq. (16 in one train and 16 in another) - one train is 10 ms long with 16 transmit slots (each 312.5 micro-sec long) and 16 corresponding receive slots which make the time period for one train 10 ms  long (16*312.5*2 = 10 ms). Now one train is suggested to repeat at least 256 times before switching to another train and the whole process repeats itself. There are 3 such switches. So the total time becomes = 256 * 10 * 4 = 10.24 sec. But there is no hard-bound limit on this time-period according to specification.

How did you measure the time taken for your inquiry taking 10 sec? Are you using "hcitool inq" command or anything else? I also plan to vary the inquiry time period to see the effects. Any idea how can I achieve this - I mean how to vary the default 10 sec period of inquiry time to make a bit shorter or larger? Or is it absolutely chip-dependent and can't be altered using the BlueZ stack? Any help on this would be appreciated!

Thanks in Advance
Mahtab

Simon Siemens <Simon.Siemens@arcor.de> wrote: The Bluetooth 1.2 specification has to major improvements to reduce the
inquiry time: Enhanced Inquiry Scan and Interlaced Inquiry Scan
(http://wireless.sys-con.com/read/43887.htm). The article states, that
enhanced inquiry scan reduces the maximum inquiry time from 10 to 5
seconds and improves the reliability. Interlaced inquiry scan should
halve the inquiry time further.

As far as I understood things both mechanisms act on the side of the
listener, not the discoverer. I can also find both names in the feature
section of the Bluetooth 1.2 specification (section 3.2 on page 203).
The interlaced inquiry scan is described in section 8.4.1 "Inquiry scan
substate" (on page 144) as a method, where the scanning device checks
not only one but two frequencies in both trains at once. This halves the
maximum inquiry time.

However I could not find anything further about enhanced inquiry scan.
And tests with two Bluetooth v2.0 +EDR devices did not reduce the
maximum inquiry time (without interlaced inquiry) below 10 seconds.

So what is this enhanced inquiry scan? How is it compared to the old
v1.1 inquiry scan? How can I activate it? (Currently one device is a
Nokia N70 and the other is a Linux computer with a MSI 3X BToes dongle.)

Thanks a lot,

Simon



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
Do you Yahoo!?
 Everyone is raving about the  all-new Yahoo! Mail.
--0-95003943-1156392730=:68702
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>As far as I know about bluetooth's inquiry (no idea about Interlaced scan though), it is suggested to take 10.24 sec to complete. I will try to explain a bit what I had read in Bluetooth spec. 1.2:<br><br>It uses 32 dedicated freq. (16 in one train and 16 in another) - one train is 10 ms long with 16 transmit slots (each 312.5 micro-sec long) and 16 corresponding receive slots which make the time period for one train 10 ms&nbsp; long (16*312.5*2 = 10 ms). Now one train is suggested to repeat at least 256 times before switching to another train and the whole process repeats itself. There are 3 such switches. So the total time becomes = 256 * 10 * 4 = 10.24 sec. But there is no hard-bound limit on this time-period according to specification.<br><br>How did you measure the time taken for your inquiry taking 10 sec? Are you using "hcitool inq" command or anything else? I also plan to vary the inquiry time period to see the effects. Any idea how can I achieve this - I
 mean how to vary the default 10 sec period of inquiry time to make a bit shorter or larger? Or is it absolutely chip-dependent and can't be altered using the BlueZ stack? Any help on this would be appreciated!<br><br>Thanks in Advance<br>Mahtab<br><br><b><i>Simon Siemens &lt;Simon.Siemens@arcor.de&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> The Bluetooth 1.2 specification has to major improvements to reduce the<br>inquiry time: Enhanced Inquiry Scan and Interlaced Inquiry Scan<br>(http://wireless.sys-con.com/read/43887.htm). The article states, that<br>enhanced inquiry scan reduces the maximum inquiry time from 10 to 5<br>seconds and improves the reliability. Interlaced inquiry scan should<br>halve the inquiry time further.<br><br>As far as I understood things both mechanisms act on the side of the<br>listener, not the discoverer. I can also find both names in the feature<br>section of
 the Bluetooth 1.2 specification (section 3.2 on page 203).<br>The interlaced inquiry scan is described in section 8.4.1 "Inquiry scan<br>substate" (on page 144) as a method, where the scanning device checks<br>not only one but two frequencies in both trains at once. This halves the<br>maximum inquiry time.<br><br>However I could not find anything further about enhanced inquiry scan.<br>And tests with two Bluetooth v2.0 +EDR devices did not reduce the<br>maximum inquiry time (without interlaced inquiry) below 10 seconds.<br><br>So what is this enhanced inquiry scan? How is it compared to the old<br>v1.1 inquiry scan? How can I activate it? (Currently one device is a<br>Nokia N70 and the other is a Linux computer with a MSI 3X BToes dongle.)<br><br>Thanks a lot,<br><br>Simon<br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with
 pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
		<hr size=1>Do you Yahoo!?<br> Everyone is raving about the <a href="http://us.rd.yahoo.com/evt=42297/*http://advision.webevents.yahoo.com/mailbeta"> all-new Yahoo! Mail.</a>
--0-95003943-1156392730=:68702--


--===============1534040298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1534040298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1534040298==--
