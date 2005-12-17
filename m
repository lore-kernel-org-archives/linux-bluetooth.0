Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <1516267928@web.de>
MIME-Version: 1.0
From: Wolfgang Krug <w-krug@web.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Modify scotest?
Content-Type: text/plain; charset=iso-8859-1
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
Date: Sat, 17 Dec 2005 08:47:49 +0100

Now  I have simply inserted a  recording option in scotest ( like in hstest). It seems to work, I can transmit audio from Dongle to Dongle and record it,
 but do I have to use the correct format (8Khz / 8 Bit Sample)?

 Have you already done that  - any experiences? 


bluez-devel@lists.sourceforge.net schrieb am 16.12.05 09:51:22:
> 
> Hi Arnaud,
> 
> > Using SCO for quality measurement is a good idea if your bluetouth 
> > device supports trasnparent audio, and if you configure them to use this 
> > mode. If not, you can still try a configuration like ulaw on air, ulaw 
> > on HCI (no conversion in theory)
> 
> no it is not a good idea. The chip will insert bits/bytes/frames as it
> thinks it needs to. The transparent audio is not guaranteed. Read the
> posts from the CSR guys for any details. 
> 
> > In this case, write a tool like scotest that always send FF.FF.FF...FF 
> > frames (or anything you want) (write the same amount of data that you 
> > receive). Then juste count zeros bits to detect BER, and 00.00.00...00 
> > frames for PER.
> 
> Get a CSR development kit and get their BCCMD specification and use
> their internals to get the BER values.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


__________________________________________________________________________
Erweitern Sie FreeMail zu einem noch leistungsstarkeren E-Mail-Postfach!		
Mehr Infos unter http://freemail.web.de/home/landingpad/?mc=021131



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
