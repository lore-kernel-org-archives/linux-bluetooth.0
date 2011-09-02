Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBdVf6pchy4sAb2qrT_FWqD5fxDNC0tsHzmFKXP6jDjpxA@mail.gmail.com>
References: <CAFpRq5k1425=uttf1f-a3996qWmMyEh-AJhXL4SeGXW_QYC25A@mail.gmail.com>
 <CAKT1EBdVf6pchy4sAb2qrT_FWqD5fxDNC0tsHzmFKXP6jDjpxA@mail.gmail.com>
From: Dmitry Shipilov <dmitry.shipilov@gmail.com>
Date: Fri, 2 Sep 2011 15:10:29 +0100
Message-ID: <CAFpRq5kXU6OWvvD0KSatUtGxqemPowUX_wvDwORYTt=GNM5gJg@mail.gmail.com>
Subject: Re: L2CAP socket binding fails with gatttool over LE
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

Yes, that really solved the issue! After the upgrade to 3.0.0+ kernel,
I can finally use gatttool and read the remote GATT database. Thanks a
lot for your help!


With best regards, Dmitry...




On Wed, Aug 24, 2011 at 1:37 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Dmitry,
>
> On Tue, Aug 23, 2011 at 5:17 PM, Dmitry Shipilov
> <dmitry.shipilov@gmail.com> wrote:
>> Hello!
>>
>> I was trying to use gatttool from the latest BlueZ 4.96 over LE link,
>> but it immediately fails with error message:
>>
>> $ sudo gatttool --adapter=hci0 --device=<BD addr> --primary
>> l2cap_bind: Invalid argument (22)
>
> It looks that you don't have a proper kernel.
>
> I sent an email last week containing links for the kernel & BlueZ.
> Search for: "Current status on BLE development"
>
> BR,
> Claudio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
