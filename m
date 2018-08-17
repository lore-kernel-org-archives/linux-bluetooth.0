Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <BN7PR07MB4305C0AA4DBCB0136D7F72199D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
References: <BN7PR07MB4305C0AA4DBCB0136D7F72199D3E0@BN7PR07MB4305.namprd07.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 17 Aug 2018 09:14:47 +0300
Message-ID: <CABBYNZKSuDMX38OszjLZOEt9L_f5YM1L000-hb0Gv9LqcGSPOA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Change ConnectDevice to optionally connect services
To: "Karabin, Josh" <George.Karabin@honeywell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Josh,

On Thu, Aug 16, 2018 at 11:26 PM, Karabin, Josh
<George.Karabin@honeywell.com> wrote:
> This patch set makes it possible to use the experimental Adapter1
> ConnectDevice DBUS API to connect to a device without also
> connecting each of the devices service. This enables out-of-band
> discovery of an address with the conditional behavior of calling
> ConnectProfile on a discovered device.
>
> I chose to change the default behavior of the ConnectDevice API.
> It will only connect all services if you set a new ConnectAllDevices
> boolean value in the dictionary argument.
>
> I feel that that makes a better default, and with this still being
> an experimental API, I'll ask to see how others feel.

I wonder how this is suppose to work since what you are suggesting is
to not auto-connect matching profiles/services, but that would leave
the ACL link with no channels in use (at least on BR/EDR) so the link
would disconnect anyway.


> This would require changes to users of the original commit:
>
> commit c3f7b6733c5f ("adapter: Add ConnectDevice method")
>
> I would be fine with changing the API in some other way that makes this
> use case possible - this is just my preference.
>
> You may have seen questions about this a little bit ago - this is the
> follow-up:
>
> https://marc.info/?l=linux-bluetooth&m=153317507925739&w=2
> https://marc.info/?l=linux-bluetooth&m=153315011619515&w=2
>
> George Josh Karabin (2):
>   Change the experimental Adapter1 ConnectDevice api to default to not
>     connecting all profiles, using an optional parameter to restore the
>     current behavior.
>   Update the Adapter1 API to match the change to ConnectDevice.
>
>  doc/adapter-api.txt | 15 ++++++++++-----
>  src/adapter.c       | 18 +++++++++++++++---
>  2 files changed, 25 insertions(+), 8 deletions(-)
>
> --
> 2.17.1
>



-- 
Luiz Augusto von Dentz
