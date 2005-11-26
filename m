Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth connection too slow
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1133028275.9123.29.camel@localhost.localdomain>
References: <1133028275.9123.29.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1133028830.28718.19.camel@blade>
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
Date: Sat, 26 Nov 2005 19:13:50 +0100

Hi Mario,

> I recently bought a Bluetooth 2.0 EDR USB adapter (Trust, BT-2200Tp),
> because I wanted to try it out with my new Motorola E1070 (UMTS phone).

you need EDR on both sides to profit from it.

> I tried it out with my Ubuntu linux. The device has been recognized
> properly. Then I tried the Internet connection (with UMTS you can have
> more than 30 kBytes/s). Unfortunately all I could see was a transfer
> rate (taken with wget downloading the kernel sources from a fast mirror)
> of about 9 kB/s. I also tried to do the same with Windows XP and there
> the transfer rate reached about 32 kB/s!! I did the same several times
> and all the times I had the same results.
> Furthermore, I tried to do the same under Linux with a USB connection,
> and I'm getting 32kB/s as well. This brought me to think the bottleneck
> is in the BT connection.
> 
> This is how I'm setting the BT connection:
> $ sudo hcitool cc --role=m 00:0E:A1:45:1F:AE
> $ sudo hcitool auth 00:0E:A1:45:1F:AE
> $ sudo rfcomm bind 00:0E:A1:45:1F:AE
> $ sudo ln -sf /dev/rfcomm0 /dev/modem

The two hcitool commands are not needed. RFCOMM can create the piconet
by itself.

> To dial I'm using exactly the same procedure as when using the USB
> connection (with kppp).
> 
> I'm wondering if I need to tweak some parameter of the bluetooth
> connection. hciconfig gives me many info but I don't know how to
> interpret them and what options to give (where can I find
> documentation?).

If you reach 32 kB/s then this is a good result. With Bluetooth prior
EDR you will reach max something around 80 kB/s, but this is not really
doable with PPP in between. The bottleneck can also be the UART inside
your mobile phone.

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
