Return-Path: <cyrus@holtmann.org>
Message-ID: <4AA1533D.7090505@charter.net>
Date: Fri, 04 Sep 2009 13:49:49 -0400
From: Peter Hurley <phurley@charter.net>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@nokia.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [4.48] SDP Discovery not reset on error
References: <4AA08357.7050903@charter.net> <20090904063104.GA23278@jh-x301> <4AA13234.5060909@charter.net> <20090904155536.GA5889@jh-x301>
In-Reply-To: <20090904155536.GA5889@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan Hedberg wrote:
> Hi Peter,
>
> On Fri, Sep 04, 2009, Peter Hurley wrote:
>   
>> I hadn't moved to 4.52 yet because I'm still trying to track down what I
>> think is a race condition in avdtp.
>>     
>
> Actually that should be an even more important reason to move to 4.52
> since there's at least one AVDTP race condition fix there.
>
> Johan
>
>   
Maybe.  The race I'm observing may have something to do with your 
auth_cb fix (tbh, I don't fully understand the sequence avdtp_confirm_cb 
-> avdtp_connect_cb -> session_cb and how auth_cb fits in).

Here's the daemon log (notice the "Transport endpoint is not connected 
(107)" errors):

Sep  4 07:30:04 dev-wkstn bluetoothd[2713]: link_key_request 
(sba=00:07:61:A0:08:9B, dba=00:0D:FD:1E:99:30)
Sep  4 07:30:04 dev-wkstn bluetoothd[2713]: kernel auth requirements = 0x00
Sep  4 07:30:04 dev-wkstn bluetoothd[2713]: stored link key type = 0x00
Sep  4 07:30:04 dev-wkstn bluetoothd[2713]: 
adapter_get_device(00:0D:FD:1E:99:30)
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: 
hcid_dbus_bonding_process_complete: status=00
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: 
adapter_get_device(00:0D:FD:1E:99:30)
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: 
hcid_dbus_bonding_process_complete: no pending auth request
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: State changed 
/org/bluez/2713/hci0/dev_00_0D_FD_1E_99_30: HEADSET_STATE_DISCONNECTED 
-> HEADSET_STATE_CONNECT_IN_PROGRESS
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: 
/org/bluez/2713/hci0/dev_00_0D_FD_1E_99_30: Connected to 00:0D:FD:1E:99:30
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: telephony-dummy: device 
0x7fd0c11d4230 connected
Sep  4 07:30:05 dev-wkstn bluetoothd[2713]: State changed 
/org/bluez/2713/hci0/dev_00_0D_FD_1E_99_30: 
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_ref(0x7fd0c11c9f50): ref=2
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_ref(0x7fd0c11c9f50): ref=3
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
ref=2
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Received AT+CKPD=200
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: telephony-dummy: got key 
press request for 200
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: AVDTP: incoming connect from 
00:0D:FD:1E:99:30
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: AVDTP: connected signaling 
channel to 00:0D:FD:1E:99:30
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: AVDTP imtu=672, omtu=895
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: send: Transport endpoint is 
not connected (107)
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: session_cb
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Received DISCOVER_CMD
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: send: Transport endpoint is 
not connected (107)
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Unable to handle command. 
Disconnecting
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: Disconnected from 
00:0D:FD:1E:99:30
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
ref=1
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: connect:connect XCASE detected
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
ref=0
Sep  4 07:30:06 dev-wkstn bluetoothd[2713]: avdtp_unref(0x7fd0c11c9f50): 
freeing session and removing from list
Sep  4 07:30:09 dev-wkstn bluetoothd[2713]: Stream setup failed, after 
XCASE connect:connect

If this is related to the auth_cb fix, would you please explain how?

Regards,
Peter
