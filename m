Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 18 May 2011 17:03:47 +0800
Message-ID: <BANLkTi=V_s9UjZ19qk-jivF=0wzPk9XYbA@mail.gmail.com>
Subject: bluez patch : Modify OPUSH sdp record when use sdptool for GOEP v2.0
From: hui li <nami.li1984@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc: "haijun.liu" <haijun.liu@atheros.com>, steven.li@atheros.com,
	ruiyi.zhang@atheros.com, yang.wu@atheros.com,
	costa.yao@atheros.com, nami.li@atheros.com
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, all
 Since GOEP v2.0 has some changes in sdp record, I`d like to add the
two changes in bluez for backwards compatibility with GOEP v1.x:
• The profile version number in the BluetoothProfileDescriptorList
attribute shall be incremented to match the version number of the
enhanced profile specification. If earlier versions of the profile do
not include this SDP attribute it shall be included in revised
versions.
• The SDP records shall include the GoepL2capPsm attribute.

The upper text references Generic Object Exchange Profile v2.0.
The GoepL2capPsm attribute value can be found in Bluetooth SIG
Assigned Numbers – Service Discovery, and this value is 0x0200.

My patch only define GoepL2capPsm and change OPUSH sdp record in
sdptool. I didn`t assign a new variable in svc_info_t struct to
indicate the new l2cap psm value, I used its original psm member to
indicate l2cap psm value.
Also, I didn`t found OPUSH l2cap psm default value in Bluetooth SIG
Assigned Numbers or its spec, so I just choose 0x1015 as its default
value.

I will send my patch later.

Best wishes.
Nami
