Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EDEF901A-564A-4532-B291-61F0CCDB9BFD@holtmann.org>
References: <1374078638-3248-1-git-send-email-syamsidhardh@gmail.com>
	<EDEF901A-564A-4532-B291-61F0CCDB9BFD@holtmann.org>
Date: Wed, 24 Jul 2013 22:08:29 +0530
Message-ID: <CAFBvHid+Ff=wn0bz8m-fK8=o1YWNPu_pBSuRizadGi8nK3WpNg@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] Bluetooth: Fix ACL alive for long in case of non
 pariable devices
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: User Name <linux-bluetooth@vger.kernel.org>, Syam Sidhardhan <s.syam@samsung.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 17, 2013 at 10:10 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Syam,
>
>> For certain devices (ex: HID mouse), support for authentication,
>> pairing and bonding is optional. For such devices, the ACL alive
>> for too long after the L2CAP disconnection.
>>
>> To avoid the ACL alive for too long after L2CAP disconnection, reset the ACL
>> disconnect timeout back to HCI_DISCONN_TIMEOUT when L2CAP is connected.
>>
>> While merging the commit id:a9ea3ed9b71cc3271dd59e76f65748adcaa76422
>> this issue might have introduced.
>>
>> Signed-off-by: Sang-Ki Park <sangki79.park@samsung.com>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> ---
>> v1 -> Modified the code as per the latest code.
>> v2 -> Add descriptive comment as per Marcel request.
>>
>> net/bluetooth/l2cap_core.c |    9 +++++++++
>> 1 file changed, 9 insertions(+)
>
While testing this patch more with a remote non SSP device, we have noticed that
when the remote device is busy with entering the pin key(over a UI),
we are initiating
a HCI disconnection exactly after 4 seconds. This happens because
l2cap_conn_ready()
is getting called from multiple locations (ex:hci_remote_ext_features_evt() ->
hci_proto_connect_cfm() -> l2cap_connect_cfm()->l2cap_conn_ready()) and the
disconnect timeout is reseted to 2 seconds.

As Szymon mentioned, we have to apply the reset logic during
l2cap_connect_req(), not in l2cap_le_conn_ready(). After this modification
its working fine. I'll soon send an another patchset version.

Regards,
Syam
