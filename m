Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160411120058.GA15243@t440s.P-661HNU-F1>
References: <CAHhAz+hDBUz-PN5CNce8ujaiPnNA1H4f7sdQUTxWF2rVq6r2cA@mail.gmail.com>
	<20160411120058.GA15243@t440s.P-661HNU-F1>
Date: Mon, 11 Apr 2016 17:58:48 +0530
Message-ID: <CAHhAz+j70Ea5L11_pZKFstO11R9yVoVPzOEPNMssqeUbU=k5tA@mail.gmail.com>
Subject: Re: BT over SDIO
From: Muni Sekhar <munisekharrms@gmail.com>
To: johan.hedberg@gmail.com, kernelnewbies@kernelnewbies.org,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Apr 11, 2016 at 5:30 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Sekhar,
>
> On Mon, Apr 11, 2016, Muni Sekhar wrote:
>> Does BlueZ supports for Bluetooth devices over SDIO protocol?
>>  If so any links to test procedure will be useful.
>
> There's a btsdio driver for that. See drivers/bluetooth/btsdio.c in the
> kernel source tree.
Thanks Johan. I loaded the btsdio.ko, and then followed the below
mentioned steps to "display my bluetooth device" and "search for
remote bluetooth devices", but failed. Any idea?

# lsmod | grep bt
btsdio                 13708  0
bluetooth             446286  11 bnep,btsdio,rfcomm


# /etc/init.d/bluetooth status
 * bluetooth is running


# /etc/init.d/bluetooth start
 * Starting bluetooth

        [ OK ]


/* Display Bluetooth device */
# hcitool dev
Devices:


/* search for remote Bluetooth devices */
# hcitool scan
Device is not available: No such device


>
> Johan



-- 
Thanks,
Sekhar
