Return-Path: <cyrus@holtmann.org>
Subject: RE: patch for hci_bcsp.c(2.6.31.-rc1)
From: Marcel Holtmann <marcel@holtmann.org>
To: "Weng, Wending" <WWeng@rheinmetall.ca>
Cc: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <54B31811B83D744D90BF0289EB447D460C1A5045@MAIL-MB1.oerlikon.ca>
References: <54B31811B83D744D90BF0289EB447D460C1A5045@MAIL-MB1.oerlikon.ca>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 10:19:26 -0700
Message-Id: <1251134366.2950.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wending,

please don't top post. Use proper inline quoting.

>         If I keep "if (i++ >= pkts_to_be_removed)", the loop will end up with
>         i=2 if pkts_to_be_removed==1 and the second test skb_queue_walk_safe is true,
> 
>         it will cause error message later on:
> 
>         if (i != pkts_to_be_removed) {
>                 BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
>         }
> 
>         I think we should add another line for i++.

Not following? I am saying replace >= with >. Would that work too?
Otherwise please send a patch with a more detailed commit message.

Regards

Marcel


