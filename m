Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041109144107.19373.qmail@webmail.aruba.it>
References: <20040727145602.30665.qmail@webmail.aruba.it>
            <1090940808.4845.21.camel@pegasus>
In-Reply-To: <1090940808.4845.21.camel@pegasus>
From: "ubaldo" <ubaldo@eja.it>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Subject: [Bluez-devel] Re: multi rfcomm/sco connection
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 09 Nov 2004 15:41:07 +0100

Ciao Suriyan, 

I was looking, few months ago, for a way to solve a problem more or less 
like your. 

All what I could do was to set the headphones to HV3 and the bt-dongle too, 
in this mode it was possible to "listen"  audio on 3 different channels, the 
problem, for me, was that this channels were "mixed" so if with a channel I 
was receiving 24bit with 3 channels they were 72, but I could not find a way 
to "demux" this caos who was coming out, but I remember I found a way to 
"create" 3 different sco connections with just one bt-(usb)-dongle.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
