Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Aug 2015 03:40:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: hciuart: Add support QCA chipset for UART
Message-ID: <20150814004056.GC4484@mwanda>
References: <20150813205655.GA30361@mwanda>
 <55CD1158.10508@qca.qualcomm.com>
 <55CD1342.9090705@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55CD1342.9090705@qca.qualcomm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 13, 2015 at 02:59:30PM -0700, Ben Young Tae Kim wrote:
> BTW, which tool are you using to detect static warning? Can you
> recommend me some tool so that I could prevent same error to the
> upcoming patches?
> 

This test is a Smatch test but it has too many false positives to
publish.  Many of them can probably be silenced...  I will see what I
can do.

regards,
dan carpenter

