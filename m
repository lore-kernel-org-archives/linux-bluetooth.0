Return-Path: <Fupan.Li@windriver.com>
Subject: Re: [PATCH] net/bluetooth: make bluetooth socket can be created in
 net namespace
To: Marcel Holtmann <marcel@holtmann.org>,
        Szymon Janc
	<szymon.janc@codecoup.pl>
References: <20170814071640.289327-1-fupan.li@windriver.com>
 <6EC96C1E-CE98-4CF1-B1B2-1CEC9DBC36EA@holtmann.org>
 <d0d2f76d-fb23-0688-0038-51582a374c8e@windriver.com>
 <CAAEJBhKY-8G_9-cwi6HpLBmbFhyBKCnYJ+yvBy_nXxy9G66Wvw@mail.gmail.com>
 <74252530-EF31-4CDA-A4E1-9FDD19DC25FA@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        Bluez mailing list
	<linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: fupan <fupan.li@windriver.com>
Message-ID: <4ead25c2-1512-4449-7ed4-b5e094f3a4f8@windriver.com>
Date: Tue, 15 Aug 2017 09:12:18 +0800
MIME-Version: 1.0
In-Reply-To: <74252530-EF31-4CDA-A4E1-9FDD19DC25FA@holtmann.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 2017/8/14 23:59, Marcel Holtmann wrote:
> Hi Szymon,
>
>>>>> By now kernel only supported creating bluetooth socket in init_net
>>>>> net namespace, which made bluetooth device cannot be accessed in
>>>>> containers, this patch made bluetooth socket can be created in
>>>>> net namespaces to fix this issue.
>>>>>
>>>>> Signed-off-by: Fupan Li <fupan.li@windriver.com>
>>>>> ---
>>>>> net/bluetooth/af_bluetooth.c | 2 +-
>>>>> net/bluetooth/bnep/sock.c    | 4 ++--
>>>>> net/bluetooth/cmtp/sock.c    | 4 ++--
>>>>> net/bluetooth/hci_sock.c     | 4 ++--
>>>>> net/bluetooth/hidp/sock.c    | 4 ++--
>>>>> net/bluetooth/l2cap_sock.c   | 4 ++--
>>>>> net/bluetooth/rfcomm/core.c  | 2 +-
>>>>> net/bluetooth/rfcomm/sock.c  | 4 ++--
>>>>> net/bluetooth/sco.c          | 4 ++--
>>>>> 9 files changed, 16 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>>>>> index 91e3ba280706..eec5ac17faee 100644
>>>>> --- a/net/bluetooth/af_bluetooth.c
>>>>> +++ b/net/bluetooth/af_bluetooth.c
>>>>> @@ -113,7 +113,7 @@ static int bt_sock_create(struct net *net, struct
>>>>> socket *sock, int proto,
>>>>> {
>>>>>         int err;
>>>>>
>>>>> -       if (net != &init_net)
>>>>> +       if (!net_eq(net, current->nsproxy->net_ns))
>>>>>                 return -EAFNOSUPPORT;
>>>> before I apply such a patch, what is the actual change here. What impact
>>>> does this have? Are things like Bluetooth mgmt sockets still operating
>>>> correctly after this? We have no support for move a Bluetooth controller
>>>> into a container. The Bluetooth hardware is global.
>>> Hi， Marcel
>>>
>>> This patch hasn't nothing to do with the Bluetooth hardware, the hardware is
>>> still global.
>>> But before you apply this patch, you cannot access the bluetooth hardware in
>>> a container,
>>> since you cannot create a bluetooth socket if you are not in the init_net
>>> namespace.
>>> After applying this patch, you can access the bluetooth hardware both in the
>>> init_net namespace
>>> and containers.
>> Does this mean one could sniff BT traffic from container? Or control
>> BT hw from multiple containers?
> from how I read the change, then yes, the container could start another bluetoothd or btmon. As long as you use an user namespace and gain CAP_NET_ADMIN and CAP_NET_RAW privileges.
Hi, Marcel

Yes, you are right. Actually the reason we want this patch is that in 
our embedded container OS we want to
put all of the hardware control rights into a privilege container, just 
as Xen's dom0 role.

Thus we can thin our essential rootfs as small as possible and 
containerlized all of the Apps.

Thanks!

Fupan
> I am actually not convinced we really want this. More useful seems the fact to create a virtual child hciX controller that then can be moved into container. It would use the parent hciX controller as real hardware. However this most likely only works for BLE since with BR/EDR this is rather complicated and there are actual role limits.
>
> Regards
>
> Marcel
>
>
