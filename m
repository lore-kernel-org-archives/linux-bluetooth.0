Return-Path: <nhogg@whoi.edu>
Message-ID: <4090F914.6050103@whoi.edu>
Date: Thu, 29 Apr 2004 08:46:12 -0400
From: Nelson Hogg <nhogg@whoi.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] cups (non)printing
References: <408FDFFD.2090904@whoi.edu> <1083172830.4000.52.camel@pegasus>
In-Reply-To: <1083172830.4000.52.camel@pegasus>
Content-Type: text/html; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1083172830.4000.52.camel@pegasus" type="cite">
  <pre wrap="">Hi Nelson,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I have a canon i80 printer equipped with a bluetooth receiver which 
prints properly under cups and a usb connection. I've compiled the 
cups-bluetooth package and transfered the 2 files manually to their 
appropriate locations. I edited the printer.conf file to put in the 
device address that I had determined from looking at the winxp 
configuration (where bluetooth does work). However, I can't get any 
response from trying to set the printer up in cups using the second 
method described in the install instructions. I am not sure where to 
look for it in the device list. I have a "zoom pccard" bluetooth device 
that flashes and is listed as running in the services. It seems to 
attach itself to ttyS4. I am running Mandrake 10.0 with the 2.6.3 
kernel. Thanks for any help, Nelson Hogg
    </pre>
  </blockquote>
  <pre wrap=""><!---->
actually I think the problem is to get your card running. What is the
output of dump_cis? Do hciconfig shows a HCI device?

  </pre>
</blockquote>
Here is the listing from dump_cis:<br>
<br>
Socket 0:<br>
&nbsp; dev_info<br>
&nbsp;&nbsp;&nbsp; NULL 0ns, 512b<br>
&nbsp; manfid 0x0279, 0x950b<br>
&nbsp; funcid serial_port [post]<br>
&nbsp; serial_interface<br>
&nbsp;&nbsp;&nbsp; uart 16550 [space/mark/odd/even] [5/6/7/8] [1/1.5/2]<br>
&nbsp; vers_1 7.1, "PCMCIA", "Bluetooth Card", "", ""<br>
&nbsp; config base 0x00f8 mask 0x000f last_index 0x04<br>
&nbsp; cftable_entry 0x01 [default]<br>
&nbsp;&nbsp;&nbsp; [rdybsy]<br>
&nbsp;&nbsp;&nbsp; Vcc Vnom 3300mV<br>
&nbsp;&nbsp;&nbsp; io 0x03f8-0x0407 [lines=8] [8bit] [range]<br>
&nbsp;&nbsp;&nbsp; irq mask 0xffff [level] [shared]<br>
&nbsp; cftable_entry 0x02<br>
&nbsp;&nbsp;&nbsp; io 0x0000-0x7fff [lines=15] [8bit]<br>
<br>
Socket 1:<br>
&nbsp; no CIS present<br>
<br>
which I guess to indicate problems. hciconfig returns nothing. Is there
any hope?<br>
Thanks, Nelson Hogg<br>
</body>
</html>
