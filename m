Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A21EE3.5060408@phaldor.co.uk>
From: Dave Givens <dave.givens@phaldor.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth Printing (Belkin Print Server)
References: <41A2089D.5030100@phaldor.co.uk> <1101139759.15086.14.camel@pegasus>
In-Reply-To: <1101139759.15086.14.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------010704040407010204000200"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 22 Nov 2004 17:16:19 +0000

This is a multi-part message in MIME format.
--------------010704040407010204000200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcel,
    I have tried that via the web page and the KDE Print manager. It 
still does not work. The blue light on the print server flashes wildly 
for ever, but nothing prints. The same result is obtained by clicking on 
the icon under bluetooth devices. Lots of lights but no print. I have 
tried other printers, but get the same results.
    I have been trying to set-up the printer for several weeks now and I 
have read all the bluez postings, I have tried everything that has been 
suggested on your site and all others I can find.
    The output from hcidump went on forever but seems to repeat what I 
have included. I had to kill the job to stop the file before it filled 
the hard disk. Is there anything else that might give me a clue as to 
what is wrong? I have tried to include the data that I thought you might 
need.

Dave Givens

Marcel Holtmann wrote:

>Hi Dave,
>
>  
>
>>    I have taken Marcels advice and moved to SUSE 9.2 after trying
>>Debian on the way. I could not get Debian to work with SATA and so it
>>was a non starter for this system. SUSE works a treat with SATA,
>>wireless LAN card and everything but my bluetooth print server. I
>>cannot find any services for this device, my phone shows up fine as
>>does a windows bluetooth enabled machine. I have included results from
>>some commands, please let me know if  there are any others I should
>>run. Any help would be greatly appreciated as I have very little hair
>>left.
>>    
>>
>
>what do you actually wanna do? If you wanna print to your Bluetooth
>printer then setup a new CUPS printer with "bluetooth://0002724080A3/"
>as URI and simply use it.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>  
>

--------------010704040407010204000200
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
Marcel,<br>
&nbsp;&nbsp;&nbsp; I have tried that via the web page and the KDE Print manager. It
still does not work. The blue light on the print server flashes wildly
for ever, but nothing prints. The same result is obtained by clicking
on the icon under bluetooth devices. Lots of lights but no print. I
have tried other printers, but get the same results.<br>
&nbsp;&nbsp;&nbsp; I have been trying to set-up the printer for several weeks now and
I have read all the bluez postings, I have tried everything that has
been suggested on your site and all others I can find. <br>
&nbsp;&nbsp;&nbsp; The output from hcidump went on forever but seems to repeat what I
have included. I had to kill the job to stop the file before it filled
the hard disk. Is there anything else that might give me a clue as to
what is wrong? I have tried to include the data that I thought you
might need.<br>
<br>
Dave Givens<br>
<br>
Marcel Holtmann wrote:<br>
<blockquote type="cite" cite="mid1101139759.15086.14.camel@pegasus">
  <pre wrap="">Hi Dave,

  </pre>
  <blockquote type="cite">
    <pre wrap="">    I have taken Marcels advice and moved to SUSE 9.2 after trying
Debian on the way. I could not get Debian to work with SATA and so it
was a non starter for this system. SUSE works a treat with SATA,
wireless LAN card and everything but my bluetooth print server. I
cannot find any services for this device, my phone shows up fine as
does a windows bluetooth enabled machine. I have included results from
some commands, please let me know if  there are any others I should
run. Any help would be greatly appreciated as I have very little hair
left.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
what do you actually wanna do? If you wanna print to your Bluetooth
printer then setup a new CUPS printer with "bluetooth://0002724080A3/"
as URI and simply use it.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest &amp; candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
<a class="moz-txt-link-freetext" href="http://productguide.itmanagersjournal.com/">http://productguide.itmanagersjournal.com/</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>


  </pre>
</blockquote>
</body>
</html>

--------------010704040407010204000200--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
