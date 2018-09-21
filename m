Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <70C091497DE2844DBD9E143B2282ABDA9BE5DA@BGSMSX105.gar.corp.intel.com>
References: <1537350714-32105-1-git-send-email-mallikarjun.phulari@intel.com>
 <CABBYNZ+CAujgpF_8T_xyeu=+Zfzkocuwb5Df0YMT9YDv7M9-4w@mail.gmail.com> <70C091497DE2844DBD9E143B2282ABDA9BE5DA@BGSMSX105.gar.corp.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Sep 2018 14:44:22 +0300
Message-ID: <CABBYNZKb8qZKbP45Pk1=3OyJUUz95MDP9h8Vd_dyt+iL5A3f7A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth : Errata Service Release 8 Erratum 3253
To: "Phulari, Mallikarjun" <mallikarjun.phulari@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mallikarjun,

On Fri, Sep 21, 2018 at 7:37 AM, Phulari, Mallikarjun
<mallikarjun.phulari@intel.com> wrote:
> Hi Luiz,
> Please find the new patch with review comments incorporated.

Please send a proper patch not as attachment.

> *I have added the Page number of Core Specification for reference in the commit message and included the "signed of by" in the patch.
>
> *L2CAP_CR_INVALID_SCID and L2CAP_CR_SCID_IN_USE are specific to LE with different result values as:
>  L2CAP_CR_INVALID_SCID  -  0x0009
>  L2CAP_CR_SCID_IN_USE   -  0x000A

Alright, so they probably need to be renamed to
L2CAP_CR_LE_INVALID_SCID and L2CAP_CR_LE_SCID_IN_USE so we don't
confuse these with BR codes.

> It is already implemented.
>
> Thanks & Regards
> Mallikarjun Phulari
>
> _____________________________________
> From: Luiz Augusto von Dentz [luiz.dentz@gmail.com]
> Sent: Wednesday, September 19, 2018 5:06 AM
> To: Phulari, Mallikarjun
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth : Errata Service Release 8 Erratum 3253
>
> Hi Mallikarjun,
>
> On Wed, Sep 19, 2018 at 12:51 PM, Mallikarjun Phulari
> <mallikarjun.phulari@intel.com> wrote:
>> L2CAP: Changes include the new result codes for the l2cap channel
>> create/connect request. The new result code are:
>> 0x0006 - sent in the response when the CID is not in valid dynamic range.
>> 0x0007 sent in the response when the CID is already allocated.
>
> It would be a good idea to quote the erratum with page number where
> the new errors come from. Btw, you should include a signed of by in
> the kernel patches.
>
>> ---
>>  include/net/bluetooth/l2cap.h |  6 ++++++
>>  net/bluetooth/l2cap_core.c    | 12 ++++++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 0697fd4..eb0c8d0 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -284,6 +284,12 @@ struct l2cap_conn_rsp {
>>  #define L2CAP_CR_INVALID_SCID  0x0009
>>  #define L2CAP_CR_SCID_IN_USE   0x000A
>>
>> +/* connect/create channel results
>> + * As per Erratum 3253
>> + */
>> +#define L2CAP_CR_BREDR_INVALID_SCID    0x0006
>> +#define L2CAP_CR_BREDR_SCID_IN_USE     0x0007
>
> Weird, are L2CAP_CR_INVALID_SCID and L2CAP_CR_SCID_IN_USE specific to
> LE? If they are we should probably fix their names.
>
>>  /* connect/create channel status */
>>  #define L2CAP_CS_NO_INFO       0x0000
>>  #define L2CAP_CS_AUTHEN_PEND   0x0001
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 9b7907e..85887df 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -3814,9 +3814,21 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>>         }
>>
>>         result = L2CAP_CR_NO_MEM;
>> +       /* As per Erratum 3253, check the CID is in valid dynamic range and
>> +        *  is not allocated already. Send the new result codes accordingly
>> +        */
>> +
>> +       /* Check for valid dynamic CID range */
>> +       if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
>> +               result = L2CAP_CR_BREDR_INVALID_SCID;
>> +               chan = NULL;
>> +               goto response;
>> +       }
>>
>>         /* Check if we already have channel with that dcid */
>>         if (__l2cap_get_chan_by_dcid(conn, scid))
>> +               result = L2CAP_CR_BREDR_SCID_IN_USE;
>> +               chan = NULL;
>>                 goto response;
>
> Missing { } above?
>
>>
>>         chan = pchan->ops->new_connection(pchan);
>> --
>> 2.7.4
>>
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
