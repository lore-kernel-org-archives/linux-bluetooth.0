Return-Path: <szymon.janc@codecoup.pl>
MIME-Version: 1.0
In-Reply-To: <d0d2f76d-fb23-0688-0038-51582a374c8e@windriver.com>
References: <20170814071640.289327-1-fupan.li@windriver.com>
 <6EC96C1E-CE98-4CF1-B1B2-1CEC9DBC36EA@holtmann.org> <d0d2f76d-fb23-0688-0038-51582a374c8e@windriver.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Mon, 14 Aug 2017 14:46:07 +0200
Message-ID: <CAAEJBhKY-8G_9-cwi6HpLBmbFhyBKCnYJ+yvBy_nXxy9G66Wvw@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: make bluetooth socket can be created in
 net namespace
To: fupan <fupan.li@windriver.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 14 August 2017 at 11:45, fupan <fupan.li@windriver.com> wrote:
> On 2017/8/14 17:30, Marcel Holtmann wrote:
>>
>> Hi Fupan,
>>
>>> By now kernel only supported creating bluetooth socket in init_net
>>> net namespace, which made bluetooth device cannot be accessed in
>>> containers, this patch made bluetooth socket can be created in
>>> net namespaces to fix this issue.
>>>
>>> Signed-off-by: Fupan Li <fupan.li@windriver.com>
>>> ---
>>> net/bluetooth/af_bluetooth.c | 2 +-
>>> net/bluetooth/bnep/sock.c    | 4 ++--
>>> net/bluetooth/cmtp/sock.c    | 4 ++--
>>> net/bluetooth/hci_sock.c     | 4 ++--
>>> net/bluetooth/hidp/sock.c    | 4 ++--
>>> net/bluetooth/l2cap_sock.c   | 4 ++--
>>> net/bluetooth/rfcomm/core.c  | 2 +-
>>> net/bluetooth/rfcomm/sock.c  | 4 ++--
>>> net/bluetooth/sco.c          | 4 ++--
>>> 9 files changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
>>> index 91e3ba280706..eec5ac17faee 100644
>>> --- a/net/bluetooth/af_bluetooth.c
>>> +++ b/net/bluetooth/af_bluetooth.c
>>> @@ -113,7 +113,7 @@ static int bt_sock_create(struct net *net, struct
>>> socket *sock, int proto,
>>> {
>>>         int err;
>>>
>>> -       if (net !=3D &init_net)
>>> +       if (!net_eq(net, current->nsproxy->net_ns))
>>>                 return -EAFNOSUPPORT;
>>
>> before I apply such a patch, what is the actual change here. What impact
>> does this have? Are things like Bluetooth mgmt sockets still operating
>> correctly after this? We have no support for move a Bluetooth controller
>> into a container. The Bluetooth hardware is global.
>
> Hi=EF=BC=8C Marcel
>
> This patch hasn't nothing to do with the Bluetooth hardware, the hardware=
 is
> still global.
> But before you apply this patch, you cannot access the bluetooth hardware=
 in
> a container,
> since you cannot create a bluetooth socket if you are not in the init_net
> namespace.
> After applying this patch, you can access the bluetooth hardware both in =
the
> init_net namespace
> and containers.

Does this mean one could sniff BT traffic from container? Or control
BT hw from multiple containers?

--=20
pozdrawiam
Szymon K. Janc
