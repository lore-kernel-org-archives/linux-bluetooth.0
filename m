Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ] android/AVDTP: Duplicate fd passed to avdtp_new
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 20 Dec 2013 05:16:26 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <6E8A8CD1-5CB6-4D65-9BD7-DF4CF23F274C@holtmann.org>
References: <1387533387-6724-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This use dup to create a new fd to be used by AVDTP session leaving the
> caller free to close the original fd. Note that even if the caller
> decides to keep the original fd it will still be notified when
> avdtp_shutdown is called since it uses shutdown.

I would be more curious on why this is needed.

Regards

Marcel

