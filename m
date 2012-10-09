Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 18:03:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Thermometer watchers API change + fixes
Message-ID: <20121009160303.GA8064@x220.c.hospitality.swisscom.com>
References: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349781598-22580-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Oct 09, 2012, Andrzej Kaczmarek wrote:
> Changes since v2:
> - restored special values for exponent and mantissa in API document
>   and added note about IEEE spec
> - fixed parameters parsing for incoming measurement (memset was placed
>   in wrong place)
> 
> Also this was tested with PTS 4.5.3 and works fine now after memset fix,
> except for TP/THF/CO/BI-07-I which seems to have issue in PTS (there should
> be reserved value for temperature type but PTS sends 0x02 which is
> perfectly valid value thus it won't be discarded on our side).
> 
> 
> Andrzej Kaczmarek (15):
>   thermometer: Store thermometer devices per-adapter
>   thermometer: Register ThermometerManager interface on adapter path
>   thermometer: Move watcher logic to adapter interface
>   thermometer: Include remote device information in MeasurementReceived
>   thermometer: Update API document
>   thermometer: Update test script
>   thermometer: Reformat MeasurementReceived description
>   thermometer: Change string properties to lower-case
>   thermometer: Update driver naming style
>   thermometer: Add constant definition for watcher interface name
>   thermometer: Add common function to write characteristics CCC
>   thermometer: Refactor processing of measurement characteristic value
>   thermometer: Fix whitespace
>   thermometer: Fix indentation
>   thermometer: Fix missing braces
> 
>  doc/thermometer-api.txt            | 136 +++++-----
>  profiles/thermometer/manager.c     |  24 +-
>  profiles/thermometer/thermometer.c | 512 +++++++++++++++++++++----------------
>  profiles/thermometer/thermometer.h |   2 +
>  test/test-thermometer              |  16 +-
>  5 files changed, 395 insertions(+), 295 deletions(-)

All patches in this set have been applied. Thanks.

Johan
