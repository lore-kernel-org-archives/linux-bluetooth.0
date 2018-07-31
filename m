Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Cinaed Simson <cinaed.simson@gmail.com>
Subject: Re: bluetooth faq
To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <14979653-a357-02f1-25f3-a86231a608d2@GMail.COM>
 <1533066378.3353.13.camel@intel.com>
Message-ID: <eb4688c9-4fbf-7324-d47d-09f44ad0462a@GMail.COM>
Date: Tue, 31 Jul 2018 13:15:19 -0700
MIME-Version: 1.0
In-Reply-To: <1533066378.3353.13.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/31/2018 12:46 PM, Stotland, Inga wrote:
> Hi  Cinaed,
> 
> On Wed, 2018-07-25 at 21:07 -0700, Cinaed Simson wrote:
>> The FAQ on the Wiki appears to indicate that you need to build the
>> source is a kernel version > 2.6.
>>
>> However, the build fails on Jessie running kernel version 3.16.51-3
>> because of no ell.
>>
>> Not big deal.
>>
>> I was able to download it and build it but the ell web page suggests I
>> need the latest kernel version - 4.17 for things to work.
>>
>> I haven't actually installed ell to see if that was only requirement for
>> the build which wasn't mentioned in the README.
>>
>> So am I wasting my time the release from
>>
>>   https://git.kernel.org/pub/scm/bluetooth/bluez.git
>>
>> ? I don't mind installing additional packages from source provided it
>> fixes the known problems with bluetooth.
>>
>> I am currently using 5.49 from
>>
>>    https://github.com/Vudentz/BlueZ.git
>>
>> It doesn't require ell to build.
>>
>> The following URL
>>
>>    https://www.theregister.co.uk/2018/07/24/bluetooth_cryptography_bug/
>>
>> which is what got me started looking for information and possible fixes.
>>
>> Any help would be greatly appreciated.
>>
>> -- Cinaed
>>
> 
> If you want to leave out the requirement for ell, you can run
> bootstrap-configure with --enable-mesh=no option. Alternatively, you
> can remove line "--enable-mesh" in your bootstrap-configure file
> altogether.
> 
> Regards,
> Inga
> 

Hi Inga - thanks for the reply. I misinterpreted what I read on the ell
web page.

I was able to build ell and the git version of bluez.

-- Cinaed


