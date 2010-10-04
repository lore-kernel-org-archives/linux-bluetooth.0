Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin5RWCfX07xRUfVvkq+C47AOJXCCRpMVa-vqrRA@mail.gmail.com>
References: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
	<20100929134521.GA19362@jh-x301>
	<AANLkTimvvp=D+X+TcP3Ji7WuGaMZF7+LA+8BWZiQCStr@mail.gmail.com>
	<20100930073938.GA6964@jh-x301>
	<AANLkTikADcqHYfOjmRQVEDdPuU9mrGVvAVGNUdRTsQcd@mail.gmail.com>
	<AANLkTin5RWCfX07xRUfVvkq+C47AOJXCCRpMVa-vqrRA@mail.gmail.com>
Date: Mon, 4 Oct 2010 14:27:20 -0300
Message-ID: <AANLkTinF1OWKMzuArUS6ptWiDTtvQuXxxW9B5ks3tebW@mail.gmail.com>
Subject: Re: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 30, 2010 at 6:51 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> On Thu, Sep 30, 2010 at 11:28 AM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> On Thu, Sep 30, 2010 at 4:39 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>>> Hi Claudio,
>>>
>>> On Wed, Sep 29, 2010, Claudio Takahasi wrote:
>>>> StartDiscovery() triggers all the process. The adapter type: BR/EDR
>>>> only/LE only or dual mode is hidden from the higher layers.
>>>> So, your suggestion it try to hide all discovery details inside the
>>>> hciops as much as possible?
>>>
>>> That was the idea yes, but I'm not 100% sure that it's the best
>>> approach. Another question is also how do we want to represent this with
>>> the new management interface. Should the kernel do it "all" through a
>>> single request from userspace or should userspace control the separate
>>> BR/EDR and LE discoveries. If it's the former, then having a single
>>> adapter_ops callback makes sense. If it's the later then we should
>>> probably have two separate ones. Either way I now realize that to
>>> implement this with a single callback we'd need to have the HCI event
>>> processing moved over to hciops and that's not something that will
>>> happen very quickly. So maybe it's better to have these as two separate
>>> adapter_ops callbacks for now.
>>>
>>> Johan
>>>
>>
>> Another point is: scanning needs to be disabled "actively", it is not
>> possible to inform a scanning length like inquiry, it is necessary to
>> create a timeout to disable the scanning. Joining inquiry and scanning
>> inside a single adapter_ops callback will be hard to control the
>> discovery procedure "states". So for now, I prefer two separate
>> callbacks due the scanning timeout and HCI events processing.
>>
>> However, for the new management interface, one single request seems to
>> be more appropriate but extra requests will be necessary to setup the
>> scan and inquiry parameters.
>>
>> Claudio
>>
>
> New pull request! Patches rebased and a new hciops callback function
> has been added to export the write LE host supported command.
>
> The following changes since commit 3a8386d428e385d97b95a890623362321a7e3a19:
>
>  Fix left open socket warning for attribute server (2010-09-30 17:26:55 -0300)
>
> are available in the git repository at:
>  git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
>
> Claudio Takahasi (23):
>      Add LE start and stop scanning
>      Remove RSSI field from the advertising report event
>      Decoding the RSSI parameter from the advertising report event
>      Send Discovering property "FALSE" when the interleave finishes
>      Add length argument on hciops start discovery function
>      Stop inquiry using the length parameter
>      Fix remote name resolution for interleave discovery
>      Add Write LE host supported function
>      Set the LE host supported and disable simultaneous LE and BR/EDR flags
>      Add extended feature mask constants definition
>      Read the local extended features
>      Stop LE scanning when discovery is suspended
>      Rename hciops {start, stop}_discovery to {start, stop}_inquiry
>      Don't enter on interleave mode if there isn't active sessions
>      Code cleanup: improving inquiry logic
>      Clear the remote device found list in the state transition
>      Fix periodic inquiry signals
>      Fixing DeviceDisappeared signal
>      Postpone discovery if still resolving names
>      Add adapter discovery type function
>      Do not send another Discovering TRUE signal if still resolving names
>      Forcing periodic inquiry exit
>      Fix interleave scanning
>
> Vinicius Costa Gomes (1):
>      Add BR/EDR LE interleaved discovery
>
>  lib/hci.c        |   29 +++++
>  lib/hci.h        |   17 +++-
>  lib/hci_lib.h    |    1 +
>  plugins/hciops.c |   69 +++++++++++-
>  src/adapter.c    |  301 +++++++++++++++++++++++++++++++++++++-----------------
>  src/adapter.h    |   38 ++++---
>  src/dbus-hci.c   |   45 +++++++--
>  src/dbus-hci.h   |    1 +
>  src/security.c   |  131 ++++++++++++++----------
>  9 files changed, 449 insertions(+), 183 deletions(-)
>


The following changes since commit 19c8e310329bb6b369f11501afec9ff4223c2971:

  Allow errors to propagate from connection callback (2010-10-04 17:06:49 +0200)

are available in the git repository at:
  git://git.infradead.org/users/cktakahasi/bluez.git for-upstream

Claudio Takahasi (23):
      Add LE start and stop scanning
      Remove RSSI field from the advertising report event
      Decoding the RSSI parameter from the advertising report event
      Send Discovering property "FALSE" when the interleave finishes
      Add length argument on hciops start discovery function
      Stop inquiry using the length parameter
      Fix remote name resolution for interleave discovery
      Add Write LE host supported function
      Set the LE host supported and disable simultaneous LE and BR/EDR flags
      Add extended feature mask constants definition
      Read the local extended features
      Stop LE scanning when discovery is suspended
      Rename hciops {start, stop}_discovery to {start, stop}_inquiry
      Don't enter on interleave mode if there isn't active sessions
      Code cleanup: improving inquiry logic
      Clear the remote device found list in the state transition
      Fix periodic inquiry signals
      Fixing DeviceDisappeared signal
      Postpone discovery if still resolving names
      Add adapter discovery type function
      Do not send another Discovering TRUE signal if still resolving names
      Forcing periodic inquiry exit
      Fix interleave scanning

Vinicius Costa Gomes (1):
      Add BR/EDR LE interleaved discovery

 lib/hci.c        |   29 +++++
 lib/hci.h        |   17 +++-
 lib/hci_lib.h    |    1 +
 plugins/hciops.c |   69 +++++++++++-
 src/adapter.c    |  301 +++++++++++++++++++++++++++++++++++++-----------------
 src/adapter.h    |   38 ++++---
 src/dbus-hci.c   |   45 +++++++--
 src/dbus-hci.h   |    1 +
 src/security.c   |  131 ++++++++++++++----------
 9 files changed, 449 insertions(+), 183 deletions(-)
