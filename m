Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110131075723.GO874@null>
References: <1296308377-2207-1-git-send-email-tim.bao@gmail.com>
	<20110131075723.GO874@null>
Date: Tue, 1 Feb 2011 11:44:33 +0800
Message-ID: <AANLkTimAV1finwk1OYqStLjZR-0cAJRYsAW=vejowafa@mail.gmail.com>
Subject: Re: [PATCH] Set connection state to BT_DISCONN to avoid multiple responses
From: Liang Bao <tim.bao@gmail.com>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2011/1/31 Ville Tervo <ville.tervo@nokia.com>:
> Hi,
>
> On Sat, Jan 29, 2011 at 09:39:37PM +0800, ext Liang Bao wrote:
>> From: Bao Liang <tim.bao@gmail.com>
>>
>> This patch fixes a minor issue that two connection responses will be sent
>> for one L2CAP connection request. If the L2CAP connection request is first
>> blocked due to security reason and responded with reason "security block",
>> the state of the connection remains BT_CONNECT2. If a pairing procedure
>> completes successfully before the ACL connection is down, local host will
>> send another connection complete response. See the following packets
>> captured by hcidump.
>>
>> 2010-12-07 22:21:24.928096 < ACL data: handle 12 flags 0x00 dlen 16
>>     0000: 0c 00 01 00 03 19 08 00  41 00 53 00 03 00 00 00  ........A.S.....
>> ... ...
>>
>> 2010-12-07 22:21:35.791747 > HCI Event: Auth Complete (0x06) plen 3
>>     status 0x00 handle 12
>> ... ...
>>
>> 2010-12-07 22:21:35.872372 > ACL data: handle 12 flags 0x02 dlen 16
>>     L2CAP(s): Connect rsp: dcid 0x0054 scid 0x0040 result 0 status 0
>>       Connection successful
>>
>> Signed-off-by: Liang Bao <tim.bao@gmail.com>
>
> Now it looks good to me.
>
> Acked-by: Ville Tervo <ville.tervo@nokia.com>
>
Thanks, so ready for push? ;)
>> ---
>>  net/bluetooth/l2cap.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
>> index fadf26b..364197d 100644
>> --- a/net/bluetooth/l2cap.c
>> +++ b/net/bluetooth/l2cap.c
>> @@ -848,6 +848,7 @@ static void __l2cap_sock_close(struct sock *sk, int reason)
>>                               result = L2CAP_CR_SEC_BLOCK;
>>                       else
>>                               result = L2CAP_CR_BAD_PSM;
>> +                     sk->sk_state = BT_DISCONN;
>>
>>                       rsp.scid   = cpu_to_le16(l2cap_pi(sk)->dcid);
>>                       rsp.dcid   = cpu_to_le16(l2cap_pi(sk)->scid);
>> --
>> 1.7.1
>>
>
> --
> Ville
>
