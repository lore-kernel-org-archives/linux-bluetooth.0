Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] A blue chamaleon to be
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <op.s1tgc9j9xabado@portatilegio>
References: <op.s1tgc9j9xabado@portatilegio>
Content-Type: text/plain
Message-Id: <1134636788.5198.42.camel@localhost>
Mime-Version: 1.0
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
Date: Thu, 15 Dec 2005 09:53:08 +0100

Hi Giovanni,

> I'm new both to Linux (OpenSuSe 10.0) and to Bluez. I'm using a  
> Tecom dongle since two years on win xp (sorry). Now I'd like to use it  
> even in Linux, but I can't pair my mobile (Motorola v600) in any way I'm  
> trying. Object push works well, in&out.. It's the pairing my only problem.  
> I tried to set as "none" the pairing mode in hcid.conf, and to "user" the  
> security mode, as I red in your archive on Gmane, but it doesn't work. I  
> also tried to set the security as auto, and the pin file text as PIN:****  
> and not just ****. Everytime I try to establish a connection in need of  
> pairing, my mobile pops up with a request for a pin code I simply... don't  
> know. Where and how should I write it before trying to establish a  
> connection with my phone?

send in the output of "hcidump -X -V" while you are doing this.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
