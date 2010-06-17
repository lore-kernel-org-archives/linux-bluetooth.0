Return-Path: <cyrus@holtmann.org>
Message-ID: <4C19ADF9.4070204@Atheros.com>
Date: Thu, 17 Jun 2010 10:39:13 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Nick Pelly <npelly@google.com>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Suraj Sumangala
	<Suraj.Sumangala@Atheros.com>, Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: RFC: Allow Bluez to select flushable or non-flushable ACL packets
 	with L2CAP_LM_RELIABLE
References: <35c90d960912081950t135e3f10m8848e54fde1e596f@mail.gmail.com> 	<1260335175.2901.20.camel@violet> <35c90d960912082213s26fb0ebse75ce85d43213d9@mail.gmail.com> 	<1260482634.2901.70.camel@violet> <35c90d960912161359u2b3f9b2fi875288896a7a8478@mail.gmail.com> 	<35c90d961003091207u66571bt789461dcc7972693@mail.gmail.com> 	<1268167524.3712.61.camel@localhost.localdomain> <AANLkTinOFG0NcADz2ewxyaPWiLpe52MFLP8GCEvFna2a@mail.gmail.com> 	<4C18BDDF.7030002@Atheros.com> <AANLkTimZB71m9zGxTjmKjTiKNo-hDHsrCLrOLXr1EjyY@mail.gmail.com> <AANLkTinzTubv9p_AOUnm_HCjpn8DWaSMmft57NhFVli8@mail.gmail.com>
In-Reply-To: <AANLkTinzTubv9p_AOUnm_HCjpn8DWaSMmft57NhFVli8@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------070506040707040106070204"
List-ID: <linux-bluetooth.vger.kernel.org>

--------------070506040707040106070204
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
On 6/16/2010 9:56 PM, Nick Pelly wrote:
> On Wed, Jun 16, 2010 at 8:14 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>  wrote:
>> Hi,
>>
>> On Wed, Jun 16, 2010 at 3:04 PM, Suraj<suraj@atheros.com>  wrote:
>>> Hi Luis,
>>>
>>> On 6/16/2010 5:10 PM, Luiz Augusto von Dentz wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Tue, Mar 9, 2010 at 11:45 PM, Marcel Holtmann<marcel@holtmann.org>
>>>>   wrote:
>>>>>
>>>>> Hi Nick,
>>>>>
>>>>>>>>>>> Right now Bluez always requests flushable ACL packets (but does not
>>>>>>>>>>> set a flush timeout, so effectively they are non-flushable):
>>>>>>>>>>>
>>>>>>>>>>> However it is desirable to use an ACL flush timeout on A2DP packets
>>>>>>>>>>> so
>>>>>>>>>>> that if the ACL packets block for some reason then the LM can flush
>>>>>>>>>>> them to make room for newer packets.
>>>>>>>>>>>
>>>>>>>>>>> Is it reasonable for Bluez to use the 0x00 ACL packet boundary flag
>>>>>>>>>>> by
>>>>>>>>>>> default (non-flushable packet), and let userspace request flushable
>>>>>>>>>>> packets on A2DP L2CAP sockets with the socket option
>>>>>>>>>>> L2CAP_LM_RELIABLE.
>>>>>>>>>>
>>>>>>>>>> the reliable option has a different meaning. It comes back from the
>>>>>>>>>> old
>>>>>>>>>> Bluetooth 1.1 qualification days where we had to tests on L2CAP that
>>>>>>>>>> had
>>>>>>>>>> to confirm that we can detect malformed packets and report them.
>>>>>>>>>> These
>>>>>>>>>> days it is just fine to drop them.
>>>>>>>>>
>>>>>>>>> Got it, how about introducing
>>>>>>>>>
>>>>>>>>> #define L2CAP_LM_FLUSHABLE 0x0040
>>>>>>>>
>>>>>>>> that l2cap_sock_setsockopt_old() sets this didn't give you a hint that
>>>>>>>> we might wanna deprecate this socket options ;)
>>>>>>>>
>>>>>>>> I need to read up on the flushable stuff, but in the end it deserves
>>>>>>>> its
>>>>>>>> own socket option. Also an ioctl() to actually trigger Enhanced flush
>>>>>>>> might be needed.
>>>>>>>>
>>>>>>>>> struct l2cap_pinfo {
>>>>>>>>>     ...
>>>>>>>>>     __u8 flushable;
>>>>>>>>> }
>>>>>>>>
>>>>>>>> Sure. In the long run we need to turn this into a bitmask. We are just
>>>>>>>> wasting memory here.
>>>>>>>
>>>>>>> Attached is an updated patch, that checks the LMP features bitmask
>>>>>>> before using the new non-flushable packet type.
>>>>>>>
>>>>>>> I am still using L2CAP_LM_FLUSHABLE socket option in
>>>>>>> l2cap_sock_setsockopt_old(), which I don't think you are happy with.
>>>>>>> So how about a new option:
>>>>>>>
>>>>>>> SOL_L2CAP, L2CAP_ACL_FLUSH
>>>>>>> which has a default value of 0, and can be set to 1 to make the ACL
>>>>>>> data sent by this L2CAP socket flushable.
>>>>>>>
>>>>>>> In a later commit we would then add
>>>>>>> SOL_ACL, ACL_FLUSH_TIMEOUT
>>>>>>> That is used to set an automatic flush timeout for the ACL link on a
>>>>>>> L2CAP socket. Note that SOL_ACL is new.
>>>>>>>
>>>>>>> But maybe this is not what you had in mind, so I'm looking for your
>>>>>>> advice before I implement this.
>>>>>>
>>>>>> Attached an updated patch for 2.6.32 kernel. We've been using this
>>>>>> patch successfully on production devices.
>>>>>
>>>>> can see anything wrong with that patch. However we need to use
>>>>> SOL_BLUETOOTH for it of course. So we need to come up with something to
>>>>> make this simple.
>>>>>
>>>>> An additional change I like to see is to use flags for booleans like
>>>>> flushable in the structures. Can you work on changing that.
>>>>>
>>>>> Also do we have decoding support for this in hcidump. It might be nice
>>>>> to include some really simple examples in the commit message.
>>>>>
>>>>> Regards
>>>>
>>>> I would like to play a little bit with this, so is there any missing
>>>> updates?
>>>>
>>> This is not exactly something related to your question, but there is another
>>> side effect for the current implementation.
>>>
>>> Assume you have 2 ACL links, FTP and A2DP. A2DP streaming and FTP doing FTP
>>> Put.
>>> When the A2DP packets start blocking, it effectively start blocking the
>>> packets available for FTP too. But, the host has no idea about it and keep
>>> pumping in A2DP data until all available buffers are blocked. Effectively
>>> blocking both A2DP and FTP.
>>>
>>> So at the user level you will see your FTP connection stalling as long your
>>> A2DP connection is stalled (out of range). FTP will restart as soon as A2DP
>>> comes back in range.
>>>
>>> I had raised this issue sometime before, but could not follow it up.
>>
>> I got the impression that we can still control which packets are
>> Automatically-Flushable and which are not, so even thought we set the
>> timeout in a per ACL link fashion we can still mark which packets
>> should be flushable in a per socket basis.
>>
>> Is that correct, Nick?
>
> Yes, as Suraj explains, my patch will solve the problem of a stalled
> A2DP link preventing FTP packets on another ACL - because the A2DP
> packets will be marked flushable.
>
> However its worth bringing up that my patch does not solve the reverse
> problem - if an FTP link is stalled then all ACL packets will be
> temporarily stalled - because you would not normally mark FTP packets
> as flushable. For this you would need the kernel to set a high level
> watermark on a per-ACL-link or per-socket basis, so that a single ACL
> link or a single socket can not use all available ACL buffers
> regardless of whether they are flushable or not.
>
> Nick

