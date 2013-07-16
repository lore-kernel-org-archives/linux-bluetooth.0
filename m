Return-Path: <cyrus@holtmann.org>
Message-ID: <51E5633A.2080800@hurleysoftware.com>
Date: Tue, 16 Jul 2013 11:14:02 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org
Subject: Re: [PATCH 2/8] Move functions before the definition of rfcomm_port_ops
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-2-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-2-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/12/2013 04:40 PM, Gianluca Anzolin wrote:
> Move rfcomm_tty_copy_pending and rfcomm_get_device before the definition of
> rfcomm_port_ops.
>
> These functions will be called later from the .activate and .shutdown methods of
> the tty_port.
>
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>

Ok.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
