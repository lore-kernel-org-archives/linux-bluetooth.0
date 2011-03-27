Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Mar 2011 23:04:46 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v7 0/6] Support for out of band association mode
Message-ID: <20110327200446.GD6994@jh-x301>
References: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sat, Mar 26, 2011, Szymon Janc wrote:
> Changes since v6:
> - fixed issues pointed out by Johan
> 
> BR,
> Szymon Janc
> on behalf of ST-Ericsson
> 
> Szymon Janc (6):
>   Add initial support for Out of Band (OOB) association model
>   Add support for Out of Band (OOB) association model in mgmtops
>   Add support for Out of Band (OOB) association model in hciops
>   Add D-Bus OOB plugin
>   Update mgmt-api.txt with OOB commands
>   Add oob-api.txt with documentation about OOB D-Bus methods
> 
>  Makefile.am       |    8 ++-
>  acinclude.m4      |    6 ++
>  doc/mgmt-api.txt  |   30 +++++++
>  doc/oob-api.txt   |   38 +++++++++
>  lib/mgmt.h        |   18 ++++
>  plugins/dbusoob.c |  234 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/hciops.c  |  142 +++++++++++++++++++++++++++++++-
>  plugins/mgmtops.c |  129 +++++++++++++++++++++++++++++
>  src/adapter.c     |   18 ++++
>  src/adapter.h     |   12 +++
>  src/oob.c         |   41 +++++++++
>  src/oob.h         |   32 +++++++
>  12 files changed, 702 insertions(+), 6 deletions(-)
>  create mode 100644 doc/oob-api.txt
>  create mode 100644 plugins/dbusoob.c
>  create mode 100644 src/oob.c
>  create mode 100644 src/oob.h

All six patches have been pushed upstream. Thanks.

Do you think you could come up with a test script to test this (through
the dbusoob plugin) between two local adapters? We could then add that
to the test subdirectory.

Johan
