Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm0: connection refused
From: Marcel Holtmann <marcel@holtmann.org>
To: Virat Gohil <virat4lug@hotpop.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001b01c46355$7a0c4150$c1010f0a@matrix>
References: <007c01c46334$7d8f5090$17010f0a@matrix>
	 <1089110652.4504.138.camel@pegasus> <001b01c46355$7a0c4150$c1010f0a@matrix>
Content-Type: text/plain
Message-Id: <1089124649.4504.208.camel@pegasus>
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
Date: Tue, 06 Jul 2004 16:37:29 +0200

Hi Virat,

> > about what patch are you talking? What kernel do you use?
> 
> I am using 2.4.20-8 which comes with RedHat Linux 9.0

not really good. Better you use 2.4.26-mh1.

> > This can be a PIN problem or you use the wrong RFCOMM channel number.
> > Check the channel number of DUN with sdptool first.
> 
> I dont think so, as I was able to connect once, and then it failed after
> restart and without me making any changes.

Check it with "sdptool browse <bdaddr>". What does "hciconfig -a" say?

> > Fix up your mailer. This messed up hcidump was hard to read.
> 
> I am attaching a text file with the hcidump with this mail, hope you wont
> mind that.

Use the suffix *.txt so I can view it inline in my mailer.

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
