Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331044542.3392.168.camel@aeonflux>
References: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
	<1331035658-10000-3-git-send-email-luiz.dentz@gmail.com>
	<CAJdJm_OmpNXq-hhqAQTXn-rvOk1eJhfQzuGdt2pQLRaa4+F1og@mail.gmail.com>
	<CABBYNZL3tUpmqEHPx+6LJkJjZMDf7ajc0d-x_n51=i6HX03nng@mail.gmail.com>
	<1331044542.3392.168.camel@aeonflux>
Date: Wed, 7 Mar 2012 10:14:18 +0200
Message-ID: <CABBYNZK+Te2_dXweZ9xMPv8+ha9V9W_bLC2SuEpu7EQiinrFPw@mail.gmail.com>
Subject: Re: [RFC BlueZ 3/3] core: Add Interfaces property to org.bluez.Device
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 6, 2012 at 4:35 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> > On Tue, Mar 6, 2012 at 8:07 AM, Luiz Augusto von Dentz
>> > <luiz.dentz@gmail.com> wrote:
>> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >>
>> >> This enables applications to be able to detect when an interface is
>> >> enabled/disabled without depending on UUIDs.
>> >> ---
>> >>  doc/device-api.txt |    4 ++++
>> >>  src/device.c       |   27 ++++++++++++++++++++++-----
>> >>  2 files changed, 26 insertions(+), 5 deletions(-)
>> >
>> > I thought it was possible to achieve this by using D-Bus listeners?
>> > E.g. similar to g_dbus_add_service_watch()
>>
>> Afaik there is no such thing as introspection data changed or anything
>> like that, we could in theory have local listeners, but at least in
>> BlueZ there is no much use for them since it is not really dynamic
>> after drivers are loaded, but perhaps for oFono and others it could be
>> useful to have some way to watch when interfaces changes.
>>
>> In case of oFono it does that by having e.g.
>> ofono_modem_add_interface/ofono_modem_remove_interface.
>>
>> > What happens when the interface is unregistered with
>> > g_dbus_unregister_interface() ?
>>
>> This should only be the case when removing the object so the driver
>> .remove is called which then calls g_dbus_unregister_interface.
>
> I was not planning to add this to our gdbus code and focus on getting
> this right for ELL. However look into the D-Bus ObjectManager
> specification since that is what you want actually.

So the way forward is to implement ObjectManager? We could have that
without breaking any API, but I guess it would make sense to change
API such as the manager to take advantage of the ObjectManager.

Btw what is ELL?


-- 
Luiz Augusto von Dentz
