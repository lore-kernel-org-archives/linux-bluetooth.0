Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <408C72DA.4070205@mWare.ca>
From: Mykel <Mykel@mWare.ca>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] can't get bthid
References: <408C4D8D.7090104@yahoo.com.au>  <408C5F5C.1040501@mWare.ca> <1082941746.28880.111.camel@pegasus>
In-Reply-To: <1082941746.28880.111.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------090008020301070204060706"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 25 Apr 2004 22:24:26 -0400

This is a multi-part message in MIME format.
--------------090008020301070204060706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>Hi Myke,
>
>  
>
>>I have the exact same problem! I just joined this mailing list yesterday 
>>to ask this same question.
>>I have a BlueTooth equipped laptop and I have the Logitech cradle 
>>plugged in... I have no idea what I'm doing tho. I've seen 
>>http://www.bueche.ch/comp/mx900/mx900.html and followed what I can, but 
>>I still get the same errors.
>>
>>But like I said, I'm just doing this stuff blindly, I'm quite clueless 
>>at most of this. :(
>>    
>>
>
>you must start a daemon instance first. Run "bthid -d" before trying to
>use the "-c" switch.
>
>Regards
>
>Marcel
>
>  
>
Hey hey! I got somewhere! (Thanks! I'm so happy about this!) But after 
reboot, I'm not sure what I was doing wrong... It seems I need to hit 
connect every time I restart... Maybe I have the sequence of commands wrong?

bthid -d
hcid
bthid -c xx:xx:xx:...

?





--------------090008020301070204060706
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1082941746.28880.111.camel@pegasus" type="cite">
  <pre wrap="">Hi Myke,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I have the exact same problem! I just joined this mailing list yesterday 
to ask this same question.
I have a BlueTooth equipped laptop and I have the Logitech cradle 
plugged in... I have no idea what I'm doing tho. I've seen 
<a class="moz-txt-link-freetext" href="http://www.bueche.ch/comp/mx900/mx900.html">http://www.bueche.ch/comp/mx900/mx900.html</a> and followed what I can, but 
I still get the same errors.

But like I said, I'm just doing this stuff blindly, I'm quite clueless 
at most of this. :(
    </pre>
  </blockquote>
  <pre wrap=""><!---->
you must start a daemon instance first. Run "bthid -d" before trying to
use the "-c" switch.

Regards

Marcel

  </pre>
</blockquote>
Hey hey! I got somewhere! (Thanks! I'm so happy about this!) But after
reboot, I'm not sure what I was doing wrong... It seems I need to hit
connect every time I restart... Maybe I have the sequence of commands
wrong?<br>
<br>
bthid -d<br>
hcid<br>
bthid -c xx:xx:xx:...<br>
<br>
?<br>
<br>
<br>
<br>
<br>
</body>
</html>

--------------090008020301070204060706--


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
