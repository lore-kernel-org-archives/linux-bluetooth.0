Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 17:36:47 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 02/20] Bluetooth: Process HCI callbacks in a workqueue
Message-ID: <20120724203647.GB20029@joana>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343136121-22476-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-24 16:21:43 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use workqueue to process HCI callbacks.

Could elaborate more on why a new workqueue is needed, I tried to figure this
out this but was unable to find a user for this function in the following
patches.

	Gustavo
