Return-Path: <cyrus@holtmann.org>
Message-id: <86CE592A523D405C836834BA532840DA@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
 <1349891245.27233.153.camel@aeonflux>
 <E3660838E8D64186924BA81A32F30682@sisodomain.com>
 <1349963810.27233.178.camel@aeonflux>
 <CABBYNZ+rGP0cirHDexU49+SJnSn2hRd+GVH0sVOFU53DfNnq0g@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue
Date: Mon, 15 Oct 2012 23:46:58 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Luiz,

----- Original Message ----- 
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Syam Sidhardhan" <s.syam@samsung.com>; 
<linux-bluetooth@vger.kernel.org>
Sent: Thursday, October 11, 2012 7:59 PM
Subject: Re: [PATCH 1/4] Bluetooth: Fix L2CAP PSM bind issue


> Hi Marcel,
>
> On Thu, Oct 11, 2012 at 3:56 PM, Marcel Holtmann <marcel@holtmann.org> 
> wrote:
>> Hi Syam,
>>
>>> >> Problem: If we bind a particular PSM with source address as 
>>> >> BDADDR_ANY,
>>> >> then we are able to bind the same PSM with adapter address(or any 
>>> >> other
>>> >> address), which is incorrect.
>>> >
>>> > why is this incorrect? Explain that to me.
>>> >
>>>
>>> Here there is a correction required in the commit message.
>>>
>>> As per my understanding the a particular PSM can be binded only once
>>> for a single adapter address. Kindly correct me if I'm wrong here.
>>
>> a PSM can be bound once per adapter address. And of course once per
>> BDADDR_ANY.
>>
>> So you can bind PSM 23 to BDADDR_ANY and 11:22:33:44:55:66. An incoming
>> connection to 11:22:33:44:55:66 will arrive to that specific socket, but
>> an incoming to all others will be handled by the BDADDR_ANY.
>>
>> The BDADDR_ANY is special. Consider it a wildcard bound with lower
>> priority. If overwritten with a specific address bound, that will be
>> considered first of course.
>>
>> If we are not doing it that way, than that is a bug.
>>
>> Outgoing connections should behave the same btw. If a specific address
>> is bound, than that will be used. If not available, then you can not
>> connect. If BDADDR_ANY is used, then the next available adapter will be
>> used.
>
> The real problem is by giving psm 0 the kernel should return the first
> available psm in the non-reserved space, but since we reuse the same
> code to do the matching it end up given both obexd and hdp the same
> psm, IMO in this case we should consider using Syam code and not
> __l2cap_global_chan_by_addr as the userspace is probably asking for a
> psm not in use which should  exclude those in use by BDADDR_ANY.
>

It seems there is a bug.
I tried to listen first using BDADDR_ANY and then again listen
using the adapter address for a particular PSM. If I try to connect
on that particular PSM from the remote device, then the incoming
connection follows the order of the listen rather than the priority.

Ex:
1) Listen
-sh-4.1# /opt/l2test -d -P 11
l2test[3450]: Waiting for connection on psm 11 ...

2) Listen
-sh-4.1# /opt/l2test -w -P 11 -i hci0
l2test[3451]: Waiting for connection on psm 11 ...

If we try to connect from the remote device, then the connection goes to 
First listen
-sh-4.1# /opt/l2test -n -P 11 00:02:4B:28:2C:48

Similarly if we swap the order of the listen 1 & 2, then connection goes to 
hci0 one.

The following diff resolves the issue for me. I'm not sure its correct or 
not.

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 33b5d34..12f9b52 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1499,7 +1499,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int 
state, __le16 psm,
                        src_any = !bacmp(&bt_sk(sk)->src, BDADDR_ANY);
                        dst_any = !bacmp(&bt_sk(sk)->dst, BDADDR_ANY);
                        if ((src_match && dst_any) || (src_any && dst_match) 
||
-                           (src_any && dst_any))
+                           (!c1 && src_any && dst_any))
                                c1 = c;
                }
        }

Regards,
Syam 
