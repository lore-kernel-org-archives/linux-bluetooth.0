Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120601070641.GB3009@aemeltch-MOBL1>
References: <1338508794-12534-1-git-send-email-andre.guedes@openbossa.org>
	<20120601070641.GB3009@aemeltch-MOBL1>
Date: Tue, 5 Jun 2012 15:50:50 -0300
Message-ID: <CACJA=fX9XCqk34ZimMZjY+Z_YJe8UmVfDokQf3biE5guDhF23Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Trivial refactoring in __l2cap_chan_add
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jun 1, 2012 at 4:06 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Andre,
>
> On Thu, May 31, 2012 at 08:59:54PM -0300, Andre Guedes wrote:
>> All cases in switch statement set chan->omtu to L2CAP_DEFAULT_MTU.
>> This patch moves the assignments to outside the switch statement.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/l2cap_core.c |    5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index f9bffe3..0ba8875 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -449,13 +449,11 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>>       case L2CAP_CHAN_CONN_ORIENTED:
>>               if (conn->hcon->type == LE_LINK) {
>>                       /* LE connection */
>> -                     chan->omtu = L2CAP_DEFAULT_MTU;
>>                       chan->scid = L2CAP_CID_LE_DATA;
>>                       chan->dcid = L2CAP_CID_LE_DATA;
>>               } else {
>>                       /* Alloc CID for connection-oriented socket */
>>                       chan->scid = l2cap_alloc_cid(conn);
>> -                     chan->omtu = L2CAP_DEFAULT_MTU;
>>               }
>>               break;
>>
>> @@ -463,7 +461,6 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>>               /* Connectionless socket */
>>               chan->scid = L2CAP_CID_CONN_LESS;
>>               chan->dcid = L2CAP_CID_CONN_LESS;
>> -             chan->omtu = L2CAP_DEFAULT_MTU;
>>               break;
>>
>>       case L2CAP_CHAN_CONN_FIX_A2MP:
>
> what about omtu for fixed channel?

You're right. This patch doesn't make sense anymore. We recently added
the case L2CAP_CHAN_CONN_FIX_A2MP, this patch was written before that.

Thanks,

Andre
