Return-Path: <cyrus@holtmann.org>
Message-ID: <5065A248.7020009@linux.intel.com>
Date: Fri, 28 Sep 2012 15:12:40 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] Convert storage to use per-remote device directories
References: <50642389.40107@intel.com> <CAJdJm_NbPw0jwWvuUiu7L=wzxc+qxfF_4i2vj7U1G06b=BE2qw@mail.gmail.com>
In-Reply-To: <CAJdJm_NbPw0jwWvuUiu7L=wzxc+qxfF_4i2vj7U1G06b=BE2qw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Anderson,

On 28/09/2012 12:56, Anderson Lizardo wrote:
> Hi Frederic,
>
> On Thu, Sep 27, 2012 at 5:59 AM, Frederic Danis
> <frederic.danis@intel.com> wrote:
>> Hi everyone,
>>
>> Here is my proposal for new storage directory structure using ini-file
>> format.
>
> Do you know if the INI parser in glib allows for multiple groups with
> same name?

Following glib documentation:
"groups in key files may contain the same key multiple times; the last 
entry wins. Key files may also contain multiple groups with the same 
name; they are merged together."

So, I do not think this meet our needs.

> In LE we can have services with same UUID (not sure if this
> is valid for BR/EDR also), and they are differentiated by other means
> (e.g. a "Description" descriptor with different value, besides the
> different handle).

For BDEDR, it is easy to retrieve info related to a profile as profile's 
UUIDs are unique.

Are "Description" descriptors for a profile well-know or implementation 
dependent ?

Do you think we can use [<UUID>,<Description>] as group name ?

> Regarding LE, we have two kinds of storage needs: server profiles, and
> client profiles.
>
> For server profiles, we need to store the attribute database.

Is it possible to save it as we did for SDP records (record entry in 
profile group) ?

> Currently we don't do this, but we need to implement it, or have
> ServiceChanged characteristic notifying that the service ranges have
> changed every time BlueZ restarts (which adds overhead as service
> discovery is triggered on the client side). I suggest we store the
> attribute database into a "attribute_db.conf" file containing the
> attribute name/value/uuid triples.

Isn't it possible to save it in [<uuid>] group of device.conf file ?

> Additionally, we also need to store
> the Client Characteristic Configuration descriptor values (which are
> specific to each bonded device), currently stored into a "ccc" file.
> We could have one group just for them into attribute_db.conf.
>
> For client profiles, I think the storage needs are specific to each
> profile. From memory, only the generic GATT client and the GAP plugin
> use storage currently (other profiles eventually need to use storage
> to avoid full service discovery every time a bonded device
> re-connects). The generic GATT client stores service/characteristics
> handles/uuids ("primaries" and "characteristics" files), and the GAP
> plugin stores appearance data ("appearances" file).

My first thought for LE data in device.conf is:
   [<Primary UUID>#<Description>]
   Handle=
   Characteristic=
   Attribute=
   CCC=

I think we can easily add other key entries when needed.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

