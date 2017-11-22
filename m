Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <C2BC44D770753C45AAAC42695FB5BE02012571A2DD@SLC-EXMB01.CORP.SRELAY.COM>
References: <C2BC44D770753C45AAAC42695FB5BE02012571A2DD@SLC-EXMB01.CORP.SRELAY.COM>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Nov 2017 11:01:51 +0200
Message-ID: <CABBYNZKtRF3xmcyabvZrF0TmX8z=LfweAZ=meBH3tqL0-fMrKw@mail.gmail.com>
Subject: Re: mtu negotiation issues
To: Thomas Green <TGreen2@sorenson.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Wed, Nov 22, 2017 at 2:48 AM, Thomas Green <TGreen2@sorenson.com> wrote:
> All,
>
> We are having a problem with negotiating the mtu of a device when re-conn=
ecting.  If we try to re-connect the device and negotiate the mtu it fails =
and after the supervisor timeout and the device requests the termination of=
 the device.  Attached is a log of the process.   We are using bluez5.43.  =
Is this a known issue and is there a patch for it?

The only thing strange on the log is:


> ACL Data RX: Handle 1025 flags 0x02 dlen 6                               =
     [hci0] 16348.382281
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, Legacy, No
Keypresses (0x01)

Which apparently we never respond, all the ATT/GATT traffic goes fine
including the MTU exchange, perhaps the request leads to the
disconnection though at that point it seems we are already encrypted
so it is not clear why the remote is sending that request.

> TIA,
>
> Tom



--=20
Luiz Augusto von Dentz
