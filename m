Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <6297d67c0606192109obc34f76oc00d36729e555b84@mail.gmail.com>
Date: Tue, 20 Jun 2006 09:39:17 +0530
From: "Mayank Batra" <mayankbatra@gmail.com>
To: "=?ISO-8859-1?Q?G=F6tz_Issel?=" <g.issel@fh-wolfenbuettel.de>,
        "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <16b5b416d372.16d37216b5b4@fh-wolfenbuettel.de>
MIME-Version: 1.0
References: <16b5b416d372.16d37216b5b4@fh-wolfenbuettel.de>
Subject: Re: [Bluez-devel] blueZ and SAP
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1535855588=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1535855588==
Content-Type: multipart/alternative;
	boundary="----=_Part_10595_26368256.1150776557280"

------=_Part_10595_26368256.1150776557280
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Goetz,

First of all, please do not reply on individual ids.



>
>
> first of all I am happy to hear that there is somebody out there working
> on this too. I thought I was on my own since I never got any helpful
> response on the list so far.
>
> I have been checking the returned values in 2 ways.
>
> First I tried to use "read()" on the socket on which I did the "write()"
> before. I got no response at all. By the way, I am using  Nokia 6810 and
> a Siemens S65 for testing.


Hang on, if you do a read() before write(), won't the read block your
thread? and your control will never reach the write()?
Or are you using different threads for the read and write?

I have a report/thesis to hand in in 2 weeks and am soo stuck on this
> problem. I need to implement the whole sap profile. Panic!
>
> If you have any decend code I can use... please help. If you want I can
> send you the code I have so far.


No, I did not have any code actually, I just made the RFCOMM connection, and
I was sending the connect_req etc on this rfcomm device (/dev/rfcomm0). So I
wrote the connect_req in hex form in a file and then simply did cat file >
/dev/rfcomm0

Regards,
Mayank

------=_Part_10595_26368256.1150776557280
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Goetz,</div>
<div>&nbsp;</div>
<div>First of all, please do not reply on individual ids.<br><br>&nbsp;</div>
<div>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br><br>first of all I am happy to hear that there is somebody out there working<br>on this too. I thought I was on my own since I never got any helpful
<br>response on the list so far.<br><br>I have been checking the returned values in 2 ways.<br><br>First I tried to use &quot;read()&quot; on the socket on which I did the &quot;write()&quot;<br>before. I got no response at all. By the way, I am using&nbsp;&nbsp;Nokia 6810 and
<br>a Siemens S65 for testing.</blockquote>
<div>&nbsp;</div>
<div>Hang on, if you do a read() before write(), won't the read block your thread? and your control will never reach the write()?</div>
<div>Or are you using different threads for the read and write?</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I have a report/thesis to hand in in 2 weeks and am soo stuck on this<br>problem. I need to implement the whole sap profile. Panic!
<br><br>If you have any decend code I can use... please help. If you want I can<br>send you the code I have so far.</blockquote>
<div>&nbsp;</div>
<div>No, I did not have any code actually, I just made the RFCOMM connection, and I was sending the connect_req etc on this rfcomm device (/dev/rfcomm0). So I wrote the connect_req in hex form in a file and then simply did cat file &gt; /dev/rfcomm0
</div>
<div>&nbsp;</div></div>
<div>Regards,</div>
<div>Mayank</div>

------=_Part_10595_26368256.1150776557280--


--===============1535855588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1535855588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1535855588==--
