Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+5PVA5ViRVRG53TSvUDOKcTx8pFV2FcmNaVcuEebB22xqE9eg@mail.gmail.com>
References: <20171130101838.69b51124@tedd-ubuntu-vm> <CA+5PVA5ViRVRG53TSvUDOKcTx8pFV2FcmNaVcuEebB22xqE9eg@mail.gmail.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Tue, 5 Dec 2017 17:25:58 -0500
Message-ID: <CA+5PVA4B3p4JVwbGktzZtj9u1D337LdiQz1WavJO-U9NiGa4fg@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux-firmware: Add firmware file for Intel Bluetooth 9560
To: Tedd Ho-Jeong An <tedd.an@intel.com>,
        Thomas Backlund <tmb@mageia.org>
Cc: linux-firmware@kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        "matt.chen@intel.com" <matt.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 5, 2017 at 1:15 PM, Josh Boyer <jwboyer@kernel.org> wrote:
> On Thu, Nov 30, 2017 at 1:18 PM, Tedd Ho-Jeong An <tedd.an@intel.com> wrote:
>> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>>
>> This patch adds the firmware file for Intel Bluetooth 9560
>> Also it is known as Intel JeffersonPeak (JfP).
>>
>> FW Build: REL0186
>>
>> 9560:
>> BL Ver: 37 11 10 06 01 2a 34 0f 00
>> FW Ver: 37 11 10 23 01 ba 2c 11 00
>>
>> Release Version: 20.10
>> ibt-17-x-x.sfi/ddc format will be used from 4.14 kernel version. Below
>> is the commit ID for driver changes.
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=af3715e5cef8859571cabecc71e1cd4cc5869d6a
>>
>> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
>> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> All four patches applied and pushed out.  Thanks.

Hm.  So I spoke too soon on this.  Thomas pointed out all the newly
added files are 0 sized.  I can't figure out why this is.  git-am
accepts the patch, but it doesn't look like it is writing out any of
the content to the actual files.

Kyle, Ben, do you have any ideas on this?

josh
