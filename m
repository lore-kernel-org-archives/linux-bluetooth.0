Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm0: connection refused
From: Marcel Holtmann <marcel@holtmann.org>
To: Virat Gohil <virat4lug@hotpop.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <007c01c46334$7d8f5090$17010f0a@matrix>
References: <007c01c46334$7d8f5090$17010f0a@matrix>
Content-Type: text/plain
Message-Id: <1089110652.4504.138.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 06 Jul 2004 12:44:13 +0200

Hi Virat,

>  I tried connecting to GPRS using my nokia 6820 and CSR usbdongle. I am able
> to start hcid, sdpd.
> 
>  I am also able to l2ping my device.
> 
>  I can bind the device to rfcomm0, after patching the kernel

about what patch are you talking? What kernel do you use?

>  I was able to connect to The Internet once, but after I restarted I got the
> following error while connecting using pppd
> 
>  rfcomm0: connection refused!

This can be a PIN problem or you use the wrong RFCOMM channel number.
Check the channel number of DUN with sdptool first.

>  I thought may be I messed up a setting here or there, so I re-installed
> RedHat 9.0 and tried again, I was able to conenct once, after I restart I
> get the same problem. please help.
> 
>  The following is the output of hcidump:

Fix up your mailer. This messed up hcidump was hard to read.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
