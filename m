Return-Path: <cjo@csr.com>
Message-ID: <411DEBAE.7040700@csr.com>
Date: Sat, 14 Aug 2004 11:38:38 +0100
From: Carl Orsborn <cjo@csr.com>
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>,
   Steven Singer <steven.singer@csr.com>
Subject: Re: [Bluez-devel] CSR firmware question...
References: <20040813002514.GA21388@bougret.hpl.hp.com>     <411C9CC0.90507@csr.com> <20040813180748.GB23661@bougret.hpl.hp.com>
In-Reply-To: <20040813180748.GB23661@bougret.hpl.hp.com>
Content-Type: multipart/alternative;
 boundary="------------040105000207020402000501"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040105000207020402000501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jean Tourrilhes wrote:

>>Can you reveal what you're doing with the CSR device when
>>you suffer deadlock?  We may recognise the symptoms, and possibly
>>know of a workaround or of fixed firmware.
>>    
>>
>	Trivial deadlock :
>	initiating a connection to a device within 80ms of receiving
>incomming connection from same device. Unknown if bug is in fw or
>stack, but firmware deadlock.
>
Is the incoming connection a connection request from the remote device, or a
connection complete?

If the latter, is it from an auto-accept filter, or from your host 
accepting the connection?

This feels as though it might be from an LMP collision - one of the 
nastier elements
of the baseband specification.  When collisions occur (two devices 
initiate LMP
transactions at the "same" time) the firmware sometimes defends itself 
with lengthy
timeouts, but I'm unaware of any resulting deadlocks in current firmware.

>	Intermitent failure :
>	Initiating connection (page) within 20ms of bringing HCI
>device up. Sometime it works, sometime it doesn't.
>  
>
I assume "bringing HCI device up" means your local BT device.  The CSR
device should be ready for a single HCI command as soon as the host 
transport
is established, though to signal readiness, the device sends a NOP 
command_complete
to the host when it starts.  I don't know if your host code waits for this.

It's fairly common for host stacks to use an HCI Reset command after a 
device
has started.  I don't know if your host code does so, but this shouldn't 
matter.

You say the device sometimes doesn't work.  How does the host perceive
the command doesn't work?  Failure to respond, or command rejected?

Carl

--------------040105000207020402000501
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Jean Tourrilhes wrote:<br>
<blockquote type="cite"
 cite="mid20040813180748.GB23661@bougret.hpl.hp.com">
  <blockquote type="cite">
    <pre wrap="">Can you reveal what you're doing with the CSR device when
you suffer deadlock?  We may recognise the symptoms, and possibly
know of a workaround or of fixed firmware.
    </pre>
  </blockquote>
  <pre wrap=""><!---->	Trivial deadlock :
	initiating a connection to a device within 80ms of receiving
incomming connection from same device. Unknown if bug is in fw or
stack, but firmware deadlock.</pre>
</blockquote>
Is the incoming connection a connection request from the remote device,
or a<br>
connection complete?<br>
<br>
If the latter, is it from an auto-accept filter, or from your host
accepting the connection?<br>
<br>
This feels as though it might be from an LMP collision - one of the
nastier elements<br>
of the baseband specification.&nbsp; When collisions occur (two devices
initiate LMP<br>
transactions at the "same" time) the firmware sometimes defends itself
with lengthy<br>
timeouts, but I'm unaware of any resulting deadlocks in current
firmware.<br>
<blockquote type="cite"
 cite="mid20040813180748.GB23661@bougret.hpl.hp.com">
  <pre wrap="">	Intermitent failure :
	Initiating connection (page) within 20ms of bringing HCI
device up. Sometime it works, sometime it doesn't.
  </pre>
</blockquote>
I assume "bringing HCI device up" means your local BT device.&nbsp; The CSR<br>
device should be ready for a single HCI command as soon as the host
transport<br>
is established, though to signal readiness, the device sends a NOP
command_complete<br>
to the host when it starts.&nbsp; I don't know if your host code waits for
this.<br>
<br>
It's fairly common for host stacks to use an HCI Reset command after a
device<br>
has started.&nbsp; I don't know if your host code does so, but this
shouldn't matter.<br>
<br>
You say the device sometimes doesn't work.&nbsp; How does the host perceive<br>
the command doesn't work?&nbsp; Failure to respond, or command rejected?<br>
<br>
Carl<br>
</body>
</html>

--------------040105000207020402000501--
