Return-Path: <cyrus@holtmann.org>
Message-id: <FBDDCCD50B2547FF8FC981999BB7949E@sisodomain.com>
From: Jaganath <jaganath.k@samsung.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1341551602-1493-1-git-send-email-jaganath.k@samsung.com>
 <1341551602-1493-2-git-send-email-jaganath.k@samsung.com>
 <20120706092510.GB10494@x220.ger.corp.intel.com>
In-reply-to: <20120706092510.GB10494@x220.ger.corp.intel.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: Override status if local user rejects
 pairing
Date: Sat, 07 Jul 2012 18:37:04 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

--------------------------------------------------
From: "Johan Hedberg" <johan.hedberg@gmail.com>
Sent: Friday, July 06, 2012 2:55 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Bluetooth: Override status if local user rejects 
pairing

> Hi Jaganath,
>
> On Fri, Jul 06, 2012, Jaganath Kanakkassery wrote:
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 5a442b9..4fc3379 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -1764,6 +1764,10 @@ static void pairing_complete(struct pending_cmd 
>> *cmd, u8 status)
>>  bacpy(&rp.addr.bdaddr, &conn->dst);
>>  rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
>>
>> + /* Override status if local device rejected pairing */
>> + if (conn->auth_rejected == true)
>> + status = MGMT_STATUS_REJECTED;
>
> I think simply "if (conn->auth_rejected)" should be fine (no "== true").
> And what if status == 0 and this is a repairing over the same hci_conn
> which was previously rejected? Seems like you'd give a false negative in
> that case. Maybe the check should be "if (status && conn->auth_rejected)".
>> + /* Override status if local device rejected pairing */
>> + if (auth_rejected == true)
>
> Same thing again with the comparison. The stuff inside () of an
> if-statement should be a valid boolean, and if the standard bool type by
> itself can't be considered that then I don't know what can.
>
> The thing that's worrying me is that there's nowhere where you clear
> conn->auth_rejected. If a re-authentication is attempted with the same
> hci_conn the code would be doing wrong things. I'm not completely sure
> where this clearing should occur since we're potentially sending two
> mgmt events through two different code paths (pairing_complete and
> mgmt_auth_failed) so clearing in either one might be risky in that it
> causes the second function to do the wrong thing.

I think we can change setting auth_rejected to true only if the pairing is
local initiated and reset it in pairing_complete (). Since 
mgmt_auth_failed()
will be called before pairing_complete () it will be fine I think. Please 
let me
know your view on that.

Thanks,
Jaganath 

