Return-Path: <cyrus@holtmann.org>
Message-ID: <48FF0C69.40203@csr.com>
Date: Wed, 22 Oct 2008 12:20:09 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: Matt Witherspoon <spoon@vt.edu>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Problems & crash with Bluecore6 and SDIO driver
References: <1224633899.48fe6e2b1e94e@webmail.vt.edu>
In-Reply-To: <1224633899.48fe6e2b1e94e@webmail.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Matt Witherspoon wrote:
> 
>  I attempted to sdio_f0_writeb(func, 0x01, 0xf0, NULL) as the post from David
> Vrabel suggests (http://lkml.org/lkml/2007/8/10/150) to disable deep sleep, but
> it didn't help any.

Deep sleep control is done on a per-function basis so you need to write
0x11 to disable deep sleep on function 1 (the bluetooth function).

The oops may be fixed by: http://lkml.org/lkml/2008/10/6/47

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/
