Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030519141834.0951b330@unixmail.qualcomm.com>
Date: Mon, 19 May 2003 14:19:22 -0700
To: "Daryl Van Vorst" <daryl@wideray.com>, "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: RE: [Bluez-devel] Qualification Testing
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001301c31bd5$3287cb10$1a01010a@baked>
References: <5.1.0.14.2.20030516101849.0d55f0f0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

At 11:01 AM 5/16/2003, Daryl Van Vorst wrote:
>Max,
>
>> >> I sent the above quote to Cetecom last week. They responded
>> >> saying that MTU isn't the only negotiated parameter.
>> 
>> FlushTO _must_ be 0xffff for reliable ACL link. So far none 
>> of the profiles specified use of unreliable links. 
>> 
>> Support for QOS is totally optional. We're only required to 
>> support 'best effort'. Which means that even if they want 
>> something other than 'best effort' (i.e. they reject 
>> default settings) we won't be able to accept it simply 
>> because we don't support it.
>> 
>> So I'm not sure what can be negotiated there. 
>
>Ok. I'll see what they say about that too.
>
>> btw Can this fancy Merlin viewer export trace in plain text ? 
>> I'm too lazy to install that stuff. And it looks like I need to see 
>> what is it exactly that they request/reject.
>
>
>Before we start the test, we must specify to the tester the parameters that
>we'll accept. The tester will reject the first set of values, no matter what
>they are. In its response it will send new values (which we specify) that it
>expects to see in the next request from the IUT.

Any updates on this one ?

Max
