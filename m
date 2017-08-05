Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKPf1JOr4BiDEsRibUd37pWC=Y8uVe2Gv_Op5S0qB41XQ@mail.gmail.com>
References: <CAGfak60obAiVJToyRbPvVmsjO3phw4SpL8Wn_mgucNeSUFOG-g@mail.gmail.com>
 <CABBYNZKPf1JOr4BiDEsRibUd37pWC=Y8uVe2Gv_Op5S0qB41XQ@mail.gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sat, 5 Aug 2017 09:36:16 +0300
Message-ID: <CAMQUNB-1XSM0LCWDJN117x3kZ0Nq7C1szsawkL8aj01P90E5JQ@mail.gmail.com>
Subject: Re: Support for SPP 1.2 Specification in Bluez
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 4, 2017 at 3:59 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Karunakar,
>
> On Thu, Aug 3, 2017 at 3:37 PM, Karunakar Reddy <karan.tillu@gmail.com> wrote:
>> Hi All,
>>
>> We are looking for bluez stack revision which has support for SPP 1.2
>> specification. As per the information we have collected, it seems to
>> have support for SPP 1.1 only.
>>
>> Are there any plans for Bluez to add support for SPP 1.2?
>
> Patches are always welcome.

As far as I know we're already compliant. E.g. the SPP SDP record that
bluetoothd registers when an app uses the Profile D-Bus interface sets
the SPP version as 1.2.

Johan
