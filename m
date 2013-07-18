Return-Path: <cyrus@holtmann.org>
Message-ID: <51E7E377.2000108@hurleysoftware.com>
Date: Thu, 18 Jul 2013 08:45:43 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 6/8] Fix the reference counting of tty_port
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-6-git-send-email-gianluca@sottospazio.it> <51E6A3F7.20202@hurleysoftware.com> <20130717170500.GA10640@sottospazio.it> <51E6DE1D.4020808@hurleysoftware.com>
In-Reply-To: <51E6DE1D.4020808@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/17/2013 02:10 PM, Peter Hurley wrote:
> That said, preventing rfcomm_dev destruction by holding the dlc lock
> is poor design (not that I'm suggesting you should be required to fix it though)
> and something that at least needs documenting.
>
> Regarding acquiring a snapshot of dev->id is fine, provided that the id
> cannot be reallocated in between dropping the dlc lock and subsequently
> scanning the rfcomm_dev_list for that id.

Or at least a FIXME comment that the id could potentially be reallocated
between dropping the dlc lock and the subsequent rfcomm_dev_get().

Regards,
Peter Hurley
