Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez and rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: David Thornton <david@villagepublishing.com.au>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <BF25BE8B-1DDF-4981-BFCB-6295A64F77B9@villagepublishing.com.au>
References: <BF25BE8B-1DDF-4981-BFCB-6295A64F77B9@villagepublishing.com.au>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:56:44 +0100
Message-Id: <1233122204.18259.20.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> I was wondering if the /dev/rfcommX device nodes are handled directly  
> by the kernel module (bluez) itself or by a userspace program?

they are handled direct by the kernel.

> (its not possible for anything userspace to put something in /dev is  
> it?)

Not without kernel help. Even PTYs are done with kernel help.

Regards

Marcel


