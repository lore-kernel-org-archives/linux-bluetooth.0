Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
	<1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 18 Feb 2014 10:41:33 -0300
Message-ID: <CAKT1EBdF-T9tVSROLBfs8_D1wMPXWDLTAooNtt5e6wVQNuF3aw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 00/18] GATT API: External Services
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Tue, Feb 4, 2014 at 2:53 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patchset implements the minimal support for adding local services
> declarations.
>
> Limitation: Remove services and multiple services exported by the same
> remote will be implemented the next series.
>
> Changes from PATCH v6 to PATCH v5:
> * Rebase
> * Fixed warning (gcc 4.6.3/32-bits): "ignoring return value of ‘write’"
>
> Changes from PATCH v4 to PATCH v5:
> * Removed Release() method of GattService1 interface
>
> Changes from PATCH v3 to PATCH v4:
> * Rebase
> * src/gatt.c: Replaced GIOChannel/GAttrib by "io".
>
> Changes from PATCH v2 to PATCH v3:
> * Rebase
> * Interfaces renamed: s/GattServiceManager1/GattManager1,
>   s/Characteristic1/GattCharacteristic1, s/Descriptor/GattDescriptor1
> * test/gatt-service.c: s/fprintf/printf
>
> Changes from PATCH v1 to PATCH v2:
> * Rebase
> * Included patch "doc: Add GATT API"
> * Interfaces renamed: s/Service1/GattService1, and
>   s/ServiceManager1/GattServiceManager1
> * Removed patch "gatt: Implement UnregisterService" from this patchset
>
> Changes from PATCH v0 to PATCH v1:
> * Rebase
>
> Changes from RFC v0 to PATCH v0:
> * Changed copyright year : s/2013/2014
> * Fixed coding style
> * Added gatt-service binary to gitignore
> * Added extra comment in the source code
>
> Features:
> * API for internal and external services declaration
> * Unix socket for testing purpose: services are exported through unix
>   sockets to avoid breaking the current attribute server.
>
> How to test:
>   Run bluetoothd with EXPERIMENTAL flag (-E)
>   Replace /etc/dbus-1/system.d/bluetooth.conf and reload DBus settings
>   $gatttool -L --primary (or interactive mode)
>
> Roughly upstreaming plan (steps):
>  * GATT Server: External Services -> pathset GATT API: External Services
>  * GATT Server: External Characteristics (Server)
>  * GATT Server: External Descriptors (Server)
>  * Replacement for GAttrib: use "io"
>  * Replace attribute server
>  * Remove ATTIO and automatic connection mechanism from userspace
>  * Fix all GATT internal plugins
>  * GATT Client: Remote Services
>
> Alvaro Silva (6):
>   gatt: Add stub for gatt.{c, h} files
>   gatt: Register Manager D-Bus Interface
>   gatt: Add registering external service
>   gatt: Add external services tracking
>   gatt: Register ATT command/event handler
>   gatt: Add Discover All Primary Services
>
> Andre Guedes (1):
>   gatt: Add helper for creating GATT services
>
> Claudio Takahasi (11):
>   doc: Add experimental GATT API
>   lib: Move GATT UUID to uuid.h
>   gatt: Add server unix socket
>   gattrib: Use default ATT LE MTU for non-standard sockets
>   test: Add external service GATT skeleton
>   gitignore: Add test/gatt-service
>   test: Add signal handling for gatt-service
>   test: Add registering external service
>   gatttool: Add unix socket connect
>   gatttool: Add unix socket support for interactive mode
>   bluetooth.conf: Add ObjectManager interface
>
>  .gitignore           |   1 +
>  Makefile.am          |   2 +
>  Makefile.tools       |   5 +
>  attrib/gatt.h        |  25 ----
>  attrib/gattrib.c     |  16 +--
>  attrib/gatttool.c    |  27 +++-
>  attrib/gatttool.h    |   1 +
>  attrib/interactive.c |  19 +--
>  attrib/utils.c       |  54 ++++++++
>  doc/gatt-api.txt     | 142 +++++++++++++++++++
>  lib/uuid.h           |  30 ++++
>  src/bluetooth.conf   |   1 +
>  src/gatt-dbus.c      | 271 ++++++++++++++++++++++++++++++++++++
>  src/gatt-dbus.h      |  25 ++++
>  src/gatt.c           | 379 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/gatt.h           |  36 +++++
>  src/main.c           |   4 +
>  test/gatt-service.c  | 267 ++++++++++++++++++++++++++++++++++++
>  18 files changed, 1257 insertions(+), 48 deletions(-)
>  create mode 100644 doc/gatt-api.txt
>  create mode 100644 src/gatt-dbus.c
>  create mode 100644 src/gatt-dbus.h
>  create mode 100644 src/gatt.c
>  create mode 100644 src/gatt.h
>  create mode 100644 test/gatt-service.c
>
> --
> 1.8.3.1
>

ping...

Claudio.
