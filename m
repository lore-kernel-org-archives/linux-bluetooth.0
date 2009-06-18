Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 18 Jun 2009 08:41:53 +0200
Subject: Recommended asoundrc for bluetooth headset
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E06A506A3@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is there a recommended .asoundrc for use with a bt headset? I've seen at least three versions and would be interested to know which is the "correct" one:

------
pcm.bluetooth {
type bluetooth
device "00:12:EE:A6:1D:F4"
profile "auto"
}

ctl.bluetooth {
type bluetooth
}
-----
pcm.rawbluetooth {
   type bluetooth
   device 00:12:EE:A6:1D:F4
}

pcm.bluetooth {
   type plug
   slave {
      pcm {
         type bluetooth
      }
   }
}
-----
pcm.bluetoothraw {
   type bluetooth
   device 00:12:EE:A6:1D:F4
   profile auto
}

pcm.bluetooth {
   type plug
   slave {
        pcm bluetoothraw
   }
}
-----
