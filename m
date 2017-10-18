Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7B53A3173656CB4190908401FE75F4F860077BD9@exgmbxfz02.sasken.com>
References: <7B53A3173656CB4190908401FE75F4F860077BD9@exgmbxfz02.sasken.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Oct 2017 12:19:54 +0300
Message-ID: <CABBYNZKz3ScfkX_5NeQgBeGhA4T_O-AhroD4nkLxrtN63w76+Q@mail.gmail.com>
Subject: Re: Need info on factory reset api in Bluez
To: Anitha Chandrasekar <anitha.chandrasekar@sasken.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anitha,

On Tue, Oct 17, 2017 at 2:52 PM, Anitha Chandrasekar
<anitha.chandrasekar@sasken.com> wrote:
> Hi,
>
> We are using bluez stack apis for developing BLE client.Our device has an option of factory reset.
> I have tried using rfkill etc to reset the controller, but I see that devices are not getting deleted from gatt database.
>
> Is there any single api call, which is used for factory reset in Bluez?

Usually, this is implemented by wiping the storage which is under
/var/lib/bluetooth.


-- 
Luiz Augusto von Dentz
