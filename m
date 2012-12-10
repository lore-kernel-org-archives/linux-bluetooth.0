Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] HCI commands flow fix
Date: Mon, 10 Dec 2012 15:08:44 +0100
Message-ID: <1355148525-29379-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm seeing issues with some of BT dongles. With mgmt interface this results
in not being able to further communicate with chip due to state mismatch in
kernel e.g. kernel is replying busy for every command that could update CoD.
This can be quite easy reproduced by quickly restarting bluetoothd.

This patch fix 1 issue noticed: sending new commands before CC for reset
is received.

This makes things better on my PC but...

There is still a window for getting stuck: when closing device kernel is not
waiting for last command to complete and (depending on command) this sometimes
(but less frequent comparing to command-reply mismatch without this patch)
result in getting into wrong state and chip stops responding (or maybe commands
don't get to chip..?):

< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241  [hci0] 2078.141360
        FEC: Not required (0x00)
        Name (complete): uw000953
        16-bit Service UUIDs (complete): 0x1801 0x1800 
> HCI Event: Command Complete (0x0e) plen 4                            [hci0] 2078.143329
      Write Extended Inquiry Response (0x03|0x0052) ncmd 1
        Status: Success (0x00)
< HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241  [hci0] 2078.188088
        FEC: Not required (0x00)
        Name (complete): uw000953
        16-bit Service UUIDs (complete): 0x1800 
@ New Settings: 0x00d2
            connectable pairable ssp br/edr 
@ Local Name Changed: uw000953 ()
< HCI Command: Reset (0x03|0x0003) plen 0                              [hci0] 2078.445154
@ Local Name Changed: uw000953 ()
@ Local Name Changed: uw000953 ()

bluetoothd[28619]: Bluetooth Management interface initialized
bluetoothd[28619]: hci0: Set Powered (0x0005) failed: Busy (0x0a)

hciconfig hci0 up
Can't init device hci0: Connection timed out (110)

So, maybe (along with this patch) kernel should not discard last sent command on close but
wait for CC (or tx TO)?

Any comments on how this could be solved are welcome.

Szymon Janc (1):
  Bluetooth: Don't send new commands before CC for reset is received

 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5

