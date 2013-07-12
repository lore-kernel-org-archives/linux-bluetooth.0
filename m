Return-Path: <cyrus@holtmann.org>
Message-ID: <51DFFCBB.3090709@redhat.com>
Date: Fri, 12 Jul 2013 14:55:23 +0200
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: hidp: remove wrong send_report at init
References: <1373550090-30379-1-git-send-email-benjamin.tissoires@redhat.com> <1373550090-30379-3-git-send-email-benjamin.tissoires@redhat.com> <20130712100923.GA2065@joana>
In-Reply-To: <20130712100923.GA2065@joana>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/12/2013 12:09 PM, Gustavo Padovan wrote:
> Hi Benjamin,
> 
> * Benjamin Tissoires <benjamin.tissoires@redhat.com> [2013-07-11 15:41:30 +0200]:
> 
>> The USB hid implementation does retrieve the reports during the start.
>> However, this implementation does not call the HID command GET_REPORT
>> (which would fetch the current status of each report), but use the
>> DATA command, which is an Output Report (so transmitting data from the
>> host to the device).
>> The Wiimote controller is already guarded against this problem in the
>> protocol, but it is not conformant to the specification to set all the
>> reports to 0 on start.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>  net/bluetooth/hidp/core.c | 14 --------------
>>  1 file changed, 14 deletions(-)
> 
> Both patches have been applied to bluetooth-next. Thanks.
> 
> 	Gustavo
> 

Thanks Gustavo!

Cheers,
Benjamin
