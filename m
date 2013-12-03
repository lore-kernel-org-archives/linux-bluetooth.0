Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Dec 2013 11:22:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mathieu Laurendeau <mathieu@laurendeau.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Missing BT_POWER option for l2cap sockets in bluetooth.h?
Message-ID: <20131203092228.GA9498@x220.p-661hnu-f1>
References: <529CEC22.60107@laurendeau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529CEC22.60107@laurendeau.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mathieu,

On Mon, Dec 02, 2013, Mathieu Laurendeau wrote:
> I believe the following defines are missing in the bluetooth.h file:
> 
> #define BT_POWER        9
> struct bt_power {
>         uint8_t force_active;
> };
> #define BT_POWER_FORCE_ACTIVE_OFF 0
> #define BT_POWER_FORCE_ACTIVE_ON 1

I think the only user of this has been pre-4.2 Android versions
(considering that the feature came from Android developers), which is
probably why this never made it to bluez.git. Anyway, I just pushed a
patch to add it there.

What are you planning to use this for? Do you have a patch to contribute
to our A2DP implementation?

Johan
