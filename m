Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602150831j55ae6d68p856bbc3761ecab00@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
In-Reply-To: <1140013222.26072.80.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
	 <1140013222.26072.80.camel@localhost>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Feb 2006 14:31:38 -0200

Hi Marcel,

On 2/15/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > Here is the first proposal to support the discoverable timeout.
> >
> > Current behaviour:
> > * it's using SIGALARM. We can try integrate in the main loop in the fut=
ure..
> > * the scan mode is changed automatically to connectable mode after 3 mi=
n
> > * multiple local adapters are handled: there are separated timers.
> > * scan mode changes requested by other applications(hciconfig and
> > other dbus clients) are monitored too.
> >
> >
> > Some points to things about:
> > * bluez_timeout_add consider the function handler and the user data to
> > compare if it's necessary update or add new timer. Is this approach
> > acceptable?
> > * Is it necessary handle race condition when updating the timeout array=
?
> > * 8 positions to timeout handler are enough?
> >
> > Any comments?
>
> maybe you wanna separate the {Set|Get}DiscoverableTimeout code, because
> this is obviously correct and would apply right away.
[Claudio Takahasi]
Ok. I will split into two patches.

>
> Using an array of 8 handles is actually not enough. Even if no sane
> person would ever attach more than 8 dongles, but I might do ;)
>
> However you need at least to support HCI_MAX_DEV from hci.h and this is
> currently 16 adapters. Remember that the kernel will still accept more
> than 16 device, but the userspace simply can't handle them (except you
> recompile the Bluetooth library).
[Claudio Takahasi]
ok. I will fix it.
>
> Do we have a function to iterate over the registered device paths and
> retrieve their hci_dbus_data structures? If yes, then I would prefer to
> include everything from timeout_settings there and use it.
[Claudio Takahasi]
It's possible store in the dbus path data. Using the function
"dbus_connection_get_object_path_data(DBusConnection, path, user
data)" it's possible retrieve the data associated to one device. I
will try propose someting soon.

Regards,
Claudio

> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
