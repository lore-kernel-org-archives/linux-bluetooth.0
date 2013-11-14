Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20131114081937.GA2019@x220.p-661hnu-f1>
References: <6522C4F948C6F5419BA5943E1E79DD2A8ABBAE@IRSMSX104.ger.corp.intel.com>
	<CABBYNZJSdzsuuzEJctKo_UiKExX4_XXW+zzphhZcHzCuOoLBwg@mail.gmail.com>
	<E03FE70C-ECC4-4D7D-917E-6F3E92297C1C@holtmann.org>
	<20131114081937.GA2019@x220.p-661hnu-f1>
Date: Thu, 14 Nov 2013 11:37:55 +0200
Message-ID: <CABBYNZL_vGHZeGjDWMpUn0M_c57zR1arrjc10b01Vi1njeZjsA@mail.gmail.com>
Subject: Re: bluetoothd failure after a "malloc retun NULL" injection
 (attachment fix)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Oprisenescu, CatalinX" <catalinx.oprisenescu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Trandafir, IonutX" <ionutx.trandafir@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Nov 14, 2013 at 10:19 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Marcel,
>
> On Thu, Nov 14, 2013, Marcel Holtmann wrote:
>> >> Following is an issue encountered and handled using bluez-5.10 on a
>> >> 32bit Tizen 2.0 IVI based distribution.
>> >>
>> >> If malloc returns a random NULL bluetoothd exits with core dumped.
>> >> In this case we do the following:
>> >>      -start bluetoothd,
>> >>      -at a random malloc call from any library (*lib*.so*), a random NULL will be returned by bluetoothd with a ld_preloaded library.
>> >>
>> >> ~# LD_PRELOAD=/root/lib_wrapper.so /usr/libexec/bluetooth/bluetoothd -E
>> >>
>> >> Analyzing the dump, it points directly to a DBUS_ERROR_NO_MEMORY
>> >> which, after handling, keeps bluetoothd from dumping and allowing
>> >> it to return the fatal error occurred as exit status, thus failing
>> >> gracefully.
>> >>
>> >> A fix proposal, handling the use-case is attached.
>> >
>> > Im afraid if we start treating all the out of memory cases we wont
>> > have time to do anything else, and quite frankly if this happens for
>> > real the least concern would be bluetoothd, so I believe we should
>> > just treat OOM cases as unrecoverable. Since this can happen with any
>> > dbus_error, I would probably suggest to wrap it perhaps we a
>> > g_dbus_error API that does assert in OOM.
>>
>> I am fine with fixing obvious ones. However long-term these tiny sized
>> memory allocation must just abort the program if we run out of memory.
>> Since there is no recovery from it anyway.
>
> Did you actually take a look at the patch? It's not exactly fixing any
> missing error checks but only modifying the behavior if the error is OOM
> by not doing a g_printerr call in that case. However, the main()
> function still does an error() call when connect_dbus() returns failure
> (even if it's -ENOMEM) so I don't really see how this particular patch
> would fix any obvious OOM handling issue.

Yep, I was thinking more in the following:

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 9542109..ced55d9 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -216,6 +216,7 @@ struct GDBusSecurityTable {
        .flags = G_DBUS_SIGNAL_FLAG_EXPERIMENTAL

 void g_dbus_set_flags(int flags);
+gboolean g_dbus_error_is_set(DBusError *err);

 gboolean g_dbus_register_interface(DBusConnection *connection,
                                        const char *path, const char *name,
diff --git a/gdbus/object.c b/gdbus/object.c
index b248cbb..699c7e2 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -27,6 +27,7 @@

 #include <stdio.h>
 #include <string.h>
+#include <assert.h>

 #include <glib.h>
 #include <dbus/dbus.h>
@@ -1820,3 +1821,16 @@ void g_dbus_set_flags(int flags)
 {
        global_flags = flags;
 }
+
+gboolean g_dbus_error_is_set(DBusError *err)
+{
+       dbus_bool_t ret;
+
+       ret = dbus_error_is_set(err);
+       if (!ret)
+               return FALSE;
+
+       assert(!dbus_error_has_name(err, DBUS_ERROR_NO_MEMORY));
+
+       return TRUE;
+}

But perhaps there is a way to set libdbus to not handle OOM cases and
just assert/exit, the interesting part is that even in dbus code
itself there are comments like this:

     /* FIXME have less lame handling for OOM, we just silently fail to
      * watch.  (In reality though, the whole OOM handling in dbus is
      * stupid but we won't go into that in this comment =) )
      */


-- 
Luiz Augusto von Dentz
