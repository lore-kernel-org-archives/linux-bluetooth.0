Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170103173007.21929-1-eu@felipetonello.com>
References: <20170103173007.21929-1-eu@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Jan 2017 12:10:50 +0200
Message-ID: <CABBYNZK44Nnz+AKK0ii6FDD89an--J-R1_7_GLEVJGuDT3=Bng@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5 0/2] MIDI over BLE implementation
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        agoode@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Tue, Jan 3, 2017 at 7:30 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
> This patchset implements the MIDI over BLE spec, more information on patch #1.
>
> Patch #2 is some unit-tests to make sure the MIDI parser works properly.
>
> Changes from v4:
>  * Fixed valgrind's memory corruption warning
>  * Added some asserts where needed
>  * Minor improvements on libmidi API
>  * Fixed potential memory leak in case of initialization errors
>  * More unit-test checks
>
> Changes from v3:
>  * Splited patch in two (main profile and unit-test)
>  * Some refactor on duplicated and complex code
>  * Removed usage of GLib types
>
> Changes from v2:
>  * Removed _GNU_SOURCE (not used)
>  * Appended " Bluetooth" to the ALSA-Seq port name
>  * Changed configuration from alsa to midi (--disable-midi)
>
> Changes from v1:
>  * Fixed typos in commit message
>  * Minor improves on the SysEx parser
>
> Felipe F. Tonello (2):
>   profiles/midi: Added MIDI over BLE profile implementation
>   unit/test-midi: Added libmidi use-case tests
>
>  Makefile.am             |  14 +-
>  Makefile.plugins        |   8 +
>  configure.ac            |  11 +
>  profiles/midi/libmidi.c | 459 +++++++++++++++++++++++++++++++++++
>  profiles/midi/libmidi.h | 122 ++++++++++
>  profiles/midi/midi.c    | 490 +++++++++++++++++++++++++++++++++++++
>  unit/test-midi.c        | 628 ++++++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 1731 insertions(+), 1 deletion(-)
>  create mode 100644 profiles/midi/libmidi.c
>  create mode 100644 profiles/midi/libmidi.h
>  create mode 100644 profiles/midi/midi.c
>  create mode 100644 unit/test-midi.c
>
> --
> 2.11.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
