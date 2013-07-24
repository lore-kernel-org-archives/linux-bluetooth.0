Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Jul 2013 08:45:50 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/11] GATT/ATT C API improvements
Message-ID: <20130724154550.GA22830@x220.p-661hnu-f1>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jul 19, 2013, Anderson Lizardo wrote:
> This patch set is based on patches sent earlier as "[RFC BlueZ 00/18] GATT C
> API refactoring". See that cover letter for more details on what improvements
> we are doing.
> 
> This first set contains only the changes that do not impact functionality.
> Once these are upstream, we will send the more complex patches that will
> further improve the API by simplifying GATT callbacks and adding unit tests.
> 
> Best Regards,
> Anderson Lizardo
> 
> Alvaro Silva (3):
>   attrib: Remove unused parameter from enc_write_resp()
>   attrib: Add encode/decode prepare write support
>   attrib: Add encode/decode execute write support
> 
> Anderson Lizardo (6):
>   attrib: Rename gatt_find_info() to gatt_discover_char_desc()
>   attrib: Do not use Write Command in gatt_write_char()
>   attrib: Fix coding style in prepare_write_cb()
>   attrib: Simplify prepare_write()
>   attrib: Allow dec_read_resp() to just check if PDU is valid
>   attrib: Reduce scope of variable declarations in char_discovered_cb()
> 
> Eder Ruiz Maria (2):
>   gatttool: Remove unused code
>   attrib: Fix coding style for various enc_*/dec_* functions
> 
>  attrib/att.c                         |  112 ++++++++++++++++++++++++++++++----
>  attrib/att.h                         |    9 ++-
>  attrib/gatt.c                        |   68 ++++++++++-----------
>  attrib/gatt.h                        |    2 +-
>  attrib/gatttool.c                    |   18 +-----
>  attrib/interactive.c                 |   38 +++---------
>  profiles/cyclingspeed/cyclingspeed.c |    2 +-
>  profiles/gatt/gas.c                  |    3 +-
>  profiles/heartrate/heartrate.c       |    2 +-
>  profiles/input/hog.c                 |   13 ++--
>  profiles/scanparam/scan.c            |    6 +-
>  profiles/thermometer/thermometer.c   |    2 +-
>  src/attrib-server.c                  |    2 +-
>  13 files changed, 167 insertions(+), 110 deletions(-)

All patches in this set have been applied. Thanks.

Johan
