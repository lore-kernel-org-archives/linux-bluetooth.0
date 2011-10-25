Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "claudio.takahasi@openbossa.org" <claudio.takahasi@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 25 Oct 2011 09:38:14 +0200
Subject: GATT Dbus API on BlueZ
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
 <4EA6143E.4000606@googlemail.com>
In-Reply-To: <4EA6143E.4000606@googlemail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

Currently, the DBUS API for GATT Client will allow discovering characteristics and services, connecting to the peer device if required. However, when the operation is done, the link is dropped (no more attio registered). The only way to register a global gatt_service->attio and keep the connection alive all the time is to register a characteristic watcher. Is there another way to do it ? I'd like to keep the link a live (for example, implementing a proximity link loss profile on top of the DBUS GATT Client) without the need for a watcher.

Thanks,
Chen Ganir

