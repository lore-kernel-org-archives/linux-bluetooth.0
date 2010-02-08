Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 8 Feb 2010 07:19:03 +0100
Subject: bluez and a2dp sennheiser pcx310 headphones
Message-ID: <6AC5A55546F64545AE996F8200E3AC4E0323A72E4D@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Using the .asoundrc below with bluez-4.53, I've been able to play music to a pair of sennheiser pcx310 headphones without problems, but although the remote volume control on the headphones works, the track skip/fastforward/repeat does not.

According to the headphones manual, the remote controls reply on an avrcp profile - is this something supported by bluez or is it something that should be supported by the audio source (or both)?

Is the .asoundrc file correct for a2dp headphones with remote control?


Regards
John


pcm.!default {
   type plug
   slave.pcm "dmix"
}

ctl.mixer0 {
   type hw
   card 0
}

pcm.bluetooth {
       type bluetooth
       device "00:1B:66:00:31:88"
       profile "auto"
}
