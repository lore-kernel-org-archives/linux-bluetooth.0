Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 15:11:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ethan <ethancsge@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Connection Rejected due to Unacceptable BD_ADDR in Chromebook
 smart lock feature
Message-ID: <20150212131108.GA2849@t440s.lan>
References: <CAAAJ3C+JuhUMea+LYNbC8xSMyWT6EEQutq=VWkLLs6+WHwsi1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAAAJ3C+JuhUMea+LYNbC8xSMyWT6EEQutq=VWkLLs6+WHwsi1w@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

On Thu, Feb 12, 2015, Ethan wrote:
> I met a connection rejected issue in kernel 3.10/3.14 (the kernel version
> that be used in Chrome) in Chromebook smart lock feature. From btmon, the
> connect request was initial from phone, but chrome host reject it due to "
> Unacceptable BD_ADDR". I need to start
> connection manually from Chrome (and then it's working).The full btmon log
> as below, thank.

The only way this should be possible on a clean 3.10 or 3.14 kernel
(i.e. no backported Bluetooth patches) is if you have explicitly
blacklisted the device in question. Is this a clean kernel or do you
perhaps have (incorrectly) backported patches which break the behavior?

Johan
