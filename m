Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120118122354.GE6655@x220>
References: <1326701069-19146-1-git-send-email-hemant.gupta@stericsson.com>
	<1326701069-19146-2-git-send-email-hemant.gupta@stericsson.com>
	<20120118122354.GE6655@x220>
Date: Mon, 23 Jan 2012 20:07:04 +0530
Message-ID: <CACj007=pmfONthR5zVhN-Un1x7U0pd8C11psuf2f=63zeNRg=w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Bluetooth: Send correct response to IO Capability Request
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: marcel@holtmann.org
Cc: Hemant Gupta <hemant.gupta@stericsson.com>, linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 18, 2012 at 5:53 PM, Johan Hedberg <johan.hedberg@gmail.com> wr=
ote:
> Hi Hemant,
>
> On Mon, Jan 16, 2012, Hemant Gupta wrote:
>> This patch sends correct IO Capability response to remote device
>> in case Local Device supports KeyBoardDisplay IO Capability as
>> this capability is not valid as per BT spec for IO capability
>> Request Reply Command.
>> This capability is mapped to DisplayYesNo which is in accordance
>> with BT spec.
>>
>> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
>> ---
>> =A0net/bluetooth/hci_event.c | =A0 =A06 +++++-
>> =A01 files changed, 5 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index d37f5b2..3590e72 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -2782,7 +2782,11 @@ static inline void hci_io_capa_request_evt(struct=
 hci_dev *hdev, struct sk_buff
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hci_cp_io_capability_reply cp;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bacpy(&cp.bdaddr, &ev->bdaddr);
>> - =A0 =A0 =A0 =A0 =A0 =A0 cp.capability =3D conn->io_capability;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Change the IO capability from KeyboardDis=
play
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to DisplayYesNo as it is not supported by=
 BT spec.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 cp.capability =3D (conn->io_capability =3D=3D =
0x04) ? 0x01 : conn->io_capability;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 conn->auth_type =3D hci_get_auth_req(conn);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp.authentication =3D conn->auth_type;
>
> Looks good to me but this still needs Marcel's ack before I apply it to
> my bluetooth-next tree.
>
> Johan

Could you please provide comments on this patch, as with the
application of BlueZ patch, SSP pairing would not work in case local
device has set the IO Capability to KeyboardDisplay (0x04).

--=20
Best Regards
Hemant Gupta
ST-Ericsson India
