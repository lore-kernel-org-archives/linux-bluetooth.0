Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: [PATCH 0/1] Add capability option to simple-agent
Date: Tue, 14 Jun 2011 10:19:40 +0300
Message-Id: <1308035981-3623-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The patch adds capability option (-c, --capability) to simple-agent.

There is one point of concern as
'optparse module is deprecated since version 2.7: The optparse module
is deprecated and will not be developed further; development will
continue with the argparse module.'

Any comments regarding use of this module are appreciated.

BR,
Dmitriy

