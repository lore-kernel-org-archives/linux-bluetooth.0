Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Enable duplicates filter in background scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394486784-5431-1-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 11 Mar 2014 09:28:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A8F8858B-001A-44CB-B295-E31E4ACC4FE8@holtmann.org>
References: <1394486784-5431-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> To avoid flooding the host with useless advertising reports during
> background scan, we enable the duplicates filter from controller.
> 
> However, enabling duplicates filter requires a small change in
> background scan routine in order to fix the following scenario:
>  1) Background scan is running.
>  2) A device disconnects and starts advertising.
>  3) Before host gets the disconnect event, the advertising is reported
>     to host. Since there is no pending LE connection at that time,
>     nothing happens.
>  4) Host gets the disconnection event and adds a pending connection.
>  5) No advertising is reported (since controller is filtering) and the
>     connection is never established.
> 
> So, to address this scenario, we should always restart background scan
> to unsure we don't miss any advertising report (due to duplicates
> filter).

don’t we need a timer that restarts the background scan in a regular interval?

Regards

Marcel

