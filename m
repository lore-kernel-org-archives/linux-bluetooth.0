Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 15:01:15 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: 'Ville Tervo' <ville.tervo@nokia.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: EVT_NUM_COMP_PKTS and LE, GATT and SM
Message-ID: <20101207180115.GB4797@eris>
References: <002501cb95a6$b350fc50$19f2f4f0$@org>
 <20101207084704.GY874@null>
 <002b01cb9632$ca3a9840$5eafc8c0$@org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002b01cb9632$ca3a9840$5eafc8c0$@org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On 09:18 Tue 07 Dec, Brian Gix wrote:
> Hi Ville, Vinicius,
> 
> On Tue, Dec 07, 2010 at 12:47 AM -0800, Ville Tervo wrote:
> > Hi Brian,
> > 
> > On Mon, Dec 06, 2010 at 04:35:51PM -0800, ext Brian Gix wrote:
> > > Hi All,
> > >
> > > I've have encountered a problem while using the gatttool, where my
> > write
> > > commands get clobbered by the LE ACL being disconnected prior to the
> > ATT
> > > (fixed channel 4) WRITE_CMD being sent over the LE based ACL link.
> > >
> > > I believe this is fundamentally due to there being no dependency on
> > the
> > > EVT_NUM_COMP_PKTS event when gatttool decides that the WRITE_CMD has
> > been
> > > successfully sent.  There is multiple parts to this.
> > >
> > > 1. In User space, the WRITE_CMD pkt is written to the socket.
> > Gatttool
> > > erroneously considers a successful socket write as completion,
> > disconnects
> > > the socket and exits.
> 
> I would like to try Vinicius' patch that (may) address this, but again
> I do not have access to infradead, although I think gitorious, which
> you used before, was not a problem.
> 

Sorry, I forgot about this problem, please take a look here:

http://gitorious.org/~vcgomes/bluez/vcgomes-bluez


> > >
> > > 2. In Kernel space, the ACL packet is added to an ACL queue, which is
> > > separate from the CMD queue, which can allow either the Disconnect
> > request,
> > > or the ACL packet to be sent over the H4 link to the baseband.
> > >
> > 
> > And in usb case CMD and ACL are even using different endpoints.
> > 
> > > 3. In the baseband, due to LE clocking (and possible other baseband
> > > activity) the ACL packet could be received first, and the Disconnect
> > CMD
> > > second, and still result in the connection being detached prior to Tx
> > of the
> > > ACL packet containing the ATT WRITE_CMD.
> > >
> > > This is not an issue with  any of the ATT READ/FIND/MTU or WRITE_REQ
> > > transactions, because they require a response from the server.  I
> > believe
> > > for ATT, this problem is restricted to the WRITE_CMD only, due to
> > it's
> > > unacknowledged nature.
> > 
> > True.
> > 
> > > However, this will also be an issue with the LE Security Manager,
> > because as
> > > stated in the Core Spec v4.0, Vol 3, in the last paragraph of 3.6.1
> > Key
> > > Distribution on page 630 (of 656):
> > >
> > > 	> Key distribution is complete in the device sending the final
> > key
> > > when it receives
> > > 	> the baseband acknowledgement for that key and is complete in
> > the
> > > receiving
> > > 	> device when it receives the final key being distributed.
> > >
> > > This is intended to prevent exactly the kind of problem I am
> > experiencing
> > > with the ATT WRITE_CMD, and the acknowledgement from the baseband can
> > only
> > > be the EVT_NUM_COMP_PKTS event.
> > >
> > > While talking to my colleagues here, we were thinking that the
> > cleanest
> > > method to get this accomplished would be by using the "select" method
> > with
> > > the ATT socket, where the socket could be marked as non-writable by
> > the
> > > kernel driver until the EVT_NUM_COMP_PKTS is received. The User space
> > code
> > > could then wait for the socket to become writeable before issuing the
> > socket
> > > disconnect.
> > >
> > 
> > How about implement waiting on l2cap_sock_shutdown() like for ERTM.
> > User space
> > could then call shutdown() before closing the socket so make sure the
> > data is
> > sent or timeout occurred.
> 
> If I understand l2cap_sock_shutdown() correctly, then I think this
> is the correct solution.  The socket mode would be BASIC, and the
> channel (dcid) would be fixed-4 (or perhaps fixed-5 or fixed-6 as well),
> but instead of waiting for an ack, it would be waiting on the
> EVT_NUM_COMP_PKTS, that indicates the number of outstanding ACL packets
> on the connection is Zero, with the rest of the logic unchanged.
> 
> 
> > 
> > Would this be enough to solve the problem?
> > 
> > > If the Security manager is totally within the kernel, it probably
> > does not
> > > have to do as much work, however it does still need to wait on the
> > > EVT_NUM_COMP_PKTS before disconnecting the remote device.
> > >
> > > Has anybody else observed this issue with ATT WRITE_CMD? It could be
> > getting
> > > exacerbated by slow (115Kbps) H4 links that I am using, however the
> > hcidump
> > > tool confirms that the disconnect happens prior to the
> > EVT_NUM_COMP_PKTS.
> > 
> > I have seen this problem but didn't dig it deeper.
> > 
> > --
> > Ville
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-- 
Vinicius
