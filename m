Return-Path: <cyrus@holtmann.org>
Message-id: <531563D2.1060301@samsung.com>
Date: Tue, 04 Mar 2014 06:25:38 +0100
From: Michael Knudsen <m.knudsen@samsung.com>
MIME-version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth:  Stop BCSP/H5 timer before cleaning up
References: <1392713288-12227-1-git-send-email-m.knudsen@samsung.com>
In-reply-to: <1392713288-12227-1-git-send-email-m.knudsen@samsung.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/18/2014 09:48 AM, Michael Knudsen wrote:
> When stopping BCSP/H5, stop the retransmission timer before proceeding
> to clean up packet queues.  The previous code had a race condition where
> the timer could trigger after the packet lists and protocol structure
> had been removed which lead to dereferencing NULL or use-after-free bugs.

No interest?

-m.

