Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: KeiHachi <keihachi@swissinfo.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000a01c461a4$e79be160$0364a8c0@haruo>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo>
	 <1088442828.6030.27.camel@pegasus>  <002801c45dfb$c533d760$0364a8c0@haruo>
	 <1088530908.6030.310.camel@pegasus>  <000d01c45ebe$72d6e660$0264a8c0@haruo>
	 <1088619095.4540.126.camel@pegasus>  <000a01c461a4$e79be160$0364a8c0@haruo>
Content-Type: text/plain
Message-Id: <1088941116.4639.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 04 Jul 2004 13:38:37 +0200

Hi KeiHachi,

> > I already did that and in the fact of SEP it is nothing different from a
> > PSM or RFCOMM channel. Actually because of this I thought that a socket
> > based implementation is the best. Along time I prefered to keep AVDTP in
> > userspace. However the only difficult part is the discover, because if
> > you don't know the SEP you must use it to find the available ones and
> > this includes a L2CAP connection. I must see how this gets integrated in
> > a nice way.
> 
> I see.
> You, Marcel, are the one of the best engineer in the world,
> so I anticipate the time when AVDTP will be completed.

many thanks for these nice words.

When I first looked deeper at the details of AVDTP, my plan was to get a
working demo of the VDP at the Linux konferenca 2004 in Portoroz. Anyhow
my work on the HID support will take longer as expected and I hope that
I can finish the Bluetooth HID boot protocol support for the kernel
integration within the next two days.

Actually I thought that I will find some time to write the basics of the
AVDTP implementation in August, but I got invited to the O'Reilly Euro
Foo Camp. I will attend there and my plan is to present something very
nice, but right now I am not sure what it will be. Any proposals?

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
