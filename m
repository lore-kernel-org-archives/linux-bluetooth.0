Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2
	devices?
From: Marcel Holtmann <marcel@holtmann.org>
To: albert@csail.mit.edu
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ef9938ec041012125930f0b8e3@mail.gmail.com>
References: <ef9938ec041012125930f0b8e3@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1097658003.4643.17.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 13 Oct 2004 11:00:03 +0200

Hi Albert,

> I'd like to use bluez to perform a device inquiry with RSSI using a
> bluetooth 1.2 device.  Currently, I'm using an Anycom USB-120
> bluetooth adapter with the latest firmware installed.
> 
> I want to check the inquiry mode of the bluetooth device first and
> then change it if needed.  Based on my reading of the bluez headers
> and the bluetooth spec, this is what I came up with.
> 
>         // first read the current mode and see if we need to change it
>         {
>             struct hci_request req;
>             char raw_rp[EVT_CMD_COMPLETE_SIZE + READ_INQUIRY_MODE_RP_SIZE];
>             read_inquiry_mode_rp *rp;
> 
>             req.ogf = OGF_LINK_CTL;
>             req.ocf = OCF_READ_INQUIRY_MODE;
>             req.cparam = 0;
>             req.clen = 0;
>             req.rparam = &raw_rp;
>             req.rlen = READ_INQUIRY_MODE_RP_SIZE;
> 
>             err = hci_send_req( sock, &req, 0 );
>             if( err ) {
>                 if( errno == EPERM ) {
>                     fprintf(stderr, "permission denied while reading inquiry "
>                             "mode.  Are you sure you're superuser?\n");
>                 }
>                 return -1;
>             }
> 
>             rp = (read_inquiry_mode_rp*)(raw_rp + EVT_CMD_COMPLETE_SIZE);
>             if( rp->status != 0 ) {
>                 fprintf(stderr, "error 0x%x reading inquiry mode\n", 
>                         rp->status);
>                 return -1;
>             }
>             change_inquiry_mode = (! rp->mode);
> 
>             fprintf(stderr, "done reading inquiry mode.  %s to set\n",
>                     change_inquiry_mode?"Need":"Do not need");
>         }
> 
>         // set the inquiry mode (use RSSI or not) if needed
>         if( change_inquiry_mode )
>         {
>             write_inquiry_mode_cp wim_cp;
>             struct hci_request req;
>             char raw_rp[EVT_CMD_COMPLETE_SIZE + WRITE_INQUIRY_MODE_RP_SIZE];
>             write_inquiry_mode_rp *rp;
>             wim_cp.mode = do_inquiry_with_rssi;
> 
>             req.ogf = OGF_LINK_CTL;
>             req.ocf = OCF_WRITE_INQUIRY_MODE;
>             req.event = EVT_CMD_COMPLETE;
>             req.cparam = &wim_cp;
>             req.clen = WRITE_INQUIRY_MODE_CP_SIZE;
>             req.rparam = &raw_rp;
>             req.rlen = EVT_CMD_COMPLETE_SIZE + WRITE_INQUIRY_MODE_RP_SIZE;
> 
>             err = hci_send_req( sock, &req, 0 );
>             if( err ) { 
>                 fprintf(stderr, "error while setting inquiry mode.  errno %d\n",
>                         errno);
>                 perror("hci_send_cmd"); 
>                 return -1;
>             }
> 
>             rp = (write_inquiry_mode_rp*)(raw_rp + EVT_CMD_COMPLETE_SIZE);
>             if( rp->status != 0 ) {
>                 fprintf(stderr, "error 0x%x setting inquiry mode\n",
>                         rp->status);
>                 return -1;
>             }
> 
>             fprintf(stderr, "Done setting inquiry mode\n");
>         }
> 
> My first question is - is this the correct way to do it?

looks like it is correct. Send me a patch for the Bluetooth library to
include this as API functions.

> When I run this with the anycom bluetooth device, the very first
> hci_send_req never returns.  I expected the READ_INQUIRY_MODE command
> to generate a CMD_COMPLETE event, but no event is ever generated (I
> tested this separately).  Also, when hcidump is run concurrently with
> this program, it doesn't pick anything up (no events are read by
> hcidump)  The same happens if I try to set the inquiry mode directly
> without reading it first (the WRITE_INQUIRY_MODE command never
> returns)

I never saw that on my dongle. Please recompile your kernel without the
SCO audio support for the hci_usb driver. What kind of USB host
controller are you using? What kernel version do you use?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
