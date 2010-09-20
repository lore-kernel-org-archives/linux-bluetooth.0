Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth Management Interface
Date: Mon, 20 Sep 2010 14:07:43 +0300
Message-Id: <1284980866-3974-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a initial set of patches to get the Bluetooth Management
interface work started. As I've mentioned in previous emails the idea of
this interface is to replace all current HCI level access in bluetoothd.
Many things, e.g. SSP logic and name resolving, will be moved to the
kernel side so there wont be a one-to-one mapping from the new
interface to the current HCI messages that bluetoothd handles.

The patches here just add the initial header file definitions and a
command line test tool. The kernel side patches can be found from my
kernel.org git tree:
http://git.kernel.org/?p=linux/kernel/git/jh/linux-2.6.git;a=summary

Access to the new kernel interface is done with the help of a new
hci_channel member of the HCI socket address. Only channel 1 is defined
for now for the new messages, but I've understood Marcel has plans to
enable some sort of special tracing support through a second channel.
Messages with hci_channel == 1 from userspace get routed to the
callbacks defined in net/bluetooth/hci_mgmt.c.

So far I haven't made many changes to the initial draft API doc from
Marcel (doc/mgmt-api.txt). The general idea is to try to mimic standard
HCI messaging concepts whenever possible. One of the changes that I did
do is removal of the Num_Command_Packets parameters from the command
status and command complete events since I don't think it makes sense to
require userspace to do command queuing.

Next steps that need to be done for bluetoothd:

- Move all HCI socket access to hciops.c
  - All ioctl and hci_* calls
  - HCI event processing (mostly src/security.c)
- Create a new mgmtops.c for the new API which can ultimately replace
  hciops.c
- Figure out exactly which features are needed in the new API and fill
  in doc/mgmt-api.txt accordingly.

Next steps for the kernel side:

- Define structs for each message. Not sure if this is needed/wanted but
  it would surely improve the readability of the current code that
  accesses the byte array directly. Since the new protocol and the
  format of the messages is still largely open I haven't bothered with
  these structs yet.
- Implement handling of events (right now only commands and direct
  responses to them are supported)
- Implement handling of commands that require sleeping (currently all
  implemented commands imediately write the response to the socket)

Any feedback is welcome about these plans and the code. It's my first
attempt at more serious kernel side coding so there might well be issues
needing fixing/polishing in the code.

Johan

