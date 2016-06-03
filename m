Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <85edbbc7-91ca-368a-1a2c-db5463a22df5@gmail.com>
References: <85edbbc7-91ca-368a-1a2c-db5463a22df5@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 Jun 2016 13:11:34 +0300
Message-ID: <CABBYNZ+PT=jMXvfem_n9u=P96p1fFG0GWDwrPmg7N3+Ebt6Rxw@mail.gmail.com>
Subject: Re: Proximity Profile (PXP) Reporter
To: Marco Trapanese <marcotrapanese@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

On Fri, Jun 3, 2016 at 10:03 AM, Marco Trapanese
<marcotrapanese@gmail.com> wrote:
>
>
> I have a linux-based machine, which runs bluez 5.39. I want to setup a
> Proximity Reporter on that:
>
> https://developer.bluetooth.org/TechnologyOverview/Pages/PXP.aspx
>
> I edited the proximity.conf file:
>
> https://github.com/r10r/bluez/blob/master/profiles/proximity/proximity.conf
>
> [General]
> Disable=
>
> in order to enable all options. Now, I don't know how to "start" the
> Reporter service. I would use a smartphone (Android or iOS) with any App as
> Monitor to connect and "track" my machine.
>
> Please, would you help me to understand how to use this profile?

PXP plugin is currently not working, the API has changed making it
deprecated, the recommended way to use GATT profiles/service is to use
the D-Bus API which you can find the documentation here:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/gatt-api.txt

-- 
Luiz Augusto von Dentz
