Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405110452.GA1654@x220>
References: <1333615989-15979-1-git-send-email-hemant.gupta@stericsson.com>
	<20120405110452.GA1654@x220>
Date: Thu, 5 Apr 2012 16:52:28 +0530
Message-ID: <CACj007nTwwTQcafn4krgrNL6hAco9XMDM60v0RiP6jqKzMh3dA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Send Connect failed event when LE Connection fails
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Apr 5, 2012 at 4:34 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Hemant,
>
> On Thu, Apr 05, 2012, Hemant Gupta wrote:
>> This patch adds management connect failed event when LE Create Connection
>> Command fails to inform BlueZ that LE Connection failed to get established.
>
> s/BlueZ/user space/
>
> Also change the summary line to:
>
> Bluetooth: mgmt: Fix missing connect failed event for LE
>
Thanks, please have a look at my new patch.
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1649,6 +1649,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
>>       if (status) {
>>               if (conn && conn->state == BT_CONNECT) {
>>                       conn->state = BT_CLOSED;
>> +                     mgmt_connect_failed(hdev, &cp->peer_addr, conn->type,
>> +                                                     conn->dst_type, status);
>>                       hci_proto_connect_cfm(conn, status);
>>                       hci_conn_del(conn);
>>               }
>
> Please use our new alignment style for split lines, i.e. align with the
> opening parenthesis.
>
Done, sent a new patch for review.
> Johan



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
