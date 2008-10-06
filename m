Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Don't show (null) in wizard
From: David Woodhouse <dwmw2@infradead.org>
To: Mario_Limonciello@Dell.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <FA7963CC89065B49AED46A6F797F0FA6F286AA@AUSX3MPC128.aus.amer.dell.com>
References: <FA7963CC89065B49AED46A6F797F0FA6F286AA@AUSX3MPC128.aus.amer.dell.com>
Content-Type: text/plain
Date: Mon, 06 Oct 2008 07:25:46 +0100
Message-Id: <1223274346.28401.54.camel@macbook.infradead.org>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-10-06 at 01:21 -0500, Mario_Limonciello@Dell.com wrote:
> I've noticed that the wizard will show (null) if the device name is
> not yet recognized when pairing.  This is a bit confusing to the user
> experience.  The attached patch makes the behavior a little bit
> better.

Thanks; I noticed that too a couple of days ago but hadn't got round to
the patch yet.

Perhaps showing the bdaddr would be better, though?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

