Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Aaron Klish <aklish1@urbana.css.mot.com>
Cc: Aaron Klish <AKLISH1@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: 
	<Pine.GSO.4.20.0310231659530.15561-100000@wombat.urbana.css.mot.com>
References: 
	<Pine.GSO.4.20.0310231659530.15561-100000@wombat.urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1066976671.1667.26.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: setsockopt for RFCOMM
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 24 Oct 2003 08:24:25 +0200

Hi Aaron,

>   I didn't explain myself well.  The subject of my mail was also incorrect.  
> Suggesting exposing credit and RFCOMM frame size to user space has nothing to do
> with the Rfcomm TTY data loss I have observed.  Therefore, I'm changing the subject of 
> this thread to "setsockopt for RFCOMM".

I wasn't talking about the TTY data loss. This is another problem and I
will talk about it after I found the time to test it by myself.

> The MTU I was referring to in my email was not the L2CAP MTU that Rfcomm initializes for PSM 3.
> 
> I was referring to the "Maximum Frame Size" defined in GSM 7.10 specification in
> section 5.1.8.1.1.
> 
> This is the part of the PN negotiation in core.c:
> 
>         pn->mtu = htobs(d->mtu);
> 
> in function rfcomm_send_pn.
> 
> This Maximum Frame Size is separate than the L2CAP MTU negotiated.   The Maximum Frame
> Size cannot exceed the L2CAP MTU negotiated, but it can certainly be less.

And this is why it doesn't matter, because we have the underlaying L2CAP
MTU as max value.

	s->mtu = min(l2cap_pi(sk)->omtu, l2cap_pi(sk)->imtu) - 5;
	d->mtu = s->mtu;

> The reason we are interested in changing these values (credit and Max Frame Size)
> is not for performance but to limit memory.
> 
> When RFCOMM sends a PN, it is advertising an abstract "buffer size" which equals
> the number of credits * the Maximum Frame Size.
> 
> Currently, this abstract "buffer" is defined at compile time.  To customize it
> for a given product, requires modifying the kernel or modules.  Furthermore,
> this "buffer" is currently the same size for all services.  

It makes no sense to shrink the RFCOMM frame size, because this ends up
in performance problems and we already have the L2CAP packet which can
be size of L2CAP MTU. We don't copy the L2CAP packet and so RFCOMM needs
no extra buffer for it. The only variable parameter to limit the memory
usage is the number of outstanding credits, but this can also decrease
the performance.

> It would be nice to be able to configure this without having to recompile
> and to customize it on a per service basis.

The RFCOMM frame size can be negotiated per channel, but it makes no
sense to do this, because we have the same underlaying L2CAP connection
for each channel. We have the same L2CAP MTU for all RFCOMM channels on
that ACL link and so we can use the same frame size for all RFCOMM
channels.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
