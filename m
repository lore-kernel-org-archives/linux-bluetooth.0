Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960809191520n2067753cs71c07d37ea83b28@mail.gmail.com>
Date: Fri, 19 Sep 2008 15:20:36 -0700
From: "Nick Pelly" <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: Data on eglib vs glib, implications for embedded use of bluez
Cc: "Iliyan Malchev" <malchev@google.com>,
	"Brian Swetland" <swetland@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To bluez developers,

With bluez 4.x, support for Embedded GLIB (EGLib) support was dropped,
and GLib became a requirement for bluez.

This presents some challenges for embedded platforms. I want to
present some data from my experience of using both glib and eglib with
bluez 4.6, and suggest that eglib become a supported option for bluez.

-- Size of GLIB compared to EGLIB --

compiled size of glib static library (see file list later) VS eglib:
            RAW   STRIPPED
libglib.a   2147 k       695 k
libeglib.a   137 k        37 k

compiled size of bluetoothd w/glib compared to bluetoothd w/eglib
                    RAW   STRIPPED
bluetoothd w/glib  1489 k       462 k
bluetoothd w/eglib  530 k       117 k

** bluetoothd _triples_ in size when using glib **

This was for the Android platform - an embedded ARM Linux platform
with our own libc implementation.
glib was compiled statically using only the source files required for
bluetoothd, which are listed at the bottom of this email.
glib has other dependencies that I stubbed out and haven't included in
this data, such as libintl and libiconv. These (if actually required)
would further increase the penalty of using glib.


-- Challenges porting GLIB to a lightweight ARM Linux platform --

We only ported the subset of GLIB needed for bluetoothd, and
customized config.h for the features our platform supported, but still
came across these issues:

- gutils.c expects the platform to have Desktop linux features such as
passwd files, real names for each user etc. I had to stub out
setpwent(), pw_gecos and some friends. Yes bluetoothd requires
gutils.c
- Our libc does not implement bindtextdomain(), dngettext(),
dgettext(), localeconv()  which are required for gstrfuncs.c and
gutf8.c. I had to stub them out. These are language translation
features which for many embedded platforms it does not make sense to
support in libc.
- Had to stub out references to libintl, libiconv and libcharset -
again these are translation libraries.

In short, GLIB requires significant modification to compile for a
embedded platform such as Android. These modification are in areas of
code that are required to compile and link, but are code paths that
bluetoothd probably never hits (translation, locales etc). This lack
of modularity suggests that glib was never designed for very
lightweight platforms such as embedded. I am worried about what other
problem we would come across once we start running smoke tests of this
binary etc.


-- Experience building bluetoothd 4.6 with EGLIB from bluez 3.36 --

It was surprisingly easy to compile bluetoothd 4.6 using the eglib
library from bluez 3.36. The only missing functions from eglib were
g_key_file_set_list_separator
g_option_context_add_main_entries
g_option_context_parse
g_option_context_free

For these tests, I just stubbed these out with some simple code. This
allows us to compile bluetoothd with eglib, and it runs and passes
some smoke tests. It would not be a big effort to add these functions
to eglib, and I plan on doing so.


-- Going forwards --

For Android it is a clear win to use eglib rather than glib, and we
will very likely do so once we move to bluez 4.x.  I expect many other
embedded platforms will come to the same conclusions. Glib is simply
too bloated and has too many dependencies for many embedded platforms,
and on the other hand it is very easy today to continue using eglib.

Once I have a patch to add the missing functions to eglib, what do the
bluez developers think about returning eglib to the bluez codebase, to
make life easier for embedded developers?

If we do not, then the danger going forwards is that Desktop Bluez
developers will use more and more Desktop orientated features from
glib that are not easily ported to eglib. Without eglib being a
supported configuration, it would require strong discipline from Bluez
to avoid glib features that are not easily ported to embedded.

I guess it comes down to whether Bluez wants to support an embedded
configuration. If Bluez is happy to abandon embedded, then they can
forget eglib. But it Bluez is serious about supporting embedded
configurations, it should keep eglib as a supported option in my
opinion.

I understand that one concern about eglib support is a lack of
maintenance. I would be happy to help out with eglib support.

If supporting eglib is not an option, I am very much interested to
hear the specific reasons as to why not. Is it due to eglib bugs? lack
of eglib features (which ones)? or is embedded just not significant
enough to be a concern?

Perhaps this can be discussed further in Portland.

Nick

PS Marcel - Mono no longer contains an eglib implementation. I haven't
heard back from any of there dev's on what happened to it.


NOTES:

GLIB sources required for bluetoothd
    glib/garray.c \
    glib/gatomic.c \
    glib/gdataset.c \
    glib/gconvert.c \
    glib/gerror.c \
    glib/ghash.c \
    glib/gfileutils.c \
    glib/giochannel.c \
    glib/giounix.c \
    glib/glist.c \
    glib/gkeyfile.c \
    glib/gmain.c \
    glib/gmem.c \
    glib/gmessages.c \
    glib/goption.c \
    glib/gpattern.c \
    glib/gprintf.c \
    glib/grand.c \
    glib/gslice.c \
    glib/gslist.c \
    glib/gstdio.c \
    glib/gstrfuncs.c \
    glib/gstring.c \
    glib/gprimes.c \
    glib/gqsort.c \
    glib/gtestutils.c \
    glib/gthread.c \
    glib/gtimer.c \
    glib/guniprop.c \
    glib/gunidecomp.c \
    glib/gutils.c \
    glib/gutf8.c \
    gmodule/gmodule.c
