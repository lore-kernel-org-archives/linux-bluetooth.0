Return-Path: <dh.herrmann@gmail.com>
MIME-Version: 1.0
From: David Herrmann <dh.herrmann@gmail.com>
Date: Tue, 17 Apr 2018 13:14:33 +0200
Message-ID: <CANq1E4TX=T4XNbDpi8dTJi6HVY5YosRiRLy=sKP9QKgn8W5NaQ@mail.gmail.com>
Subject: [RFC BlueZ] Replacing D-Bus at_console usage
To: linux-bluetooth@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hey!

The dbus-daemon XML policy configuration allows matching clients based
on whether they are locally logged in or not, a feature usually dubbed
'at_console' since this is the tag used in the XML configuration.
BlueZ is a long-time user of this and controls access to BlueZ that
way, allowing local users full access to the Bluetooth subsystem. Our
intention is to get rid of the 'at_console' selector, hence this email
to start a discussion on how to proceed regarding BlueZ's usage of it.

Right now, src/bluetooth.conf contains the following three lines:

    <policy at_console="true">
      <allow send_destination="org.bluez"/>
    </policy>

My proposal is to drop the 'at_console="true"' selector without replacement.

The effect of these three lines is as follows: By default every user
is denied access to the D-Bus APIs of bluetoothd. This is the default
D-Bus policy for the system bus. The XML policy of bluetoothd then
punches 2 holes: It allows root full access, and it allows any user
that is considered 'at_console' access. The intent is clear: As long
as you are logged in to a local machine, and you are the
foreground/active console, you are allowed to control bluetooth.
However, the behavior of 'at_console' does *not* match this intent.
Instead, 'at_console' is a property a D-Bus client is assigned when
connecting to the system bus, and it is never changed for the lifetime
of a client. Whenever a client connects, dbus-daemon calls
`sd_uid_get_seats()` on the UID of that client, checking whether there
is *AT LEAST ONE* seat associated with that client. If, and only if,
that is the case, the client is considered 'at_console'.
First of all, what this means is that any process is considered
'at_console', iff at the time of connect their UID is logged in on any
seat local to the machine. It does not matter whether they log out
from the machine afterwards. A client might keep lingering processes
around forever, just to retain this property. Furthermore, if a
process connects before a local login happens, the client will *NEVER*
be considered at console. Also, on a multi-seat system, all local
users get this access. Lastly, it does not matter whether a client is
a foreground or background session, they will be considered
'at_console' nonetheless.

This clearly misses the intent of 'at_console'. These racy,
questionable and counter-intuitive semantics have led upstream
dbus-daemon to deprecate usage of 'at_console' several years ago.
Debian tracks remaining usage via lintian [1]. The remaining
_relevant_ users of 'at_console' are bluez, ofono, neard. Almost
everything else has been converted over the years.

Upstream dbus-daemon is unlikely to ever drop at_console-support if
users remain. However, we have been working on a redesign known as
'dbus-broker' [2], and Fedora-29 will likely start shipping it as
default [3]. dbus-broker does not implement 'at_console' fully, but
only a 'best-effort' compatibility option. Reason is, the feature
requires the message-broker to perform IPC to other system tools
(i.e., it has to query systemd-loging for seat and session
information). In dbus-broker we explicitly avoid
"IPC-to-implement-IPC". This means, all runtime requests to
dbus-broker must be strictly served without stalling on external
resources. Violating this rule makes it very easy to deadlock the IPC
system, as each hop might be stalled on the other. Hence, we never
implemented full 'at_console' support. Instead, dbus-broker considers
every UID higher than `SYSTEMUIDMAX` (999) to be 'at_console'. This
decision was based on the fact that every local user could already
emulate this, by using a local dbus-proxy that lingers in background
after the first successfull login, using systemd-logind's AllowLinger
feature. On common linux distributions, the effect is almost
identical. However, there are cases where this leads to problems. For
instance, 'gdm' and other greeters use system-uids, and as such would
never be considered 'at_console' on dbus-broker.

Hence, our proposal to fully drop 'at_console' alltogether. It really
does not do what it was intended to do. Furthermore, whatever the
message-bus invents as replacement, we must be aware that this needs
to be performed on every single message transaction, unless we cache
the information. But caching it always leads to the unexpected
behavior as we see today with 'at_console'.

Instead, we recommend D-Bus services to perform their own policy
checks for messages where it matters. This might be as simple as
calling `sd_uid_get_seats()` manually in the daemon, or referring to
PolicyKit to get a similar behavior. Using PolicyKit is clearly the
easiest solution, but at the same time requires reliance on PolicyKit.
If you roll your own security checks, the downside is that you better
remember client-UIDs locally, otherwise you must query dbus-daemon for
the client-uid on every security check.

Lastly, if you really want to rely on the message-broker to perform
security checks, you can always use classic UNIX groups to do that.
BlueZ already allows 'lp' group-access, so something similar can be
done to allow anyone in the 'bluetooth' group access, and requiring
distributions to make use of this group.

Of course, there is always the option to stay with 'at_console', in
case we cannot find a suitable solution.

Do you guys have a strong opinions on this? If yes, which properties
do you exactly care about? And which alternatives would sound
acceptible for BlueZ? (And possibly ofono+neard, in case there is some
overlap here on the ML)

Thanks!
David


[1] https://lintian.debian.org/tags/dbus-policy-at-console.html
[2] https://github.com/bus1/dbus-broker/wiki
[3] https://fedoraproject.org/wiki/Changes/DbusBrokerAsTheDefaultDbusImplementation
