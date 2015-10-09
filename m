Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with small
 transfers"
To: Greg KH <gregkh@linuxfoundation.org>,
	andriy.shevchenko@linux.intel.com
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
 <20151006135503.GA13250@kroah.com> <5613D968.7000505@linux.intel.com>
Cc: linux-serial@vger.kernel.org, peter@hurleysoftware.com,
	linux-bluetooth@vger.kernel.org, heikki.krogerus@linux.intel.com,
	marcel@holtmann.org
From: Frederic Danis <frederic.danis@linux.intel.com>
Message-ID: <5617D2FA.1020108@linux.intel.com>
Date: Fri, 9 Oct 2015 16:45:14 +0200
MIME-Version: 1.0
In-Reply-To: <5613D968.7000505@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Greg,

On 06/10/2015 16:23, Frederic Danis wrote:
>>
>> Andy, any objections?
>>
>> Frederic, don't you want to see this backported to 4.0 and newer?
>
> Yes, you're right, unless Andy has any objection this should be good

This is first time for me that patch may be applied to previous kernel.

Is there something specific I should do to allow this patch to be 
applied and backported to 4.0 and newer ?

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

