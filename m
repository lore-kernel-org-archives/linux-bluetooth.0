Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] problems with nc6 with bluez support
Date: Fri, 23 Jan 2004 11:25:12 +0100
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Fabio Coatti <fabio.coatti@wseurope.com>
References: <200401221042.53134.mtortonesi@ing.unife.it> <200401221221.49241.mtortonesi@ing.unife.it> <1074771503.19046.12.camel@pegasus>
In-Reply-To: <1074771503.19046.12.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200401231125.12823.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thursday 22 January 2004 12:38, Marcel Holtmann wrote:
> Hi Mauro,
>
> I must admit that I am not an autoconf expert, so my rule is that as
> long as it works it is ok. A nice idea is to check for the sockaddr_*
> definitions.
>
> BTW please post a diff of nc6 that adds the Bluetooth support. This will
> make it easier for me to audit your code.

i have added configuration-time detection of bluez to nc6 and i have just 
merged the changes in the nc6 cvs repository:

http://cvs.deepspace6.net/view/nc6


> > > But you should forget about the SCO transfers. SCO is for audio
> > > transmission (voice) only. Use L2CAP (SOCK_SEQPACKET) and RFCOMM
> > > (SOCK_STREAM).
> >
> > in fact i just wanted to perform audio transmission.
> >
> > i have written the audioread application, that reads an oggvorbis file,
> > decodes it and writes the PCM samples to stdout, and the audiotest
> > application, that reads PCM samples from stdin and writes them to
> > /dev/dsp.
> >
> > so i was testing audio transfers by issuing this command on the server
> > host:
> >
> > nc6 -b -l -p 10 | audiotest
> > (nc6 -b -l --sco | audiotest for SCO)
> >
> > and this command on the client host:
> >
> > audioread file.ogg | nc6 -b 00:0D:88:8E:CA:07 10
> > (audioread file.ogg | nc6 -b --sco 00:0D:88:8E:CA:07 for SCO)
> >
> > i must have made something wrong, since all the audio transfer tests i've
> > made failed.
>
> The audio stuff is not very easy if you do SCO over HCI over USB. You
> have to check if your dongle sends the SCO traffic over the HCI layer.
> Then you really need the latest 2.4.25-pre kernel or you have to apply
> one of my -mh patches.

ok, thanks. i'll try to figure this out.


> > so are you suggesting to stick to 2.4 for the moment? i have been using
> > 2.6 on my laptop for the last 5 months and i am really enthusiastic about
> > it ;-)
>
> If you want to use SCO with an USB Bluetooth dongle? Yes, you must stick
> to 2.4 until the SCO problem is solved. Of course if you own an OHCI USB
> host adapater you can give 2.6 a try, but the UHCI will fail and crash
> your system.

very interesting. do you think there is a bug in the UHCI code which is 
related to isochronous traffic type? see this thread:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107238134310638&w=2

i am asking this because a friend of mine (fabio coatti, included in cc) has a 
dlink dbt120 usb dongle (hardware revision b2) and if he compiles the 2.6 
kernel with sco support over hci_usb he gets an oops each time he unplugs the 
dongle. IIRC, the crash happens only if he has hcid and sdpd running. 

oddly enough, with the same kernel and the same dbt120 usb dongle (although 
hardware revision b3) i had no such problems on my laptop. i don't know if 
this depends from the chipsets (i have an intel 815P and he has a brand new 
intel i875P), but it is sure worth investigating.

BTW: marcel & max, can i ask you what tools you use to debug your bluetooth 
kernel code? printk? kgdb? kdb?

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
