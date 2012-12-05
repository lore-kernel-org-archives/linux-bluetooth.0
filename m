Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Dec 2012 10:23:39 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 00/20] CSCP plugin
Message-ID: <20121205082339.GA32201@x220.ger.corp.intel.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Dec 04, 2012, Andrzej Kaczmarek wrote:
> Changes since v2:
> - rebased to latest upstream master
> - moved all code to cyclingspeed.c to avoid "empty" calls across files
> 
> No changes in functionality.
> 
> 
> Andrzej Kaczmarek (20):
>   cyclingspeed: Add CSC profile plugin skeleton
>   cyclingspeed: Add attio callbacks
>   cyclingspeed: Discover CSCS characteristics
>   cyclingspeed: Discover characteristics CCC
>   cyclingspeed: Read CSC Feature characteristic value
>   cyclingspeed: Read Sensor Location characteristic value
>   cyclingspeed: Add CyclingSpeedManager interface
>   cyclingspeed: Add support to enable measurement notifications
>   cyclingspeed: Process measurement notifications
>   cyclingspeed: Add DBus.Properties for org.bluez.CyclingSpeed
>     interface
>   cyclingspeed: Add stub to use SC Control Point
>   cyclingspeed: Add support for Request Supported Sensor Locations
>   cyclingspeed: Add support for Update Sensor Location
>   cyclingspeed: Add support for Set Cumulative Value
>   core: Add CyclingSpeedWatcher interface to default policy
>   doc: Remove Get-/SetProperties from CSC API document
>   doc: Rename cycling API to cyclingspeed
>   build: Add CSCP API document to EXTRA_DIST
>   test: Add cyclingspeed test script
>   test: Enable speed and cadence calculation in test-cyclingspeed
> 
>  Makefile.am                          |    8 +-
>  Makefile.tools                       |    3 +-
>  doc/cycling-api.txt                  |  118 ----
>  doc/cyclingspeed-api.txt             |  100 +++
>  lib/uuid.h                           |    6 +
>  profiles/cyclingspeed/cyclingspeed.c | 1285 ++++++++++++++++++++++++++++++++++
>  src/bluetooth.conf                   |    1 +
>  test/test-cyclingspeed               |  191 +++++
>  8 files changed, 1590 insertions(+), 122 deletions(-)
>  delete mode 100644 doc/cycling-api.txt
>  create mode 100644 doc/cyclingspeed-api.txt
>  create mode 100644 profiles/cyclingspeed/cyclingspeed.c
>  create mode 100755 test/test-cyclingspeed

All patches in this set have been applied. Thanks.

I also pushed an additional coding style cleanup patch, so if you have
further patches to this code queued up please rebase first to the
upstream tree.

Johan
