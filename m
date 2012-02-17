Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: RFC Heart Rate API
Date: Fri, 17 Feb 2012 11:37:29 +0100
Message-Id: <1329475050-2710-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This RFC aims to establish the Heart Rate Profile API. It follows the same
principles we did in thermometer to enable or disable notifications based
on the number of watcher registered. Furthermore, other specific protocol
details have been hidden to applications such as management of heart rate
control points wich is managed internally in plugin making easy for
application developers to deal with this kind of devices. On the other hand,
moving this feature inside the plugin avoids the case when multiple applications
reset the device disturbing the other ones wich are waiting for measurements.

As always, comments are welcome.

Regards
