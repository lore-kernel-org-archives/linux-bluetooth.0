Return-Path: <cyrus@holtmann.org>
From: "Duda, Lukasz" <Lukasz.Duda@nordicsemi.no>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>
Subject: RE: [RFC v2 0/4] Adding stateful compression to IPHC 
Date: Wed, 15 Jul 2015 09:55:01 +0000
Message-ID: <AB80DA35A7B64E4E98291794926897D9741DE538@MBX03.nvlsi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann <marcel@holtmann.org> wrote:
> I am not sure that 6LoWPAN long-term should be a compile time option of
> IPv6. However that is certainly a possibility. If we want to discuss that=
, then it
> needs to be a discussion on the netdev mailing list with the netdev folks=
.
>=20
> Initially the direction was to go for net/6lowpan/ and make 6LoWPAN a
> subsystem of its own. Making it part of IPv6 would mean this has to move =
into
> net/core/ and that needs convincing of the netdev folks.
>=20
> My viewpoint of 6LoWPAN subsystem was always that besides compression, it
> actually becomes a full net_device abstraction. So instead of BLE and 802=
.15.4
> allocating net_device on its own, we have something like lowpan_netdev th=
at
> gets allocated by each subsystem. And then you just provide the framing
> functions that take the encapsulated frames and transport it over the bea=
rer.
> Right now we are doing a lot of duplication in each subsystem to support
> 6LoWPAN. The less it takes to hook up 6LoWPAN to new bearers, the better.
> Moving the compression into a separate module was just the first step.
>=20
> Regards
>=20
> Marcel

Thanks a lot for your feedback and valuable comments.=20

I hope it is okay that I am responding using the new mail thread.
As you might have noticed I have resubmitted the RFC patch after
addressing your comments in a new thread, and split the patch
into smaller parts.

The idea of making an abstraction of lowpan_dev sounds like a good idea,
but I'm not sure if I'm grasping the details involved. Could you please
elaborate a bit more on you proposal?

Is the structure like below something you had in mind for lowpan_dev?
struct lowpan_dev { // Struct build-in /net/core like wpan_dev
    net_device * net_dev;   // Pointer to net device
    FUNC_PTR tx_xmit;       // Transmit function in the subsystem
                               (assigned on the registration of a=20
                               lowpan_dev)
    FUNC_PTR decompress;    // Is called after receive of new data from
                               the subsystem. But how to deliver such data,
                               for example by creating lowpan_dev_rx() API?
    FUNC_PTR compress;      // Is called when net_device sends packet to
                               lowpan_dev (xmit).
    FUNC_PTR handle_ra;     // Is called when ndisc.c finds lowpan options
                               e.g. 6CO.
}

struct net_device {
    ...
    lowpan_dev  * lowpan_dev_ptr;
    ...
}

For now 6CO is the only flag that I am currently interested in, but with
such structure, it could easily be extended to handle other message types.

Having the pointers to compress/decompress and to act upon lowpan options,
allow us to keep 6lowpan as a module in /net/6lowpan. Could this work?=20
Or you are proposing to completely move IP Header compression mechanism to
lowpan_dev implementation (built-in - /net/core)?

Best regards,
=A3ukasz Duda
