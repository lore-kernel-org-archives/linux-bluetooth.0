Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <11039254.T5CGnodsWr@leonov>
References: <CAJgpifs7FyA5o+6BTQ1S8wv8fVhSXCWbzUrDvOqFrz8KqyMc8w@mail.gmail.com>
	<CABBYNZKSpFw4arsZFA=jGNq1Q7svVzzAemHD31dfempWMqHxog@mail.gmail.com>
	<11039254.T5CGnodsWr@leonov>
Date: Wed, 2 Mar 2016 14:42:26 +0000
Message-ID: <CAJgpifuAVJVdDRbXF3W=LShonUKnujbEptRN3SKw06xaJpd8Jw@mail.gmail.com>
Subject: Re: Writing an out of the tree new GATT service (for Debian stable):
 plugin or DBus?
From: Olivier Martin <olivier.martin.fr@gmail.com>
To: Szymon Janc <ext.szymon.janc@tieto.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Szymon that is the limitation I was suspecting about. After
having a quick look to the btd_* functions, it looks to be unlikely I
can register a GATT server service with an external plugin.

On 2 March 2016 at 14:34, Szymon Janc <ext.szymon.janc@tieto.com> wrote:
> Hi,
>
> On Wednesday 02 of March 2016 16:18:22 Luiz Augusto von Dentz wrote:
>> Hi Olivier,
>>
>> On Wed, Mar 2, 2016 at 3:20 PM, Olivier Martin
>>
>> <olivier.martin.fr@gmail.com> wrote:
>> > Hello all,
>> > I am looking at writing a new GATT (server) service for my Linux-based
>> > bluetooth device using Bluez.
>> > My device use Debian stable (Jessie) that uses Bluez v5.23.
>> > Ideally, I would like to build my GATT service out of the Bluez tree.
>> > As far as I understand I have two solutions:
>> >
>> > Solution A) Stay with Bluez v5.23 and write a plugin. I managed to
>> > build `plugins/gatt-example.c` out of the tree. But when `bluetoothd`
>> > loads the plugin, it fails to find the symbol `attrib_db_update`. I am
>> > wondering if it is due to the fact `shared/gatt-server` has not been
>> > added to v5.23
>> > (https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/shared?h=5.23).
>> > And in this case it would not be possible to have a GATT service out of
>> > the tree for this Bluez version.
>>
>> It depends on the level of control you want to have, if you need extra
>> permissions and low level of access than perhaps building as a plugin
>> is probably a good idea. BlueZ daemon works kind similar to the
>> kernel, the internal API may change so building out of the tree will
>> never be very stable, and you still have to comply to GPL.
>>
>> > Solution B) Moving to the latest Bluez version and use the GATT server
>> > D-BUS API. But it means I need to remove and replace Bluez on my
>> > stable Debian. I understand this solution is the long term solution
>> > but it might take a while before the Linux distributions used this
>> > version of Bluez.
>>
>> If more people like you starting using this features it might become
>> stable faster, thus we encourage people to go with this solution. Btw,
>> you can disable the BlueZ from your distro and just run BlueZ from
>> source without overwriting anything from your distro.
>>
>> > So, is it possible to have an out of the tree plugin with v5.23? I saw
>> > `sixaxis` plugin. But this plugin does not manipulate GATT services
>> > and characteristics.
>>
>> Possible, yes, but it is not recommended, but you can try to create a
>> external plugin that is build within the source tree so that we keep
>> it working as we change the internal APIs.
>
> External plugins (like sixaxis) are able to use only btd_* (plus few
> exceptions) functions. If you want to use other symbols you would have
> to go with builtin plugin.
>
> --
> BR
> Szymon Janc
