Return-Path: <ulissesf@gmail.com>
Message-ID: <d23110170606291331q48f5062dh4eb67803291b45b8@mail.gmail.com>
Date: Thu, 29 Jun 2006 17:31:52 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Controller to host flow control
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1151612400.14964.41.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <d23110170606291108r57335a6bx76a19d7cf7f63cf6@mail.gmail.com>
	 <1151612400.14964.41.camel@localhost>
List-ID: <bluez-devel.lists.sourceforge.net>

On 6/29/06, Marcel Holtmann <marcel@holtmann.org> wrote:

> > Well, I was saying that finally I had time to look into controller to
> > host flow control and I'd like to share what I've thought to see if
> > you agree with me before I start implementing it. Ah.. another thing,
> > do you like me to send these messages to the mailing list or directly
> > to you?
>
> I am fine with using the mailing list.

Ok, I've CCed the bluez development mailing list.

> > I've thought about implementing some simple flow control. We could add
> > 5 extra fields in hci_dev structure to set if that device wants
> > controller to host flow control and also the ACL/SCO buffer sizes.
> > These fields might be something like:
> >
> >   __u8    host_flow_ctl;
> >   __u16  acl_data_len;
> >   __u16  sco_data_len;
> >   __u16  max_acl_pkts;
> >   __u16  max_sco_pkts;
> >
> > When the device is registered we can set flow control with the "Set
> > Controller to Host Flow Control" command and set the buffer sizes with
> > the "Host Buffer Size" command (if the device wants controller to host
> > flow control, of course).
>
> We also need the "Host Buffer Size" command for normal operation. The
> ISSC based dongles for example tend to send to much data which we can't
> handle smoothly.

Hmm.. I don't know if I understood. Do you mean we need to send the
host buffer size command more than once?

> > Besides that we'd need a counter per connection to be able to report
> > how many packets were completed per connection handle with the "Host
> > Number of Completed Packets" command. The counter per connection can
> > be a field like the following in hci_conn:
> >
> >   __u16  nr_compl_pkts;
>
> I prefer to have an atomic counter here.

Of course. I wanted an atomic counter but have written __u16.

> > We'll have to define when we're going to send the "Host Number of
> > Completed Packets" command. The specification says we should send this
> > command when "the corresponding buffer space has been freed on the
> > Host", so we can do it this way. What do you think?
>
> For starters we can send it after every data packet, but that is not
> what we really want. We might wanna have something like 8 outstanding
> packets.

Ok.

Best regards,

-- Ulisses
