Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec041012125930f0b8e3@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
Reply-To: albert@csail.mit.edu
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-devel] how to do inquiry with RSSI in bluetooth 1.2 devices?
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
Date: Tue, 12 Oct 2004 15:59:31 -0400

I'd like to use bluez to perform a device inquiry with RSSI using a
bluetooth 1.2 device.  Currently, I'm using an Anycom USB-120
bluetooth adapter with the latest firmware installed.

I want to check the inquiry mode of the bluetooth device first and
then change it if needed.  Based on my reading of the bluez headers
and the bluetooth spec, this is what I came up with.

        // first read the current mode and see if we need to change it
        {
            struct hci_request req;
            char raw_rp[EVT_CMD_COMPLETE_SIZE + READ_INQUIRY_MODE_RP_SIZE];
            read_inquiry_mode_rp *rp;

            req.ogf = OGF_LINK_CTL;
            req.ocf = OCF_READ_INQUIRY_MODE;
            req.cparam = 0;
            req.clen = 0;
            req.rparam = &raw_rp;
            req.rlen = READ_INQUIRY_MODE_RP_SIZE;

            err = hci_send_req( sock, &req, 0 );
            if( err ) {
                if( errno == EPERM ) {
                    fprintf(stderr, "permission denied while reading inquiry "
                            "mode.  Are you sure you're superuser?\n");
                }
                return -1;
            }

            rp = (read_inquiry_mode_rp*)(raw_rp + EVT_CMD_COMPLETE_SIZE);
            if( rp->status != 0 ) {
                fprintf(stderr, "error 0x%x reading inquiry mode\n", 
                        rp->status);
                return -1;
            }
            change_inquiry_mode = (! rp->mode);

            fprintf(stderr, "done reading inquiry mode.  %s to set\n",
                    change_inquiry_mode?"Need":"Do not need");
        }

        // set the inquiry mode (use RSSI or not) if needed
        if( change_inquiry_mode )
        {
            write_inquiry_mode_cp wim_cp;
            struct hci_request req;
            char raw_rp[EVT_CMD_COMPLETE_SIZE + WRITE_INQUIRY_MODE_RP_SIZE];
            write_inquiry_mode_rp *rp;
            wim_cp.mode = do_inquiry_with_rssi;

            req.ogf = OGF_LINK_CTL;
            req.ocf = OCF_WRITE_INQUIRY_MODE;
            req.event = EVT_CMD_COMPLETE;
            req.cparam = &wim_cp;
            req.clen = WRITE_INQUIRY_MODE_CP_SIZE;
            req.rparam = &raw_rp;
            req.rlen = EVT_CMD_COMPLETE_SIZE + WRITE_INQUIRY_MODE_RP_SIZE;

            err = hci_send_req( sock, &req, 0 );
            if( err ) { 
                fprintf(stderr, "error while setting inquiry mode.  errno %d\n",
                        errno);
                perror("hci_send_cmd"); 
                return -1;
            }

            rp = (write_inquiry_mode_rp*)(raw_rp + EVT_CMD_COMPLETE_SIZE);
            if( rp->status != 0 ) {
                fprintf(stderr, "error 0x%x setting inquiry mode\n",
                        rp->status);
                return -1;
            }

            fprintf(stderr, "Done setting inquiry mode\n");
        }

My first question is - is this the correct way to do it?

When I run this with the anycom bluetooth device, the very first
hci_send_req never returns.  I expected the READ_INQUIRY_MODE command
to generate a CMD_COMPLETE event, but no event is ever generated (I
tested this separately).  Also, when hcidump is run concurrently with
this program, it doesn't pick anything up (no events are read by
hcidump)  The same happens if I try to set the inquiry mode directly
without reading it first (the WRITE_INQUIRY_MODE command never
returns)

Here's the information that bluez gets out of the bluetooth adapter
# hciconfig -a hci1 features
hci1:   Type: USB
        BD Address: 00:0B:0D:30:0A:99 ACL MTU: 120:20  SCO MTU: 64:0
        Features: 0xff 0xff 0x05 0x78 0x18 0x10 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset> 
                <timing accuracy> <role switch> <hold mode> <sniff mode> 
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets> 
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control> 
                <enhanced iscan> <interlaced iscan> <interlaced pscan> 
                <inquiry with RSSI> <AFH cap. slave> <AFH class. sla
# hciconfig -a hci1
hci1:   Type: USB
        BD Address: 00:0B:0D:30:0A:99 ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:1205 acl:0 sco:0 events:31 errors:0
        TX bytes:324 acl:0 sco:0 commands:18 errors:0
        Features: 0xff 0xff 0x05 0x78 0x18 0x10 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
Can't read local name on hci1. Connection timed out(110)


Any and all help is appreciated.  Thanks!

-albert


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
