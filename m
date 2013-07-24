Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Jul 2013 09:07:57 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/8] Hook mechanism for discovery tests
Message-ID: <20130724160757.GB22830@x220.p-661hnu-f1>
References: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Sat, Jul 20, 2013, Bruna Moreira wrote:
> This series contains the hook mechanism implementation that will be used for
> discovery tests.
> 
> The hook mechanism is a way to run custom code from tests before/after
> processing HCI commands and building events. It is also possible to "cancel"
> events if the post event hook returns false. This is necessary because the
> current emulator implementation is sequential and does not let having control
> about emulator behaviour.
> The hooks will only intercept the events which were registered previously using
> the hooks API exported by hciemu. If no hooks are added, the emulator will work
> as before.
> To simplify implementation, default_cmd() was split in two parts: the command
> response (command status/complete events) was kept in default_cmd() and "extra"
> events were moved to default_cmd completion().
> There are four hooks types:
> - pre command: before default_cmd() function.
> - post command: before sending packet in command status and command complete.
> - pre event: before default_cmd_completion() function.
> - post event: in send_event() function, before sending the packet.
> They can used in external applications like tools/mgmt-tester.
> 
> To illustrate this purpose, the following discovery test was implemented using
> this new infrastructure:
> - Stop discovery for BR/EDR only: this test sends stop command during inquiry,
>   checks if inquiry cancel is sent and discovering event is disabled.
> 
> Note that in current implementation it is not possible to send a stop discovery
> before the discovery is finished due to emulator running sequentially during
> same mainloop iteration, i.e., the inquiry complete HCI command is sent
> immediately after inquiry command.
> 
> Comments and suggestions are welcome.
> 
> BR,
> Bruna Moreira.
> 
> Bruna Moreira (2):
>   emulator: Add new function for running all hooks
>   tools/mgmt-tester: Add stop discovery for BR/EDR only
> 
> Eder Ruiz Maria (6):
>   emulator: Add support for pre/post command/event hooks
>   emulator: Add hook only if there aren't other with same type and
>     opcode
>   emulator: Export command and event hooks for hciemu user
>   emulator: Add support for delete a hook
>   emulator: Split default_cmd() for better command and event handler
>   emulator: cmd_status() using send_packet() for run hooks easily
> 
>  emulator/btdev.c    |  271 +++++++++++++++++++++++++++++++++++++++++++--------
>  emulator/btdev.h    |   18 ++++
>  src/shared/hciemu.c |   58 +++++++++++
>  src/shared/hciemu.h |   17 ++++
>  tools/mgmt-tester.c |   72 +++++++++++++-
>  5 files changed, 395 insertions(+), 41 deletions(-)

All patches in the set have been applied. Thanks.

Johan
