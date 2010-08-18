Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] Fast connectable mode for HFP (update)
Date: Wed, 18 Aug 2010 13:35:55 +0300
Message-Id: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The following patches are implementation of fast connectable mode for HFP.
Such mode means significantly shorter page scan interval and interlaced
page scan type. As a result, HFP connection typically is created much faster.
The fast connectable mode can be activated by incomming call indicator and
deactivated by answer or reject call indicator. Such speeds up connectability
of a headset when there is an incomming call. Retransmisions in eSCO are
possiblle to be paused for in-band ring tone when the mode is enabled during
given above period of time. eSCO is not affected during call since page scan
settings are returned to their default values immidiately after call is
accepted (or rejected).

Use of the mode can be enabled by changing FastConnectable in audio.conf
configuration file. It is disabled by default. Also, it doesn't affect and
doesn't change any other interfaces.

Br,
Dmitriy


