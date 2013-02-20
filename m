Return-Path: <cyrus@holtmann.org>
From: Randy Yates <yates@digitalsignallabs.com>
To: linux-bluetooth@vger.kernel.org
Subject: Controlling Bluetooth RF Transmit Power Level in the WL1271L (tiwi-ble)
Date: Tue, 19 Feb 2013 22:02:45 -0500
Message-ID: <871ucbznze.fsf@randy.site>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm including this message here in case there is anyone on
the list with this expertise. I would sure appreciate any
help.

--randy


Note the message below was also posted in TI's E2E forum:

  http://e2e.ti.com/support/low_power_rf/f/307/t/246713.aspx

I am using the LS Research tiwi-ble, which is based on TI's WL1271L,
and need to set the RF output power, over all modulation schemes and
operating modes, to a specific level, for example, -32 dBm. 

Can someone please provide the EXACT steps to accomplish this? 

Here is what I have tried (but has not worked). Note the document
containing the vendor-specific HCI commands for the WL1271L is
available here: http://www.digitalsignallabs.com/hci-vs-commands.pdf

  1. Based on Gustav's suggestions here, 

     http://e2e.ti.com/support/low_power_rf/f/307/t/136165.aspx

  I tried issuing a triplet of the HCI_VS_DRPb_Set_Power_Vector
  (0xFD82) command (once for each modulation type) as follows
  (in hex):

    fd82 0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 ff 0 0 
    fd82 1 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 ff 0 0 
    fd82 2 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 c0 ff 0 0 

  The idea is that if we set each of the 16 power levels to the same
  power, the automatic power control algorithm will essentially be
  disabled.

  2. I tried issuing the triplet above followed by the
  HCI_VS_DRPb_Set_Class2_Single_Power (0xFD87) as follows:

    fd87 07 07 07

  Note that index 7 was chosen arbitrarily since all power levels are
  identical in the power vector.

  3. I tried issuing the triplet in 1 followed by a reset (see reset
  code below).

  4. I tried issuing the triplet in 1 followed by the
  HCI_VS_DRPb_Set_Class2_Single_Power command in 2 followed by a
  reset.

  5. I tried each of these in various startup sequence orders of
  bluetoothd and bluetoothctl. 

Note I am running under TI's Arago distribution for linux using kernel
version 3.7.4 and bluez library 5.2 on a BeagleBoard XM (bbxm) and
using the com6l-adapter and com6l-ble boards.

I tested by using bluetoothctl (a CLI utility provided by the bluez
5.2 library) to place the bbxm in scan and enabling discovery on an LG
LGL35G (running Android 2.3.6), with the phone about 30 feet from the
bbxm. I assumed that at this power level and distance the phone would
not "hear" the bbxm's discovery inquiries and the phone would not be
discovered, but it was being discovered.

Code
----

I am using my own hci_cmd() function to send the vendor-specific hci
commands as follows. Note that I have successfully used this command
to set the bdaddr (HCI_VS_Write_BD_Addr (0xFC06)), so I believe the
function is working properly.

  uint8_t hci_cmd(uint8_t ogf, uint16_t ocf, uint32_t payloadLength, uint8_t* payload)
  {
    int dev_id;
    int dd;
    unsigned char buf[HCI_MAX_EVENT_SIZE];
    struct hci_filter flt;
    uint16_t n;
  
    /* print the message */
    fprintf(stdout, "%x ", ((ogf << 10) | ocf));
    for (n = 0; n < payloadLength; n++)
    {
      fprintf(stdout, "%x ", *(payload + n));
    }
    fprintf(stdout, "\n");
  
    /* open the device */
  
    dev_id = hci_get_route(NULL);
    if (dev_id < 0)
    {
      fprintf(stderr, "Device is not available or not connected.\n");
      return 1;
    }
  
    dd = hci_open_dev(dev_id);
    if (dd < 0)
    {
      fprintf(stderr, "Could not open device ID %d.\n", dev_id);
      return 1;
    }
  
    /* set a filter */
  
    /* why do we need to set a filter? (copied from hcitool.c, cmd_cmd function) */    
    hci_filter_clear(&flt);
    hci_filter_set_ptype(HCI_EVENT_PKT, &flt);
    hci_filter_all_events(&flt);
    if (setsockopt(dd, SOL_HCI, HCI_FILTER, &flt, sizeof(flt)) < 0) 
    {
      fprintf(stderr, "HCI filter setup failed\n");
      return 1;
    }
  
    /* send the hci command */
    if (hci_send_cmd(dd, ogf, ocf, payloadLength, payload) < 0)
    {
      fprintf(stderr, "Error sending hci cmd, ogf = %x, ocf = %x\n", ogf, ocf);
      return 1;
    }
  
    read(dd, buf, sizeof(buf));
    hci_close_dev(dd);
    return 0;
  }

Here is the reset code:

  uint8_t bt_reset(void)
  {
    int ctl;
    static struct hci_dev_info di;
  
    /* Open HCI socket  */
    if ((ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI)) < 0) {
      fprintf(stderr, "Can't open HCI socket.\n");
      return 1;
    }
  
    di.dev_id = 0;
  
    if (ioctl(ctl, HCIGETDEVINFO, (void *) &di))
    {
      fprintf(stderr, "Can't get device info\n");
      return 1;
    }
  
    if (hci_test_bit(HCI_RAW, &di.flags) && !bacmp(&di.bdaddr, BDADDR_ANY)) 
    {
      int dd = hci_open_dev(di.dev_id);
      hci_read_bd_addr(dd, &di.bdaddr, 1000);
      hci_close_dev(dd);
    }
  
    /* stop HCI device */
    if (ioctl(ctl, HCIDEVDOWN, di.dev_id) < 0) 
    {
      fprintf(stderr, "Can't down device hci%d: %s (%d)\n", di.dev_id, strerror(errno), errno);
      exit(1);
    }
  
    /* Start HCI device */
    if (ioctl(ctl, HCIDEVUP, di.dev_id) < 0) 
    {
      if (errno != EALREADY)
      {
        fprintf(stderr, "Can't init device hci%d: %s (%d)\n", di.dev_id, strerror(errno), errno);
        return 1;
      }
    }
  
    close(ctl);
    return 0;
  }

Any help or pointers would be greatly appreciated.

--Randy

-- 
Randy Yates
Digital Signal Labs
http://www.digitalsignallabs.com
