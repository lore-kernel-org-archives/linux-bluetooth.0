Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120531134255.GP18069@joana>
References: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
	<1338401329-31429-2-git-send-email-andre.guedes@openbossa.org>
	<20120531134255.GP18069@joana>
Date: Thu, 31 May 2012 16:08:46 -0300
Message-ID: <CACJA=fUXJ6C8529kO2_n_aCuAYnH0T=ptPUTe3sCU4AMLUV9Jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Check MTU value in l2cap_sock_setsockopt_old
From: Andre Guedes <andre.guedes@openbossa.org>
To: Gustavo Padovan <gustavo@padovan.org>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, May 31, 2012 at 10:42 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Andre,
>
> * Andre Guedes <andre.guedes@openbossa.org> [2012-05-30 15:08:48 -0300]:
>
>> If user tries to set an invalid MTU value, l2cap_sock_setsockopt_old
>> should return -EINVAL.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/l2cap_sock.c |   21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index d856cc8..a7ac747 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -445,6 +445,22 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
>>       return err;
>>  }
>>
>> +static bool is_valid_mtu(struct l2cap_chan *chan, u16 mtu)
>
> I prefer if we call this l2cap_valid_mtu()

Ok, I'll rename it.

>> +{
>> +     switch (chan->scid) {
>> +     case L2CAP_CID_LE_DATA:
>> +             if (mtu < L2CAP_LE_DEFAULT_MTU)
>> +                     return 0;
>
> If you want to return bool you might want to return false here.
>
>> +             break;
>> +
>> +     default:
>> +             if (mtu < L2CAP_DEFAULT_MIN_MTU)
>> +                     return 0;
>> +     }
>> +
>> +     return 1;
>
> and true here.

Sure. I'll fix this.

I'll send a new version of this patch series.

BR,

Andre
