Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <BN7PR07MB430513DBD3BF38324AB5D1A19D3D0@BN7PR07MB4305.namprd07.prod.outlook.com>
References: <BN7PR07MB4305C0AA4DBCB0136D7F72199D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
 <CABBYNZKSuDMX38OszjLZOEt9L_f5YM1L000-hb0Gv9LqcGSPOA@mail.gmail.com> <BN7PR07MB430513DBD3BF38324AB5D1A19D3D0@BN7PR07MB4305.namprd07.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Aug 2018 17:32:22 +0300
Message-ID: <CABBYNZLrkfqv1LZ057k6Og-F9+zO+yWpHvLiwRJgOqvK9daELg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH BlueZ 0/2] Change ConnectDevice to
 optionally connect services
To: "Karabin, Josh" <George.Karabin@honeywell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

On Fri, Aug 17, 2018 at 4:35 PM, Karabin, Josh
<George.Karabin@honeywell.com> wrote:
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Friday, August 17, 2018 2:15 AM
>
>> I wonder how this is suppose to work since what you are suggesting is
>> to not auto-connect matching profiles/services, but that would leave
>> the ACL link with no channels in use (at least on BR/EDR) so the link
>> would disconnect anyway.
>
> In my use case, the client application will wait for the appearance of
> a device object with a matching address to appear on the Device1
> interface. If that device contains a profile that that the application
> supports, it will call ConnectProfile on the device object. In general,
> the link won't time out before the application has a chance to
> respond, but it would be fine if it did - the ConnectProfile call would
> end up re-establishing the link in that case.
>
> I could note that behavior in the adapter api document if you think
> It would help to clarify the intent.

Wouldn't it be better to have a list of profiles to connect then? That
would make a nice addition to the API since ConnectProfile only
connect one profile at time, that way we could have auto-connect be a
list and in case it is empty we connect all otherwise we just connect
the profiles in that list, how about that?

-- 
Luiz Augusto von Dentz
