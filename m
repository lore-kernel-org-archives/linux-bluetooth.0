Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] killing a persisted pand session
Date: Sun, 7 Mar 2004 02:42:16 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com> <200403070221.59578.wim.delvaux@adaptiveplanet.com> <1078623235.2807.6.camel@pegasus>
In-Reply-To: <1078623235.2807.6.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403070242.16684.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

On Sunday 07 March 2004 02:33, Marcel Holtmann wrote:
> Hi Wim,
>
> > 	Ah so it means that pand -k does not send anything to the pand that is
> > running .  pand --connect just does something to create the connection.
> >
> > 	If that is the case why doesn't pand without --persist return after the
> > 	connection was established ?
>
> what are you talking about? After pand has established the connection it
> hands it over to the kernel BNEP module and exit.

	I was wondering WHY pand is kept running after the BNEP is set up.
	For the persist option I can understand since i presume pand monitors the
	connection it had to establish and if it 'downs' it restarts it.  However if
	this feature is NOT requested (i.e. no --presist is given), then WHY is pand 
still alive after the setup of the connection.

	The reason for this question is that I was trying to determine a fail safe
	integration into hotplug/interfaces.  Seems that if you pand -k the bnep
	module is deactivated and ifdown does no longer work properly (and hence
	the dhcp server is not stopped properly and does not RELEASE its lease)

	I have noticed something else here.  I am testing BT between my Ipaq and
	a usb BT dongle.  When I suspend my Ipaq the pand on my desktop (the one that
	is listening) blocks on an ioctl after it receives the connection request. (I 
checked with strace on that listening pand)

	The iotcl that blocks is the one in bnep_connadd.  Because of this blocking 
(for I do not know what reason) the connection is not established (no IP is 
set up)

static int bnep_connadd(int sk, uint16_t role, char *dev)
{
        struct bnep_connadd_req req;

        strcpy(req.device, dev);
        req.sock = sk;
        req.role = role;
        /* THIS IS THE ONE THAT BLOCKS */
        if (ioctl(ctl, bnepconnadd, &req))
                return -1;
        strcpy(dev, req.device);
        return 0;
}
	Do you know what that ioctl is supposed to do and why it blocks on something

>
> Regards
>
> Marcel
