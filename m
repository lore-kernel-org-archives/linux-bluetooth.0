Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ohad Ben-Cohen <ohad@bencohen.org>
In-Reply-To: <bd5b16740705040630o58f22ddfi39b6399092c1677a@mail.gmail.com>
References: <200704301140.46336.ohad@bencohen.org>
	<1178261528.25425.38.camel@violet>
	<bd5b16740705040630o58f22ddfi39b6399092c1677a@mail.gmail.com>
Date: Fri, 04 May 2007 16:30:50 +0200
Message-Id: <1178289050.25425.50.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH 2.6.21] Bluetooth: add support for TI's
	HCILL UART	protocol
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ohad,

> > please explain the usefulness of HCIUARTGETDEVICE to me.
> 
> Most of the initializing commands should be (and thus are) sent normally,
> before the new device is added (and notification is sent to hcid).
> 
> But, there is one initialization command (deep sleep configuration),
> which must be sent _after_ the HCILL protocol is set.
> 
> This command is signalling the device that it can start initiating deep sleep.
> The device may immediate request to do so, so the HCILL protocol must
> already be there to receive this request.
> 
> That's why I let hciattach do its HCIUARTSETPROTO, and only then
> I send the remaining init commands.
> 
> But, at this stage, in order to send commands to the device,
> I must use Bluez' sockets interface, and for that I must know the device
> number (for hci_open_dev).
> 
> In order to be able to easily know the hci device number, I have
> added HCIUARTGETDEVICE.
> 
> If there's a better way of knowing the hci device number please tell me.

this sounds reasonable and could be useful for other transport protocols
as well. Please create a separate patch for it, because it has nothing
to do with the HCILL support.

However I have some concerns when hcid autoinits devices and you send
extra commands at the same time. They get queued inside the kernel, but
it make produce dead locks for some chips. I have to play a little bit
with it, but the general idea is not bad.

> > And the ll_dbg_data() has to go away. On LKML they discussing a generic
> > hexdump function. I could accept the usage of that, but no crazy own
> > debug routine in the kernel code.
> 
> Of course :)
> I am aware of Randy's hexdumper, and once it will be merged I will make
> use of it.

Until it is merged, this has to go away.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
