Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43F10AED.7050703@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] class 1 bluetooth 1.2 dongles with CSR 		chipset?(inUSA)
References: <20060123122802.280f747e@taco> <43D55AC7.6040500@xmission.com> 		<5f30e2610601301026l14b8354dne9a6eca4d0f98eea@mail.gmail.com> 	<43DE617D.1010807@xmission.com> <43EFD2D8.5030300@cs.bgu.ac.il> <43F00CE4.2070808@xmission.com> <43F0E26D.9000505@cs.bgu.ac.il>
In-Reply-To: <43F0E26D.9000505@cs.bgu.ac.il>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Mon, 13 Feb 2006 15:40:45 -0700

Niv

> As far as I read the V.w Bus is 12 Mb, which is way more then the 0.7M
> the V.1 offers
> 
> does that mean I can use a V.2 adaptor to stream A2DP while using the
> earpeace and mouse - without hearing braek-ups in the headphones?
> 
> I currently get brake-ups if I run the proximity script during A2DP
> playback.
> 
> gentoo-wiki.com/TIP_Bluetooth_Proximity_Monitor

you won't have breaks in the audio because of the usb bandwidth. You're
 likely to have breaks when...

- you have a scatternet--because one device has to switch between master
and slave

- you run wifi traffic alongside a pre-bt1.2 adapter

- you use a timer other than rtc

- you run the rtc timer on a machine with nvidia drivers

- you hijack the radio with a proximity scan or any other paging activity :)

bluetooth v2 is unlikely to help with proximity scanning. the real
problem is the bluetooth radio can only be on one frequency at a time
and the proximity scan needs to take it over briefly to check each
frequency.

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
