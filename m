Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4642E9F3.9000501@telnet-ri.es>
Date: Thu, 10 May 2007 11:46:27 +0200
From: David Beamonte <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4642CD6D.4020904@telnet-ri.es>
	<1178789693.25565.73.camel@aeonflux.holtmann.net>
In-Reply-To: <1178789693.25565.73.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] LMX9830 driver
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0801760783=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0801760783==
Content-Type: multipart/alternative;
	boundary="------------000900060900070204080705"

This is a multi-part message in MIME format.
--------------000900060900070204080705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Marcel,

What I know about the device is that its command interface (UART) uses a 
frame protocol, with start and end delimiters of frames, frame ids and 
so on. I understand from your words that this is the standard way to 
communicate and that all devices have the same set of commands.

Anyway, I will check what you mention about hciattach. Is there any kind 
of documentation on how to do this, or I must dig into the code?

Thanks again,

David


Marcel Holtmann wrote:

>Hi David,
>
>  
>
>>We have included a National LMX9830 module in a new design. The 
>>communication between the chip and the microprocessor is via UART and we 
>>have also connected the audio channels of the chip to the processor, so 
>>that we can use the SCO link.
>>
>>It's the first time we use bluetooth modules in our designs, and so, we 
>>are open to any kind of suggestion on how to work on this.
>>
>>At first sight, it seems that we should use the UART(H4) driver, but we 
>>are not really sure if the commands to communicate to the chip are 
>>standard or not. I think that we will probably need to develop some kind 
>>of a driver.
>>    
>>
>
>unless you use some vendor specific deep-sleep things, the H4 driver
>should be fine. However you might need to adapt hciattach for the module
>initialization.
>
>Regards
>
>Marcel
>
>
>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by DB2 Express
>Download DB2 Express C - the FREE version of DB2 express and take
>control of your XML. No limits. Just data. Click to get it now.
>http://sourceforge.net/powerbar/db2/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>  
>

--------------000900060900070204080705
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Thanks Marcel,<br>
<br>
What I know about the device is that its command interface (UART) uses
a frame protocol, with start and end delimiters of frames, frame ids
and so on. I understand from your words that this is the standard way
to communicate and that all devices have the same set of commands.<br>
<br>
Anyway, I will check what you mention about hciattach. Is there any
kind of documentation on how to do this, or I must dig into the code?<br>
<br>
Thanks again,<br>
<br>
David<br>
<br>
<br>
Marcel Holtmann wrote:<br>
<blockquote type="cite"
 cite="mid1178789693.25565.73.camel@aeonflux.holtmann.net">
  <pre wrap="">Hi David,

  </pre>
  <blockquote type="cite">
    <pre wrap="">We have included a National LMX9830 module in a new design. The 
communication between the chip and the microprocessor is via UART and we 
have also connected the audio channels of the chip to the processor, so 
that we can use the SCO link.

It's the first time we use bluetooth modules in our designs, and so, we 
are open to any kind of suggestion on how to work on this.

At first sight, it seems that we should use the UART(H4) driver, but we 
are not really sure if the commands to communicate to the chip are 
standard or not. I think that we will probably need to develop some kind 
of a driver.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
unless you use some vendor specific deep-sleep things, the H4 driver
should be fine. However you might need to adapt hciattach for the module
initialization.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
<a class="moz-txt-link-freetext" href="http://sourceforge.net/powerbar/db2/">http://sourceforge.net/powerbar/db2/</a>
_______________________________________________
Bluez-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>

  </pre>
</blockquote>
</body>
</html>

--------------000900060900070204080705--



--===============0801760783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0801760783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0801760783==--
