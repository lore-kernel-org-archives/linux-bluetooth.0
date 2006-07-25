Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060725101412.70209.qmail@web50515.mail.yahoo.com>
Date: Tue, 25 Jul 2006 03:14:12 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20060725101155.68760.qmail@web50509.mail.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============0903037303=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0903037303==
Content-Type: multipart/alternative; boundary="0-771668297-1153822452=:68163"
Content-Transfer-Encoding: 8bit

--0-771668297-1153822452=:68163
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Just one correction to one line I wrote:

"Again the bluetooth specification mentions that the output power at the transmitting side shouldn't exceed +4 dBm if the receiving side doesn't support power-control!"

Mahtab Hossain <mahtab_hossain2002@yahoo.com> wrote: Sorry to bring the topic back to live again! I was looking for the bluetooth-chips' configuration parameters - especially "signal-strength" related ones.
By contacting CSR chip guys and going through their chip-datasheet, I have found this information regarding BlueCore4-ROM's golden receiver power range for one modulation scheme:

TT/4 DQPSK : -6 ~ -86 dBm
As u can see, for the mentioned modulation scheme, the "Golden receiver power range" spans about 80 dB. But from the bluetooth specification, I had the impression that GRPR should be around 20+/-6 dB (though it was stated as minimum). But can the manufacturer have this range this BIG? Any comments?

Again the bluetooth specification mentions that the output power at the transmitting side shouldn't exceed +4 dBm. From this, I have the impression that, the typical power-setting for the transmitter shouldn't also go beyond this value. Is it a right assumption? But the BlueCore4-ROM chip has  typical power setting to about +5 dBm. Any comments?

I am just expecting comments on these issues. Anything would give me more things to work on.

Regards
Mahtab

Marcel Holtmann <marcel@holtmann.org> wrote: Hi Mahtab,

> Thanks for your help. I know it may be irrelevant to ask this......but
> I have no other way! This group seems to be the only one where I can
> get a bit help.

you know that you are trying to exploit the open source community ;)

> 1. I want to know the golden receiver power range (GRPR) of the
> bluetooth dongles I am using (specifically the upper & lower
> threshold). From your reply, I guess it should be implemented in the
> chips (BlueCore4-Ext or BlueCore4-ROM) and so will be a chip paramter.
> Should reading the data-sheets of those  chips help me in finding their
> Golden Receiver Power Range (i.e. the upper & lower threshold level)?
> Or any other way to find it?

Check the CSR documentation.

> 2. Is Link Quality (LQ) also a chip-parameter? Is the link quality
> algorithm same for all CSR chips (the one posted in your website)? How
> could you find that algorithm?

It is described on my webpage and you will also find it in the CSR
documentation.

> 3. Does the power-control (stepping up or down of power) vary from
> chip to chip?

For the CSR chips, I is fully configurable as far as I know. For other
vendors, I have no idea.

> 4. What's the main purpose of the driver (Toshiba or Level1 etc.)?

How should I know? Toshiba and Level1 are dongle manufactures and I
don't care about any Windows based driver at  all.

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
See the all-new, redesigned Yahoo.com.  Check it out. -------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates starting at 1¢/min.
--0-771668297-1153822452=:68163
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Just one correction to one line I wrote:<br><br>"Again the bluetooth specification mentions that the output power at the transmitting side shouldn't exceed +4 dBm <span style="font-weight: bold;">if the receiving side doesn't support power-control</span>!"<br><br><b><i>Mahtab Hossain &lt;mahtab_hossain2002@yahoo.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Sorry to bring the topic back to live again! I was looking for the bluetooth-chips' configuration parameters - especially "signal-strength" related ones.<br>By contacting CSR chip guys and going through their chip-datasheet, I have found this information regarding BlueCore4-ROM's golden receiver power range for one modulation scheme:<br><pre wrap="">TT/4 DQPSK : -6 ~ -86 dBm</pre>As u can see, for the mentioned modulation scheme, the "Golden receiver power range" spans about 80 dB. But from the bluetooth specification, I had the
 impression that GRPR should be around 20+/-6 dB (though it was stated as minimum). But can the manufacturer have this range this BIG? Any comments?<br><br>Again the bluetooth specification mentions that the output power at the transmitting side shouldn't exceed +4 dBm. From this, I have the impression that, the typical power-setting for the transmitter shouldn't also go beyond this value. Is it a right assumption? But the BlueCore4-ROM chip has  typical power setting to about +5 dBm. Any comments?<br><br>I am just expecting comments on these issues. Anything would give me more things to work on.<br><br>Regards<br>Mahtab<br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Mahtab,<br><br>&gt; Thanks for your help. I know it may be irrelevant to ask this......but<br>&gt; I have no other way! This group seems to be the only one where I
 can<br>&gt; get a bit help.<br><br>you know that you are trying to exploit the open source community ;)<br><br>&gt; 1. I want to know the golden receiver power range (GRPR) of the<br>&gt; bluetooth dongles I am using (specifically the upper &amp; lower<br>&gt; threshold). From your reply, I guess it should be implemented in the<br>&gt; chips (BlueCore4-Ext or BlueCore4-ROM) and so will be a chip paramter.<br>&gt; Should reading the data-sheets of those  chips help me in finding their<br>&gt; Golden Receiver Power Range (i.e. the upper &amp; lower threshold level)?<br>&gt; Or any other way to find it?<br><br>Check the CSR documentation.<br><br>&gt; 2. Is Link Quality (LQ) also a chip-parameter? Is the link quality<br>&gt; algorithm same for all CSR chips (the one posted in your website)? How<br>&gt; could you find that algorithm?<br><br>It is described on my webpage and you will also find it in the CSR<br>documentation.<br><br>&gt; 3. Does the power-control (stepping up or
 down of power) vary from<br>&gt; chip to chip?<br><br>For the CSR chips, I is fully configurable as far as I know. For other<br>vendors, I have no idea.<br><br>&gt; 4. What's the main purpose of the driver (Toshiba or Level1 etc.)?<br><br>How should I know? Toshiba and Level1 are dongle manufactures and I<br>don't care about any Windows based driver at  all.<br><br>Regards<br><br>Marcel<br><br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<br>_______________________________________________<br>Bluez-users mailing
 list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><div>      </div><hr size="1">See the all-new, redesigned Yahoo.com. <a href="http://us.rd.yahoo.com/evt=40762/*http://www.yahoo.com/preview"> Check it out.</a> -------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys -- and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;
		<hr size=1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.rd.yahoo.com/evt=39666/*http://messenger.yahoo.com"> Great rates starting at 1¢/min.
--0-771668297-1153822452=:68163--


--===============0903037303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0903037303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0903037303==--
