Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Content-Type: text/plain; charset=us-ascii
Subject: HDP stress test script
Date: Thu, 4 Nov 2010 10:59:18 -0200
Message-Id: <1EEF2306-56E6-4C77-8BB6-02F16050BC0A@signove.com>
Cc: linux-bluetooth@vger.kernel.org
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I put together a kind of "stress test" or "torture" script for HDP profile and API. It is available at http://gitorious.org/hdpy project, path is scripts/bluez/hdp_stress_test. Major features:

a) useful either as a test tool and as an API usage example (though scripts/bluez/hdp_oxi_sink is probably a better example);

b) any number of machines can participate (minimum 2, tested with 3);

c) each machine finds the others semi-automatically (tries to contact paired devices that publish an HDP record).

I could extract a segfault with it already, but did not have time to pinpoint the cause. It happened when there were a couple of async Echo's pending and script was killed (which triggers HealthApplication destruction).

Note: it uses the 'Application' property of HealthChannel, which is pending acceptance. This can be easily disabled by changing a flag in script.

Another thing I stumbled on, was the UUIDs property of Device object. The script creates sources and sinks, but 'UUIDs' only shows the sink (0x1402). For now, the script assumes that every source is also a sink in order to find the counterparts, but this needs to be truly fixed in near future.