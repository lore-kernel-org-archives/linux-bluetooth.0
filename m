Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <441D3D91.3060000@silicom.fr>
From: Fabien Chevalier - <fchevalier@silicom.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Kernel panic with SCO socket - Debian kernel 2.6.15-8
References: <441C3CAB.5030806@silicom.fr> <20060318201220.46312b44.henryk@ploetzli.ch>
In-Reply-To: <20060318201220.46312b44.henryk@ploetzli.ch>
Content-Type: multipart/alternative;
 boundary="------------090403080404050103060407"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 19 Mar 2006 12:16:33 +0100

This is a multi-part message in MIME format.
--------------090403080404050103060407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>Hehe, I recently did something similar (in Python, though) ...
>
>  
>
Good to now i'm not alone playing with SCOs !!

>>The thing basically works... exect after 1or 2 minutes playback, the 
>>program suddenly exits.
>>Then i just have a few seconds left and *bang* . Kernel Panic :-(
>>    
>>
>
>... and had similar results. Just look at the memory consumption when
>this happens. Apparently all incoming SCO data is buffered in kernel
>memory for you to read, so you *must* read it, even if you only ever
>intend to send data.
>
>I'd also suggest you simply use select() to wait for incoming data and
>then only send something when you received (and read!) something. This
>nicely gives the right timing without guessing the delay parameter.
>
>  
>
Quite interesting is the way you solved the issue :-)
I'm gonna give a try to this select way of things :-)
By the way i just ran another test using hsplay. I basically send a SCO 
packet every second,
which is obviously not enough to sustain the SCO packet flow.
Using hcidump i am able to see the SCO flow coming from the Headset.
... and no crash at all :-)

Which for me basically means that the bug is somewhere on the 
PC-->Heaset flow, where something must be handled the wrong way...

Cheers,

Fabien

--------------090403080404050103060407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid20060318201220.46312b44.henryk@ploetzli.ch"
 type="cite">
  <pre wrap="">Hehe, I recently did something similar (in Python, though) ...

  </pre>
</blockquote>
Good to now i'm not alone playing with SCOs !!<br>
<blockquote cite="mid20060318201220.46312b44.henryk@ploetzli.ch"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap="">The thing basically works... exect after 1or 2 minutes playback, the 
program suddenly exits.
Then i just have a few seconds left and *bang* . Kernel Panic :-(
    </pre>
  </blockquote>
  <pre wrap=""><!---->
... and had similar results. Just look at the memory consumption when
this happens. Apparently all incoming SCO data is buffered in kernel
memory for you to read, so you *must* read it, even if you only ever
intend to send data.

I'd also suggest you simply use select() to wait for incoming data and
then only send something when you received (and read!) something. This
nicely gives the right timing without guessing the delay parameter.

  </pre>
</blockquote>
Quite interesting is the way you solved the issue :-)<br>
I'm gonna give a try to this select way of things :-)<br>
By the way i just ran another test using hsplay. I basically send a SCO
packet every second,<br>
which is obviously not enough to sustain the SCO packet flow.<br>
Using hcidump i am able to see the SCO flow coming from the Headset.<br>
... and no crash at all :-)<br>
<br>
Which for me basically means that the bug is somewhere on the
PC--&gt;Heaset flow, where something must be handled the wrong way...<br>
<br>
Cheers,<br>
<br>
Fabien<br>
</body>
</html>

--------------090403080404050103060407--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
