Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141208184310.GC16755@t440s.ger.corp.intel.com>
References: <1411599462-8680-1-git-send-email-scott@netsplit.com>
	<1411599462-8680-3-git-send-email-scott@netsplit.com>
	<20141208184310.GC16755@t440s.ger.corp.intel.com>
Date: Tue, 9 Dec 2014 11:10:16 +0200
Message-ID: <CABBYNZ+S5dPBP7-6dXLjoh-6Bh36sYEQ7wydyb-J9ZA2TN9X0w@mail.gmail.com>
Subject: Re: [PATCH] core: add D-Bus property for ServiceData
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Scott James Remnant <scott@netsplit.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"keybuk@chromium.org" <keybuk@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott, Johan,

On Mon, Dec 8, 2014 at 8:43 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Scott,
>
> On Wed, Sep 24, 2014, Scott James Remnant wrote:
>> Since the standard doesn't make any specific requirement that a UUID
>> present in a Service Data field be also present in a specific UUIDs
>> field, the UUIDs are also added to that list as well.
>> ---
>>  doc/device-api.txt |  9 ++++++
>>  src/adapter.c      |  1 +
>>  src/device.c       | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  src/device.h       |  1 +
>>  src/eir.c          | 72 +++++++++++++++++++++++++++++++++++++++++++++
>>  src/eir.h          | 11 +++++++
>>  6 files changed, 179 insertions(+)
>
> This too looks fine, but the documentation and EIR parsing parts should
> be split into their own patches.

Another possibility would be to add a Data property to
org.bluez.GattService1, but then if the service is not gatt based
perhaps we need something else. I had actually plans to introduce a
generic Service interface as a plugin, it was originally meant to
provide a better control over connections for classic, the interface
documentation can be found here:

https://gitorious.org/bluez/vudentzs-clone/source/b19b4b043fff27e6c3bdbb5e5eefef9b7c0de95b:doc/service-api.txt

This could be exposed in the same object as org.bluez.GattService1 but
we would need to align because right now the paths are different,
having another Property would be easy to add and we can mark some
properties optional in case they don't make sense in LE.


-- 
Luiz Augusto von Dentz
