Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <TU4PR84MB031993F9D5F95A651BCFBC65CDF30@TU4PR84MB0319.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB031993F9D5F95A651BCFBC65CDF30@TU4PR84MB0319.NAMPRD84.PROD.OUTLOOK.COM>
Date: Mon, 11 Jan 2016 12:10:16 -0300
Message-ID: <CABBYNZJeK9==T5JxWk3rjiaMtkcPhn9=aDUMB8fNwWzeXLFtWw@mail.gmail.com>
Subject: Re: Creating BLE Server application with BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Stanbro, Matthew A." <matthew.a.stanbro@hp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

On Tue, Jan 5, 2016 at 3:36 PM, Stanbro, Matthew A.
<matthew.a.stanbro@hp.com> wrote:
> Hello Everyone,
>
> I am new to working with BlueZ and I am trying to get a handle on how to create a BLE service and add characteristics. Looking around the web I can find quite a bit of information about using BlueZ as a BLE client for connecting to other BLE devices to read/write attributes, but I am struggling to find anything which helps explain creating a BLE service and dealing with advertising. Can anyone point me to a resource for learning to work with the BlueZ C api for creating/starting/stopping services, adding/modifying characteristics, starting/stopping/modifying advertisments? Thanks in advance for any help you can offer.

Currently there is no sample in C but the plan is to add some support
to bluetoothctl to do that, in the meantime you can check the examples
in python under test/example-gatt-server and test/example-advertising.
Alternatively you can create a plugin and link it directly with the
daemon so that you can use BlueZ C API, but this is only recommended
if you need low level access or there is security implication/special
access necessary for the services you want to add.



-- 
Luiz Augusto von Dentz
