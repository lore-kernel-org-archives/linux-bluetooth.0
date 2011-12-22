Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 22 Dec 2011 17:49:39 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 09/12] Bluetooth: remove *_bh usage from hci_dev_list and
 hci_cb_list
Message-ID: <20111222194939.GG2730@joana>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
 <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
 <1324583121.1965.221.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324583121.1965.221.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2011-12-22 11:45:21 -0800]:

> Hi Gustavo,
> 
> > They don't need to disable interruption anymore, we only run in interrupt
> > context now.
> 
> I assume you mean process context here.

Yes. I left some typos in the messages. Ulisses helped me here to fix all of
them.

	Gustavo
