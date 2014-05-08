Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] tools: Add "hciconfig pagetype" command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140507191001.8901C100802@puck.mtv.corp.google.com>
Date: Thu, 8 May 2014 13:41:52 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <00B402CF-040A-40F8-8725-5F520E57AC61@holtmann.org>
References: <20140507191001.8901C100802@puck.mtv.corp.google.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> Add "hciconfig pagetype" command so that Bluetooth adapter can be
> easily configured to standard or interlaced page scan mode.
> ---
> lib/hci.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> lib/hci.h         | 17 +++++++++++++++--
> lib/hci_lib.h     |  2 ++

I really have no intention to extend libbluetooth with even more functions. We are trying to get rid of it.

> tools/hciconfig.1 |  6 ++++++
> tools/hciconfig.c | 37 +++++++++++++++++++++++++++++++++++++

However hciconfig and hcitool are still generally useful for debugging and testing. They are not really useful for day to day operation since we do everything through the mgmt interface. So if you want to configure anything, it should be done through mgmt.

> static void cmd_page_parms(int ctl, int hdev, char *opt)
> {
> 	struct hci_request rq;
> @@ -1932,6 +1968,7 @@ static struct {
> 	{ "inqdata",	cmd_inq_data,	"[data]",	"Get/Set inquiry data" },
> 	{ "inqtype",	cmd_inq_type,	"[type]",	"Get/Set inquiry scan type" },
> 	{ "inqparms",	cmd_inq_parms,	"[win:int]",	"Get/Set inquiry scan window and interval" },
> +	{ "pagetype",	cmd_page_type,	"[type]",	"Get/Set page scan type" },
> 	{ "pageparms",	cmd_page_parms,	"[win:int]",	"Get/Set page scan window and interval" },
> 	{ "pageto",	cmd_page_to,	"[to]",		"Get/Set page timeout" },
> 	{ "afhmode",	cmd_afh_mode,	"[mode]",	"Get/Set AFH mode" },

I have in general no problem providing simple ways of testing new commands or changing settings on a controller to test things. That has always been one of the most powerful features of BlueZ.

However as said above, libbluetooth should not be extended anymore. And actually hciconfig and hcitool should be changed into using src/shared/hci.[ch]. You can access the raw HCI socket via bt_hci_new_raw_device() from there as well.

Might be a little bit too much work, but it needs to started somehow. I have also started to define clean types in monitor/bt.h that do not require libbluetooth includes either.

Regards

Marcel

