Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm0: connection refused
From: Marcel Holtmann <marcel@holtmann.org>
To: Virat Gohil <virat4lug@hotpop.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <006d01c46417$0d9795c0$05000f0a@matrix>
References: <007c01c46334$7d8f5090$17010f0a@matrix>
	 <1089110652.4504.138.camel@pegasus> <001b01c46355$7a0c4150$c1010f0a@matrix>
	 <1089124649.4504.208.camel@pegasus> <006d01c46417$0d9795c0$05000f0a@matrix>
Content-Type: text/plain
Message-Id: <1089205016.4857.22.camel@pegasus>
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
Date: Wed, 07 Jul 2004 14:56:57 +0200

Hi Virat,

> > not really good. Better you use 2.4.26-mh1.
> 
> sorry, but I dont know much about kernel, my question is can I use
> 2.4.26-mh1 patch on 2.4.20 series kernel or shall I download the source for
> 2.4.26 series and then apply the patch that you suggested?

take a look at www.kernelnewbies.org for kernel FAQ etc. Anyhow the
patch-2.4.26-mh1 is as the name indicates for Linux kernel 2.4.26. You
have to choose another one, but these patches only apply to a vanilla
kernel from www.kernel.org and not the RedHat specific kernels.

> > > > This can be a PIN problem or you use the wrong RFCOMM channel number.
> > > > Check the channel number of DUN with sdptool first.
> > >
> > > I dont think so, as I was able to connect once, and then it failed after
> > > restart and without me making any changes.
> >
> > Check it with "sdptool browse <bdaddr>". What does "hciconfig -a" say?
> 
> I am attaching the output of "sdptool browse" and hciconfig -a and the
> hcidump with this mail. Thanks again

Maybe you have initiated a pairing between phone and PC, but the phone
didn't save the link key. Make sure that you accept a new pairing on the
phone and that you also store it. Check the list of paired devices.

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
