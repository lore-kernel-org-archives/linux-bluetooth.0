Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120814091317.GA1083@x220>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
 <1344632507-21381-5-git-send-email-jefferson.delfes@openbossa.org> <20120814091317.GA1083@x220>
From: Aloisio Almeida <aloisio.almeida@openbossa.org>
Date: Wed, 29 Aug 2012 14:42:23 -0300
Message-ID: <CAEsZsEhh9ipERRC__zZZ9gD1HtnTNYSHaxfZyycifgsrmr7-vw@mail.gmail.com>
Subject: Re: [RFC 4/5] Bluetooth: Add set broadcaster MGMT command
To: Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

It was decided to have broadcaster/observer in BR/EDR also. I think it
was decided in the Bluez meeting, right?

For now we're thinking in use this on BR/EDR only controllers. Dual
mode controllers would use LE for broadcasting.

I'm working on adding this feature right now. Further I'll send the v2.

Aloisio

On Tue, Aug 14, 2012 at 6:13 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jefferson,
>
> On Fri, Aug 10, 2012, Jefferson Delfes wrote:
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -379,6 +379,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>>       settings |= MGMT_SETTING_FAST_CONNECTABLE;
>>       settings |= MGMT_SETTING_DISCOVERABLE;
>>       settings |= MGMT_SETTING_PAIRABLE;
>> +     settings |= MGMT_SETTING_BROADCASTER;
>
> Shouldn't this be behind the same conditional as MGMT_SETTING_LE? I.e.
> only when hdev->features indicates LE support.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
