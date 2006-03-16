Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Andreas Merkle <andreas.merkle@addcom.de>
Message-ID: <loom.20060316T195745-915@post.gmane.org>
References: <200603141107.53660.me@goetzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [Bluez-devel] Re: AT commands for GSM to use remoteSAP
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
Date: Thu, 16 Mar 2006 18:59:28 +0000 (UTC)

Götz Issel <me <at> goetzi.de> writes:

> 
> Hi all, 
> 
> I am working on a tool to eventually use remote SIM access or the SIM access 
> profile. To make it adaptable for different hardware I would like to know if 
> the AT commands for different GSM hardware are exactly the same. My question 
> of course only aims at the commands concerning the remote SIM access.  
> Example: a Siemens AC45 has AT^SRSA=.... for de/activation or AT^SRSM for 
SAP 
> messages like "CONNECT_REQ" etc. 
> Question: Can anyone with different hardware send me the needed sequence to 
> set the correct mode and instruct their GSM to use a remote SIM plus the 
> manufacturer, device name and revision.
> 
> Thx, 
> goetz
> 


Hi,
IMHO the AT^SRSA=... is specific for the AC45 GSM module.
Other modules communicate with the T0-protocol and the Bluetooth Stack does 
the rest.

Regards





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
