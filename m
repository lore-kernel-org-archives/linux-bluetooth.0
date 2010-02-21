Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <588634.45024.qm@web52606.mail.re2.yahoo.com>
References: <588634.45024.qm@web52606.mail.re2.yahoo.com>
Date: Sun, 21 Feb 2010 18:52:03 +0200
Message-ID: <2d5a2c101002210852o68efa3aaj2b073c3debac0c37@mail.gmail.com>
Subject: Re: obex-client: how to select a dongle from muliple dongles to
	send-files
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 19, 2010 at 9:47 PM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> Hi,
>   Need some hint from the expert.
>   I am using  test/send-files to send files. But when I have multiple dongles, I would like in run time to select which dongle to send out the file either using hci0/1 or the actual dongle address or other means. I tried trace it down but got lost. Anyone could provide some hint.

Currently send-files doesn't support choosing the source, but the dbus
API does, just set the bdaddr (string format) as Source in device
dictionary.


-- 
Luiz Augusto von Dentz
Computer Engineer
