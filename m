Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 14 Dec 2011 19:48:24 +0530
Message-ID: <CACj007n47KuT4uzJMDnHc2KKy_Mog469QvvrRm5mAE54Q6Y7Ug@mail.gmail.com>
Subject: [RFC BlueZ]Proximity Monitor: Immediate Alert Timeout
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am working on Proximity Monitor Role using BlueZ 4.96 + and have a
query on the need for Timeout in case of Immediate Alert in file
proximity/monitor.c.

I feel that this timer is not required, because this will lead to
following scenario in case of Proximity Profile:

If Path loss has occurred and Immediate Alert has been written, then
after Timeout (5 seconds), Proximity Monitor will set immediate alert
level to “none”, which will indicate to Proximity Reporter that Path
Loss is now within threshold, which actually might not be the case.

As per Sec 4.6 of Proximity Profile Spec,
“If the path loss falls below a threshold set on the Proximity Monitor
it shall write in the Alert Level characteristic of the Immediate
Alert service, using the GATT Write Without Response sub-procedure, to
cause the Proximity Reporter to end the alert. When the path loss is
below the threshold the Proximity Monitor should stop alerting.”

So this means that the proximity monitor should not change the alert
level to “None” until the path loss is above Threshold.

Please let me know if my understanding is correct.

-- 
Best Regards
Hemant Gupta
ST-Ericsson India