Exactly, this was the problem I raised sometime before.
Attached is a patch that works for me.
Not sure if this is the best solution. I can send a formal patch if this 
is worth a try.

Regards
Suraj


--------------070506040707040106070204
Content-Type: text/plain;
	name="0001-Fix-for-Link-starvation-if-device-goes-out-of-range.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-for-Link-starvation-if-device-goes-out-of-range.pat";
	filename*1="ch"

>From cbcb5fd9d126e490a7b12469a0a1e1fb09ce535b Mon Sep 17 00:00:00 2001
From: root <root@localhost.localdomain>
Date: Tue, 4 May 2010 13:52:04 +0530
Subject: [PATCH] Fix for Link starvation if device goes out of range

---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |    5 +++++
 net/bluetooth/hci_event.c        |    4 ++++
 3 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 25b8a03..4216a7b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -178,6 +178,8 @@ struct hci_conn {
 
 	unsigned int	 sent;
 
+	unsigned int	 avail_buffer;
+
 	struct sk_buff_head data_q;
 
 	struct timer_list disc_timer;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 406ad07..f8a99cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1325,6 +1325,8 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 
 		if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
 			continue;
+		if (c->avail_buffer == 0)
+			continue;
 
 		num++;
 
@@ -1390,6 +1392,9 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 
 			hdev->acl_cnt--;
 			conn->sent++;
+
+			if (conn->avail_buffer != 0)
+				conn->avail_buffer--;
 		}
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e99fe38..2f3b6dc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -900,6 +900,9 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
 			cp.handle = ev->handle;
+
+			conn->avail_buffer = hdev->acl_pkts;
+
 			hci_send_cmd(hdev, HCI_OP_READ_REMOTE_FEATURES,
 							sizeof(cp), &cp);
 		}
@@ -1447,6 +1450,7 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 			if (conn->type == ACL_LINK) {
 				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
+				conn->avail_buffer = count;
 			} else {
 				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
 					hdev->sco_cnt = hdev->sco_pkts;
-- 
1.6.0.6


--------------070506040707040106070204--
