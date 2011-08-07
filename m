Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Sun, 7 Aug 2011 17:34:21 +0200
Subject: Question regarding SET_CONFIGURATION avdtp command handling
Message-ID: <AC090B9732AB2B4DB7FF476E907FE6600131C84B8E@dnce02.ent.ti.com>
References: <1310554946-765-1-git-send-email-iliak@ti.com>
 <20110713183142.GA23921@joana>
 <AC090B9732AB2B4DB7FF476E907FE66001318A5DDC@dnce02.ent.ti.com>
In-Reply-To: <AC090B9732AB2B4DB7FF476E907FE66001318A5DDC@dnce02.ent.ti.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!
Can anybody help me to understand the process of handling avdtp
SET_CONFIGURATION command in scenario when a2dp headset initializes
connection to linux machine? I see that the headset sends
SET_CONFIGURATION avdtp command (with appropriate SBC params),
but i cant find out how this ultimately translates to actual
configuration of a player (totem in my case).

What layers are involved in general?

I see that handling of the command follows the following path (approx.):
avdtp.c::sbc_setconf_ind()
	a2dp.c::auto_config()
		avdtp.c::avdtp_sep_set_state()
			a2dp.c::stream_state_changed()
			sink.c::stream_state_changed()
At no stage I am able to spot the actual configuration of the sbc...
(there should be probably some sort of d-bus messages, but, again,
I don’t see that neither SelectConfiguration nor SetConfiguration
from the media-api are used).

In addition, there is BT_SET_CONFIGURATION command that is handled
in unix.c (after SET_CONFIGURATION is handled); how does it fits
in the configuration picture?

Any info (or reference where it can be found) will be much
appreciated.

Thanks and regards.
	


Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009
