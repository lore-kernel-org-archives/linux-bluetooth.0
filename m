Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Sep 2012 12:09:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 07/18] neard: Implement PushOOB function
Message-ID: <20120924090941.GA20042@x220>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
 <1348230995-8967-8-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348230995-8967-8-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 21, 2012, Szymon Janc wrote:
> +static struct btd_adapter *pending_adapter = NULL;
> +static DBusMessage *pending_msg = NULL;

I'm not really a fan of these global variables. Any chance of moving
them to a non-global temporary context that gets passed around. In
general I find it hard to get the big picture on the life-time of these
variables as it seems you don't actually explicitly initiate the pairing
process from your code but are relying on some external entity to do
that? Or did I miss something? The whole thing just looks quite brittle
right now.

Johan
