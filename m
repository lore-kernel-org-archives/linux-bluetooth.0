Return-Path: <cyrus@holtmann.org>
Message-ID: <603738.29222.qm@web94902.mail.in2.yahoo.com>
Date: Tue, 1 Sep 2009 12:07:31 +0530 (IST)
From: Pavan Savoy <pavan_savoy@yahoo.co.in>
Subject: scheduling vs commands
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

as I was looking through the code for tx path of vs commands, I see that the vs hci_command_pkt commands are scheduled into tx_task rather than cmd_task.
Any reason for this ?

also, is it safe to assume that the packets on top of cmd_q are processed first before data_q ?

regards,
Pavan



      Love Cricket? Check out live scores, photos, video highlights and more. Click here http://cricket.yahoo.com
