Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 7 Jun 2011 18:43:52 +0800
Subject: for sync profile crash(irmc server)when using tracer
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473593108F1@shsmsx501.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all:

For the sync profile(irmc) of obex, I meet a question when I use phonebook-tracer.c.

Firstly, in the function of irmc_connect, we use phonebook_pull("telecom/pb.vcf", irmc->params,
					phonebook_size_result, irmc, err);

In the callback function of phonebook_size_result, we can get the number of vcards.

If the number of vcards is 0, irmc still use irmc->request = phonebook_pull("telecom/pb.vcf", irmc->params,
						query_result, irmc, &ret); in the function of irmc_open_pb.

If that, the callback function of phonebook_pull is query_result and the number of vcards is 0.

The condition will result in the crash of program if we use tracker.

The reason is that if the number of vcards is 0, params->maxlistcount = 0. And phonebook_pull will search pull_contacts_size again.

Therefore, if the number of vcards is 0 after irmc_connect, we need to do something for avoid the crash when irmc_open_pb, is right?

Any idea or comments for it?

Best regards
Zheng wu

