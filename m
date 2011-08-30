Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: second scan timing out, bisected to 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
Date: Tue, 30 Aug 2011 10:05:20 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201108301005.20103.oliver@neukum.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am seeing with newer kernels a regression in "hcitool scan" failing if it
is issued a second or further times by timing out. I can bisect this in the
kernel to

commit 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
Author: Johan Hedberg <johan.hedberg@nokia.com>
Date:   Wed Apr 27 10:29:57 2011 -0400

    Bluetooth: Add discovering event to the Management interface
    
    This patch adds a new event to the Management interface to track when
    local adapters are discovering remote devices. For now this only tracks
    BR/EDR discovery procedures.

Is this a known issue. Might this be an issue with too old bluez utils?
I am using bluez-4.64

	Regards
		Oliver
