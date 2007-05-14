Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46484364.5070409@telnet-ri.es>
Date: Mon, 14 May 2007 13:09:24 +0200
From: David Beamonte <dbeamonte@telnet-ri.es>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <4642CD6D.4020904@telnet-ri.es>	<1178789693.25565.73.camel@aeonflux.holtmann.net>	<4642E9F3.9000501@telnet-ri.es>
	<46447D58.2090300@telnet-ri.es>
	<1178893772.2820.20.camel@aeonflux.holtmann.net>
In-Reply-To: <1178893772.2820.20.camel@aeonflux.holtmann.net>
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
Content-Type: multipart/mixed; boundary="===============0147368141=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0147368141==
Content-Type: multipart/alternative;
	boundary="------------020003030107060505030803"

This is a multi-part message in MIME format.
--------------020003030107060505030803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Marcel,

We will probably substitute the chip for another one that supports HCI. 
I think it will be the easiest and fastest way.

Regards,

David


Marcel Holtmann wrote:

>Hi David,
>
>  
>
>>We have realized that LMX9830 doesn't have HCI controller. The
>>communicating with the chip is via an specific set of commands, and
>>so, the HCI drivers and hciattach are not suitable for us.
>>
>>We guess that we must develop our own driver that substitutes HCI
>>driver, but we are not sure where we should start working. I would
>>like to know if there's any effort done in this way in the BlueZ
>>development.
>>    
>>
>
>National never sent me any development hardware and so no.
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

--------------020003030107060505030803
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
We will probably substitute the chip for another one that supports HCI.
I think it will be the easiest and fastest way.<br>
<br>
Regards,<br>
<br>
David<br>
<br>
<br>
Marcel Holtmann wrote:<br>
<blockquote type="cite"
 cite="mid1178893772.2820.20.camel@aeonflux.holtmann.net">
  <pre wrap="">Hi David,

  </pre>
  <blockquote type="cite">
    <pre wrap="">We have realized that LMX9830 doesn't have HCI controller. The
communicating with the chip is via an specific set of commands, and
so, the HCI drivers and hciattach are not suitable for us.

We guess that we must develop our own driver that substitutes HCI
driver, but we are not sure where we should start working. I would
like to know if there's any effort done in this way in the BlueZ
development.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
National never sent me any development hardware and so no.

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

--------------020003030107060505030803--



--===============0147368141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0147368141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0147368141==--
