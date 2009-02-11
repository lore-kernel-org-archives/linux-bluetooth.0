Return-Path: <cyrus@holtmann.org>
Message-ID: <4992A900.8080406@powercraft.nl>
Date: Wed, 11 Feb 2009 11:31:28 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: "Li, Zhigang" <zhigang.li@intel.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth Optical Mouse BM083 and BM013
References: <4991878E.4010100@powercraft.nl> <B94C62E7C2870743865418621F040C13069A3138@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <B94C62E7C2870743865418621F040C13069A3138@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Li, Zhigang wrote:
>> This message contains the following attachment(s):
>> Bluetooth Optical Mouse BM083 and BM013.tar.gz
>>
>> Hello everybody,
>>
>> I bought two new bluetooth mouses for testing and both do not work
>> with the simple-agent.py script. Would somebody be willing to fix the
>   Why you want use simple-agent to make mouse work?

I would like to be able to configure my system from the command line
and documented all steps to get it running. This way I can also
automate the process and provide better support. There are tons of
reasons why to use the command line.

> 
>> command line tool to connect mouses? I got the logs and device
>> information attached in this mail.
>   
> 
>   Make the mouse in paring status, Perhaps just rest some button in mouse.
>   Hidd -- search 

Using hidd --search is depreciated and insecure, at leased this is
tolled to in the past by some developers, so i am not using it. I am
also using the latest git and the hidd tool is disabled for compiling
by default.

>   
> 
>> Thanks in advance,
>>
>> Best regards,
>>
>> Jelle
