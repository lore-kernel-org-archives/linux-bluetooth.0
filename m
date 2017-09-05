Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tools/csr_usb: Fix compilation failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504601609.5928.3.camel@hadess.net>
Date: Tue, 5 Sep 2017 15:15:05 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <27E0FF70-D31E-4CD2-82C2-75660B1C14BF@holtmann.org>
References: <20170905083534.19184-1-hadess@hadess.net>
 <1504601609.5928.3.camel@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

>> GCC's "format-nonliteral" security check is enabled as an error in
>> recent versions of Fedora. Given the reduced scope of use, mark the
>> error as ignorable through pragma.
>> 
>> tools/csr_usb.c: In function 'read_value':
>> tools/csr_usb.c:82:2: error: format not a string literal, argument
>> types not checked [-Werror=format-nonliteral]
>>  n = fscanf(file, format, &value);
>>  ^
> 
> I also ran into this, which looks suspicious:
> obexd/plugins/bluetooth.c: In function 'register_profile':
> obexd/plugins/bluetooth.c:310:7: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
>       profile->driver->port);
>       ^~~~~~~
> obexd/plugins/bluetooth.c:314:7: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
>       profile->driver->name);
>       ^~~~~~~

we would have to change the code on how to build the XML record information. However here it is the same issue with the compiler not getting that the actual value used is const. So it seems this warning has no logic on traversing any levels down.

I mean for example HFP_HF_RECORD is a static const string. It just gets handed through an interim const char * pointer variable before used as format descriptor. Frankly gcc is stupid here.

Regards

Marcel

