Return-Path: <david.libault@inventel.fr>
Message-ID: <3E58CB9800003E68@serveur.inventel.fr> (added by serveur.inventel.fr)
From: David LIBAULT <david.libault@inventel.fr>
Reply-To: david.libault@inventel.fr
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>, Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] BlueZ Qualification
Date: Mon, 3 Mar 2003 19:06:35 +0100
Cc: Daryl Van Vorst <dvpub@telus.net>, bluez-devel@lists.sourceforge.net, Halam.Rose@7layers-UK.com
References: <5.1.0.14.2.20030227125343.023513a0@mail1.qualcomm.com>
	<5.1.0.14.2.20030228122906.023b3ca8@mail1.qualcomm.com>
	<1046706518.14907.133.camel@linux>
In-Reply-To: <1046706518.14907.133.camel@linux>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=iso-8859-1
List-ID: <bluez-devel.lists.sourceforge.net>

Le Lundi 3 Mars 2003 16:48, Marcel Holtmann a écrit :
> Hi,
>
> > >Who is going to write the test report ?
> > >Is Bluez going to be listed as official Bluetooth qualified stack ?
> >
> > I don't know. That's what we need to discuss.
> > There are many questions (at least in my mind) like
> > - Does it make sense to have qualified stack in the official kernel ?
> > Like I mentioned before I don't want to add things that simply don't make
> > sense for general stack operation only because we want to pass
> > qualification (I'm talking mostly about kernel stuff here).
> > In which case a separate qualified kernel package with the same API as
> > mainstream kernel make sense.
> >
> > - What happens when we make changes to the stack ? Have to qualify again
> > ?
>
> the first thing here is that we must differ between the kernel modules
> and the userspace utitlities. Question is what make really sense to
> qualify and what kind of userspace programs need to be qualified? I
> think for the beginning we should concentrate only on HCI and L2CAP and
> we should go along with stable releases of the 2.4 kernel. And the best
> Kernel to start with is for me the not yet released 2.4.21. Sticking to
> an external Kernel package is very ugly because it needs to be
> maintained and this is a job that can not be done by any of us at the
> moment and in general it does not make sense to double the work.
>
> Getting a qualification for all new 2.4 kernel should be easy, because
> we mostly don't change things in the core layers and bugfixes didn't
> need to be qualified again if I am right. If we do a big change or add
> new features we have to qualify again, so we should automate as most
> things as we can to make this easy and fast. I think that the time
> between the 2.4 kernel releases is a good gap and it will grow bigger
> after the 2.6 comes out and we should completly forget about to qualify
> a 2.6 in the first six month. The userspace component looks mostly the
> same. Most big changes are done for SDP and PAN in the last months.
>
> The BlueZ kernel modules are working perfect in conjunction with other
> devices and other stacks, but we have already seen that we need to add
> some quirks for passing the qualification and I agree completly with Max
> that is a bad idea to have things that don't makes sense, but are needed
> for a qualification. We should start colleting these quirks and see how
> we handle them. At the moment I see two ways out of this problem:
>
> 1. Include them into the kernel code and make them a compile option
>
> 2. Have own patches against the stable kernel for qualification

IMHO, it is possible to have L2CAP qualified without messing up that much the 
code, and without changing the behavior/performance when "the other side" is 
working properly. It anyway does not make sense to have one stack for 
qualification and one stack for "real usage", as, in theory, only qualified 
bluetooth products should be runing... Bluez is one of the cleanest Bluetooth 
implementations, and is becoming (or is already) a reference implementation. 
Lets qualify it ! 

>
> The same rules apply to the userspace utils and also to the userspace
> protocol implementations like SDP and OBEX.
>
> In general I think a qualified version of the BlueZ stack is a good
> idea, but this is also hard work and at this points comes the money
> problem in. The end user don't get any advantages of a qualified Linux
> Bluetooth (it only sounds great), but companies who plan to use BlueZ in
> their Bluetooth products will save a lot of time, money and knowledge if
> they don't have to qualify the complete stack again. If we really got
> BlueZ qualified and companies can take advantage of it I think that they
> should payback something to the OpenSource community. And at this point
> the idea of a non-profit organization which takes care of a qualified
> version of the BlueZ stack and represent the Linux fraction in the
> Bluetooth SIG comes to my mind.

My interest as a company is to help having Bluez qualified. If once I have 
suffered, for the qualification I have to pay someone again later there is 
absolutely no interest in having Bluez qualified ! I just use Bluez as it is 
and qualify it myself !

I also think that having Bluez qualified is very small effort compared to the 
one of developing a complete/robust/functional/performant stack. The biggest 
effort has already been done by Maxim and other people, and it is open 
source. Companies take more advantage from Bluez itself than from a 
"qualified" Bluez. Qualification should be as the stack itself : open source.

>
> People that already have some experiences in qualification (and
> especially BlueZ) should start now sharing their results with us, so we
> can start planing the next step.

Next step : L2CAP qualification.

The main issue is to have the tester side...

	1) write a small user-mode program that can open and close an ACL channel, 
and send any kind of packet over this link
	2) write a script for each test case

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
