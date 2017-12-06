Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171206065119.GA10541@x1c.home>
References: <20171205183327.853-1-luiz.dentz@gmail.com> <20171205183327.853-3-luiz.dentz@gmail.com>
 <fb1a7761-4b4a-a647-d9f9-ab9634eb1266@jp.fujitsu.com> <20171206065119.GA10541@x1c.home>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Dec 2017 14:15:08 +0200
Message-ID: <CABBYNZ++Kh8bF3+iEhZTem+a4-SEB2Z2zp0Oq4aG_9kcOELG5g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] tools/obexctl: Use bt_shell helpers
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto, Johan,

On Wed, Dec 6, 2017 at 8:51 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Wed, Dec 06, 2017, ERAMOTO Masaya wrote:
>> On 12/06/2017 03:33 AM, Luiz Augusto von Dentz wrote:
>> > This makes obexctl use bt_shell to manage the menus and command
>> > handling.
>> > ---
>> >  Makefile.tools  |   5 +-
>> >  tools/obexctl.c | 609 ++++++++++++++++----------------------------------------
>> >  2 files changed, 175 insertions(+), 439 deletions(-)
>>
>> The previous obexctl gives arguments included a command name to the command, but
>> bt_shell gives arguments excluded a command name. So you should fix argc/argv
>> related processes in each command. Also bt_shell automatically checks passed
>> arguments.
>> You can refer to the attached patch about these things.
>
> If you ask me, I think we should keep this consistent with obexctl and
> e.g. how main() gets called. I.e. argv[0] is the command. An added
> benefit of this is that two very similar commands (taking the same
> parameters) can use the same command handler, since they'll be able to
> distuinguish which command was used.

Yep, lets keep the command name then and fix bluetoothctl.

-- 
Luiz Augusto von Dentz
