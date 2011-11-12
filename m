Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1321139715.15441.438.camel@aeonflux>
References: <CAOazyz26ywy+OWMCbL6JMdEd3zt9Ui8XTAWVXtLLRj_wKq+Uvw@mail.gmail.com>
	<1321139715.15441.438.camel@aeonflux>
Date: Sun, 13 Nov 2011 01:24:09 +0200
Message-ID: <CAOazyz3PxrYfXXy4Weh68Vkz7Atp3nUFG14ufivcFrQJH65p5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Automake AM_CFLAGS, AM_LDFLAGS fixups
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Nov 13, 2011 at 1:15 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Alon,
>
>> Reference: "Flag Variables Ordering"[1]
>>
>> In automake, if you modify CFLAGS or LDFLAGS of a target you
>> actually override the autoconf supplied flags. This is highly
>> none standard and may lead to undesired results, as some
>> targets will be compiled with the autoconf supplied flags and
>> some won't.
>>
>> This patch adds AM_CFLAGS, AM_LDFLAGS to any flags override.
>>
>> Some notes:
>>
>> 1. Remove none common flags:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=3D\""=
$(build_plugindir)"\"
>> Moved to bluetoothd only, as BLUETOOTH_PLUGIN_BUILTIN should effect
>> only sources compiled within it.
>> And PLUGINDIR is used only by the daemon.
>>
>> 2. More targets now will be compiled with:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@
>> If this is a problem I will add these to specific targets.
>>
>> 3. I am not sure there is a reason to set specific trivial CFLAGS for
>> simple includes in target specific. Simpler is to put all at AM_CFLAGS.
>>
>> 4. All @XXX_XXFLAGS@ can actually be used as make macros $(XXX_XXFLAGS),
>> Since AC_SUBST are automatically generated as make macros.
>>
>> 5. Why don't you split up the Makefile.am into smaller by
>> directory/library? It would be easier to control the setup.
>>
>> [1] http://www.gnu.org/software/automake/manual/automake.html#Flag-Varia=
bles-Ordering
>>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
>
> please no Signed-off-by lines, we are not using them for the userspace
> parts.

I did not think it damage anything...

> And also please send patches inline and via attachments.

This would be difficult, as gmail does not allow no wrapping.
git accepts this correctly, I use:

$ curl article.gmane.org/gmane.linux.bluez.kernel/18337/raw | git am

If this is really important I will try to find some other mail client.

> I also prefer that you split this into two patches, one for CFLAGS and
> one for LDFLAGS.

In a few moments.

Alon.
