Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Dave Beal <dbeal@cardinalpeak.com>
Date: Thu, 9 Feb 2017 09:12:48 -0700
Message-ID: <CAHHBb0djp1X5=WTMLFUsTsSJQeOoREFFg88C0j1m12c5_XdRVw@mail.gmail.com>
Subject: GATT client not working with BlueZ 5.19
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello -

I'm trying to get a GATT client working on a Linux system that's
running BlueZ 5.19.  Unfortunately, neither Python or glib are
available on this system, so my only choice is using libdbus.  And did
I mention that I've never used D-Bus before?  I have a GATT server on
another system that provides and advertises a custom service by its
16-byte UUID.  I'm trying to get my BlueZ-based system to access this
service.  I've verified that I can discover the server by the UUID
that it advertises, and I can get BlueZ to manually connect to it.  My
client app has successfully called Bluez's RegisterProfile method,
passing the UUID advertised by the server, but BlueZ never calls my
NewConnection method.  In the options of the RegisterProfile call, I'm
setting "Role" to "client", "AutoConnect" to TRUE, and both
"RequireAuthorization" and "RequireAuthentication" to FALSE.  I am
running bluetoothd with the -E (experimental) option.

If I run bluetoothd in the foreground with both the -E and debug
option, this is what I see when I start my client app:

bluetoothd[2126]: src/profile.c:register_profile() sender :1.20
bluetoothd[2126]: src/profile.c:create_ext() Created "myRemoteControlProfile"
bluetoothd[2126]: src/profile.c:ext_device_probe()
myRemoteControlProfile probed with UUID
119649b6-b656-22ae-e611-ba85a04effc5
bluetoothd[2126]: src/service.c:change_state() 0x950d0: device
24:71:89:09:AD:09 profile myRemoteControlProfile state changed:
unavailable -> disconnected (0)


That's all that happens.  "myRemoteControlProfile" is the name of the
profile I registered with Bluez,
"119649b6-b656-22ae-e611-ba85a04effc5" is the UUID that I passed in
the RegisterProfile call and 24:71:89:09:AD:09 is the GATT server I'm
trying to interact with, so BlueZ seems to know that this remote
device provides the service I'm looking for.  When I watch on the
server device, I never see BlueZ connecting to it.  Isn't BlueZ
supposed to automatically connect to a device when it sees that the
device offers the service that I passed in RegisterProfile?  Why don't
I get a NewConnection method call?  What does it mean that my
registered profile never gets past the "disconnected" state?  I know
that the GATT API was still considered experimental in BlueZ 5.19;
should I even expect this to work?  Thanks!

- Dave Beal
  dbeal@cardinalpeak.com
  Cardinal Peak, LLC
