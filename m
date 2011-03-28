Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110328124448.GA15266@jh-x301>
References: <AANLkTin4-oCPX3qoWFS1rnLScPmS1xs5LGW6+rAKyEaX@mail.gmail.com>
	<20110328124448.GA15266@jh-x301>
Date: Mon, 28 Mar 2011 15:04:32 +0200
Message-ID: <AANLkTinwVMShrWW7A3D98sYZNFPPz_yObzkAO6zj8ZF4@mail.gmail.com>
Subject: Re: Bug in hciconfig.c
From: Arno Willig <akw@thinkwiki.org>
To: Arno Willig <akw@thinkwiki.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

wow, 6 years...
I always wondered whi LMP and HCI versions are identical on my
bluetooth sticks, but maybe this is correct for most devices...

Thank you!

Ciao, Arno


2011/3/28 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Arno,
>
> On Mon, Mar 28, 2011, Arno Willig wrote:
>> I do not follow this list, so please excuse me, if this request isn't
>> appropriate here.
>>
>> I think I found an error in the Bluez Package of my Ubuntu 11.04
>> distro. (bluez-4.90)
>> In bluez-4.90/tools/hciconfig.c (Function cmd_version(), line 1141):
>>
>>        hciver = hci_vertostr(ver.hci_ver);
>>  -     lmpver = lmp_vertostr(ver.hci_ver);
>>
>>
>> I think it should be this, right?
>>
>>        hciver = hci_vertostr(ver.hci_ver);
>>  +    lmpver = lmp_vertostr(ver.lmp_ver);
>>
>>
>> Maybe nobody saw this before, because the values are nevertheless
>> equal (2.1 for example) ?
>>
>>
>> Please tell me if this is really a bug or if I oversaw something, will you?
>
> It's a real bug which can be seen from commit 9848c1fa that introduced
> it (6 years ago). Before that commit the code was correctly using lmp_ver.
>
> I've pushed a patch to fix it upstream.
>
> Johan
>



-- 
Arno Willig <akw@thinkwiki.org>
