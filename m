Return-Path: <robh+dt@kernel.org>
MIME-Version: 1.0
In-Reply-To: <46A7D7AE-FDBB-424D-8E85-7180FEE24A14@holtmann.org>
References: <1504637923-21652-1-git-send-email-loic.poulain@linaro.org>
 <1504637923-21652-3-git-send-email-loic.poulain@linaro.org>
 <CAL_JsqJhEaZkcBA6qnC3rVduQJ9Yesrz_h9i_WXo1bRaq1NT4Q@mail.gmail.com> <46A7D7AE-FDBB-424D-8E85-7180FEE24A14@holtmann.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 7 Sep 2017 10:50:32 -0500
Message-ID: <CAL_JsqLVQeC9TX6g+JbYq6gX7LbRT_-oeTevwDMeX8VHRrEcXg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Bluetooth: btqcomsmd: retieve BD address from DT
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Loic Poulain <loic.poulain@linaro.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Sep 6, 2017 at 2:04 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Rob,
>
>>> Retrieve BD address from the DT local-bd-address property.
>>> This address must be unique and is usually added in the DT
>>> by the bootloader which has access to the provisioned data.
>>>
>>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>

[...]

>>> +       /* The local-bd-address DT property is usually injected by the
>>> +        * bootloader which has access to the allocated BD address.
>>> +        */
>>> +       bdaddr =3D of_get_property(pdev->dev.of_node, "local-bd-address=
", &ret);
>>> +       if (bdaddr && ret =3D=3D sizeof(bdaddr_t)) {
>>> +               BT_INFO("BD address %pMR retrieved from device-tree", b=
daddr);
>>> +               bacpy(&btq->bdaddr, bdaddr);
>>> +       }
>>
>> Can we put all this into a helper function before we get more
>> instances. And use the u8 array property function. We're trying to
>> make of_get_property an internal function.
>
> using of_property_read_u8_array seems sensible since that would shorten t=
his into
>
>         if (!of_property_read_u8_array(pdev->dev.of_node, =E2=80=9Clocal-=
bd-address=E2=80=9D, &btq->bdaddr, 6))
>                 bt_dev_info(pdev->dev, =E2=80=9CBD address %pMR ..=E2=80=
=9D, &btq->bdaddr);
>

Yes.

> Creating a Bluetooth internal helper function seems rather pointless at t=
his stage. If more users appears, then we might need to move this into the =
Bluetooth core to deal with this. However as said before, I am not a big fa=
n of IEEE address assignment via DT since that forces to have the smarts in=
 the boot loader and the boot loader doing the right thing. There are too m=
any boards and DT where this will not be true. In a lot of cases it would m=
ake more sense to store the BD address as part of your file system. Since w=
e do support this in a total generic fashion, I rather push for that method=
 and have the QCOM SMD based SoC being the exception.

Okay, sounds reasonable and it's your call anyway.

Rob

BTW, your mails are always quoted-printable encoding which shouldn't
be used on lists AIUI.
