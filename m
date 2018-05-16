Return-Path: <denkenz@gmail.com>
Subject: Re: [PATCH BlueZ] shared/io-ell: Add support for ELL based IO
 handling
To: Marcel Holtmann <marcel@holtmann.org>,
 Inga Stotland <inga.stotland@intel.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20180514235614.25231-1-inga.stotland@intel.com>
 <C65C87C6-375D-46B1-8CB1-3C96EF9939E4@holtmann.org>
From: Denis Kenzior <denkenz@gmail.com>
Message-ID: <5b6349ba-e0dd-8b56-5654-c1e0e20be4a8@gmail.com>
Date: Wed, 16 May 2018 09:39:29 -0500
MIME-Version: 1.0
In-Reply-To: <C65C87C6-375D-46B1-8CB1-3C96EF9939E4@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> +
>> +	do {
>> +		ret = writev(fd, iov, iovcnt);
>> +	} while (ret < 0 && errno == EINTR);
> 
> explain this one to me. Or maybe Luiz should explain it since he introduced this.
> 

I'm curious why not use TEMP_FAILURE_RETRY macro?  ell already uses that 
for clarity.

Regards,
-Denis
