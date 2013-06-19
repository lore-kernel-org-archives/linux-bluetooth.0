Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jun 2013 13:02:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ 00/35] More discovery tests
Message-ID: <20130619100251.GD6370@x220>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Jun 12, 2013, Bruna Moreira wrote:
> This series implements more complex discovery tests and all necessary support
> in the emulator. It is rather long because it required many modifications to
> the emulation layer in order to support these tests.
> 
> Patches 1-11 implement basic LE support on emulator. The main features are:
> - Set LE advertising data
> - Set advertising enable command
> - Set LE advertising parameters
> - Send LE advertising report
> - LE create connection command (Basic support for multiple connections).
> NOTE: support for multiple connections is not necessary for discovery tests.
> 
> Patches 12-19 implement hook mechanism.
> The hook mechanism is a way to run custom code from tests before/after
> processing HCI commands and building events. It is also possible to "cancel"
> events if the post event hook returns false. To simplify implementation,
> default_cmd() was split in two parts: the command response (command
> status/complete events) was kept in default_cmd() and "extra" events were moved
> to default_cmd completion().
> 
> There are four hooks types:
> - pre command: before default_cmd() function.
> - post command: before sending packet in command status and command complete.
> - pre event: before default_cmd_completion() function.
> - post event: in send_event() function, before sending the packet.
> They can used in external applications like tools/mgmt-tester.
> 
> Patches 20-25 and 28-35 implement discovery tests.
> For start discovery, we have:
> - Start BR/EDR Discovery and wait for Device Found event from BR/EDR device.
> - Start LE-only Discovery and wait for Device Found event from LE device.
> For stop discovery:
> - Stop BR/EDR Discovery during Inquiry (no devices found).
> - Wait for Device Found event from BR/EDR device and stop BR/EDR Discovery during:
>   - Inquiry.
>   - Name Resolving.
> - Wait for Device Found event from LE device and stop interleaved discovery
>   during LE scanning.
> - Wait for Device Found event from BR/EDR device and stop interleaved discovery
>   during:
>   - Inquiry.
>   - Name Resolving.
> - Wait for Device Found event from LE device and stop LE-only Discovery during
>   LE scanning.
> 
> NOTE: currently, bluetoothd should not be running during tests because it will
> try to change EIR data for the second virtual controller (which represents the
> remote device) and thus will not match the data statically declared on the
> tests.
> 
> Patch 26 adds support for saving a packet cancelled by a post event hook, so it
> can be sent later.
> 
> Patch 27 contains a fix already sent to the mailing list (with some
> modifications to apply upstream):
>  emulator: Fix Remote Name Request Cancel command complete
> 
> Comments and suggestions are welcome.
> 
> BR,
> Bruna Moreira.
> 
> Anderson Lizardo (1):
>   emulator: Fix Remote Name Request Cancel command complete
> 
> Bruna Moreira (16):
>   emulator: Add remove operation in HCI hook callback
>   emulator: Add new function for running all hooks
>   tools/mgmt-tester: Add stop discovery for BR/EDR only
>   tools/mgmt-tester: Add support for second controller
>   tools/mgmt-tester: BR/EDR Start discovery (Device Found)
>   tools/mgmt-tester: LE only Start discovery (Device Found)
>   tools/mgmt-tester: Split test_command_generic()
>   tools/mgmt-tester: BR/EDR Stop discovery (Device Found)
>   btdev: Add function to send an aborted packet
>   tools/mgmt-tester: Move command_generic_callback()
>   tools/mgmt-tester: BR/EDR Stop discovery (Name Resolving)
>   tools/mgmt-tester: Add support to set emulator type
>   tools/mgmt-tester: Interleaved stop discovery (LE dev. found)
>   tools/mgmt-tester: Increase timeout for dual mode controller
>   tools/mgmt-tester: Interleaved stop discovery (BR/EDR dev. found)
>   tools/mgmt-tester: Interleaved Stop discovery (Name Resolving)
> 
> Eder Ruiz Maria (7):
>   emulator: Add support for pre/post command/event hooks
>   emulator: Add hook only if there aren't other with same type and
>     opcode
>   emulator: Export command and event hooks for hciemu user
>   emulator: Add support for delete a hook
>   emulator: Split default_cmd() for better command and event handler
>   emulator: cmd_status() using send_packet() for run hooks easily
>   tools/mgmt-tester: LE Stop discovery (Device Found)
> 
> Jefferson Delfes (11):
>   emulator: Add support for multiple connections
>   emulator: Store LE advertising data length in btdev
>   emulator: Implement basic LE set adv enable command
>   emulator: Store LE scan state of virtual controller
>   emulator: Search virtual devices in LE advertising mode
>   emulator: Search virtual devices in LE scan mode
>   emulator: Implement LE advertising report
>   emulator: Implement basic LE create connection
>   emulator: Dummy LE set advertising parameters
>   emulator: Disallow LE set scan params command when scan is enabled
>   emulator: Set LE supported states
> 
>  emulator/btdev.c    |  619 +++++++++++++++++++++++++++++++++++++++------
>  emulator/btdev.h    |   20 ++
>  monitor/bt.h        |   17 ++
>  src/shared/hciemu.c |   87 ++++++-
>  src/shared/hciemu.h |   22 +-
>  tools/mgmt-tester.c |  690 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  6 files changed, 1338 insertions(+), 117 deletions(-)

You should know by now that huge patch bombs like this are not really
appreciated (this is part of the reason why it has taken so long to get
any response to it). Could you please split this up in some sensible
way, e.g. put clear fixes and necessary refactoring into its own patch
set (which shouldn't need the RFC declaration).

Johan
