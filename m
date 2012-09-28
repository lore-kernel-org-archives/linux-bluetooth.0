Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50642389.40107@intel.com>
References: <50642389.40107@intel.com>
Date: Fri, 28 Sep 2012 06:56:32 -0400
Message-ID: <CAJdJm_NbPw0jwWvuUiu7L=wzxc+qxfF_4i2vj7U1G06b=BE2qw@mail.gmail.com>
Subject: Re: [RFC] Convert storage to use per-remote device directories
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Frederic Danis <frederic.danis@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Thu, Sep 27, 2012 at 5:59 AM, Frederic Danis
<frederic.danis@intel.com> wrote:
> Hi everyone,
>
> Here is my proposal for new storage directory structure using ini-file
> format.

Do you know if the INI parser in glib allows for multiple groups with
same name? In LE we can have services with same UUID (not sure if this
is valid for BR/EDR also), and they are differentiated by other means
(e.g. a "Description" descriptor with different value, besides the
different handle).

Regarding LE, we have two kinds of storage needs: server profiles, and
client profiles.

For server profiles, we need to store the attribute database.
Currently we don't do this, but we need to implement it, or have
ServiceChanged characteristic notifying that the service ranges have
changed every time BlueZ restarts (which adds overhead as service
discovery is triggered on the client side). I suggest we store the
attribute database into a "attribute_db.conf" file containing the
attribute name/value/uuid triples. Additionally, we also need to store
the Client Characteristic Configuration descriptor values (which are
specific to each bonded device), currently stored into a "ccc" file.
We could have one group just for them into attribute_db.conf.

For client profiles, I think the storage needs are specific to each
profile. From memory, only the generic GATT client and the GAP plugin
use storage currently (other profiles eventually need to use storage
to avoid full service discovery every time a bonded device
re-connects). The generic GATT client stores service/characteristics
handles/uuids ("primaries" and "characteristics" files), and the GAP
plugin stores appearance data ("appearances" file).

Johan, what do you think?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
