Return-Path: <tbaillys@free.fr>
Message-ID: <40D05E6A.402@free.fr>
Date: Wed, 16 Jun 2004 16:51:22 +0200
From: Tom Bailly-Salins <tbaillys@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sony DSC-FX77 and BIP
References: <40D043DF.4070306@free.fr> <1087391351.4309.16.camel@pegasus>
In-Reply-To: <1087391351.4309.16.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Thank you for the info, but about the DSC-FX77 support for BIP it seems
that Sony has everything running very well between their own hardware.<br>
<br>
The DSC-FX77 and the Clie TG-50 PDA - with the "Remote Camera" Clie
application<br>
<a class="moz-txt-link-freetext" href="http://www.clieandco.com/00clieandco/04dossiers/Bluetooth/bluetooth_4_apn.html">http://www.clieandco.com/00clieandco/04dossiers/Bluetooth/bluetooth_4_apn.html</a><br>
<br>
The DSC-FX77 and the VAIO laptops - with the "Network Smart Capture"
VAIO application<br>
<a class="moz-txt-link-freetext" href="http://www.sonydigital-link.com/tutorials/DIME/cybershotBT/en/remote.html">http://www.sonydigital-link.com/tutorials/DIME/cybershotBT/en/remote.html</a><br>
<br>
Is that only a partial implementation of BIP ? If not, my 2 questions
remain:<br>
&nbsp;- Is there an application like "Remote Camera" or "Network Smart
Capture" that runs under linux.<br>
&nbsp;- And if not, can I use a library like BlueZ to make one ?<br>
<br>
TOM<br>
<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1087391351.4309.16.camel@pegasus" type="cite">
  <pre wrap="">Hi Tom,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I would like to ask two questions:

 - Does the BlueZ bluetooth library implement BIP (Basic Imaging Profile) ?

 - Does anyone know of a frontend software on Linux that would allow me 
to operate a Sony DSC-FX77 bluetooth camera using BIP.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
try the OBEX Push Daemon (<a class="moz-txt-link-freetext" href="http://oss.bdit.de/opd.html">http://oss.bdit.de/opd.html</a>). The FX77 has no
full BIP support. You can push or receive images and use the remote
camera feature, but you can't retrieve any thumbnail or image from it
using the PC and tools like gPhoto etc.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! <a class="moz-txt-link-freetext" href="http://java.sun.com/javaone/sf">http://java.sun.com/javaone/sf</a> Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>


  </pre>
</blockquote>
<br>
</body>
</html>
