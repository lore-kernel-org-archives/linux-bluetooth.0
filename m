Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Miquel Puchol" <miquel.puchol@south-wing.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Dongle with a strange configuration
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1137719696.17336.137.camel@localhost>
Message-ID: <E1EzqxO-0005bu-1G@mail.sourceforge.net>
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
Date: Fri, 20 Jan 2006 08:45:49 +0100

Hi Marcel,

Thanks for your input - I have the dongle out of plastics, and will be
lifting the RF shield off today, this will tell for sure.

Hcid is running fine now, I have found that if I boot with the dongle
inserted, all goes well, I'll investigate a bit further with your
suggestion.

Best regards,

Mike 

> -----Mensaje original-----
> De: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] En nombre de 
> Marcel Holtmann
> Enviado el: viernes, 20 de enero de 2006 2:15
> Para: bluez-devel@lists.sourceforge.net
> Asunto: Re: [Bluez-devel] Dongle with a strange configuration
> 
> Hi Mike,
> 
> > I'm trying out this Billionton dongle (CSR-based, class 1), 
> and it's 
> > curious that:
> > 
> > Name: 'James-1711....'  (I guess James what one of the developers)
> > Class: 0x000000
> > HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP 
> Subver: 0x460
> 
> are you sure this is a CSR dongle? The build id is a little 
> bit too high for a Bluetooth 1.1 dongle from CSR.
> 
> > The problem is that when I start hcid, it doesn't configure 
> the dongle 
> > with the values in hcid.conf, but the ones above. I've 
> tried various 
> > combinations of inserting, then starting hcid, having hcid running 
> > then insert, etc.
> > 
> > Can anyone give me an insight as to why this is happening? 
> How can I 
> > get the dongle to init with the right settings?
> 
> Run "hcidump -X -V" before you start hcid and look out what 
> it tells you.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep 
> through log files for problems?  Stop!  Download the new AJAX 
> search engine that makes searching your log files as easy as 
> surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&
dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
