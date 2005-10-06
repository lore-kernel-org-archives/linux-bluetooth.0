Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ken Booth <sf.net@booths.org.uk>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How do I pair?
References: <200510060042.36966.sf.net@booths.org.uk> <1128592717.5492.20.camel@localhost.localdomain>
In-Reply-To: <1128592717.5492.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510061820.28005.sf.net@booths.org.uk>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 6 Oct 2005 18:20:27 +0100

Hi Marcel,

Thanks for the diagnostic tips. I found the a hcid.conf.rpmsave file with the 
corrects settings. It appears the upgrade changed the following parameters in 
the hcid.conf file
        pscan disable;
        iscan disable;
        pin_helper /usr/bin/bluepin;

I fixed the problem by restoring them to
        pscan enable;
        iscan enable;
        pin_helper /bin/bluepincat;
(the PC identifying itself as "Unknown" is just a signal quality problem - too 
many walls between computer and phone)

PS: What do pscan and iscan do?

Ken.

On Thursday 06 October 2005 10:58, Marcel Holtmann wrote:
> Hi Ken,
>
> > I've just upgraded from the Suse 9.3 default bluez packages to:
> > bluez-libs-2.21.tar.gz
> > bluez-utils-2.21.tar.gz
> > bluez-pin-0.26.tar.gz
> > bluez-firmware-1.0.tar.gz
> > bluez-hcidump-1.26.tar.gz
> > bluez-hciemu-1.2.tar.gz
> >
> > and my /etc/bluetooth/hcid.conf still says
> >         name "Ken's PC";
> > and I've editted the /etc/bluetooth/pin to have the same PIN code, yet
> > when I try to pair from my SE K750i, the PCs name is discovered as
> > "Unknown" and the PIN is rejected.
>
> show us "hciconfig -a" and run "hcidump -X -V".
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
