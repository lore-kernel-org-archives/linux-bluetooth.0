Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Emeltchenko Andrei'" <Andrei.Emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Subject: RE: [RFCv0 00/20] RFC A2MP implementation
Date: Thu, 3 Nov 2011 17:20:38 -0700
Message-ID: <000f01cc9a87$94d0dc00$be729400$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> RFC meant to indicate our current development status.
> 
> Code based on Code Aurora (git://codeaurora.org/kernel/msm.git) and
Atheros
> (search for: [PATCH 2/3] Add a2mp protocol/AMP manager, by Atheros Linux
BT3)
> implementations (mostly Code Aurora). Main difference to the original code
is
> - code rebase against recent bluetooth-next
> - rewritten way to send A2MP msgs
> - handling fixed channel modifications
> - I was trying to separate AMP vs A2MP name usage. AMP is used for
> "Alternate MAC PHY" controller, A2MP for "AMP Manager Protocol".
> - fixes related to PTS beta A2MP tests

I think your approach looks fine so far. Do you plan to continue on with
adding detail to the patches in this series or will just do cleanup on them
and then prepare another set?

Peter.
 
--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum



