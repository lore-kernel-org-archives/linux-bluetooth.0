Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5065A248.7020009@linux.intel.com>
References: <50642389.40107@intel.com>
	<CAJdJm_NbPw0jwWvuUiu7L=wzxc+qxfF_4i2vj7U1G06b=BE2qw@mail.gmail.com>
	<5065A248.7020009@linux.intel.com>
Date: Fri, 28 Sep 2012 10:04:52 -0400
Message-ID: <CAJdJm_O+8tWER69LEbz9oMeoadfp=gGT3_6V0=fY-LDZ8B90kA@mail.gmail.com>
Subject: Re: [RFC] Convert storage to use per-remote device directories
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Fri, Sep 28, 2012 at 9:12 AM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> Following glib documentation:
> "groups in key files may contain the same key multiple times; the last entry
> wins. Key files may also contain multiple groups with the same name; they
> are merged together."
>
> So, I do not think this meet our needs.

I agree.

>> In LE we can have services with same UUID (not sure if this
>> is valid for BR/EDR also), and they are differentiated by other means
>> (e.g. a "Description" descriptor with different value, besides the
>> different handle).
>
> For BDEDR, it is easy to retrieve info related to a profile as profile's
> UUIDs are unique.
>
> Are "Description" descriptors for a profile well-know or implementation
> dependent ?
>
> Do you think we can use [<UUID>,<Description>] as group name ?

The Description descriptor is profile specific (some profiles don't
have description, but on the other hand are unique in the database).
Unfortunately, I think it is not possible to use them on the group
name.

>> Regarding LE, we have two kinds of storage needs: server profiles, and
>> client profiles.
>>
>> For server profiles, we need to store the attribute database.
>
>
> Is it possible to save it as we did for SDP records (record entry in profile
> group) ?

It seems the SDP records have the UUID as group on the INI file. This
is not feasible for GATT/ATT because the UUID is not a unique key, but
the attribute handle is.

Are you sure that for SDP each record has its own UUID (i.e. no SDP
record shares same UUID)?

>> Currently we don't do this, but we need to implement it, or have
>> ServiceChanged characteristic notifying that the service ranges have
>> changed every time BlueZ restarts (which adds overhead as service
>> discovery is triggered on the client side). I suggest we store the
>> attribute database into a "attribute_db.conf" file containing the
>> attribute name/value/uuid triples.
>
>
> Isn't it possible to save it in [<uuid>] group of device.conf file ?

The attribute database needs to be stored on the adapter side (the
services exposed to remote devices over GATT are group of attributes).

> My first thought for LE data in device.conf is:
>   [<Primary UUID>#<Description>]
>   Handle=
>   Characteristic=
>   Attribute=
>   CCC=

As mentioned above, the "#Description" part is profile specific and
thus not generic enough for the group name (IMHO). It is actually a
high level information (a Characteristic Descriptor, which is just a
special attribute with a specific UUID.

If that helps, this is how I could imagine the attribute database (see
Core Spec page 1950 for an example database where I based the info
below from):

/var/lib/bluetooth/<adapter address>/attribute_db.conf

[0x0001]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=0018

[0x0004]
UUID=00002803-0000-1000-8000-00805f9b34fb
Value=020600002A

[0x0006]
UUID=00002a00-0000-1000-8000-00805f9b34fb
Value=4578616D706C6520446576696365

[0x0010]
UUID=00002800-0000-1000-8000-00805f9b34fb
Value=0118

...

With this format, it is easy to "serialize" and "de-serialize" the
attribute database for the adapter.

I still haven't thought for the client side stuff, but they definitely
be on the device directory.

Hope that helps,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
