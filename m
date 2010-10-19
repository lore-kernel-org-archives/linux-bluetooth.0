Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 19 Oct 2010 11:46:35 +0530
Message-ID: <AANLkTi=jnPSWAiYWWE6Z_oPswA-uXSOWWMfZKfcfgegH@mail.gmail.com>
Subject: AVRCP 1.4 : Future on Target Role
From: Shivendra Agrawal <ag.shivendra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I have been looking at AVRCP 1.4 in BlueZ and intending to
enhance/develop this profile for the target role. I have been
following the discussion initiated by Sander van Grieken earlier last
month, and as I understand, they are premitive and has scope for
further enhancements.

In the current BlueZ implementation, control-api.txt mentions few
methods e.g. SendVendoeDependent, ChangePlayback..., that are not
referred/implemented in the code, or I may be unable to find at right
place.
Further, there are some more AVRCP 1.4 TG specific Notify and Browsing
commands that can be added.

I am willing to define some preliminary interface APIs for Target
Media Applications to register itself with BlueZ, and would come back
with some idea proposal for your suggestions on improvements.

I am keen to receive your feedback with some ideas and thoughts to put
my effort in right direction.

Question:
Is anyone working on AVRCP 1.4 Target role profile development?

Regards,
Shivendra
