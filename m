Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150213091557.GA30773@t440s.lan>
References: <1423795883-13182-1-git-send-email-jpawlowski@google.com>
	<20150213091557.GA30773@t440s.lan>
Date: Fri, 13 Feb 2015 09:25:37 -0800
Message-ID: <CAD0=r8yV2KQibaSht_aFHhQNQi4Ow_4mLWJrEx7f26FF-rdD3w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix service discovery behaviour for empty
 uuids filter
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Feb 13, 2015 at 1:15 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Thu, Feb 12, 2015, Jakub Pawlowski wrote:
>> This patch fixes service discovery behaviour, when provided uuid filter
>> is empty and HCI_QUIRK_STRICT_DUPLICATE_FILTER is set. Before this
>> patch, empty uuid filter was unable to trigger scan restart, and that
>> caused inconsistent behaviour in applications.
>>
>> Example: two DBus clients call BlueZ, one to find all devices with
>> service abcd, second to find all devices with rssi smaller than -90.
>> Sum of those filters, that is passed to mgmt_service_scan is empty
>> filter, with no rssi or uuids set.
>> That caused kernel not to restart scan when quirk was set.
>> That was inconsistent with what happen when there's only one of those
>> two filters set (scan is restarted and reports devices).
>>
>> To fix that, new variable hdev->discovery.service_discovery was
>> introduced. It can indicate that filtered scan is running, no matter
>> what uuid or rssi filter is set.
>>
>> Thi patch also closes all code responsible for filtered discovery in
>
> Minor typo there: s/Thi/This/
>
>> one if statement. That makes whole code shorter, much more readable,
>> and easier to backport to older kernels, especially pre 3.10.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>>  include/net/bluetooth/hci_core.h |   2 +
>>  net/bluetooth/mgmt.c             | 140 +++++++++++++++------------------------
>>  2 files changed, 55 insertions(+), 87 deletions(-)
>
> Would it be possible to provide a mgmt-tester case to catch this issue?
> The fact that this issue wasn't noticed earlier can be seen as an
> indication that the mgmt-tester coverage of this API isn't good enough.

I don't think it's possible to create mgmt-tester test for this issue yet.
I'll need ability to control quirks, and then to specify that
controller responded with device advertisement, it'll be pretty
complicated. I havent seen any example doing such things, and after
looking at hci_vhci.c and mgmt-tester.c it looks impossible right now.
I do however have plans to play with mgmt-tester and add some
functionalities to make this test possible after I add the DBus
interface code.

>
> Do you think this is critical enough that we should try to get a fix
> still for 3.20 through bluetooth.git? The fact that the patch looks
> largely as refactoring (as opposed to a clear fix) might make that
> difficult.

I don't think it's critical enough.

>
> Johan
