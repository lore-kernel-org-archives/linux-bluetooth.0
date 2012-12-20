Return-Path: <cyrus@holtmann.org>
From: Xian Pan <panxian1212@gmail.com>
Content-Type: text/plain; charset=us-ascii
Subject: Question for setting IO capability parameter for RegisterAgent
Date: Wed, 19 Dec 2012 21:18:46 -0500
Message-Id: <679160B2-3B1E-4D5E-978E-E3358F6126E9@gmail.com>
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1283)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I confuse the relationship between the 4 pairing mode in SSP with the IO capability parameter for the agent. From the agent-api.txt file, the capability parameter can have 5 values: DisplayOnly, DisplayYesNo, KeyboardOnly, NoInputNoOutput and KeyboardDisplay. I think there are only 4 pairing mode in SSP: just works, numeric comparison, out of band, and passkey entry. How the 5 IO capabilities can map to those 4 pairing modes?

Thanks a lot.

BEST
Xian