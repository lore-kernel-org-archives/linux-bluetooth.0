Return-Path: <ramin@popak.myftp.org>
Message-ID: <40DAFE80.2010207@popak.myftp.org>
Date: Thu, 24 Jun 2004 09:17:04 -0700
From: Ramin Rezaiifar <ramin@popak.myftp.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Low bit rate
References: <40DA45E0.9000207@popak.myftp.org> <1088068716.4296.35.camel@pegasus>
In-Reply-To: <1088068716.4296.35.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Marcel Holtmann wrote:<br>
<blockquote cite="mid1088068716.4296.35.camel@pegasus" type="cite">
  <pre wrap="">Hi Ramin,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I use the bluetooth link between a Palm T3 and a Linux machine.
The data rate seems to be noticeably lower than the rate when I use the 
Palm device with a Windows XP machine.  In both cases I use a Linksys 
USB dongle.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
actually I don't use Windows, so I can't tell. In general the BlueZ is
as fast as possible. Maybe it is a RFCOMM flow control problem.</pre>
</blockquote>
Can the flow control in RFCOMM be disabled? If yes, how can that be
done?<br>
<br>
thanks,<br>
<br>
-Ramin<br>
<blockquote cite="mid1088068716.4296.35.camel@pegasus" type="cite">
  <pre wrap=""> Make
sure that you use the latest Linux kernel.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Can I increase the rate with the hcitool by changing the pcacket type 
for the connection?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No. Changing the packet types makes it only worse. Let the link manager
be able to use every packet type and let it choose the best for your
current connection.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings &amp; Training.
Attend Black Hat Briefings &amp; Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit <a class="moz-txt-link-abbreviated" href="http://www.blackhat.com">www.blackhat.com</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
  </pre>
</blockquote>
</body>
</html>
