Return-Path: <cyrus@holtmann.org>
Message-ID: <353624.65161.qm@web95411.mail.in2.yahoo.com>
References: <6AC5A55546F64545AE996F8200E3AC4E06A506A3@NL0105EXC01V01.eur.slb.com>
Date: Thu, 18 Jun 2009 12:47:26 +0530 (IST)
From: balaji palaniswami <balaji_palaniswami@yahoo.com>
Subject: Re: Recommended asoundrc for bluetooth headset
To: John Frankish <j-frankish@slb.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06A506A3@NL0105EXC01V01.eur.slb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>






----- Original Message ----
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Sent: Thursday, 18 June, 2009 12:11:53 PM
Subject: Recommended asoundrc for bluetooth headset

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
--
John,
Third  asoundrc is right one, this asoundrc is working for me upto bluez 4.32.
I am upgrading kernel to 2.6.rc8, bluez 4.41  and other depnedencies whatever you mentioned.
then i will update you result of a2dp , headset profile.Inmeanwhile please try 3rd asoundrc ,let me know your result.

Thanks,
Balaji.P
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      Cricket on your mind? Visit the ultimate cricket website. Enter http://cricket.yahoo.com

