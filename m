Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_MWBg4rOnmXi5CAO5cC9hJ0Twzih=x2Bd-QvmjNH=WpdA@mail.gmail.com>
References: <1327531949-29463-1-git-send-email-andre.guedes@openbossa.org>
	<1327531949-29463-6-git-send-email-andre.guedes@openbossa.org>
	<CAJdJm_MWBg4rOnmXi5CAO5cC9hJ0Twzih=x2Bd-QvmjNH=WpdA@mail.gmail.com>
Date: Thu, 26 Jan 2012 10:05:28 -0300
Message-ID: <CACJA=fVwm3S7SQL0kYLdWYrjzZBPeBQ_HAA=Jmtz-cQyi0FPZg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] Bluetooth: MGMT start discovery LE-Only support
From: Andre Guedes <andre.guedes@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 26, 2012 at 9:55 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Andre,
>
> On Wed, Jan 25, 2012 at 6:52 PM, Andre Guedes
> <andre.guedes@openbossa.org> wrote:
>> - =A0 =A0 =A0 err =3D hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
>> + =A0 =A0 =A0 if (test_bit(MGMT_ADDR_BREDR, &discov_type))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_do_inquiry(hdev, INQUIRY_LEN_B=
REDR);
>> + =A0 =A0 =A0 else if (test_bit(MGMT_ADDR_LE_PUBLIC, &discov_type) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_bit(M=
GMT_ADDR_LE_RANDOM, &discov_type))
>
> Should it be "||" in the line above?

mgmt-api.txt says both bits should be set.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D hci_le_scan(hdev, LE_SCAN_TYPE, LE=
_SCAN_INT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> +
>> =A0 =A0 =A0 =A0if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mgmt_pending_remove(cmd);
>> =A0 =A0 =A0 =A0else
>> --
>> 1.7.8.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetoot=
h" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
