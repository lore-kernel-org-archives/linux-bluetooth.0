Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH BlueZ v6 00/18] GATT API: External Services
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 18 Feb 2014 09:44:51 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <B6CE0C86-8DC9-45D1-8022-78ED9D83B96F@holtmann.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org> <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> This patchset implements the minimal support for adding local services
> declarations.
> 
> Limitation: Remove services and multiple services exported by the same
> remote will be implemented the next series.

what is the deal with this unix socket you are using for local access? I think we should remove that functionality and keep it simple in the beginning.

Regards

Marcel

