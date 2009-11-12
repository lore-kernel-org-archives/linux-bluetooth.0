Return-Path: <cyrus@holtmann.org>
Message-ID: <837446.30282.qm@web111403.mail.gq1.yahoo.com>
Date: Thu, 12 Nov 2009 12:56:57 -0800 (PST)
From: Mark Stanovich <stanmj@yahoo.com>
Subject: Re: Simultaneous outgoing audio streams
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mark Stanovich wrote:


> Maybe as you mentioned it is requesting another SCO connection and prevented 
> from creating one with another device?  I will try to dig deeper and see where 

Looking at the output again, I get something different, with a sco_bind: Address already in use error.  I guess this indicates that there can be only one SCO connection at a time?

bluetoothd[13455]: Accepted new client connection on unix socket (fd=22)
bluetoothd[13455]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[13455]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[13455]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[13455]: open sco - object=ANY source=ANY destination=00:18:13:87:3D:BF lock=write
bluetoothd[13455]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[13455]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[13455]: State changed /org/bluez/13455/hci0/dev_00_18_13_87_3D_BF: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[13455]: link_key_request (sba=00:11:67:00:00:00, dba=00:18:13:87:3D:BF)
bluetoothd[13455]: kernel auth requirements = 0x00
bluetoothd[13455]: stored link key type = 0x00
bluetoothd[13455]: adapter_get_device(00:18:13:87:3D:BF)
bluetoothd[13455]: Discovered Handsfree service on channel 2
bluetoothd[13455]: /org/bluez/13455/hci0/dev_00_18_13_87_3D_BF: Connecting to 00:18:13:87:3D:BF channel 2
bluetoothd[13455]: /org/bluez/13455/hci0/dev_00_18_13_87_3D_BF: Connected to 00:18:13:87:3D:BF
bluetoothd[13455]: Received AT+BRSF=24
bluetoothd[13455]: HFP HF features: "Voice recognition activation" "Remote volume control" 
bluetoothd[13455]: Received AT+CIND=?
bluetoothd[13455]: Received AT+CIND?
bluetoothd[13455]: Received AT+CMER=3, 0, 0, 1
bluetoothd[13455]: Event reporting (CMER): mode=3, ind=1
bluetoothd[13455]: HFP Service Level Connection established
bluetoothd[13455]: telephony-dummy: device 0xb916fb68 connected
bluetoothd[13455]: State changed /org/bluez/13455/hci0/dev_00_18_13_87_3D_BF: HEADSET_STATE_CONNECTING -> HEADSET_STATE_CONNECTED
bluetoothd[13455]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[13455]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[13455]: sco_bind: Address already in use (98)
bluetoothd[13455]: start_resume: resume failed
bluetoothd[13455]: sending error Input/output error(5)
bluetoothd[13455]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[13455]: Unix client disconnected (fd=22)
bluetoothd[13455]: client_free(0xb91691f8)
bluetoothd[13455]: Received AT+VGS=09
bluetoothd[13455]: Received AT*SEAUDIO=4,4022
bluetoothd[13455]: Badly formated or unrecognized command: AT*SEAUDIO=4,4022
bluetoothd[13455]: Received AT*SEAM="HBH-PV705",13
bluetoothd[13455]: Badly formated or unrecognized command: AT*SEAM="HBH-PV705",13
bluetoothd[13455]: Received AT*SEABS=0
bluetoothd[13455]: Badly formated or unrecognized command: AT*SEABS=0
bluetoothd[13455]: telephony-dummy: device 0xb916fb68 disconnected
bluetoothd[13455]: State changed /org/bluez/13455/hci0/dev_00_18_13_87_3D_BF: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED



      
