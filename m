Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0511080645u30fb24dep3243ce434b0f07c2@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Variable arguments to Inquiry and PeriodicInquiry D-BUS methods
In-Reply-To: <20051108143016.GA7919@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051108134311.GA7150@localhost.localdomain>
	 <1131458070.5824.181.camel@blade>
	 <20051108143016.GA7919@localhost.localdomain>
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
Date: Tue, 8 Nov 2005 12:45:47 -0200

Hi,

The interface for get/set the default values is fine!

Some suggestions/comments...
1. It's better use the same method name used by device configuration.
Currently, device configuration uses SetProperty and GetProperty, it
should be better rename to Set and Get. Do you agree?

2. Does it make sense add an extra argument(device class) in order to
be notified only by device class that the client wants? Maybe this
enhancement should be applied when become possible retrieve the
Inquiry cache using the new userspace/kernel communication interface.

3. Periodic inquiry is a concurrent task. Currently there isn't
verification for PeriodicInquiry requested by more than one client. In
this case how it should work?

Regards,
Claudio.

On 11/8/05, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> Hi Marcel,
>
> Attached is a new patch with some of your proposed changes (the ones I
> agree with ;)
>
> On Tue, Nov 08, 2005, Marcel Holtmann wrote:
> > > The possible ways of calling the methods after applying this patch ar=
e:
> > >
> > > Inquiry()
> > > Inquiry(byte: length, byte: num_rsp, uint32: lap)
> > > PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period)
> > > PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period,
> > >             byte: num_rsp, uint32: lap)
> >
> > please swap the lap and num_rsp (call it num_responses btw.) and make
> > the num_responses also optional. It is more usual that you will specify
> > a different lap instead of num_responses. The reason for this is,
> > because the num_responses value is not really useful anymore. All chips
> > in inquiry mode 1 or 2 tend to send results multiple times and this
> > makes the num_responses value useless. It is only good for devices wher=
e
> > the memory storage for inquiry results is limited. Maybe we shouldn't
> > use it at all.
>
> I removed the num_responses parameter alltogether. If it's needed we can
> always allow changing it through the default settings interface in the
> future.
>
> > Is it not better to call it access_code instead of lap?
>
> Maybe. I called it lap since that's what your structs in hci.h and the
> HCI spec calls it. Note that the terms we use in the code don't have to
> the same what we put in the (yet to be created) public documentation of
> the interface.
>
> > The length parameter should also be in seconds and not the slot timing
> > we get from the baseband.
>
> Well, then it would always have to be rounded to the nearest 1.28 sec
> multiple, so I'm not so sure how useful it would be (and it might be
> even confusing for the user when the inquiry doesn't last the exact
> amount of seconds that was given). I've left it unchanged for now. I can
> send a new patch later specifically for it. If we do change it, should
> it be an integer or a floating point number?
>
> Johan
>
>
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
