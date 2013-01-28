Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359170902.16748.6.camel@aeonflux>
References: <1359148426-22271-1-git-send-email-andre.guedes@openbossa.org>
	<1359170902.16748.6.camel@aeonflux>
Date: Mon, 28 Jan 2013 15:17:42 -0300
Message-ID: <CACJA=fW1fNrGycuK77hix6mELTdA9bvOkgduSqvz1Bm-UVifNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Fix L2CAP socket shutdown for LE connections
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jan 26, 2013 at 12:28 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> During the L2CAP socket shutdown, the LE connection is not terminated
>> as expected. This bug can be reproduced using l2test tool. Once the
>> LE connection is established, kill l2test and the LE connection will
>> not terminate.
>>
>> This patch fixes hci_conn_disconnect function so it is able to
>> terminate LE connections.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  net/bluetooth/hci_conn.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 25bfce0..0492949 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -250,6 +250,7 @@ static void hci_conn_disconnect(struct hci_conn *conn)
>>
>>       switch (conn->type) {
>>       case ACL_LINK:
>> +     case LE_LINK:
>>               hci_acl_disconn(conn, reason);
>>               break;
>>       case AMP_LINK:
>
> I am wondering if we are not missing SCO_LINK here either.

Yes, we have the same problem with SCO socket shutdown.

I'll fix it and add the patch to this patchset.

Regards,

Andre
