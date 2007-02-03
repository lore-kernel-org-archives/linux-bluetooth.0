Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45C444DC.4060806@gmail.com>
Date: Sat, 03 Feb 2007 03:16:28 -0500
From: "JP Freeley (GMAIL-NYC)" <jpf321@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45C43542.3060907@gmail.com> <45C43C59.2000104@xmission.com>
In-Reply-To: <45C43C59.2000104@xmission.com>
Subject: Re: [Bluez-devel] a2dp and multiple headsets
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0769397523=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0769397523==
Content-Type: multipart/alternative;
	boundary="------------060600050009060100070901"

This is a multi-part message in MIME format.
--------------060600050009060100070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brad --

That were my research was pointing me, but I was told that something had 
been done in Amsterdam....but the details I have are about that vague. I 
figured this list would have the definitive answers.

Am I correct that in some profiles (i.e. OPP, FTP, SPP) 1 BT device can 
make upto 7 simultaneous connections?

thanks,

jpf

Brad Midgley wrote:
> JP
>
> the a2dp spec has no provisions for broadcast and there are piconet size
> limits to deal with anyway. You'd have to set up multiple bluetooth
> adapters to really stack in the headsets but you'd never reach 35. You
> may want to try a more traditional RF broadcast.
>
> Brad
>
>   
>> Pardon me if a FAQ or OT...
>>
>> Is there a limit as to how many simultaneous headsets can be streaming 
>> audio?
>> Does anyone have suggestions about configurations, hardware, software to 
>> stream to multiple headsets?
>> I'm looking to "broadcast" stream to about 35 headsets simultaneously.
>>
>> Thanks,
>>
>> jpf
>>
>> -------------------------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job easier.
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>     
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   

--------------060600050009060100070901
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Brad --<br>
<br>
That were my research was pointing me, but I was told that something
had been done in Amsterdam....but the details I have are about that
vague. I figured this list would have the definitive answers. <br>
<br>
Am I correct that in some profiles (i.e. OPP, FTP, SPP) 1 BT device can
make upto 7 simultaneous connections? <br>
<br>
thanks, <br>
<br>
jpf<br>
<br>
Brad Midgley wrote:
<blockquote cite="mid45C43C59.2000104@xmission.com" type="cite">
  <pre wrap="">JP

the a2dp spec has no provisions for broadcast and there are piconet size
limits to deal with anyway. You'd have to set up multiple bluetooth
adapters to really stack in the headsets but you'd never reach 35. You
may want to try a more traditional RF broadcast.

Brad

  </pre>
  <blockquote type="cite">
    <pre wrap="">Pardon me if a FAQ or OT...

Is there a limit as to how many simultaneous headsets can be streaming 
audio?
Does anyone have suggestions about configurations, hardware, software to 
stream to multiple headsets?
I'm looking to "broadcast" stream to about 35 headsets simultaneously.

Thanks,

jpf

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<a class="moz-txt-link-freetext" href="http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a>
_______________________________________________
Bluez-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<a class="moz-txt-link-freetext" href="http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a>
_______________________________________________
Bluez-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>

  </pre>
</blockquote>
</body>
</html>

--------------060600050009060100070901--


--===============0769397523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0769397523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0769397523==--
