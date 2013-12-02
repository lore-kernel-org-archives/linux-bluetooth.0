Return-Path: <cyrus@holtmann.org>
Message-ID: <529CEC22.60107@laurendeau.net>
Date: Mon, 02 Dec 2013 21:22:58 +0100
From: Mathieu Laurendeau <mathieu@laurendeau.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Missing BT_POWER option for l2cap sockets in bluetooth.h?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I believe the following defines are missing in the bluetooth.h file:

#define BT_POWER        9
struct bt_power {
         uint8_t force_active;
};
#define BT_POWER_FORCE_ACTIVE_OFF 0
#define BT_POWER_FORCE_ACTIVE_ON 1

Regards,
Mathieu
