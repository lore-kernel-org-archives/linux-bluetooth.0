Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4C80CE3E.8020004@linux.intel.com>
References: <4C80CE3E.8020004@linux.intel.com>
Date: Sat, 4 Sep 2010 22:07:40 +0300
Message-ID: <AANLkTi=9HR+iTm=baVdefQcd-Nb8Gchx3LN6q-CycMcq@mail.gmail.com>
Subject: Re: BD address changed but pairing failed
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sebastien Cayetanot <sebastien.cayetanot@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 3, 2010 at 1:30 PM, Sebastien Cayetanot
<sebastien.cayetanot@linux.intel.com> wrote:
>  All,
>
> I'm currently facing an issue regarding the pairing of BT devices after
> having change the BD_Addr.
>
>
> I use a TI chip and also use hci command or bdaddr script to modify the
> bd_addr
>
> I'm also using the bluez-4.69
>
> I change the BD_Addr using the bdaddr scripts provided into the bluez src.
>
> When other devices scan me, the new address is seen but hciconfig still show
> the old BD address.
>
> I have sent the hcitool cmd to read the bd_addr and after the hciconfig
> return the one.
>
> I'm discoverable with the new BD address.
>
> But When I try to pair an A2DP headset or BT Keyboard/Mouse it failed since
> BD_Addr change.
>
> I have try to use directly the hcitool cmd using the vendor specific command
> but I got the same result.
>
> I have tried to kill bluetooth daemon and restart it after having change the
> bd_addr. Still failing.
>
> I have tried to kill bluetooth daemon before changing the BD adress and
> start it after the change it still fail.
>
> I have also tried to power on/off interface. still the issue
>
> I think that something is "broken" is bluez when the BD_Addr is changed.
>
> Is someone already seen this issue ?

I don't think you are suppose to change the address like that, it is
supposed to be done once in the chip initialization and then keep it
like that forever, so I guess there is something wrong if the chip is
already initialize with the wrong address. What are you trying achieve
with this?

-- 
Luiz Augusto von Dentz
Computer Engineer
