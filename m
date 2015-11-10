Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add support for controller specific logging
In-Reply-To: <40620A11-64EA-4FA8-AF37-31BE1E0B6BC4@holtmann.org>
References: <1446944462-5512-1-git-send-email-marcel@holtmann.org> <87ziynhuq9.fsf@intel.com> <40620A11-64EA-4FA8-AF37-31BE1E0B6BC4@holtmann.org>
Date: Tue, 10 Nov 2015 10:53:09 -0200
Message-ID: <87r3jyhv7u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Vinicius,
>
>>> To enable controller specific logging, the userspace daemon has to have
>>> the ability to log per controller. To facilitate this support, provide
>>> a dedicated logging channel. Messages in this channel will be included
>>> in the monitor queue and with that also forwarded to monitoring tools
>>> along with the actual hardware traces.
>>>
>>> All messages from the logging channel are timestamped and with that
>>> allow an easy correlation between userspace messages and hardware
>>> events. This will increase the ability to debug problems faster.
>>>
>>
>> Awesome!
>>
>> I was trying to find some time to implement this idea.
>>
>> Looks good. Just a minor comment.
>>
>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>> ---
>>> include/net/bluetooth/hci_mon.h  |   1 +
>>> include/net/bluetooth/hci_sock.h |   1 +
>>> net/bluetooth/hci_sock.c         | 102 +++++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 104 insertions(+)
>>>
>>> diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
>>> index c91bb23eb29e..587d0131b349 100644
>>> --- a/include/net/bluetooth/hci_mon.h
>>> +++ b/include/net/bluetooth/hci_mon.h
>>> @@ -44,6 +44,7 @@ struct hci_mon_hdr {
>>> #define HCI_MON_INDEX_INFO	10
>>> #define HCI_MON_VENDOR_DIAG	11
>>> #define HCI_MON_SYSTEM_NOTE	12
>>> +#define HCI_MON_USER_LOGGING	13
>>>
>>> struct hci_mon_new_index {
>>> 	__u8		type;
>>> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci_sock.h
>>> index 9a46d665c1b5..8e9138acdae1 100644
>>> --- a/include/net/bluetooth/hci_sock.h
>>> +++ b/include/net/bluetooth/hci_sock.h
>>> @@ -45,6 +45,7 @@ struct sockaddr_hci {
>>> #define HCI_CHANNEL_USER	1
>>> #define HCI_CHANNEL_MONITOR	2
>>> #define HCI_CHANNEL_CONTROL	3
>>> +#define HCI_CHANNEL_LOGGING	4
>>>
>>> struct hci_filter {
>>> 	unsigned long type_mask;
>>> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
>>> index c976f9da96c0..80b8d3e7dfb5 100644
>>> --- a/net/bluetooth/hci_sock.c
>>> +++ b/net/bluetooth/hci_sock.c
>>> @@ -906,6 +906,18 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
>>> 		atomic_inc(&monitor_promisc);
>>> 		break;
>>>
>>> +	case HCI_CHANNEL_LOGGING:
>>> +		if (haddr.hci_dev != HCI_DEV_NONE) {
>>> +			err = -EINVAL;
>>> +			goto done;
>>> +		}
>>> +
>>> +		if (!capable(CAP_NET_ADMIN)) {
>>> +			err = -EPERM;
>>> +			goto done;
>>> +		}
>>> +		break;
>>> +
>>> 	default:
>>> 		if (!hci_mgmt_chan_find(haddr.hci_channel)) {
>>> 			err = -EINVAL;
>>> @@ -1033,6 +1045,9 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
>>> 	if (flags & MSG_OOB)
>>> 		return -EOPNOTSUPP;
>>>
>>> +	if (hci_pi(sk)->channel == HCI_CHANNEL_LOGGING)
>>> +		return -EOPNOTSUPP;
>>> +
>>> 	if (sk->sk_state == BT_CLOSED)
>>> 		return 0;
>>>
>>> @@ -1179,6 +1194,90 @@ done:
>>> 	return err;
>>> }
>>>
>>> +static int hci_logging_frame(struct sock *sk, struct msghdr *msg, int len)
>>> +{
>>> +	struct hci_mon_hdr *hdr;
>>> +	struct sk_buff *skb;
>>> +	struct hci_dev *hdev;
>>> +	u16 index;
>>> +	int err;
>>> +
>>> +	/* The logging frame consists at minimum of the standard header,
>>> +	 * the priority byte, the ident length byte and at least one string
>>> +	 * terminator NUL byte. Anything shorter are invalid packets.
>>> +	 */
>>> +	if (len < sizeof(*hdr) + 3)
>>> +		return -EINVAL;
>>> +
>>> +	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
>>> +	if (!skb)
>>> +		return err;
>>> +
>>> +	if (memcpy_from_msg(skb_put(skb, len), msg, len)) {
>>> +		err = -EFAULT;
>>> +		goto drop;
>>> +	}
>>> +
>>> +	hdr = (void *)skb->data;
>>> +
>>> +	if (__le16_to_cpu(hdr->len) != len - sizeof(*hdr)) {
>>> +		err = -EINVAL;
>>> +		goto drop;
>>> +	}
>>> +
>>> +	if (__le16_to_cpu(hdr->opcode) == 0x0000) {
>>> +		__u8 priority = skb->data[sizeof(*hdr)];
>>> +		__u8 ident_len = skb->data[sizeof(*hdr) + 1];
>>> +
>>
>> Considering that the maximum size of a device's name is 248, I would
>> feel better if 16 bits were used.
>
> check man syslog and see what an ident field is. I am expecting users to set it to the process name. So something like bluetoothd. At least this is what bluetoothd is doing right now. The max length of a message is actually 0xffff - ident_len - 2. You can set the ident_len to zero and use no ident.
>

Great. My bad.

> The reason why I split ident our from the message is that I want to keep it separate. Having userspace build the ident into the message did not really work well when you actually later on wanted to filter or analyze the logs. This way it has some structure.
>
> I have patches for including SCM_CREDENTIALS so you get the PID, UID and GID from the daemon as well. However they still have issues and there is always a race condition between resolving the process name from the PID. So letting good behaving daemon choose their ident is actually a good thing.
>

Sounds good.

> Regards
>
> Marcel
>


Cheers,
--
Vinicius
